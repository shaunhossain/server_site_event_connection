import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:server_site_events_connection/dialog_box/dialog_box.dart';
import 'package:server_site_events_connection/dialog_box/progress_dialog.dart';
import 'package:server_site_events_connection/api_service/server_site_event_connect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    addEventsListener();
    super.initState();
  }

  void addEventsListener() {
    final stream = ServerSiteEventConnect.connect(
        uri: 'https://express-eventsource.herokuapp.com/events',
        closeOnError: true);
    late Stream myStream;
    myStream = stream.streamController.stream.asBroadcastStream();
    late DialogBox dialogBox1;
    late DialogBox dialogBox2;
    ProgressDialog progressDialog = ProgressDialog(context);

    myStream.listen((value) async {
      log('Value from controller: ${value.data}');
      dialogBox1 =
          DialogBox(context, value.id, value.time, value.data);
      if (value.id.toString().contains('1')) {
        dialogBox1.dialog(context);

        Future.delayed(const Duration(seconds: 5), () {
          dialogBox1.closeDialog();
        }).whenComplete((){
          progressDialog.showProgress(context);
        });
      }
    });

    myStream.listen((value) async {
      log('Value from controller: ${value.data}');
      dialogBox2 =
          DialogBox(context, value.id, value.time, value.data);
      if (value.id.toString().contains('2')) {
        Future.delayed(const Duration(seconds: 5), () {
          progressDialog.closeDialogBox();
        }).whenComplete((){
          dialogBox2.dialog(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Server site Events',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addEventsListener();
          await Future.delayed(const Duration(seconds: 15));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
