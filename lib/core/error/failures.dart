import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({List properties = const <dynamic>[]}) : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}
