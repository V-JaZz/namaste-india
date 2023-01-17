import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:namastey_india/constant/common.dart';
import 'package:namastey_india/ui/phone_otp.dart';
import 'package:namastey_india/ui/share_location.dart';

import '../constant/colors.dart';
import '../main.dart';
import '../repository/sendOtpRepo.dart';

class MyPhonePage extends StatefulWidget {
  @override
  _MyPhonePageState createState() => _MyPhonePageState();
}

class _MyPhonePageState extends State<MyPhonePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  bool isContinue = false;
  late SendOtpRepository _SendOtpRepository;
  String buttonText = "Continue" ;

  @override
  void initState() {
    _SendOtpRepository = SendOtpRepository(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Flexible(
            flex: 12,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Find Food with Namaste India",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontFamily: fontBold,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 15),
                  child: Form(
                    key: formKey,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                              if (number.phoneNumber!.length > 3) {
                                setState(() {
                                  isContinue = true;
                                });
                              } else {
                                setState(() {
                                  isContinue = false;
                                });
                              }
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: const TextStyle(color: Colors.black),
                            initialValue: number,
                            textFieldController: controller,
                            formatInput: false,
                            spaceBetweenSelectorAndTextField: 1,
                            // cursorColor: Colors.black,
                            cursorColor: CupertinoColors.systemGrey,
                            // enabledBorderColor: const Color(0x20F86600),
                            // focusedBorderColor: const Color(0xFFF86600),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputDecoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: CupertinoColors.systemGrey4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: CupertinoColors.systemGrey2),
                              ),
                              hintText: "Enter your mobile number",
                              hintStyle: TextStyle(
                                color: Color(0xFFB4B4B4),
                                fontSize: 16
                              ),
                            ),
                            onSaved: (PhoneNumber number) {
                              print("LenghtNumber " + number.phoneNumber!.length.toString());
                              if (number.phoneNumber!.length == 13) {
                                print(' Saved Phone: $number');
                                sentStatus(number.phoneNumber.toString());
                                setState(() {
                                  buttonText = 'Sending OTP...';
                                });
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => OtpScreen(
                                //             phone: number,
                                //           )),
                                // );
                              } else {
                                print(' Saved Invalidate : $number');
                                formKey.currentState!.validate();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Visibility(
                            visible: isContinue,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: const Text(
                                "By continuing you may receive an SMS for verification. Message and date rates may apply.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Visibility(
                            visible: isContinue,
                            child: GestureDetector(
                              onTap: () {
                                formKey.currentState!.save();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                margin: const EdgeInsets.all(15),
                                child: Center(
                                  child: Text(
                                    buttonText,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: colorOrange,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Flexible(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 1,
                  color: const Color(0xFFE4E4E4),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder:(context) => HomePage()),
                              (route) => false);
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Or continue browsing as Guest",
                            style: TextStyle(
                              color: Color(0xAAF86600),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ))),
              ],
            ))
      ],
    ));
  }

  void sentStatus(String number) async {
    bool? sentStatus = await _SendOtpRepository.login(number);
    if(sentStatus==true){
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(phone: number),
            ));
        buttonText = 'Continue';
      });
      print('otp sent!');
    }else{
      setState(() {
        buttonText = 'Retry';
      });
      print('failed to send otp!');
    }
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
