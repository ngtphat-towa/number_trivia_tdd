# number_trivia_tdd
- This project is following the Flutter TDD Clean Architecture Course by Reso Coder
- The course teaches how to build a Flutter app using Test Driven Development (TDD) and Clean Architecture principles
# Flutter TDD Clean Architecture Course

## Introduction
This course teaches you how to build a Flutter app using Test Driven Development (TDD) and Clean Architecture principles. You will learn how to write testable and maintainable code, how to structure your app into layers of abstraction, and how to implement features such as caching, connectivity, and error handling.

## Video 1: [Explanation & Project Structure](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)
- [x] Learn the core concepts of clean architecture and how it applies to Flutter
- [x] Create a Flutter project with clean_architecture_tdd_course as the name
- [x] Add dependencies for flutter_test, cupertino_icons, and pedantic
- [x] Add .gitignore file with rules for Flutter and Dart
- [x] Create a lib folder with main.dart file
- [x] Create a test folder with widget_test.dart file
- [x] Create folders for presentation, domain, and data layers inside lib

## Video 2: [Entities & Use Cases](https://resocoder.com/2019/08/29/flutter-tdd-clean-architecture-course-2-entities-use-cases/)
- [x] Create a core folder inside lib with error and usecases subfolders
- [x] Create a Failure class  in the core folder
- [x] Create an abstract UseCase class with a call method in the usecases subfolder
- [x] Create a features folder inside lib with number_trivia subfolder
- [x] Create a domain folder inside number_trivia with entities and usecases subfolders
- [x] Create a NumberTrivia class in the entities subfolder
- [x] Create abstract classes for NumberTriviaRepository, GetConcreteNumberTrivia, and GetRandomNumberTrivia in the usecases subfolder

## Video 3: [Domain Layer Refactoring](https://resocoder.com/2019/09/02/flutter-tdd-clean-architecture-course-3-domain-layer-refactoring/)
- [x] Learn about callable classes in Dart
- [x] Refactor the `GetConcreteNumberTrivia` class to use the `call` method
- [x] Add another use case: `GetRandomNumberTrivia`
- [x] Create a `UseCase` base class to enforce a stable interface for all use cases

## Video 4: [Data Layer Overview & Models](https://resocoder.com/2019/09/09/flutter-tdd-clean-architecture-course-4-data-layer-overview-models/)
- [x] Learn about the data layer and its components: models, data sources, repositories
- [x] Create a data folder inside number_trivia with models subfolder
- [x] Create a NumberTriviaModel class that extends NumberTrivia entity
- [x] Implement toJson and fromJson methods for NumberTriviaModel
- [x] Write unit tests for NumberTriviaModel

## Video 5: [Contracts of Data Sources](https://resocoder.com/2019/09/12/flutter-tdd-clean-architecture-course-5-contracts-of-data-sources/)
- [x] Learn about contracts of data sources and why they are useful
- [x] Create data sources subfolder inside data with local_data_source.dart and remote_data_source.dart files
- [x] Define abstract classes for NumberTriviaLocalDataSource and NumberTriviaRemoteDataSource with methods for getting trivia by number or randomly
- [x] Write unit tests for data sources contracts

## Video 6: [Repository Implementation](https://resocoder.com/2019/09/19/flutter-tdd-clean-architecture-course-6-repository-implementation/)
- [x] Learn about repository implementation and its role in the data layer.
- [x] Implement NumberTriviaRepositoryImpl class that extends NumberTriviaRepository abstract class from domain layer.
- [x] Inject local and remote data sources as dependencies into repository constructor.
- [x] Implement getConcreteNumberTrivia and getRandomNumberTrivia methods using data sources and network info.
- [x] Write unit tests for repository implementation.

## Video 7: [Network Info](https://resocoder.com/2019/09/23/flutter-tdd-clean-architecture-course-7-network-info/)
- [x] Learn about network info and how to check internet connection status in Flutter
- [x] Add dependencies for connectivity package and mockito package
- [x] Create network_info.dart file inside core folder with NetworkInfo abstract class and NetworkInfoImpl class that implements it
- [x] Inject Connectivity as a dependency into NetworkInfoImpl constructor
- [x] Implement isConnected method using Connectivity package methods
- [x] Write unit tests for network info

## Video 8: [Local Data Source](https://resocoder.com/2019/09/26/flutter-tdd-clean-architecture-course-8-local-data-source/)
- [x] Learn about local data source and how to use shared preferences in Flutter
- [x] Add dependencies for shared_preferences package
- [x] Implement NumberTriviaLocalDataSourceImpl class that extends NumberTriviaLocalDataSource abstract class from data sources contracts
- [x] Inject SharedPreferences as a dependency into local data source constructor
- [x] Implement getLastNumberTrivia and cacheNumberTrivia methods using shared preferences methods
- [x] Write unit tests for local data source

