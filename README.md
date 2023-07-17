# number_trivia_tdd
- This project is following the Flutter TDD Clean Architecture Course by Reso Coder
- The course teaches how to build a Flutter app using Test Driven Development (TDD) and Clean Architecture principles
# Flutter TDD Clean Architecture Course

## Introduction
This course teaches you how to build a Flutter app using Test Driven Development (TDD) and Clean Architecture principles. You will learn how to write testable and maintainable code, how to structure your app into layers of abstraction, and how to implement features such as caching, connectivity, and error handling.

## Video 1: [Explanation & Project Structure](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)
- [✔] Learn the core concepts of clean architecture and how it applies to Flutter
- [✔] Create a Flutter project with clean_architecture_tdd_course as the name
- [✔] Add dependencies for flutter_test, cupertino_icons, and pedantic
- [✔] Add .gitignore file with rules for Flutter and Dart
- [✔] Create a lib folder with main.dart file
- [✔] Create a test folder with widget_test.dart file
- [✔] Create folders for presentation, domain, and data layers inside lib

## Video 2: [Entities & Use Cases](https://resocoder.com/2019/08/29/flutter-tdd-clean-architecture-course-2-entities-use-cases/)
- [✔] Create a core folder inside lib with error and usecases subfolders
- [✔] Create a Failure class and a NoParams class in the core folder
- [✔] Create an abstract UseCase class with a call method in the usecases subfolder
- [✔] Create a features folder inside lib with number_trivia subfolder
- [✔] Create a domain folder inside number_trivia with entities and usecases subfolders
- [✔] Create a NumberTrivia class in the entities subfolder
- [✔] Create abstract classes for NumberTriviaRepository, GetConcreteNumberTrivia, and GetRandomNumberTrivia in the usecases subfolder

## Video 3: [Domain Layer Refactoring](https://resocoder.com/2019/09/02/flutter-tdd-clean-architecture-course-3-domain-layer-refactoring/)
- [✔] Learn about callable classes in Dart
- [✔] Refactor the `GetConcreteNumberTrivia` class to use the `call` method
- [✔] Add another use case: `GetRandomNumberTrivia`
- [✔] Create a `UseCase` base class to enforce a stable interface for all use cases

## Video 4: [Data Layer Overview & Models](https://resocoder.com/2019/09/09/flutter-tdd-clean-architecture-course-4-data-layer-overview-models/)
- [ ] Learn about the data layer and its components: models, data sources, repositories
- [ ] Create a data folder inside number_trivia with models subfolder
- [ ] Create a NumberTriviaModel class that extends NumberTrivia entity
- [ ] Implement toJson and fromJson methods for NumberTriviaModel
- [ ] Write unit tests for NumberTriviaModel

## Video 5: [Contracts of Data Sources](https://resocoder.com/2019/09/12/flutter-tdd-clean-architecture-course-5-contracts-of-data-sources/)
- [ ] Learn about contracts of data sources and why they are useful
- [ ] Create data sources subfolder inside data with local_data_source.dart and remote_data_source.dart files
- [ ] Define abstract classes for NumberTriviaLocalDataSource and NumberTriviaRemoteDataSource with methods for getting trivia by number or randomly
- [ ] Write unit tests for data sources contracts

## Video 6: [Repository Implementation](https://resocoder.com/2019/09/19/flutter-tdd-clean-architecture-course-6-repository-implementation/)
- [ ] Learn about repository implementation and its role in the data layer
- [ ] Implement NumberTriviaRepositoryImpl class that extends NumberTriviaRepository abstract class from domain layer
- [ ] Inject local and remote data sources as dependencies into repository constructor
- [ ] Implement getConcreteNumberTrivia and getRandomNumberTrivia methods using data sources and network info
- [ ] Write unit tests for repository implementation

## Video 7: [Network Info](https://resocoder.com/2019/09/23/flutter-tdd-clean-architecture-course-7-network-info/)
- [ ] Learn about network info and how to check internet connection status in Flutter
- [ ] Add dependencies for connectivity package and mockito package
- [ ] Create network_info.dart file inside core folder with NetworkInfo abstract class and NetworkInfoImpl class that implements it
- [ ] Inject Connectivity as a dependency into NetworkInfoImpl constructor
- [ ] Implement isConnected method using Connectivity package methods
- [ ] Write unit tests for network info

## Video 8: [Local Data Source](https://resocoder.com/2019/09/26/flutter-tdd-clean-architecture-course-8-local-data-source/)
- [ ] Learn about local data source and how to use shared preferences in Flutter
- [ ] Add dependencies for shared_preferences package
- [ ] Implement NumberTriviaLocalDataSourceImpl class that extends NumberTriviaLocalDataSource abstract class from data sources contracts
- [ ] Inject SharedPreferences as a dependency into local data source constructor
- [ ] Implement getLastNumberTrivia and cacheNumberTrivia methods using shared preferences methods
- [ ] Write unit tests for local data source

