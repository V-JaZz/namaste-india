import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:provider/provider.dart';
import '../Provider/UserDataStateMgmt.dart';
import '../sidemenu/side_menu.dart';
import '../ui/order_mode.dart';
import '../ui/globals.dart' as globals;

class addDetails extends StatefulWidget {
  const addDetails({Key? key}) : super(key: key);

  @override
  State<addDetails> createState() => _addDetailsState();
}

enum deliveryMode { lieferung, abholung }

class _addDetailsState extends State<addDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  deliveryMode? _deliveryMode = deliveryMode.lieferung;

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
      body:
      Consumer<UserDataStateMgmt>(builder: (context, user, child) {
        return Container(
            alignment: Alignment.bottomCenter,
            child: Column(
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
                          'Add Details',
                          style: TextStyle(color: Color(0xFF2E266F),fontSize: 18,fontWeight: FontWeight.w700),
                        )
                      ])),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: deliveryMode.lieferung,
                          groupValue: _deliveryMode,
                          fillColor: MaterialStateProperty.all(
                              const Color(0xFFF86600)),
                          onChanged: (deliveryMode? value) {
                            setState(() {
                              _deliveryMode = value;
                            });
                          },
                        ),
                        GestureDetector(
                            onTap:(){
                              setState(() {
                                _deliveryMode = deliveryMode.lieferung;
                              });
                            },
                            child: const Text('Lieferung',style: TextStyle(fontSize: 14,color: Color(0xFF2E266F)))),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: deliveryMode.abholung,
                          groupValue: _deliveryMode,
                          fillColor: MaterialStateProperty.all(
                              const Color(0xFFF86600)),
                          onChanged: (deliveryMode? value) {
                            setState(() {
                              _deliveryMode = value;
                            });
                          },
                        ),
                        GestureDetector(
                            onTap:(){
                              setState(() {
                                _deliveryMode = deliveryMode.abholung;
                              });
                            },
                            child: const Text('Abholung',style: TextStyle(fontSize: 14,color: Color(0xFF2E266F)),))
                      ],
                    ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    if(_deliveryMode == deliveryMode.lieferung){
                      return Flexible(
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Your Name'),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: '858' ,

                                    fillColor: const Color(0xFFD9D4F6),
                                    hintStyle: const TextStyle(color: colorBlue),

                                    disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color(0xFFD9D4F6), width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                  ),
                                  onSaved: (value) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Email Address'),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email is required';
                                    }else if (!value.isValidEmail()) {
                                      return 'Invalid email';
                                    }else{
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Hausnummer'),
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Hausnummer is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Straße'),
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Straße is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Stadt'),
                                  textInputAction: TextInputAction.next,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Stadt is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('65185 JordanStrabe'),
                                  textInputAction: TextInputAction.done,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {},
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    else{
                      return Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: TextFormField(
                                decoration: customInputDecoration('Your Name'),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                cursorColor: colorOrange,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name is required';
                                  }

                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                hintText: '858' ,

                                fillColor: const Color(0xFFD9D4F6),
                                hintStyle: const TextStyle(color: colorBlue),

                                disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFD9D4F6), width: 1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(6)),

                                ),
                                onSaved: (value) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: TextFormField(
                                decoration: customInputDecoration('Email Address'),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                cursorColor: colorOrange,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is required';
                                  }else if (!value.isValidEmail()) {
                                    return 'Invalid email';
                                  }else{
                                    return null;
                                  }
                                },
                                onSaved: (value) {},
                              ),
                            )

                          ],
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const orderMode()));

                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6,horizontal: 16),
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
                ),
                const SizedBox(height: 16)
              ],
            ),
          );
      }),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
customInputDecoration(String hintText) {
  return InputDecoration(
  hintText: hintText ,

      //todo - if disabled then..
      // fillColor: const Color(0xFFD9D4F6),
      // hintStyle: const TextStyle(color: colorBlue),

    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black26, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(6)),

    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(6)),

    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(6)),

    border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(6)),

);

}
