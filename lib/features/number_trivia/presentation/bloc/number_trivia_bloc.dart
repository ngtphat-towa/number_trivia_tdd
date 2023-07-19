// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(NumberTriviaEmpty()) {
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }

  // Get data form usecase or
  // -> Return ouput or Exception Messages
  Future _onGetTriviaForConcreteNumber(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    try {
      // Take input from Event
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      // Convert the input to an unsigned integer
      // or throw an InvalidInputFailure exception if the conversion fails -> Emit the Error state
      final integer = inputEither.getOrElse(() => throw InvalidInputFailure());

      // Emit state loading
      emit(NumberTriviaLoading());

      // Get data from usecase
      final failureOrTrivia =
          await getConcreteNumberTrivia(Params(number: integer));

      // Emit `Loaded` state if result was number trivia
      // Otherwise emit `Error` state
      failureOrTrivia!.fold(
        (failure) => emit(
          NumberTriviaError(message: _mapFailureToMessage(failure)),
        ),
        (trivia) => emit(NumberTriviaLoaded(trivia: trivia)),
      );
    } on Failure catch (failure) {
      emit(NumberTriviaError(message: _mapFailureToMessage(failure)));
    }
  }

  Future _onGetTriviaForRandomNumber(
    GetTriviaForRandomNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    // Emit state loading
    emit(NumberTriviaLoading());
    // Get data from usecase
    final failureOrTrivia = await getRandomNumberTrivia();

    // Emit `Loaded` state if result was number trivia
    // Otherwise emit `Error` state
    failureOrTrivia!.fold(
      (failure) {
        emit(NumberTriviaError(message: _mapFailureToMessage(failure)));
      },
      (trivia) {
        emit(NumberTriviaLoaded(trivia: trivia));
      },
    );
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
