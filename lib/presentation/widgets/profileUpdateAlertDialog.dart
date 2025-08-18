import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<dynamic> ProfileUpdateAlertDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String heading,
  required String currentValue,
  required dynamic userProvider,
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
          ref.read(userProvider.notifier).state=cV.text;
          Navigator.pop(context);
        },
            child: Text("Update")),
      ],
    );
  });
}