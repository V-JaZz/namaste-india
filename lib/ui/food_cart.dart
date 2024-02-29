import 'package:get/get.dart';
import 'package:namastey_india/Provider/UserDataStateMgmt.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:namastey_india/ui/order_mode.dart';
import 'package:provider/provider.dart';
import '../Provider/CartDataStateMgmt.dart';
import '../sidemenu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:namastey_india/ui/add_details.dart';
import 'package:namastey_india/ui/phone_no_bottomsheet.dart';

class FoodCart extends StatefulWidget {
  const FoodCart({Key? key}) : super(key: key);

  @override
  State<FoodCart> createState() => _FoodCartState();
}

class _FoodCartState extends State<FoodCart> {
  bool tipVisible = false;
  late double price = 7.90, sum = 158, total = 162.8;
  final addTipController = TextEditingController();
  final noteController = TextEditingController();
  String? userPostCodeByInput;
  IconData noteIcon = Icons.check_circle_outline;
  bool error = false;
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
      body: Column(
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
              physics: const BouncingScrollPhysics(),
              children: [
                Consumer<CartStateMgmt>(builder: (context, cart, child) {
                  return Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: DeliveryMode.lieferung,
                          groupValue: cart.deliveryMode,
                          fillColor: MaterialStateProperty.all(
                              const Color(0xFFF86600)),
                          onChanged: (DeliveryMode? value) {
                              cart.deliveryMode = value;
                          },
                        ),
                        GestureDetector(
                            onTap: () {
                                cart.deliveryMode = DeliveryMode.lieferung;
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
                          groupValue: cart.deliveryMode,
                          fillColor: MaterialStateProperty.all(
                              const Color(0xFFF86600)),
                          onChanged: (DeliveryMode? value) {
                              cart.deliveryMode = value;
                          },
                        ),
                        GestureDetector(
                            onTap: () {
                                cart.deliveryMode = DeliveryMode.abholung;
                            },
                            child: const Text(
                              'Abholung',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF2E266F)),
                            ))
                      ],
                    ),
                  ],
                );
                }),
                Consumer<CartStateMgmt>(builder: (context, cart, child) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16,8,16,16),
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
                            (index) {
                              num itemDiscount = cart.getItemDiscount(index)[0];
                              return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: itemDiscount != 0 ? true : false,
                                    replacement: const SizedBox(height: 12),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 2,top: 6),
                                      padding: const EdgeInsets.fromLTRB(6, 3, 6, 2),
                                      decoration: BoxDecoration(
                                          color: colorGreen,
                                          borderRadius: BorderRadius.circular(11)
                                      ),
                                      child: Text(
                                        '$itemDiscount% OFF',
                                        style: const TextStyle(color:Colors.white,fontSize: 10, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cart.cartItems[index].name.toString() + (cart.cartItems[index].option == null? '' : '\r\n(${cart.cartItems[index].option})'),
                                                style: const TextStyle(fontSize: 13),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Visibility(
                                                replacement: const SizedBox(height: 8),
                                                visible: cart.cartItems[index].toppings!.isEmpty ? false:true,
                                                child: Expandable(index: index,cart: cart),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 26,
                                                width: 78,
                                                margin: const EdgeInsets.only(left: 6),
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
                                                          if (cart.cartItems[index].quantity == 1 && cart.cartItems.length == 1) {
                                                            cart.removeItemOrQuantity(index);
                                                            Navigator.of(context).pop();
                                                          } else {
                                                            cart.removeItemOrQuantity(index);
                                                          }
                                                        },
                                                      )),
                                                      Expanded(
                                                          child: Center(
                                                        child: Text(
                                                          cart.cartItems[index].quantity.toString(),
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
                                                          cart.addQuantity(index);
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
                                                  '${CartStateMgmt.deFormat(cart.getItemPrice(index).toStringAsFixed(2))} €',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFFF86600)),
                                                ),
                                              )
                                            ])
                                      ]),
                                  const SizedBox(height: 8),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: colorGrey,
                                  )
                                ],
                              ),
                            );
                            },
                          ),
                        ),
                        // const SizedBox(
                        //     height: 3, child: Center(child: Divider())),
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
                                  onChanged: (value){
                                    cart.note = value;
                                  },
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
                              "${CartStateMgmt.deFormat(cart.getSubTotal().toStringAsFixed(2))} €",
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
                          children: [
                            const Text('Liefergebühr'),
                            Consumer<CartStateMgmt>(
                            builder: (context, cart, child) {
                              return Text(
                                  cart.deliveryMode == DeliveryMode.lieferung ? '${CartStateMgmt.deFormat(cart.distanceDetail.deliveryCharge!)} €' : '0,00 €',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2E266F)),
                                );
                            }),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Rabatt:'),
                          Consumer<CartStateMgmt>(
                          builder: (context, cart, child) {
                            return  Text('${CartStateMgmt.deFormat(cart.getTotalDiscountPrice().toStringAsFixed(2))} €',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2E266F)));
                          }),
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
                                  "${CartStateMgmt.deFormat(cart.tip.toString())} €",
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
                                "${CartStateMgmt.deFormat(cart.getTotal().toStringAsFixed(2))} €",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                height: !error ? 0 : 88,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:  !error ? Colors.transparent : Colors.white,
                  border: Border.fromBorderSide(BorderSide(color: colorOrange,width: !error ? 0 : 1 ,strokeAlign: BorderSide.strokeAlignInside ,style:  !error ? BorderStyle.none : BorderStyle.solid))
                ),
                child: Text(
                  '⚠ Post Code not accepted!\r\nTo continue please check your post code address or change delivery type to pick up. ',
                  style: TextStyle(color: !error ? Colors.transparent : colorOrange),
                )
              ),
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
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFFF86600),
                      size: 21,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Consumer<UserDataStateMgmt>(
                          builder: (context, value, child) {
                            return Text(
                              '${value.userPostCode} ${value.userAddress}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Color(0xFF2E266F),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _addAddress();
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
              Container(
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      final user = Provider.of<UserDataStateMgmt>(context,listen: false);
                      final cart = Provider.of<CartStateMgmt>(context,listen: false);
                      if(!user.acceptedPostcodes.contains(user.userPostCode) && cart.deliveryMode == DeliveryMode.lieferung){
                        if(!error){
                          setState((){
                            error = true;
                          });
                          Future.delayed(const Duration(seconds: 5),() => setState((){error = false;}));
                        }
                      }else{
                        setState((){
                          error = false;
                        });

                        if (user.userData == null){
                          print('not verified, verify!');
                          _verifyNumber();
                        }else if(user.userData?.isActive != true){
                          print('already verified, skipped verification!');
                          Get.to(
                                  () => const AddDetails(), //next page class
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.linear,
                              transition: Transition.rightToLeftWithFade //transition effect
                          );
                        }else if(user.userData?.isActive == true){
                          print('already verified and registered, skipped verification and registration!');

                          Get.to(
                                  () => const OrderMode(), //next page class
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.linear,
                              transition: Transition.rightToLeftWithFade //transition effect
                          );
                        }
                      }
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
                ),

            ],
          )
        ],
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
          return AddTip(addTipController: addTipController);
        });
  }

  void _addAddress() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        isDismissible: true,
        builder: (context) {
          return const AddAddress();
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
                alignment: Alignment.bottomCenter,
                color: Colors.transparent,
                child: const PhoneNoBottom(),
              ),
            ),
          );
        });
  }

}

