import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoDataFaliure extends Failure{
    @override
      List<Object?> get props => [];
}
class DuplicationFailure extends Failure{
    @override
      List<Object?> get props => [];
}


class UnknowFailure extends Failure {
  @override
  List<Object?> get props => [];
}