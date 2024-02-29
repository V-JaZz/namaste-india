import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:namastey_india/repository/pickUpModeRepo.dart';
import 'package:namastey_india/ui/phone_no_bottomsheet.dart';
import 'package:provider/provider.dart';
import '../Provider/CartDataStateMgmt.dart';
import '../Provider/UserDataStateMgmt.dart';
import '../models/registerDataModel.dart';
import '../repository/deliveryModeRepo.dart';
import '../sidemenu/side_menu.dart';
import '../ui/order_mode.dart';
import 'food_cart.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final cart = Provider.of<CartStateMgmt>(context,listen: false);
  late PickUpModeRepo _pickUpModeRepo;
  late DeliveryModeRepo _deliveryModeRepo;

  @override
  void initState() {
    _pickUpModeRepo = PickUpModeRepo(context);
    _deliveryModeRepo = DeliveryModeRepo(context);
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
                            onTap:(){
                              cart.deliveryMode = DeliveryMode.lieferung;
                            },
                            child: const Text('Lieferung',style: TextStyle(fontSize: 14,color: Color(0xFF2E266F)))),
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
                            onTap:(){
                              cart.deliveryMode = DeliveryMode.abholung;
                            },
                            child: const Text('Abholung',style: TextStyle(fontSize: 14,color: Color(0xFF2E266F)),))
                      ],
                    ),
                  ],
                );
                }),
                Builder(
                  builder: (context) {
                    final myCart = Provider.of<CartStateMgmt>(context);
                    if(myCart.deliveryMode == DeliveryMode.lieferung){
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
                                  initialValue: user.userData?.firstName !=null ? ('${user.userData?.firstName ?? ''} ${user.userData?.lastName ?? ''}'):'' ,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                      user.setUserData.firstName = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: user.userData?.contact ?? '' ,
                                    fillColor: const Color(0xFFD9D4F6),
                                    hintStyle: const TextStyle(color: colorBlue),

                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color(0xFFD9D4F6), width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color(0xFFD9D4F6), width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: colorBlue, width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                  ),
                                  onTap: (){
                                    _verifyNumber();
                                  },
                                  onSaved: (value) {
                                    user.setUserData.contact = user.userData!.contact;
                                    },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Email Address'),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  initialValue: user.userData?.email ?? '' ,
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
                                  onSaved: (value) {
                                    user.setUserData.email = value;},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Hausnummer'),
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  initialValue: user.userData?.houseNumber ?? '' ,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Hausnummer is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    user.setUserData.houseNumber = value;},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Straße'),
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  initialValue: user.userData?.street ?? '' ,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Straße is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    user.setUserData.street = value;},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Stadt'),
                                  textInputAction: TextInputAction.next,
                                  initialValue: user.userData?.city ?? '' ,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Stadt is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    user.setUserData.city = value;
                                    },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  enabled: true,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onTap: (){
                                    _addAddress();
                                  },
                                  readOnly: true,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintText: '${user.userPostCode} ${user.userAddress}',
                                    fillColor: const Color(0xFFD9D4F6),
                                    hintStyle: const TextStyle(color: colorBlue),

                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color(0xFFD9D4F6), width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color(0xFFD9D4F6), width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: colorBlue, width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                  ),
                                  validator: (value) {
                                    if(!user.acceptedPostcodes.contains(user.userPostCode) && cart.deliveryMode == DeliveryMode.lieferung){
                                      return 'Post code not accepted';
                                    }else{
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    user.setUserData.postcode = user.userPostCode;
                                    user.setUserData.address = user.userAddress;},
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    else{
                      return Flexible(
                        child: Form(
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
                                  initialValue: user.userData?.firstName !=null ? ('${user.userData?.firstName ?? ''} ${user.userData?.lastName ?? ''}'):'' ,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: colorOrange,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                      user.setUserData.firstName = value;
                                    },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  readOnly: true,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: user.userData?.contact ?? '' ,
                                    fillColor: const Color(0xFFD9D4F6),
                                    hintStyle: const TextStyle(color: colorBlue),

                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color(0xFFD9D4F6), width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color(0xFFD9D4F6), width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: colorBlue, width: 1, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(6)),

                                  ),
                                  onTap: (){
                                    _verifyNumber();
                                  },
                                  onSaved: (value) {
                                    user.setUserData.contact = user.userData!.contact;},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  decoration: customInputDecoration('Email Address'),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  initialValue: user.userData?.email ?? '' ,
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
                                  onSaved: (value) {
                                    user.setUserData.email = value;},
                                ),
                              )

                            ],
                          ),
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

                    if(cart.deliveryMode == DeliveryMode.abholung){
                      sendPickUpDetails(firstName:user.setUserData.firstName!, contact:user.setUserData.contact!, email:user.setUserData.email!, lastName:'', token: user.userData?.token??'');
                    }else{
                      sendDeliveryDetails(firstName:user.setUserData.firstName!, contact:user.setUserData.contact!, email:user.setUserData.email!, lastName:'', token: user.userData?.token??'', houseNo:user.setUserData.houseNumber!, street:user.setUserData.street!, city:user.setUserData.city!, address:user.setUserData.address!, postCode:user.setUserData.postcode!);
                    }

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
                child: const PhoneNoBottom(page: 'pop context',),
              ),
            ),
          );
        });
  }


  void sendPickUpDetails(
      {required String firstName,
      required String lastName,
      required String contact,
      required String email,
      String? token}) async {

    RegisterUser? data = await _pickUpModeRepo.pickUpModeUserDetails(firstName: firstName,lastName: lastName,email: email,contact: contact,token: token);

    if(data == null){

    }else if(data.success == true){
      print('data.data!.email');
          print(data.data!.email);

      final user = Provider.of<UserDataStateMgmt>(context,listen: false);
      user.userData?.isActive = true;

      Get.off(
              () => const OrderMode(), //next page class
          duration: const Duration(milliseconds: 400),
          curve: Curves.linear,
          transition: Transition.rightToLeft //transition effect
      );
      const snackBar = SnackBar(content: Text('added details successfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else if(data.success == false){
      print("message:");
      print(data.message);
    }
  }

  void sendDeliveryDetails(
      {required String firstName,
        required String lastName,
        required String contact,
        required String email,
        required String houseNo,
        required String street,
        required String city,
        required String address,
        required String postCode,
        String? token}) async {

    RegisterUser? data = await _deliveryModeRepo.deliveryModeUserDetails(firstName:firstName,lastName:lastName,email:email,contact:contact,token:token,houseNo:houseNo,street:street,city:city,address:address,postCode:postCode);

    if(data == null){

    }else if(data.success == true){

      print('data.data!.email');
      print(data.data!.email);
      print('data.data!.firstName');
      print(data.data!.firstName);
      print('data.data!.lastName');
      print(data.data!.lastName);
      
      final user = Provider.of<UserDataStateMgmt>(context,listen: false);
      user.userData?.isActive = true;

      Get.off(
              () => const OrderMode(), //next page class
          duration: const Duration(milliseconds: 400),
          curve: Curves.linear,
          transition: Transition.rightToLeftWithFade //transition effect
      );
      const snackBar = SnackBar(content: Text('added details successfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else if(data.success == false){
      print("message:");
      print(data.message);
    }
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