class Expandable extends StatefulWidget {
  final int index;
  final CartStateMgmt cart;
  const Expandable({
    Key? key,
    required this.index,
    required this.cart
  }) : super(key: key);

  @override
  State<Expandable> createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> {
  late final CartStateMgmt cart = widget.cart;
  bool more = false;
  double height = 0;
  @override
  Widget build(BuildContext context) {
    if(cart.cartItems[widget.index].toppings!.isNotEmpty && cart.cartItems[widget.index].toppings?.length !=null){
      // return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: more,
            child: Padding(
              padding: const EdgeInsets.only(top:6.0,bottom: 2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    cart.cartItems[widget.index].toppings!.length,
                        (index) =>
                        Text(
                          '+ ${cart.cartItems[widget.index].toppings![index].name!} (${CartStateMgmt.deFormat(cart.cartItems[widget.index].toppings![index].price!.toString())} €)',
                          style: const TextStyle(fontSize: 13,color: colorBlue),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                  )
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                more = !more;
              });
            },
            child: Text(more ? 'less...' : 'more...',
                style: const TextStyle(
                    fontSize: 11,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF86600))),
          ),
        ],
      );
    }else{
      return const SizedBox.shrink();
    }
  }
}

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  late UserDataStateMgmt user = Provider.of<UserDataStateMgmt>(context,listen: false);
  late CartStateMgmt cart = Provider.of<CartStateMgmt>(context,listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Container(
        alignment: Alignment.bottomCenter,
        color: Colors.transparent,
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
                child: Column(
                  children: [
                    Autocomplete<String>(
                      initialValue: TextEditingValue(text: user.userPostCode),
                      optionsBuilder: (TextEditingValue value) {
                        if (value.text.isEmpty) {
                          return user.acceptedPostcodes;
                        }
                        return user.acceptedPostcodes.where((suggestion) =>
                            suggestion.startsWith(value.text));
                      },
                      onSelected: (value) {
                          if(value.isNotEmpty){
                            user.userPostCode = value;
                            cart.distanceDetail = cart.restaurantData!.distanceDetails!.firstWhere((e) => e.postcode == value);
                            print(cart.distanceDetail.id);
                          }
                        },
                      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                        return
                          TextField(
                            keyboardType: TextInputType.number,
                            focusNode: focusNode,
                            controller: textEditingController,
                            decoration: InputDecoration(
                                filled: true,
                                suffixIcon: Icon(
                                  user.userLocationIcon,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.white,
                                hintText: 'Post Code',
                                contentPadding: const EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide.none,
                                    borderRadius:
                                    BorderRadius.circular(6))),
                            onChanged: (value){
                                user.userPostCode = value;
                                if((cart.restaurantData!.distanceDetails!.where((e) => e.postcode == value)).isNotEmpty){
                                  cart.distanceDetail = cart.restaurantData!.distanceDetails!.firstWhere((e) => e.postcode == value);
                                  print(cart.distanceDetail.id);
                                }
                            },
                          );
                        },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              margin: const EdgeInsets.only(left: 6),
                              width: 110,
                              height: 40 * options.length.toDouble(),
                              constraints: const BoxConstraints(maxHeight: 150),
                              decoration: const BoxDecoration(
                                color: colorGrey,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x2F000000),
                                    blurRadius: 8.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(
                                      0.0,
                                      8.0,
                                    ),
                                  )
                                ],
                              ),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: ScrollController(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {

                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(options.elementAt(index));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: colorGrey,width: 1),
                                        borderRadius: BorderRadius.circular(6)
                                      ),
                                      padding: const EdgeInsets.only(left: 14),
                                      height: 40,
                                      child: Align(alignment: Alignment.centerLeft,child: Text(options.elementAt(index), style: const TextStyle(color: colorBlue,fontSize: 16))),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                        const SizedBox(
                        height: 16,
                        ),
                        TextField(
                        maxLines: 1,
                        keyboardType: TextInputType.streetAddress,
                        controller: TextEditingController(text: user.userAddress),
                        decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Address',
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                        borderSide:
                        BorderSide.none,
                                borderRadius:
                                BorderRadius.circular(6))),
                    onChanged: (value){
                            user.userAddress = value;
                    },)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
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
      ),
    );
  }
}

class AddTip extends StatelessWidget {
  const AddTip({
    Key? key,
    required this.addTipController,
  }) : super(key: key);

  final TextEditingController addTipController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.transparent,
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
                          cart.tip = double.tryParse(CartStateMgmt.enFormat(addTipController.text).toString())!;
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
        ),
      ),
    );
  }
}
