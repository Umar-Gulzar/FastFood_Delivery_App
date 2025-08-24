import 'package:fastfood_app/presentation/widgets/loginTab.dart';
import 'package:fastfood_app/presentation/widgets/signupTab.dart';
import 'bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:fastfood_app/Core/utils/Utils.dart';


late final tabController;

class CustomerAccountScreen extends StatefulWidget {
  const CustomerAccountScreen({super.key});

  @override
  State<CustomerAccountScreen> createState() => _CustomerAccountScreenState();
}

class _CustomerAccountScreenState extends State<CustomerAccountScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    tabController=TabController(length: 2, vsync: this,initialIndex: 0);
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
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
              child: Padding(
                padding:screenWidth<401? EdgeInsets.only(top: 100):EdgeInsets.zero,
                child: Column(
                  children: [
                    Container(
                  height: 150,
                      child: Lottie.asset(
                        fit: BoxFit.cover,
                          "assets/LottieAnimations/woman_thinking_food.json",
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
                            LoginTab(),
                            SignupTab(),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
