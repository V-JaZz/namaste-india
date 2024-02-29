
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:namastey_india/Provider/CartDataStateMgmt.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import '../payment/stripe_payment_controller.dart';
import 'package:provider/provider.dart';
import '../sidemenu/side_menu.dart';

class PayMode extends StatefulWidget {
  const PayMode({Key? key}) : super(key: key);

  @override
  State<PayMode> createState() => _PayModeState();
}

class _PayModeState extends State<PayMode> with TickerProviderStateMixin{
  bool paypalSelected = false;
  bool stripeSelected = false;
  double _paypalHeight = 44;
  double _stripeHeight = 44;
  IconData paypalIcon = Icons.add;
  IconData stripeIcon = Icons.add;
  IconData codIcon = Icons.radio_button_checked;
  bool stripeCard = false;
  final paymentController = Get.put(PaymentController());
  ButtonState stateOfStripeButton = ButtonState.idle;
  ButtonState stateOfPayPalButton = ButtonState.idle;
  late final cart = Provider.of<CartStateMgmt>(context,listen: false);
  @override
  void initState() {
    Stripe.publishableKey = 'pk_test_51MZ6zLSIXN9AAlh0Fw6tIgUplduJwK2fiMFtxuq01jz8JiE4WwoS7vdPe7VUPjHj1UYODaBCOobosdkJAKyvo3Qe00gkWLAIJf';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: 150,
          height: 80,
          child: Image.asset(
            'assets/images/app_logo.png',
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF86600),
              shape: BoxShape.circle,
            ),
            child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.call),
                onPressed: () {}),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(children: const [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF2E266F),
                  ),
                  Text(
                    'Wählen Sie Bestellmodus',
                    style: TextStyle(
                        color: Color(0xFF2E266F),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                ])),
          ),
          GestureDetector(
            onTap: (){
              collapsePaypal();
              collapseStripe();
              setState(() {
                codIcon =  Icons.radio_button_checked;
              });
            },
            child: Container(
              height: 44,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/cash_app.svg',
                          height: 22,
                          width: 22,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(9),
                          child: Text('Barzahlung'),
                        ),
                      ],
                    ),
                    Icon(codIcon,
                        color: const Color(0xFFF86600), size: 21),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 1),
            margin: const EdgeInsets.all(16),
            height: _paypalHeight,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (paypalSelected == false) {
                      collapseStripe();
                      expandPaypal();
                    } else {
                      collapsePaypal();
                      codIcon =  Icons.radio_button_checked;
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/paypal.svg',
                              height: 26,
                              width: 26,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Text('PayPal'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(paypalIcon, color: const Color(0xFFF86600),),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: paypalSelected,
                  child: Flexible(
                    child: Container(
                      alignment: AlignmentDirectional.topStart,
                      padding: const EdgeInsets.only(left: 16,top: 8),
                      child: ProgressButton.icon(
                        iconedButtons: {
                          ButtonState.idle: const IconedButton(
                              text: "Pay using PayPal",
                              icon: Icon(Icons.web_asset_rounded, color: Colors.white),
                              color: Color(0xFF002C8A)),
                          ButtonState.loading:
                          const IconedButton(text: "Loading", color: colorGrey),
                          ButtonState.fail: IconedButton(
                              text: "Failed",
                              icon: const Icon(Icons.cancel, color: Colors.white),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        },
                        progressIndicator: const CircularProgressIndicator(color: Color(0xFF002C8A),backgroundColor: Color(0xFF009BE1)),
                        onPressed: onPressedPayPalButton,
                        state: stateOfPayPalButton,
                        minWidthStates: const [ButtonState.loading],
                        padding: const EdgeInsets.all(3),
                        height: 40.0,
                        minWidth: 40.0,
                        progressIndicatorSize: 25.0,
                        radius: 8.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(seconds: 1),
            margin: const EdgeInsets.all(16),
            height: _stripeHeight,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (stripeSelected == false) {
                      collapsePaypal();
                      expandStripe();
                    } else {
                      collapseStripe();
                      codIcon =  Icons.radio_button_checked;
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Image.asset(
                          'assets/images/stripe.png',
                          height: 29,
                          width: 62,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(stripeIcon, color:const Color(0xFFF86600)),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: stripeSelected,
                  child: Flexible(
                    child: Container(
                      alignment: AlignmentDirectional.topStart,
                      padding: const EdgeInsets.only(left: 16,top: 8),
                      child: ProgressButton.icon(
                        iconedButtons: {
                          ButtonState.idle: const IconedButton(
                              text: "Card Payment",
                              icon: Icon(Icons.credit_card_rounded, color: Colors.white),
                              color: Color(0xFF6772e5)),
                          ButtonState.loading:
                          const IconedButton(text: "Loading", color: colorGrey),
                          ButtonState.fail: IconedButton(
                              text: "Failed",
                              icon: const Icon(Icons.cancel, color: Colors.white),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        },
                        progressIndicator: const CircularProgressIndicator(color: Colors.white,backgroundColor: Color(0xFF6772e5)),
                        onPressed: onPressedStripeCardButton,
                        state: stateOfStripeButton,
                        minWidthStates: const [ButtonState.loading],
                        padding: const EdgeInsets.all(3),
                        height: 40.0,
                        minWidth: 40.0,
                        progressIndicatorSize: 25.0,
                        radius: 8.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              const snackBar = SnackBar(content: Text('Processing'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 33, 16, 16),
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xFFF86600),
                  borderRadius: BorderRadius.circular(6)),
              child: const Center(
                child: Text('Bestellen',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          )
        ],
      ),
    );
  }


  Future<void> onPressedStripeCardButton() async {
    switch (stateOfStripeButton) {
      case ButtonState.idle:
        setState(() {
          stateOfStripeButton = ButtonState.loading;
        });

        await paymentController.makePayment(amount: cart.getTotal().toInt().toString(), currency: 'EUR');
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            stateOfStripeButton = ButtonState.idle;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateOfStripeButton = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateOfStripeButton = ButtonState.idle;
        break;
    }
    setState(() {
      stateOfStripeButton = stateOfStripeButton;
    });
  }
  void onPressedPayPalButton() {
    switch (stateOfPayPalButton) {
      case ButtonState.idle:
        stateOfPayPalButton = ButtonState.loading;
        Future.delayed(const Duration(seconds: 2), () {

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => UsePaypal(
                  sandboxMode: true,
                  clientId:
                  "ATLZ3kvHExolDCGKZaCGT5p8x2dXgySd19oCzcdTM7Bap_cSfI_eSh2lQ4ZIDwtZbMJXj17iEBgRkTtp",
                  secretKey:
                  "EDx_Tal_1KJ1lHS--Hm4uIEzGB4NA0Ath9ktfYk2juK9IvEi48KY9EtwWUkVWZ3Do_KtRaZuGNPAP3rY",
                  returnURL: "https://samplesite.com/return",
                  cancelURL: "https://samplesite.com/cancel",
                  transactions: const [
                    {
                      "amount": {
                        "total": '10.12',
                        "currency": "USD",
                        "details": {
                          "subtotal": '10.12',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description":
                      "The payment transaction description.",
                      // "payment_options": {
                      //   "allowed_payment_method":
                      //       "INSTANT_FUNDING_SOURCE"
                      // },
                      "item_list": {
                        "items": [
                          {
                            "name": "A demo product",
                            "quantity": 1,
                            "price": '10.12',
                            "currency": "USD"
                          }
                        ],

                        // shipping address is not required though
                        "shipping_address": {
                          "recipient_name": "Jane Foster",
                          "line1": "Travis County",
                          "line2": "",
                          "city": "Austin",
                          "country_code": "US",
                          "postal_code": "73301",
                          "phone": "+00000000",
                          "state": "Texas"
                        },
                      }
                    }
                  ],
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    print("onSuccess: $params");
                  },
                  onError: (error) {
                    print("onError: $error");
                  },
                  onCancel: (params) {
                    print('cancelled: $params');
                  }),
            ),
          );
          setState(() {
            stateOfPayPalButton = ButtonState.idle;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateOfPayPalButton = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateOfPayPalButton = ButtonState.idle;
        break;
    }
    setState(() {
      stateOfPayPalButton = stateOfPayPalButton;
    });
  }

  expandPaypal() {
    setState(() {
      paypalSelected = true;
      _paypalHeight = 107;
      paypalIcon = Icons.remove;
      codIcon =  Icons.radio_button_off;
    });
  }
  collapsePaypal() {
    setState(() {
      paypalSelected = false;
      _paypalHeight = 44;
      paypalIcon = Icons.add;
    });
  }

  expandStripe() {
    setState(() {
      _stripeHeight = 107;
      stripeSelected = true;
      stripeIcon = Icons.remove;
      codIcon =  Icons.radio_button_off;
    });
  }
  collapseStripe() {
    setState(() {
      stripeSelected = false;
      _stripeHeight = 44;
      stripeIcon = Icons.add;
    });
  }
}
