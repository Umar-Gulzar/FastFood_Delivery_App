import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<dynamic> ProfileUpdateAlertDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String id,
  required String heading,
  required String currentValue,
})
{
  return showDialog(context: context, builder: (context){
    final cV=TextEditingController();
    cV.text=currentValue;
    return AlertDialog(
      title: Text(heading),
      content: TextFormField(
        controller:cV,
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
            child: Text("Cancel")),
        TextButton(onPressed: (){
          FirebaseFirestore.instance.collection("customer").doc(id).update({
            heading.toLowerCase().trim():cV.text
          });
          Navigator.pop(context);
        },
            child: Text("Update")),
      ],
    );
  });
}