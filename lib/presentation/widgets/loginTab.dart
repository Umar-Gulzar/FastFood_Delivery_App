import 'package:fastfood_app/presentation/screens/bottomNavigationBar.dart';
import 'package:fastfood_app/presentation/screens/customerAccountScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:fastfood_app/Core/Utils/Utils.dart';

import '../../application/providers/Providers.dart';


class LoginTab extends ConsumerStatefulWidget {
  const LoginTab({super.key});

  @override
  ConsumerState<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends ConsumerState<LoginTab>
    with SingleTickerProviderStateMixin {

  final _formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final _auth=FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
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
                  controller: passwordController,
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
                final isLoading=ref.watch(loginLoadingProvider);
                return ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate())
                  {
                    ref.read(loginLoadingProvider.notifier).state=true;
                    _auth.signInWithEmailAndPassword(
                      email:emailController.text,
                      password:passwordController.text,
                    ).then((v){
                      Utils().toastMessage(v.user!.email.toString());
                      ref.read(loginLoadingProvider.notifier).state=false;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
                    }).onError((error,stack){
                      Utils().toastMessage(error.toString());
                      ref.read(loginLoadingProvider.notifier).state=false;
                    });
                  }
                },
                  child:isLoading?const CircularProgressIndicator(color: Colors.white,strokeWidth: 3,):const Text("Login"),
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
              const Text("Don't have an Acoount?"),
              TextButton(onPressed: (){
                tabController.animateTo(1);
              },
                  child:const Text("Signup",
                    style:const TextStyle(
                    ),
                  )
              )
            ],
          ),
          const SizedBox(height: 30,),
          Flexible(
            child: OutlinedButton(onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneLoginScreen()));
            },
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  )),
              child:const Text("Login with Phone"),
            ),
          )
        ],
      ),
    );
  }
}
