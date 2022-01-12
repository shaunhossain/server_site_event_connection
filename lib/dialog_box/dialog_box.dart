import 'package:flutter/material.dart';

class DialogBox {
  DialogBox(this.context, this.id, this.time, this.data);

  final BuildContext context;
  final int id;
  final String data;
  final String time;

  dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (thisLowerContext, innerSetState) {
          return Dialog(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.822,
              height: MediaQuery.of(context).size.height * 0.21,
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Text("Id : $id",style: const TextStyle(fontSize: 14,color: Colors.red),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.024,),
                  Text("Data : $data",style: const TextStyle(fontSize: 14,color: Colors.red),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.024,),
                  Text("Time : $time",style: const TextStyle(fontSize: 14,color: Colors.red),),
                ],
              ),
              margin: const EdgeInsets.only(bottom: 30, left: 14, right: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        });
      },
    );
  }

  void closeDialog() {
    Navigator.of(context).pop();
  }
}

