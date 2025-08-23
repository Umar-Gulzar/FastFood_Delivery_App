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
