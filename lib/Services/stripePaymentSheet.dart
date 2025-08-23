import 'dart:convert';
import 'package:fastfood_app/Core/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

Future<void> makePayment(BuildContext context,int amount,String currency)async{
  try{
    var clientSecret=await createPaymentIntent(amount, currency);
    await initPayment(clientSecret);     ///use await with this otherwise sheet will not open.or use .then()method with this to
    ///call below method.
    await displayPaymentSheet(context);  ///error-correct---->always use await with this otherwise it will run before initPayment.
    clientSecret=null;
  }
  catch(e){
    Utils().toastMessage(e.toString());
  }
}

///It will return clientSecret or also can return whole data.
Future createPaymentIntent(int amount,String currency)async
{  ///Stripe always expects the amount as an integer (whole number) in the smallest currency unit.
  final response =await http.post(
      Uri.parse("https://api.stripe.com/v1/payment_intents"),
      headers: {
        'Authorization': 'Bearer ' + '',
        //Above, "Bearer secret-key"
        'Content-Type': 'application/x-www-form-urlencoded',
        //Content-type:tells Stripe how you encoded the body (form vs json)
      },
      body:{
        'amount': (amount * 100).toString(),    // Stripe expects amount in cents
        "currency": currency, // "usd", "pkr"
        'payment_method_types[]': 'card',
      }
  );
  if(response.statusCode==200)
  {
    final data = jsonDecode(response.body);
    return data['client_secret'].toString();  ///ya pura data bhi bhej sakty han
  }
  else
  {
    throw Exception("Failed to create PaymentIntent");
  }
}

Future<void> initPayment(String clientSecret)async
{
  await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Foodies" , //brand name,
          customFlow: true,///Tells the SDK you’ll manually present the sheet later
          /// (with presentPaymentSheet()), rather than it popping automatically after
          /// init. If you set this to false, initPaymentSheet prepares a simpler auto-flow.
          applePay: PaymentSheetApplePay(merchantCountryCode: "US"),
          googlePay: PaymentSheetGooglePay(merchantCountryCode: "US"),
          style: ThemeMode.light,
          appearance: PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(
                componentBackground: Color.fromRGBO(255, 248, 240, 1),
                background: Color.fromRGBO(255, 248, 240, 1),
                primary: Colors.deepOrange[300],
                componentText: Colors.black87,
                primaryText: Colors.black87,
                secondaryText: Colors.black54,
                placeholderText: Colors.black54,
                icon: Colors.black87,
                error: Colors.deepOrange,
              )
          )
      )
  );

}


Future<void> displayPaymentSheet(BuildContext context)async
{
  try
  {
    await Stripe.instance.presentPaymentSheet();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Successful!")));
  }
  on StripeException catch(e)
  {
    print(e.error);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Cancelled")));
  }
  catch(e)
  {
    print("Unexpected error: $e");
  }
}