## Video 9: [Remote Data Source](https://resocoder.com/2019/10/03/flutter-tdd-clean-architecture-course-9-remote-data-source/)
- [ ] Learn about remote data source and how to use http package in Flutter
- [ ] Add dependencies for http package and http_mock_adapter package
- [ ] Implement NumberTriviaRemoteDataSourceImpl class that extends NumberTriviaRemoteDataSource abstract class from data sources contracts
- [ ] Inject HttpClient as a dependency into remote data source constructor
- [ ] Implement getConcreteNumberTrivia and getRandomNumberTrivia methods using http package methods and NumberTriviaModel.fromJson method
- [ ] Handle exceptions and errors from http requests
- [ ] Write unit tests for remote data source using http_mock_adapter package

## Video 10: [Bloc Scaffolding & Input Conversion](https://resocoder.com/2019/10/10/flutter-tdd-clean-architecture-course-10-bloc-scaffolding-input-conversion/)
- [ ] Learn about bloc scaffolding and input conversion in the presentation layer
- [ ] Add dependencies for bloc, flutter_bloc, dartz, and equatable packages
- [ ] Create a presentation folder inside number_trivia with bloc subfolder
- [ ] Create number_trivia_event.dart, number_trivia_state.dart, and number_trivia_bloc.dart files inside bloc subfolder
- [ ] Define abstract classes for NumberTriviaEvent and NumberTriviaState with equatable package
- [ ] Define subclasses for NumberTriviaEvent: GetTriviaForConcreteNumber and GetTriviaForRandomNumber
- [ ] Define subclasses for NumberTriviaState: Empty, Loading, Loaded, Error
- [ ] Implement NumberTriviaBloc class that extends Bloc<NumberTriviaEvent, NumberTriviaState> with bloc package
- [ ] Inject GetConcreteNumberTrivia and GetRandomNumberTrivia use cases as dependencies into bloc constructor
- [ ] Override mapEventToState method to handle different events and emit different states using bloc methods
- [ ] Create input_converter.dart file inside core folder with InputConverter class that converts a string to an unsigned integer or a failure
- [ ] Inject InputConverter as a dependency into bloc constructor
- [ ] Use InputConverter to validate and convert the input string before calling the use cases

## Video 11: [UI & Bloc Implementation](https://resocoder.com/2019/10/17/flutter-tdd-clean-architecture-course-11-ui-bloc/)
- [ ] Learn about UI and bloc implementation in the presentation layer
- [ ] Create widgets subfolder inside presentation with message_display.dart, trivia_display.dart, trivia_controls.dart, and loading_widget.dart files
- [ ] Implement MessageDisplay widget that displays a message on the screen using Text widget
- [ ] Implement TriviaDisplay widget that displays a trivia on the screen using Text widgets and CircleAvatar widget
- [ ] Implement TriviaControls widget that displays controls for getting trivia by number or randomly using TextField widget, RaisedButton widgets, and IconButton widget
- [ ] Implement LoadingWidget widget that displays a loading indicator on the screen using CircularProgressIndicator widget
- [ ] Create number_trivia_page.dart file inside presentation with NumberTriviaPage widget that displays the app's main screen using Scaffold widget, BlocProvider widget, BlocBuilder widget, and BlocListener widget
- [ ] Use the widgets from widgets subfolder to build the UI of the app according to the design
- [ ] Use the bloc from bloc subfolder to handle the events and states of the app logic

## Video 12: [Dependency Injection](https://resocoder.com/2019/10/24/flutter-tdd-clean-architecture-course-dependency-injection/)
- [ ] Learn about dependency injection and how to use get_it package in Flutter
- [ ] Add dependencies for get_it package and injectable package
- [ ] Create injection.dart file inside injection folder with init method that registers all the dependencies using get_it methods
- [ ] Use injectable package annotations to mark classes for dependency injection such as @lazySingleton, @injectable, @module etc.
- [ ] Use injectable package code generator to generate injection.config.dart file that contains the registration logic for all the dependencies marked with annotations
- [ ] Call init method from injection.dart file in main.dart file before running the app

## Video 13: [Testing the UI](https://resocoder.com/2019/11/07/flutter-tdd-clean-architecture-course-testing-the-ui/)
- [ ] Learn about testing the UI and how to use flutter_test package in Flutter
- [ ] Create number_trivia_page_test.dart file inside test/presentation with tests for NumberTriviaPage widget
- [ ] Use flutter_test package methods such as testWidgets, pumpWidget, find, and expect to write widget tests
- [ ] Use mockito package methods such as mock, when, and verify to mock the dependencies of NumberTriviaPage widget
- [ ] Test the initial state of the widget and its behavior when interacting with it

## Video 14: [Finishing the App](https://resocoder.com/2019/11/14/flutter-tdd-clean-architecture-course-finishing-the-app/)
- [ ] Learn about finishing the app and how to handle edge cases and errors
- [ ] Add more tests to number_trivia_page_test.dart file to cover all the edge cases and errors
- [ ] Refactor the code to handle edge cases and errors properly
- [ ] Test the app manually on an emulator or device to make sure everything works as expected

## Conclusion
This course teaches you how to build a Flutter app using Test Driven Development (TDD) and Clean Architecture principles. You will learn how to write testable and maintainable code, how to structure your app into layers of abstraction, and how to implement features such as caching, connectivity, and error handling. By following this course, you will be able to build high-quality Flutter apps that are easy to maintain and extend.
