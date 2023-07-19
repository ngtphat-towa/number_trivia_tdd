// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/core/error/failures.dart';
import 'package:number_trivia_tdd/core/util/input_converter.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia])
@GenerateMocks([GetRandomNumberTrivia])
@GenerateMocks([InputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () async {
    //assert
    expect(bloc.state, equals(NumberTriviaEmpty()));
  });
  group('GetTriviaForConcreteNumber', () {
    // The event takes in a String
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));
    group(
      'calling InputConverter',
      () {
        test(
          'should call the InputConverter to validate and convert the string to an unsigned integer',
          () async* {
            //arrange
            setUpMockInputConverterSuccess();
            //act
            bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
            await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
            //assert
            verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
          },
        );

        test(
          'should emit [Error] when the input is invalid.',
          () async* {
            //arrange
            when(mockInputConverter.stringToUnsignedInteger(any))
                .thenReturn(Left(InvalidInputFailure()));
            // -> the order of state
            final expected = [
              NumberTriviaEmpty(),
              NumberTriviaError(message: INVALID_INPUT_FAILURE_MESSAGE),
            ];
            //assert later
            expectLater(bloc, emitsInOrder(expected));

            //act
            bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
          },
        );
      },
    );
    test(
      'should get data from the concrete usecase',
      () async* {
        //arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        //act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
        await untilCalled(mockGetRandomNumberTrivia(any));

        //assert
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      },
    );

    group('emitting bloc state in order', () {
      test('should emits [Loading, Loaded] when data is gotten successfully',
          () async* {
        //arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        //assert later
        final expeted = [
          NumberTriviaEmpty(),
          NumberTriviaLoading(),
          NumberTriviaLoaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc, emitsInOrder(expeted));
        //act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      });
      test(
        'should emits [Loading, Error] when getting data fails',
        () async* {
          //arrange
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia(any))
              .thenAnswer((_) async => Left(ServerFailure()));

          //assert later
          final expeted = [
            NumberTriviaEmpty(),
            NumberTriviaLoading(),
            NumberTriviaError(message: SERVER_FAILURE_MESSAGE)
          ];
          expectLater(bloc, emitsInOrder(expeted));
          //act
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
        },
      );
      test(
          'should emits [Loading, Error] with a proper message for the error when getting data fails',
          () async* {
        //arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));

        //assert later
        final expeted = [
          NumberTriviaEmpty(),
          NumberTriviaLoading(),
          NumberTriviaError(message: CACHE_FAILURE_MESSAGE)
        ];
        expectLater(bloc, emitsInOrder(expeted));
        //act
        bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      });
    });
  });
  group(
    'GetTriviaForRandomNumber',
    () {
      final tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);
      test(
        'should get data from the random usecase',
        () async* {
          //arrange
          when(mockGetRandomNumberTrivia(any))
              .thenAnswer((_) async => Right(tNumberTrivia));
          //act
          bloc.add(GetTriviaForRandomNumber());
          await untilCalled(mockGetRandomNumberTrivia(any));

          //assert
          verify(mockGetRandomNumberTrivia());
        },
      );
      group(
        'emitting bloc state in order',
        () {
          test(
              'should emits [Loading, Loaded] when data is gotten successfully',
              () async* {
            //arrange
            when(mockGetRandomNumberTrivia(any))
                .thenAnswer((_) async => Right(tNumberTrivia));

            //assert later
            final expeted = [
              NumberTriviaEmpty(),
              NumberTriviaLoading(),
              NumberTriviaLoaded(trivia: tNumberTrivia),
            ];
            expectLater(bloc, emitsInOrder(expeted));
            //act
            bloc.add(GetTriviaForRandomNumber());
          });

          test('should emits [Loading, Error] when getting data fails',
              () async* {
            //arrange
            when(mockGetRandomNumberTrivia(any))
                .thenAnswer((_) async => Left(ServerFailure()));

            //assert later
            final expeted = [
              NumberTriviaEmpty(),
              NumberTriviaLoading(),
              NumberTriviaError(message: SERVER_FAILURE_MESSAGE),
            ];
            expectLater(bloc, emitsInOrder(expeted));
            //act
            bloc.add(GetTriviaForRandomNumber());
          });
          test(
            'should emits [Loading, Error] with a proper message for the error when getting data fails',
            () async* {
              //arrange
              when(mockGetRandomNumberTrivia(any))
                  .thenAnswer((_) async => Left(CacheFailure()));

              //assert later
              final expeted = [
                NumberTriviaEmpty(),
                NumberTriviaLoading(),
                NumberTriviaError(message: CACHE_FAILURE_MESSAGE)
              ];
              expectLater(bloc, emitsInOrder(expeted));
              //act
              bloc.add(GetTriviaForRandomNumber());
            },
          );
        },
      );
    },
  );
}
