import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_site_events_connection/bloc/server_side_event_bloc.dart';
import 'package:server_site_events_connection/bloc/server_states.dart';
import 'package:server_site_events_connection/dialog_box/dialog_box.dart';
import 'package:server_site_events_connection/dialog_box/progress_dialog.dart';
import 'package:server_site_events_connection/api_service/server_side_event_connect.dart';

import 'bloc/send_event_request.dart';

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
      home: BlocProvider(
          create: (context) =>
              ServerSideEventBloc(),
          child: const MyHomePage(title: 'hello',))
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
    final sseStream = context.read<ServerSideEventBloc>();
    sseStream.getEventResponse("https://express-eventsource.herokuapp.com/events");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServerSideEventBloc,ServerStates>(
      builder: (context, state) {
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
              await Future.delayed(const Duration(seconds: 15));
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
      listenWhen: (context,state){
        return state is LoadingData;
      },
      listener: (context, state) {
        if(state is LoadedData){
          log("check bloc : ${state.modelData.data}");
        }
        if(state is InitialData){
          log("loading");
        }
      },
    );
  }
}
