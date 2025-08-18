import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<dynamic> ProfileUpdateAlertDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String heading,
  required dynamic currentValue,
  required dynamic userProvider,
})
{
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(heading),
      content: TextFormField(
        controller:currentValue,
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        },
            child: Text("Cancel")),
        TextButton(onPressed: (){
          ref.read(userProvider.notifier).state=currentValue;
        },
            child: Text("Update")),
      ],
    );
  });
}