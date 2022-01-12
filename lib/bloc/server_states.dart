
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:server_site_events_connection/model/model_data.dart';

@immutable
abstract class ServerStates extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialData extends ServerStates {}

class LoadingData extends ServerStates {}

class LoadedData extends ServerStates {
  LoadedData({required this.modelData});
  final ModelData modelData;

  @override
  List<Object> get props => [modelData];
}

class LoadingDataError extends ServerStates {
  LoadingDataError({this.error});
  final dynamic error;

  @override
  List<Object> get props => [error];
}