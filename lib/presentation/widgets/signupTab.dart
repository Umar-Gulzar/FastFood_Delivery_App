import 'package:fastfood_app/application/providers/Providers.dart';
import 'package:fastfood_app/presentation/screens/bottomNavigationBar.dart';
import 'package:fastfood_app/presentation/screens/customerAccountScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:fastfood_app/Core/Utils/Utils.dart';


class SignupTab extends ConsumerStatefulWidget {
  const SignupTab({super.key});

  @override
  ConsumerState<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends ConsumerState<SignupTab>
    with SingleTickerProviderStateMixin{

  final _formKey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _auth=FirebaseAuth.instance;
  final _customerCollection=FirebaseFirestore.instance.collection("customer");
  final _userNameController=TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 60,),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon:Icon(Icons.person),
                  ),
                  validator: (v)
                  {
                    if(v!.isEmpty)
                      return "Empty Field";
                    return null;
                  },
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon:Icon(Icons.email),
                  ),
                  validator: (v)
                  {
                    if(v!.isEmpty)
                      return "Empty Field";
                    else if(!v!.contains('@'))
                      return "Invalid Email";
                    return null;
                  },
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon:Icon(Icons.lock_open),
                  ),
                  validator: (v){
                    if(v!.isEmpty)
                      return "Empty Field";
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height:40),
          FractionallySizedBox(
            widthFactor:0.7,
            child: Consumer(
              builder: (context,ref,child){
                final isLoading=ref.watch(signupLoadingProvider);
                return ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate())
                  {
                    ref.read(signupLoadingProvider.notifier).state=true;
                    _auth.createUserWithEmailAndPassword(
                      email:_emailController.text,
                      password:_passwordController.text,
                    ).then((v){
                      String id=DateTime.now().microsecondsSinceEpoch.toString();
                      _customerCollection.doc(id).set({
                        'name':_userNameController.text,
                        'id':id,
                        'address':'',
                        'phone number':'',
                        'postedAt':FieldValue.serverTimestamp(),
                        'creator':FirebaseAuth.instance.currentUser!.uid.toString(),
                      });
                      Utils().toastMessage(v.user!.email.toString());
                      ref.read(signupLoadingProvider.notifier).state=false;
                    }).onError((error,stack){
                      Utils().toastMessage(error.toString());
                      ref.read(signupLoadingProvider.notifier).state=false;
                    });
                  }
                },
                  child:isLoading?const CircularProgressIndicator(color: Colors.white,strokeWidth: 3,):const Text("Signup"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange[300],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                    );
              },
            ),
          ),
          SizedBox(height:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an Account?"),
              TextButton(onPressed: (){
                tabController.animateTo(0);
              },
                  child:const Text("Login",
                    style:const TextStyle(
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}
