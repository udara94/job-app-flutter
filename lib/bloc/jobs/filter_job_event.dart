
import 'package:equatable/equatable.dart';

abstract class FilterJobEvent extends Equatable {}

class FilterJobs extends FilterJobEvent {
  final String key;
  FilterJobs(this.key);

  @override
  List<Object?> get props => [];
}