import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:namastey_india/constant/common.dart';
import 'package:namastey_india/ui/add_details.dart';
import 'package:provider/provider.dart';
import '../Provider/UserDataStateMgmt.dart';
import '../constant/colors.dart';
import '../models/userLoginDataModel.dart';
import '../repository/verifyOtpRepo.dart';
import '../repository/sendOtpRepo.dart';

class otpBottom extends StatefulWidget {
  final phone;

  otpBottom({required this.phone});

  @override
  State<otpBottom> createState() => _otpBottomState();
}

class _otpBottomState extends State<otpBottom> {

  late VerifyOtpRepository _verifyOtpRepository;
  late SendOtpRepository _SendOtpRepository;
  late String otpNumber;
  late Timer _timer;
  dynamic sec = 30;
  String resendText = 'Resend code in ', verifyText = "Verify OTP";
  bool invalidVisible = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {

        if (sec == 0) {
          timer.cancel();
          setState(() {
            sec = ' ';
            resendText = 'Resend code';
          });
        } else {
          setState(() {
            sec = sec! - 1;
          });}

      },
    );
  }

  @override
  void initState() {
    _verifyOtpRepository = VerifyOtpRepository(context);
    _SendOtpRepository = SendOtpRepository(context);
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Enter the 4-digit code sent to you at ",style: TextStyle(
                      color: Color(0xFF7C75AF), fontSize: 18, fontFamily: fontBold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 1),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.phone.toString(),
                      style: const TextStyle(
                          color: Color(0xFFF86600), fontSize: 18, fontFamily: fontBold),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: OtpTextField(
                    mainAxisAlignment: MainAxisAlignment.start,
                    numberOfFields: 4,
                    cursorColor: CupertinoColors.systemGrey,
                    enabledBorderColor: const Color(0x20F86600),
                    focusedBorderColor: const Color(0xFFF86600),
                    showFieldAsBox: false,
                    onCodeChanged: (String code) {
                    },
                    onSubmit: (String verificationCode) {
                        otpNumber = verificationCode;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
               Visibility(
                visible: invalidVisible,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: Text('Invalid OTP!',style: TextStyle(color: Colors.redAccent)),
              ),
                  )),
              GestureDetector(
                onTap: (){
                  if(resendText == 'Resend code')
                  {
                    setState(() {
                      resendText = 'Sending...';
                    });
                    print( "Saved Phone: " + widget.phone);
                    reSentStatus(widget.phone);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        resendText + sec.toString(),
                      style: const TextStyle(fontSize: 12, fontFamily: fontRegular, color: Color(0xFF4F5463)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (verifyText=="Verify OTP") {
                    setState(() {
                      verifyText = "Verifying...";
                    });
                    print('Digits ' + otpNumber);
                    verify(widget.phone, otpNumber);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.all(14),
                  child: Center(
                      child: Text(verifyText,
                          style: const TextStyle(color: Colors.white, fontSize: 18))),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), color: colorOrange),
                ),
              )
            ],
          ),
        );
  }

  void reSentStatus(String number) async {
    bool? sentStatus = await _SendOtpRepository.login(number);
    if(sentStatus==true){
      setState(() {
        resendText = 'Resent!';
      });
      print('otp resent!');
    }else if(sentStatus = false){
      setState(() {
        resendText = 'Failed to resend otp!';
      });
      print('failed to resend otp!');
    }
  }

  void verify(String number, String OTP) async {
    UserDataModel userData = await _verifyOtpRepository.verifyOtp(number, OTP);

    if(userData.success){

      final userDataState = Provider.of<UserDataStateMgmt>(context);
        userDataState.userData = userData.userData;

      const snackBar = SnackBar(content: Text('phone number verified'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const addDetails(),
          )
      );
    } else if(userData == false){
      setState(() {
        invalidVisible = true;
        verifyText = "Verify OTP";
      });
    } else{
      setState(() {
        verifyText=="Failed to verify, retry!";
      });
    }
  }

}
