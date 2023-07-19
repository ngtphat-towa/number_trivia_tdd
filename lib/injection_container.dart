import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// !Core
import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';

//! Features - Number Trivia
// Data layer
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
// Doamain layer
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
// Presentation layer
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

// Service locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl<GetConcreteNumberTrivia>(),
      getRandomNumberTrivia: sl<GetRandomNumberTrivia>(),
      inputConverter: sl<InputConverter>()));

  // Use cases
  sl.registerLazySingleton(
      () => GetConcreteNumberTrivia(sl<NumberTriviaRepository>()));
  sl.registerLazySingleton(
      () => GetRandomNumberTrivia(sl<NumberTriviaRepository>()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl<NumberTriviaRemoteDataSource>(),
            localDataSource: sl<NumberTriviaLocalDataSource>(),
            networkInfo: sl<NetworkInfo>(),
          ));
  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnectionChecker>()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final httpClient = http.Client();
  final internetConnectionChecker = InternetConnectionChecker();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => httpClient);
  sl.registerLazySingleton(() => internetConnectionChecker);
}
