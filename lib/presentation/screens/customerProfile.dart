import 'dart:io';
import 'package:fastfood_app/Core/Utils/Utils.dart';
import 'package:fastfood_app/application/providers/Providers.dart';
import 'package:fastfood_app/presentation/screens/customerAccountScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final _customer=ref.watch(customerStreamProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 248, 240, 1),
        automaticallyImplyLeading: false,
        title: Row(
            children: [
              Text("Profile",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
              )]),
        foregroundColor: Color.fromRGBO(255, 248, 240, 1),
        actions: [
          IconButton(
          tooltip: "Log out",
          onPressed: (){
            FirebaseAuth.instance.signOut().then((v) =>Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerAccountScreen()))
            );
          }, icon: Icon(Icons.logout,color: Colors.black87,)),
          const SizedBox(width: 10,),
        ],
      ),
      backgroundColor: Color.fromRGBO(255, 248, 240, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 320,
            child: Stack(
              children: [
                Consumer(
                  builder:(context,ref,child){
                    final _img=ref.watch(imageProvider);
                    return Container(
                      color: Colors.grey,
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
          _customer.when(data: (cusData){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Name",style: TextStyle(color: Colors.black54),)
                ),
                ListTile(  ///cusData ma sirf aik customer ka hi data ay ga email ki base par tu neechy hum docs.first kar sakty han.
                  title: Text(cusData.docs.first['name']),
                  trailing:IconButton(icon: Icon(Icons.edit),onPressed: (){
                    ProfileUpdateAlertDialog(
                        context: context,
                        ref: ref,
                        id: cusData.docs.first['id'],
                        heading: "Name",
                        currentValue:cusData.docs.first['name'],
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
                  title: Text(cusData.docs.first['phone number']),
                  trailing:IconButton(icon: Icon(Icons.edit),onPressed: (){
                    ProfileUpdateAlertDialog(
                        context: context,
                        ref: ref,
                        id: cusData.docs.first['id'],
                        heading: "Phone Number",
                        currentValue:cusData.docs.first['phone number'],
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
                  title: Text(cusData.docs.first['address']),
                  trailing: IconButton(icon: Icon(Icons.edit),onPressed: (){
                    ProfileUpdateAlertDialog(
                        context: context,
                        ref: ref,
                        id: cusData.docs.first['id'],
                        heading: "Address",
                        currentValue:cusData.docs.first['address'],
                        userProvider: addressProvider
                    );
                  },),
                ),
                Divider(indent: 15,endIndent: 15,),
              ],
            );
          },
              error:(error,s){
                 return TextButton(
                   onPressed: (){ref.invalidate(customerStreamProvider);}, //to refresh
                   child: Text("Error: ${error}"));
            },
              loading: (){
            return Center(child: CircularProgressIndicator(),);
              }
          )
        ],
      ),
    );
  }
}
