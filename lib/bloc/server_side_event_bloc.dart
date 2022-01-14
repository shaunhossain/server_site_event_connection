import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:server_site_events_connection/api_service/server_side_event_connect.dart';
import 'package:server_site_events_connection/bloc/send_event_request.dart';
import 'package:server_site_events_connection/bloc/server_states.dart';
import 'package:server_site_events_connection/exceptions.dart';
import 'package:server_site_events_connection/model/model_data.dart';


class ServerSideEventBloc extends Cubit<ServerStates> {
  ServerSideEventBloc() : super(InitialData());

  void getEventResponse(String connectionLine){
    emit(LoadingData());
    Future.delayed(const Duration(seconds: 10), () {
      try {

        final serverStream = ServerSideEventConnect.connect(uri: connectionLine, closeOnError: true);
        serverStream.streamController.stream.listen((event) {
          emit(LoadedData(modelData: event));
        });

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

    });
  }
}
