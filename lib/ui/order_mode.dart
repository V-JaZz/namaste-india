import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namastey_india/ui/payment_mode.dart';

import '../sidemenu/side_menu.dart';

class OrderMode extends StatefulWidget {
  const OrderMode({Key? key}) : super(key: key);

  @override
  State<OrderMode> createState() => _OrderModeState();
}

enum _enum { Sofort, Sofort2 }

class _OrderModeState extends State<OrderMode> {
  _enum? _type = _enum.Sofort;

  String dropdownvalue = 'Sofort';

  var items = [
    'Sofort',
    'Sofort 2',
    'Sofort 3',
  ];
  DateTime dateTime = DateTime(2023, 01, 01, 10, 00);

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
      backgroundColor: const Color(0xFFF0EEFC),
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
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: _enum.Sofort,
                      groupValue: _type,
                      fillColor:
                          MaterialStateProperty.all(const Color(0xFFF86600)),
                      onChanged: (_enum? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _type = _enum.Sofort;
                          });
                        },
                        child:
                            const Text('Wählen Sie die Lieferzeit Ihrer Wahl',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF2E266F),
                                  fontWeight: FontWeight.w700,
                                )))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD9D4F6),
                      borderRadius: BorderRadius.circular(6)),
                  height: 49,
                  width: double.infinity,
                  child: DropdownButton(
                    value: dropdownvalue,
                    style:
                        const TextStyle(fontSize: 14, color: Color(0xFF2E266F)),
                    dropdownColor: const Color(0xFFF0EEFC),
                    underline: Container(),
                    icon: Container(
                        height: 49,
                        width: MediaQuery.of(context).size.width * .65,
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.keyboard_arrow_down)),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: _enum.Sofort2,
                      groupValue: _type,
                      fillColor:
                          MaterialStateProperty.all(const Color(0xFFF86600)),
                      onChanged: (_enum? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _type = _enum.Sofort2;
                          });
                        },
                        child: const Text('Vorbestellen',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2E266F),
                              fontWeight: FontWeight.w700,
                            ))),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        onChanged: (date) {
                          print(
                              'change $date in time zone ${date.timeZoneOffset.inHours}');

                          setState(() {
                            dateTime = date;
                          });
                        },
                        theme: const DatePickerThemeData(
                          headerForegroundColor: Color(0xFFF0EEFC),
                          backgroundColor: Color(0xFFF0EEFC),
                          // itemStyle: TextStyle(
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 18),
                          // doneStyle: TextStyle(
                          //     color: Color(0xFFF86600),
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.w500),
                          // cancelStyle: TextStyle(
                          //     color: CupertinoColors.systemGrey,
                          //     fontSize: 16)
                        ),
                        onConfirm: (date) {
                          print('confirm $date');

                          setState(() {
                            dateTime = date;
                          });
                        },
                        currentTime: dateTime,
                        locale: LocaleType.de);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                          color: const Color(0xFFD9D4F6),
                          borderRadius: BorderRadius.circular(6)),
                      height: 49,
                      width: double.infinity,
                      child: Text(
                        DateFormat('yyyy-MM-dd  |  HH:mm').format(dateTime),
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFF2E266F)),
                      )),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const PayMode(), //next page class
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.linear,
                  transition: Transition.rightToLeft //transition effect
                  );
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
}