## Video 9: [Remote Data Source](https://resocoder.com/2019/10/03/flutter-tdd-clean-architecture-course-9-remote-data-source/)
- [x] Learn about remote data source and how to use http package in Flutter
- [x] Add dependencies for http package and http_mock_adapter package
- [x] Implement NumberTriviaRemoteDataSourceImpl class that extends NumberTriviaRemoteDataSource abstract class from data sources contracts
- [x] Inject HttpClient as a dependency into remote data source constructor
- [x] Implement getConcreteNumberTrivia and getRandomNumberTrivia methods using http package methods and NumberTriviaModel.fromJson method
- [x] Handle exceptions and errors from http requests
- [x] Write unit tests for remote data source using http_mock_adapter package

## Video 10: [Bloc Scaffolding & Input Conversion](https://resocoder.com/2019/10/10/flutter-tdd-clean-architecture-course-10-bloc-scaffolding-input-conversion/)
- [x] Learn about bloc scaffolding and input conversion in the presentation layer
- [x] Generate a number_trivia bloc subfolder with bloc extension
- [x] Define abstract classes for NumberTriviaEvent and NumberTriviaState with equatable package
- [x] Define subclasses for NumberTriviaEvent: GetTriviaForConcreteNumber and GetTriviaForRandomNumber
- [x] Define subclasses for NumberTriviaState: Empty, Loading, Loaded, Error
- [x] Inject GetConcreteNumberTrivia and GetRandomNumberTrivia use cases as dependencies into bloc constructor
- [x] Wire up on<Event> method to handle TriviaForConcreteNumber and GetTriviaForRandomNumber events
- [x] Create input_converter.dart file inside core folder with InputConverter class that converts a string to an unsigned integer or a failure
- [x] Inject InputConverter as a dependency into bloc constructor
- [x] Use InputConverter to validate and convert the input string before calling the use cases

## Video 11 : [Bloc Implementation 1/2](https://resocoder.com/2019/10/10/flutter-tdd-clean-architecture-course-11-bloc-implementation/)
- [x] Implement NumberTriviaBloc class that extends Bloc<NumberTriviaEvent, NumberTriviaState> abstract class from presentation layer contracts
- [x] Inject GetConcreteNumberTrivia and GetRandomNumberTrivia use cases as dependencies into bloc constructor
- [x] Implement on<GetTriviaForConcreteNumber> and on<GetTriviaForRandomNumber> methods using use cases and InputConverter
- [x] Handle failures and successes from use cases and emit appropriate states
- [x] Write unit tests for bloc using mocktail package

## Video 12: [Bloc Implementation 2/2](https://resocoder.com/2019/10/14/flutter-tdd-clean-architecture-course-11-bloc-implementation-2-2//)
- [x] Learn how to use bloc_test package to simplify bloc testing
- [x] Refactor bloc tests using blocTest function and expect states
- [x] Implement NumberTriviaCubit class that extends Cubit<NumberTriviaState> abstract class from presentation layer contracts
- [x] Inject GetConcreteNumberTrivia and GetRandomNumberTrivia use cases as dependencies into cubit constructor
- [x] Handle failures and successes from use cases and emit appropriate states
- [x] Write unit tests for bloc using blocTest function and expect states

## Video 13: [Dependency Injection](https://resocoder.com/2019/10/21/flutter-tdd-clean-architecture-course-13-dependency-injection-user-interface//)
- [x] Learn about dependency injection and how to use get_it package in Flutter
- [x] Register all the classes and contracts as singletons or factories using GetIt methods
- [x] Inject DI into `main()` before running application.

## Video 14: [Finishing the App](https://resocoder.com/2019/10/29/flutter-tdd-clean-architecture-course-14-user-interface/)
- [x] Learn how to use Placeholder widgets to design the UI layout 
- [x] Create NumberTriviaPage widget and use BlocProvider, BlocBuilder, and BlocListener widgets
- [x] Implement TriviaDisplay, MessageDisplay, LoadingWidget, TriviaControls widgets
- [x] Create NumberTriviaPage widget and use Scaffold, AppBar, and Column widgets 
- [x] Implement MessageDisplay, LoadingWidget, and TriviaDisplay widgets using Container, Text, CircularProgressIndicator, and SingleChildScrollView widgets 
- [x] Use MediaQuery to set the height of the widgets according to the screen size
- [x] Extract the widgets into their own files and use barrel files to simplify imports 
- [x] Implement TriviaControls widget using TextField, RaisedButton, and BlocConsumer widgets 
- [x] Dispatch GetTriviaForConcreteNumber and GetTriviaForRandomNumber events from the TriviaControls widget 
- [x] Wrap the body of the Scaffold with a SingleChildScrollView to prevent overflow when the keyboard appears

## Conclusion
This course teaches you how to build a Flutter app using Test Driven Development (TDD) and Clean Architecture principles. You will learn how to write testable and maintainable code, how to structure your app into layers of abstraction, and how to implement features such as caching, connectivity, and error handling. By following this course, you will be able to build high-quality Flutter apps that are easy to maintain and extend.
