
import 'package:equatable/equatable.dart';

abstract class Failure {}

class ServerFailure extends Failure with EquatableMixin {
  final String? stackTrace;
  ServerFailure({required this.stackTrace});
  
  @override
  List<Object?> get props => [stackTrace];
}