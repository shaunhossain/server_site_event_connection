import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/model_data.dart';


class ServerSideEventConnect {
  final StreamController<ModelData> streamController;

  ServerSideEventConnect._internal(this.streamController);

  factory ServerSideEventConnect.connect({
    required String uri,
    required bool closeOnError,
  }) {
    final streamController = StreamController<ModelData>();
    try {
      http.Client _client = http.Client();

      var request =
      http.Request("GET", Uri.parse(uri));
      request.headers["Cache-Control"] = "no-cache";
      request.headers["Accept"] = "text/event-stream";

      Future<http.StreamedResponse>? response = _client.send(request);

      response.asStream().listen((response) {
        log("Received streamedResponse.statusCode:${response.statusCode}");
        response.stream.listen((data) async {
          final parsedData = utf8.decode(data);
          log("Received stream : $parsedData");
          if(parsedData.startsWith("data:")){
            String removeString = parsedData.substring(6);
            log("trim stream : $removeString");
            ModelData data = ModelData.fromRawJson(removeString);
            streamController.add(data);

            log("data stream : ${data.data}");
            if(data.id.toString().contains('3')){
              _client.close();
            }

          }
        },
          cancelOnError: closeOnError,
        );
      }, onError: (e, sT) {
        //client.close();
      }, onDone: () {

      },
          cancelOnError: true
      );
    } finally{

    }

    return ServerSideEventConnect._internal(streamController);
  }
}

