import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayScreen extends StatefulWidget {
  const RazorPayScreen({super.key});

  @override
  State<RazorPayScreen> createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  TextEditingController txtPaymentController = TextEditingController();
  Razorpay razorPay = Razorpay();

  @override
  void initState() {
    super.initState();

    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_PgcomXZ0n7R2eK",
      "amount": num.parse(txtPaymentController.text) * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {"contact": "2323232323", "email": "shdjsdh@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorPay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Pament success");
    //Toast.show("Pament success", context);
  }

  void handlerErrorFailure() {
    print("Pament error");
    //Toast.show("Pament error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    //Toast.show("External Wallet", context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtPaymentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.gradientDarkColor,
          title: Text(
            "Payment",
            style: mTextStyle16(),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextField(
                controller: txtPaymentController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                autofocus: true,
                decoration: const InputDecoration(
                    hintText: "Payment amount",
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white12))),
              ),
              hSpacer(mHeight: 40),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.gradientDarkColor,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  onPressed: () {
                    openCheckout();
                    txtPaymentController.clear();
                    setState(() {});
                  },
                  child: Text(
                    "Procced",
                    style: mTextStyle16(mFontColor: Colors.black),
                  ))
            ],
          ),
        ));
  }
}
