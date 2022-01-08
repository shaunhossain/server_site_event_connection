
import 'package:flutter/material.dart';

class ProgressDialog{
  ProgressDialog(this.context);
  final BuildContext context;

  void showProgress() async {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (BuildContext context) {
        return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.724,
                height: MediaQuery.of(context).size.height * 0.213,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.043),
                child: Column(
                  children: [
                    Image.asset(
                      "./assets/casset_loading.png",
                      height: MediaQuery.of(context).size.height * 0.106,
                      width: MediaQuery.of(context).size.width * 0.208,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.024,),
                    const Text("অনুগ্রহ করে অপেক্ষা করুন।",style: TextStyle(fontSize: 14,color: Colors.red),),
                  ],
                ),
                margin: const EdgeInsets.only(bottom: 30, left: 14, right: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
      },
    );
  }

  void closeDialogBox(){
    Navigator.pop(context, true);
  }
}