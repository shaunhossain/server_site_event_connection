import 'dart:async';
import 'package:flutter/material.dart';

class DialogBox {
  DialogBox(this.context, this.id, this.time, this.data);
  final BuildContext context;
  final int id;
  final String data;
  final String time;
  void changingComplete() {
    showDialog(
      barrierLabel: "changing casset complete dialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.822,
            height: MediaQuery.of(context).size.height * 0.21,
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Column(
                children:  [
                  Text("Id : ${id.toString()}",style: const TextStyle(fontSize: 14,color: Colors.red),),
                  Text("Data : ${data.toString()}",style: const TextStyle(fontSize: 14,color: Colors.red)),
                  Text("Time : ${time.toString()}",style: const TextStyle(fontSize: 14,color: Colors.red)),
                ],
              ),
            ),
            margin:
            const EdgeInsets.only(bottom: 30, left: 14, right: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },);
  }

  void closeDialog(){
    Navigator.of(context).pop();
  }
}