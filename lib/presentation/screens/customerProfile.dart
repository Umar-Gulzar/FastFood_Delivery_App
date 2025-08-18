import 'dart:io';
import 'package:fastfood_app/application/providers/Providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fastfood_app/presentation/widgets/profileUpdateAlertDialog.dart';

class Profile extends ConsumerWidget {
  final _picker=ImagePicker();

  Future getGalleryImage(WidgetRef ref)async
  {
    final pickedFile=await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile==null)
    {
      debugPrint('image not picked');
    }
    else
    {
      ref.read(imageProvider.notifier).state=File(pickedFile.path);
    }

  }@override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 240, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 350,
            child: Stack(
              children: [
                Consumer(
                  builder:(context,ref,child){
                    final _img=ref.watch(imageProvider);
                    return Container(
                      height: 300,
                      width: double.infinity,
                      child:_img!=null?Image.file(_img!.absolute,fit: BoxFit.cover,): const Icon(Icons.image),
                    );
                  },
                ),
                Positioned(
                  right: 15,
                  top: 280,
                  child: CircleAvatar(
                    backgroundColor: Colors.deepOrange[300],
                    child: IconButton(onPressed: (){
                      getGalleryImage(ref);
                    }, icon: Icon(Icons.edit,color: Colors.white,)),
                  ),
                ),
            ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 15),
              child: Text("Name",style: TextStyle(color: Colors.black54),)
          ),
          ListTile(
            title: Text(ref.watch(userNameProvider)),
            trailing:IconButton(icon: Icon(Icons.edit),onPressed: (){
              ProfileUpdateAlertDialog(
                  context: context,
                  ref: ref,
                  heading: "Name",
                  currentValue:ref.watch(userNameProvider),
                  userProvider: userNameProvider
              );
            },),
          ),
          Divider(indent: 15,endIndent: 15,),
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("Phone Number",style: TextStyle(color: Colors.black54))
          ),
          ListTile(
            title: Text(ref.watch(phoneNoProvider)),
            trailing:IconButton(icon: Icon(Icons.edit),onPressed: (){
              ProfileUpdateAlertDialog(
                  context: context,
                  ref: ref,
                  heading: "Phone Number",
                  currentValue:ref.watch(phoneNoProvider),
                  userProvider: phoneNoProvider
              );
            },),
          ),
          Divider(indent: 15,endIndent: 15,),
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("Address",style: TextStyle(color: Colors.black54))
          ),
          ListTile(
            title: Text(ref.watch(addressProvider)),
            trailing: IconButton(icon: Icon(Icons.edit),onPressed: (){
              ProfileUpdateAlertDialog(
                  context: context,
                  ref: ref,
                  heading: "Address",
                  currentValue:ref.watch(addressProvider),
                  userProvider: addressProvider
              );
            },),
          ),
          Divider(indent: 15,endIndent: 15,),
        ],
      ),
    );
  }
}
