import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:server_site_events_connection/bloc/send_event_request.dart';
import 'package:server_site_events_connection/bloc/server_states.dart';
import 'package:server_site_events_connection/exceptions.dart';
import 'package:server_site_events_connection/model/model_data.dart';


class ServerSideEventBloc extends Bloc<SendEventRequest, ServerStates> {
  ServerSideEventBloc({required this.repository}) : super(InitialData()) {
    on<SendEventRequest>(_onServerEventFetch);
  }

  final dynamic repository;

  void _onServerEventFetch(
      SendEventRequest event, Emitter<ServerStates> emit) async {
    switch (event) {
      case SendEventRequest.getDataFromSeverEvent:
        emit(LoadingData());
        try {
          ModelData modelData = await repository.fetchDriverInfoFromServer();
          //print(stationsFetchData.toString());
          emit(LoadedData(modelData: modelData));
        } on SocketException {
          emit(LoadingDataError(
            error: NoInternetException('No Internet'),
          ));
        } on HttpException {
          emit(LoadingDataError(
            error: NoServiceFoundException('No Service Found'),
          ));
        } on FormatException {
          emit(LoadingDataError(
            error: InvalidFormatException('Invalid Response format'),
          ));
        } catch (e) {
          //print(e);
          emit(LoadingDataError(
            error: UnknownException(e),
          ));
        }
        break;
    }
  }
}
