import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:namastey_india/ui/otp_bottomsheet.dart';
import '../constant/colors.dart';
import '../repository/sendOtpRepo.dart';

class PhoneNoBottom extends StatefulWidget {
  final String? page;

  const PhoneNoBottom({Key? key, this.page}) : super(key: key);

  @override
  State<PhoneNoBottom> createState() => _PhoneNoBottomState();

}

class _PhoneNoBottomState extends State<PhoneNoBottom> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  bool isContinue = false;
  late SendOtpRepository _SendOtpRepository;
  String buttonText = 'Continue';

  @override
  void initState() {
    _SendOtpRepository = SendOtpRepository(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: (){},
        child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF0EEFC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(15, 22, 0, 16),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Enter Your Mobile Number',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                  child: SizedBox(
                    height: 10,
                    child: Divider(
                      color: Color(0xFFBAB2E9),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Form(
                    key: formKey,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: InternationalPhoneNumberInput(
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
                              inputDecoration: const InputDecoration(
                                filled: false,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0x38000000)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              cursorColor: Colors.transparent,
                              hintText: "Enter your mobile number",
                              spaceBetweenSelectorAndTextField: 1,
                              keyboardType: const TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              onSaved: (PhoneNumber number) {
                                print("LenghtNumber ${number.phoneNumber!.length}");
                                if (number.phoneNumber!.length == 13) {
                                  print(' Saved Phone: $number');
                                  setState(() {
                                    buttonText = 'Sending OTP...';
                                  });
                                  sentStatus(number.phoneNumber.toString());

                                } else {
                                  print(' Saved Invalidate : $number');
                                  formKey.currentState!.validate();
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: isContinue,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: const Text(
                                "By continuing you may receive an SMS for verification. Message and date rates may apply.",
                                textAlign: TextAlign.start,
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
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: colorOrange,
                                ),
                                child: Center(
                                  child: Text(
                                    buttonText,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sentStatus(String number) async {
    bool? sentStatus = await _SendOtpRepository.login(number);
    if(sentStatus==true){
      print('otp sent!');
      Navigator.of(context).pop();
      _verifyOtp(number);
    }else if(sentStatus = false){
      setState(() {
        buttonText = 'Retry';
      });
      print('failed to send otp!');
    }
  }

  void _verifyOtp(String number) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        isDismissible: true,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: Container(
              alignment: Alignment.bottomCenter,
              color: Colors.transparent,
              child: OtpBottom(phone: number,page: widget.page),
            ),
          );
        });
  }

}
