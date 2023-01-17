import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../sidemenu/side_menu.dart';

class payMode extends StatefulWidget {
  const payMode({Key? key}) : super(key: key);

  @override
  State<payMode> createState() => _payModeState();
}

class _payModeState extends State<payMode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool paypalSelected = false;
  bool stripeSelected = false;
  double _paypalHeight = 44;
  double _stripeHeight = 44;
  IconData paypalIcon = Icons.add;
  IconData stripeIcon = Icons.add;
  IconData codIcon = Icons.radio_button_checked;

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
      body: Form(
        key: _formKey,
        child: Column(
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
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'PayPal ID',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF86600)),
                          )),
                        keyboardType: TextInputType.name,
                        cursorColor: const Color(0xFFF86600),
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              _paypalHeight = 126;
                            });
                            return 'PayPal ID is required';
                          }
                          return null;
                        },
                        onSaved: (value) {},
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
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'stripe ID',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF86600)),
                            )),
                        keyboardType: TextInputType.name,
                        cursorColor: const Color(0xFFF86600),
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              _stripeHeight = 126;
                            });
                            return 'stripe ID is required';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();

                const snackBar = SnackBar(content: Text('In Progress'));
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
      ),
    );
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
