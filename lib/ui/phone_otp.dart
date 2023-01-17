import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:namastey_india/constant/common.dart';
import 'package:namastey_india/main.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../constant/colors.dart';
import '../repository/verifyOtpRepo.dart';
import 'notification_permission.dart';
import '../repository/sendOtpRepo.dart';
import '../ui/globals.dart' as globals;

class OtpScreen extends StatefulWidget {
  final phone;
  OtpScreen({required this.phone});
  @override
  _MyPhonePageState createState() => _MyPhonePageState();
}

class _MyPhonePageState extends State<OtpScreen> {
  late SendOtpRepository _SendOtpRepository;
  late VerifyOtpRepository _verifyOtpRepository;
  late String otpNumber;
  late Timer timer;
  dynamic sec = 30;
  String resendText = 'Resend code in ';
  String verifyText = "Verify OTP";
  bool invalidVisible = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
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
    return MaterialApp(
      title: 'Phone OTP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_rounded)),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter the 4-digit code sent to you at ",
                    style: TextStyle(
                        color: Color(0xFF7C7C7C),
                        fontSize: 18,
                        fontFamily: fontBold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 1),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.phone.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: fontBold),
                    )),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: OtpTextField(
                    mainAxisAlignment: MainAxisAlignment.start,
                    numberOfFields: 4,
                    cursorColor: Colors.black,
                    enabledBorderColor: const Color(0x20F86600),
                    focusedBorderColor: const Color(0xFFF86600),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                    },
                    onSubmit: (String verificationCode) {
                      otpNumber = verificationCode;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: invalidVisible,
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Invalid OTP!', style: TextStyle(color: Colors.redAccent)),
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(resendText == 'Resend code')
                    {
                      setState((){
                        resendText = 'Sending...';
                      });
                      print( "Saved Phone: " + widget.phone);
                      reSentStatus(widget.phone);
                    }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      resendText + sec.toString(),
                      style: const TextStyle(fontSize: 12, fontFamily: fontRegular),
                    )),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  if (verifyText=="Verify OTP" || verifyText=="Failed to verify, retry!") {
                    setState(() {
                      verifyText = "Verifying...";
                    });
                    print("Digits " + otpNumber);
                    verify(widget.phone, otpNumber);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.all(10),
                  child: Center(
                      child: Text(verifyText,
                          style: const TextStyle(color: Colors.white, fontSize: 18))),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: colorOrange),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
    dynamic userData = await _verifyOtpRepository.verifyOtp(number, OTP);
    if(userData.success){

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage(userData: userData.userData);
            },
          ),
              (e) => false);

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
