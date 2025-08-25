# fastfood_app

# Stripe Method

**_How Stripe Works_**
Think of Stripe as two halves:

Server side (secure) → Talks to Stripe with your secret key (sk_...)
Creates things like PaymentIntent
Sends back only safe data (client_secret) to the app
Client side (Flutter app) → Shows payment UI (PaymentSheet)
Uses the client_secret to confirm the payment
Never touches your secret key

👉 So rule #1: Flutter never uses your sk_test_... or sk_live_....
Flutter only uses client_secret.

**Stripe_1**
dependencies:
flutter_stripe: ^11.0.0   # version may vary
http: ^1.2.0
# Also see changes in android/app/src/main/kotlin/MainActivity file of this project.
# android/app/src/main/res/values/styles.xml   change from given documentation file on github
# android/app/src/main/res/values-night/styles.xml   change from given documentation file on github

**Step_2:**
First,initialize whole app with publish key which we get from stripe website.
use async
void main()async
{
WidgetsFlutterBinding.ensureInitialized();
Stripe.publishableKey="pk_test_51RyytjCjTfzItJpubU8s4OX1EU0d2fAteb8p15bYcgVMXk7UDVFaFlgyuKf2oGqFVJ9AxhSThK28We55buzJKSZQ00Fa3BUpTW";
}
🔑 Publishable key is safe in Flutter — it just identifies your Stripe account.

**Step_3**
Create a PaymentIntent,

**Step_4**
Initialize PaymentSheet

**Step_5**
Present PaymentSheet



**_Push_Notification_**
android/app/build.gradle ma  applicationId = "com.umartech.firebase_practice"  iss ma example change karna.
# in android/app/build.gradle ma make these changes:     Error Fixed of local_notification....
in compileOption{
//old code
//add below
isCoreLibraryDesugaringEnabled = true
}
and at end of this file add this:
dependencies {
// ✅ Kotlin DSL uses function style
coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
# ---------------------------------------------------------------------------------- #

--->First get notification permission.
--->get FCM/Device token then print it on console copy and paste in firebase console messaging
# Add below in android/aoo/src/main/AndroidManifest.xml
<meta-data
android:name="com.google.firebase.messaging.default_notification_channel_id"
android:value="high_importance_channel" />
# important common problems
har project ki apni alag deviceToken ho ga jo firebase ma har project ko alag alag dy gy.
deviceToken get karwa ky print karwana.
In case of token expire tu isTokenRefresh() run kar ky aagr console par refresh print ho tu dobara firebase ma new token dy gy.

**Firebase sy show karwany ly liya:**
NotificationServices().requestNotificationPermission();
NotificationServices().isTokenRefresh();
NotificationServices().getDeviceToken().then((value){
print(value!);
});
NotificationServices().firebaseMessage();

**LocalNotification show karwany ky liya:**
NotificationServices().requestNotificationPermission();
NotificationServices().initLocalNotifications(RemoteMessage(data:{}));
NotificationServices().showLocalNotification(
title: "Foodies",
body:"Your order has been successfully placed and currently being processed."
);