import 'bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:fastfood_app/Core/utils/Utils.dart';

class CustomerAccountScreen extends StatefulWidget {
  const CustomerAccountScreen({super.key});

  @override
  State<CustomerAccountScreen> createState() => _CustomerAccountScreenState();
}

class _CustomerAccountScreenState extends State<CustomerAccountScreen>
    with SingleTickerProviderStateMixin {

  bool isLoading=false;
  final _formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final _auth=FirebaseAuth.instance;
  late final tabController;
  final userName=TextEditingController();

  @override
  void initState() {
    tabController=TabController(length: 2, vsync: this,initialIndex: 0);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userName.dispose();
    tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()async{
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 248, 240, 1),
        resizeToAvoidBottomInset: false,
        body: Center(
          child:SizedBox(
            height:screenWidth<800?null:screenHeight*1.5,
            width:screenWidth<800?screenWidth*0.95:screenWidth*0.4,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
              child: Column(
                children: [
                  Container(
                height: 150,
                    child: Lottie.network(
                      fit: BoxFit.cover,
                        "https://lottie.host/014dd969-e665-4e3b-bfcb-32d0a06a4684/JQjTjPdcUm.json",
                  )),
                  TabBar(tabs: [
                    const Tab(child:const Text("Login"),),
                    const Tab(child:const Text("SignUp"),),
                  ],
                  indicatorAnimation: TabIndicatorAnimation.elastic,
                  controller: tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  Flexible(
                    child: TabBarView(
                      controller: tabController,
                        children: [
                          Expanded(
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
                                    child: ElevatedButton(onPressed: (){
                                      if(_formKey.currentState!.validate())
                                      {
                                        setState(() {
                                          isLoading=true;
                                        });
                                        _auth.signInWithEmailAndPassword(
                                          email:emailController.text,
                                          password:passwordController.text,
                                        ).then((v){
                                          Utils().toastMessage(v.user!.email.toString());
                                          setState(() {
                                            isLoading=false;
                                          });
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
                                        }).onError((error,stack){
                                          Utils().toastMessage(error.toString());
                                          setState(() {
                                            isLoading=false;
                                          });
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
                          ),
                          Expanded(
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
                                        controller: userName,
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
                                  child: ElevatedButton(onPressed: (){
                                    if(_formKey.currentState!.validate())
                                    {
                                      setState(() {
                                        isLoading=true;
                                      });
                                      _auth.createUserWithEmailAndPassword(
                                        email:emailController.text,
                                        password:passwordController.text,
                                      ).then((v){
                                         Utils().toastMessage(v.user!.email.toString());
                                        setState(() {
                                          isLoading=false;
                                        });
                                      }).onError((error,stack){
                                          Utils().toastMessage(error.toString());
                                        setState(() {
                                          isLoading=false;
                                        });
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
                          ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
