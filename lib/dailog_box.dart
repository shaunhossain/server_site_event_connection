import 'dart:async';
import 'package:flutter/material.dart';

class DailogBox {
  void changingComplete(BuildContext context, int id,String data, String time) {
    showGeneralDialog(
      barrierLabel: "changing casset complete dialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        Timer(const Duration(seconds: 8), () async {
          Navigator.of(context).pop();
        });
        return Container(
              alignment: Alignment.center,
              color: Colors.blue.shade200,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.822,
                height: MediaQuery.of(context).size.height * 0.213,
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
              ));
      });
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      };
  }
}