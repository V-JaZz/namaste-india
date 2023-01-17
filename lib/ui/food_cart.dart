import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:namastey_india/Provider/UserDataStateMgmt.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:namastey_india/ui/otp_bottomsheet.dart';
import 'package:provider/provider.dart';

import '../Provider/CartDataStateMgmt.dart';
import '../sidemenu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:namastey_india/ui/add_details.dart';
import 'package:namastey_india/ui/globals.dart' as globals ;
import 'package:namastey_india/ui/phone_no_bottomsheet.dart';

class FoodCart extends StatefulWidget {
  const FoodCart({Key? key}) : super(key: key);

  @override
  State<FoodCart> createState() => _FoodCartState();
}

enum DeliveryMode { lieferung, abholung }

class _FoodCartState extends State<FoodCart> {
  DeliveryMode? _deliveryMode = DeliveryMode.lieferung;
  bool tipVisible = false;
  late double price = 7.90, sum = 158, total = 162.8;
  int count = 20;
  late String postCode = '60486', address = ' Frankfurt';
  final postCodeController = TextEditingController();
  final addTipController = TextEditingController();
  final noteController = TextEditingController();
  IconData noteIcon = Icons.check_circle_outline;

  @override
  void initState() {
    noteController.addListener(() {
      if(noteController.text.isNotEmpty){
        setState(() {
          noteIcon = Icons.check_circle;
        });
      }else{
        setState(() {
          noteIcon = Icons.check_circle_outline;
        });
      }
    });
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF2E266F),
                        ),
                        Text(
                          'Back',
                          style: TextStyle(color: Color(0xFF2E266F)),
                        )
                      ])),
                  const Text('Warenkorb',
                      style: TextStyle(
                        color: Color(0xFF1F1E1E),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: DeliveryMode.lieferung,
                            groupValue: _deliveryMode,
                            fillColor: MaterialStateProperty.all(
                                const Color(0xFFF86600)),
                            onChanged: (DeliveryMode? value) {
                              setState(() {
                                _deliveryMode = value;
                              });
                            },
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _deliveryMode = DeliveryMode.lieferung;
                                });
                              },
                              child: const Text('Lieferung',
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF2E266F)))),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: DeliveryMode.abholung,
                            groupValue: _deliveryMode,
                            fillColor: MaterialStateProperty.all(
                                const Color(0xFFF86600)),
                            onChanged: (DeliveryMode? value) {
                              setState(() {
                                _deliveryMode = value;
                              });
                            },
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _deliveryMode = DeliveryMode.abholung;
                                });
                              },
                              child: const Text(
                                'Abholung',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF2E266F)),
                              ))
                        ],
                      ),
                    ],
                  ),
                  Consumer<CartStateMgmt>(builder: (context, cart, child) {
                    return Container(
                      height: 45 * cart.cartItems.length + 76,
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              cart.cartItems.length,
                              (index) => Container(
                                height: 45,
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cart.cartItems[index].item!.name
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                          const Text('Show more',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  height: 1.5,
                                                  decoration: TextDecoration
                                                      .underline,
                                                  color: Color(0xFFF86600))),
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 26,
                                              width: 78,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFFF0EEFC),
                                                    width: 1),
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Expanded(
                                                        child: IconButton(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(0),
                                                      iconSize: 18,
                                                      icon: const Icon(
                                                          Icons.remove),
                                                      color: const Color(
                                                          0xFF337A03),
                                                      onPressed: () {
                                                        if (cart.cartItems[index].count == 1 && cart.cartItems.length == 1) {
                                                          cart.remove(cart.cartItems[index].item);
                                                          Navigator.of(context).pop();
                                                        } else {
                                                          cart.remove(cart.cartItems[index].item);
                                                        }
                                                      },
                                                    )),
                                                    Expanded(
                                                        child: Center(
                                                      child: Text(
                                                        cart.cartItems[index].count.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color(0xFF337A03)),
                                                      ),
                                                    )),
                                                    Expanded(
                                                        child: IconButton(
                                                      padding: const EdgeInsets.all(0),
                                                      iconSize: 18,
                                                      icon: const Icon(Icons.add),
                                                      color: const Color(0xFF337A03),
                                                      onPressed: () {
                                                        cart.add(cart.cartItems[index].item);
                                                      },
                                                    )
                                                    ),
                                                  ]),
                                            ),
                                            Container(
                                              width: 70,
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                '${cart.cartItems[index].item!.price} €',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color: Color(0xFFF86600)),
                                              ),
                                            )
                                          ])
                                    ]),
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 3, child: Center(child: Divider())),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    maxLines: 1,
                                    controller: noteController,
                                    cursorColor: colorOrange,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Write Note...',
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF7C75AF),
                                            height: 1)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 6, top: 6),
                                  child: Icon(
                                    noteIcon,
                                    size: 21,
                                    color: noteIcon == Icons.check_circle_outline ? Colors.grey.shade300 : const Color(0xFFF86600),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Delivery Tip',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Color(0xFF2E266F)),
                        ),
                        GestureDetector(
                          onTap: () {
                            _addTip();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: const [
                                Text(
                                  'Add Tip',
                                  style: TextStyle(
                                    color: Color(0xFFF86600),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Color(0xFFF86600),
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Bill Details',
                            style: TextStyle(
                              color: Color(0xFF1F1E1E),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ))),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Item Total'),
                            Consumer<CartStateMgmt>(
                                builder: (context, cart, child) {
                              return Text(
                                CartStateMgmt.deFormat(cart.getPriceSum().toString()) + " €",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2E266F)),
                              );
                            }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Liefergebühr'),
                              Text(
                                '2,90 €',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2E266F)),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Rabatt:'),
                            Text('1,90 €',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2E266F)))
                          ],
                        ),
                        Consumer<CartStateMgmt>(builder: (context, cart, child) {
                          return Visibility(
                            visible: cart.tip == 0 ? false : true,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Tip'),
                                  Text(
                                    CartStateMgmt.deFormat(cart.tip.toString()) + " €",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF2E266F)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Gesamt:',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w700)),
                            Consumer<CartStateMgmt>(
                                builder: (context, cart, child) {
                              return Text(
                                  CartStateMgmt.deFormat(cart.getCartTotal()!) +
                                      " €",
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1F1E1E)));
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFFF86600),
                            size: 21,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              postCode + address,
                              style: const TextStyle(
                                color: Color(0xFF2E266F),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _postCode();
                        },
                        child: Row(
                          children: const [
                            Text(
                              'Add Address',
                              style: TextStyle(
                                color: Color(0xFFF86600),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              size: 18,
                              color: Color(0xFFF86600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Consumer<UserDataStateMgmt>(builder: (context, data, _) {
                  return Container(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>  const addDetails()));
                        // if(data.userData == null){
                        //   print('not verfied, verify!');
                        //   _verifyNumber();
                        // }else{
                        //   print('already verfied, skipped verification');
                        //   Navigator.push(
                        //       context, MaterialPageRoute(builder: (context) =>  const addDetails()));
                        // }
                      },
                      child: Container(
                        height: 53,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF86600),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })

              ],
            )
          ],
        ),
      ),
    );
  }

  void _addTip() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        isDismissible: true,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
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
                    children: <Widget>[
                      Container(
                        margin:
                            const EdgeInsetsDirectional.fromSTEB(15, 22, 0, 16),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Trinkgeld',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                        child: SizedBox(
                          height: 10,
                          child: Divider(
                            color: Color(0xFFBAB2E9),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(16),
                          child: TextField(
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              controller: addTipController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Ex: 5 or 10 or 20',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(6)),
                              ))),
                      Consumer<CartStateMgmt>(builder: (context, cart, child) {
                        return GestureDetector(
                          onTap: () {
                            if (addTipController.text.isNotEmpty) {

                                cart.addTip(double.tryParse(
                                    CartStateMgmt.enFormat(addTipController.text)
                                        .toString())!);
                            }
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xFFF86600),
                                borderRadius: BorderRadius.circular(6)),
                            child: const Center(
                              child: Text('Add Tip',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                alignment: Alignment.bottomCenter,
                color: Colors.transparent,
              ),
            ),
          );
        });
  }

  void _postCode() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        isDismissible: true,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
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
                    children: <Widget>[
                      Container(
                        margin:
                            const EdgeInsetsDirectional.fromSTEB(15, 22, 0, 16),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Delivery Address',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                        child: SizedBox(
                          height: 10,
                          child: Divider(
                            color: Color(0xFFBAB2E9),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(16),
                          child: TextField(
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              controller: postCodeController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Post Code',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(6))))),
                      GestureDetector(
                        onTap: () {
                          if (postCodeController.text.isNotEmpty) {
                            setState(() {
                              postCode = postCodeController.text;
                            });
                          }
                          Navigator.of(context).pop();
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       content: Text(),
                          //     );
                          //   },
                          // );
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF86600),
                              borderRadius: BorderRadius.circular(6)),
                          child: const Center(
                            child: Text('Continue',
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
                alignment: Alignment.bottomCenter,
                color: Colors.transparent,
              ),
            ),
          );
        });
  }

  void _verifyNumber() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        isDismissible: true,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: const pNoBottom(),
                alignment: Alignment.bottomCenter,
                color: Colors.transparent,
              ),
            ),
          );
        });
  }
}
