import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namastey_india/constant/common.dart';
import 'package:namastey_india/main.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'dart:convert';
import '../constant/colors.dart';
import '../Provider/CartDataStateMgmt.dart';
import '../models/homeMenuModel.dart';
import '../networking/api_base_helper.dart';
import '../sidemenu/side_menu.dart';
import '../ui/tab_child.dart';
import '../ui/food_cart.dart';
import '../ui/globals.dart' as globals;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<Data> data = [];
  var rating = '-',
      openingTime = '--:--',
      closingTime = '--:--',
      location = 'loading..',
      deliveryCharges = '0',
      collectionTime = '30';

  late Map mapResponse, dataResponse;
  late Future getRestaurantDataInstance;
  late Future<List<Data>> getHomeDataInstance;
  int initPosition = 1;
  late TabController tabController;
  int currentTabIndex = 0;
  final AutoScrollController autoScrollController = AutoScrollController();

  @override
  void initState() {
    getHomeDataInstance = getHomeData();
    getRestaurantDataInstance = getRestaurantData();
    //getHomeMenuData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorGrey,
        resizeToAvoidBottomInset: true,
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
                color: colorOrange,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.call),
                  onPressed: () {}),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getHomeDataInstance,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/home_pre_top.svg',
                              height: 320,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.bottomCenter,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 19),
                              height: 45,
                              width: 100,
                              child: const RefreshProgressIndicator(
                                backgroundColor: Colors.white,
                                color: colorOrange,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/home_pre_bottom.svg',
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ],
                        ),
                      );
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasError) {
                        final error = snapshot.error;
                        return Align(
                            alignment: Alignment.topCenter,
                            child: Text('$error'));
                      } else {
                        if (data.isEmpty) {
                          return AlertDialog(
                            title: const Text("Failed :("),
                            titleTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                            content: const Text("No Internet Connection"),
                            actionsOverflowButtonSpacing: 20,
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    SystemNavigator.pop();
                                  },
                                  child: const Text(
                                    "Close",
                                    style: TextStyle(color: colorBlue),
                                  ),
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return HomePage();
                                    }));
                                  },
                                  child: const Text("Retry"),
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(colorOrange),
                                  )),
                            ],
                          );
                        } else {
                          return CustomScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: autoScrollController,
                            slivers: [
                              SliverAppBar(
                                  backgroundColor: colorGrey,
                                  elevation: 0.0,
                                  leading: const SizedBox.shrink(),
                                  collapsedHeight: 330,
                                  flexibleSpace: Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 320,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                      ),
                                    ),
                                    child: homeDetailHeader(),
                                  )), //profileHeader
                              SliverAppBar(
                                  backgroundColor: colorGrey,
                                  elevation: 0.0,
                                  floating: true,
                                  leading: const SizedBox.shrink(),
                                  collapsedHeight: 65,
                                  flexibleSpace: Container(
                                    color: colorGrey,
                                    height: 65,
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 10, 16, 10),
                                    child: TextField(
                                      cursorColor: colorBlue,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFFFFFFF),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                        /* -- Text and Icon -- */
                                        hintText: "Search...",
                                        hintStyle: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFB3B1B1),
                                        ),
                                        // TextStyle
                                        suffixIcon: const Icon(
                                          Icons.search,
                                          size: 20,
                                          color: Color(0xFF224656),
                                        ),
                                        // Icon
                                        /* -- Border Styling -- */
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              45.0), // BorderSide
                                        ),
                                        // OutlineInputBorder
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                          borderSide: const BorderSide(
                                            width: 1.0,
                                            color: Colors.white,
                                          ), // BorderSide
                                        ),
                                        // OutlineInputBorder
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                          borderSide: const BorderSide(
                                            width: 1.0,
                                            color: Colors.white,
                                          ), // BorderSide
                                        ), // OutlineInputBorder
                                      ), // InputDecoration
                                    ), // TextField
                                  )), //searchBar
                              SliverAppBar(
                                elevation: 1,
                                shadowColor: colorGrey,
                                pinned: true,
                                leading: const SizedBox.shrink(),
                                backgroundColor: colorGrey,
                                collapsedHeight: 54,
                                toolbarHeight: 40,
                                flexibleSpace: Container(
                                  padding: const EdgeInsets.only(
                                      top: 9, bottom: 9, left: 11, right: 16),
                                  height: 54,
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        data.length,
                                        (index) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(left: 6),
                                            height: 36,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                autoScrollController
                                                    .scrollToIndex(index,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    1200),
                                                        preferPosition:
                                                            AutoScrollPosition
                                                                .begin)
                                                    .then((_) {
                                                  autoScrollController
                                                      .highlight(index);
                                                });
                                              },
                                              style: ButtonStyle(
                                                  padding:
                                                      const MaterialStatePropertyAll(
                                                          EdgeInsets.symmetric(
                                                              horizontal: 14,
                                                              vertical: 11)),
                                                  backgroundColor:
                                                      const MaterialStatePropertyAll(
                                                          Colors.white),
                                                  overlayColor:
                                                      const MaterialStatePropertyAll(
                                                          colorOrange),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  41.0))),
                                                  textStyle:
                                                      MaterialStateProperty.resolveWith((states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color: Colors.white);
                                                    } else {
                                                      return const TextStyle(
                                                        color: colorBlue,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                      );
                                                    }
                                                  })),
                                              // ),
                                              child: Text(
                                                data[index].name.toString(),
                                                style: const TextStyle(
                                                  color: colorBlue,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ), // tabBar
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return AutoScrollTag(
                                    key: ValueKey(index),
                                    controller: autoScrollController,
                                    index: index,
                                    highlightColor:
                                        Colors.black.withOpacity(0.06),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 16),
                                          padding: const EdgeInsets.all(7),
                                          width: double.infinity,
                                          height: 40,
                                          child: FittedBox(
                                            child: Text(
                                              data[index].name.toString(),
                                              style: const TextStyle(
                                                color: colorLightBlue,
                                              ),
                                            ),
                                            fit: BoxFit.contain,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ),
                                        TabChild(
                                          tabIndex: index,
                                          homeData: data,
                                        ),
                                      ],
                                    ),
                                  );
                                }, childCount: data.length),
                              ), //itemList
                            ],
                          );
                        }
                      }
                  }
                },
              ),
            ),
            Consumer<CartStateMgmt>(
              builder: (context, cart, child) {
                return Visibility(
                    visible: cart.cartVisible,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 2, 16, 9),
                      color: colorGrey,
                      height: 67,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 231,
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              decoration: const BoxDecoration(
                                color: Color(0xFF51C800),
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(7)),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${cart.cartItems.length} Item  /  ${CartStateMgmt.deFormat(cart.getPriceSum().toString())} €',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 97,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FoodCart()));
                              },
                              child: Container(
                                // padding: const EdgeInsets.only(right: 15),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF407E16),
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(7)),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'View Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ],
        ));
  }
/*

  Future<void> getHomeMenuData() async {
    try {
      final response = await ApiBaseHelper()
          .get(ApiBaseHelper.home, "token");
      DataListResponseModel model = DataListResponseModel.fromJson(
          ApiBaseHelper().returnResponse(context, response));
      if (model.success!) {
        print(response.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }*/

  Future<List<Data>> getHomeData() async {
    print("model response");
    try {
      final response = await ApiBaseHelper()
          .getwith(ApiBaseHelper.home + "/62148771e77a130023ba78ce");

      homemodelmenu model = homemodelmenu
          .fromJson(ApiBaseHelper().returnResponse(context, response));
      // print("ResponseData " + model.data.toString());
      if (model.success == true) {
        if (model.data!.isNotEmpty) {
          data = model.data!;
          print("DATA: " + data.length.toString());
        }
        // print("itemList");
        // print(tabname);
        // print(response.toString());
      }
    } catch (e) {
      print(e.toString());
    }
    tabController =
        TabController(length: data.length, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });

    return data;
  }

  Future<void> getRestaurantData() async {
    print("second model response");
    try {
      final response = await ApiBaseHelper().getwith(
          ApiBaseHelper.restaurantProfile + "/62148771e77a130023ba78ce");

      if (response.statusCode == 200) {
        setState(() {
          mapResponse = json.decode(response.body);
          dataResponse = mapResponse['data'];
          rating = dataResponse['review'].toString();
          openingTime = dataResponse['openTime'].toString();
          closingTime = dataResponse['closeTime'].toString();
          location = dataResponse['location'].toString();
          deliveryCharges = dataResponse['deliveryCharges'].toString();
          collectionTime = dataResponse['collectionTime'].toString();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget homeDetailHeader() {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width,
              height: 150,
              child: Image.asset(
                'assets/images/bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(
                    right: 10, top: 98),
                child: Align(
                    alignment:
                    Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors
                              .transparent,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 80,
                            decoration:
                            BoxDecoration(
                              color:
                              colorOrange,
                              border:
                              Border.all(
                                color:
                                colorOrange,
                              ),
                              borderRadius:
                              const BorderRadius
                                  .only(
                                topLeft: Radius
                                    .circular(
                                    10),
                                topRight: Radius
                                    .circular(
                                    10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                rating,
                                style: const TextStyle(
                                    color: Colors
                                        .white,
                                    fontSize:
                                    17,
                                    fontFamily:
                                    fontBold,
                                    fontWeight:
                                    FontWeight
                                        .bold),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            padding:
                            const EdgeInsets
                                .all(5),
                            decoration:
                            BoxDecoration(
                              color:
                              Colors.white,
                              border:
                              Border.all(
                                color:
                                colorOrange,
                              ),
                              borderRadius:
                              const BorderRadius
                                  .only(
                                bottomLeft: Radius
                                    .circular(
                                    10),
                                bottomRight:
                                Radius
                                    .circular(
                                    10),
                              ),
                            ),
                            child: Column(
                              children: const [
                                Text(
                                  "2,142",
                                  style: TextStyle(
                                      color:
                                      colorBlue,
                                      fontSize:
                                      11,
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Bewertungen",
                                  style: TextStyle(
                                      color:
                                      colorLightBlue,
                                      fontSize:
                                      11),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 85),
              child: Align(
                  alignment:
                  Alignment.bottomLeft,
                  child: SizedBox(
                    height: 30,
                    width: 250,
                    child: Row(
                      children: [
                        Flexible(
                            flex: 3,
                            child: Container(
                              height: 30,
                              decoration:
                              const BoxDecoration(
                                color:
                                colorGreen,
                                borderRadius:
                                BorderRadius
                                    .only(
                                  bottomLeft: Radius
                                      .circular(
                                      5),
                                  topLeft: Radius
                                      .circular(
                                      5),
                                ),
                              ),
                              padding:
                              const EdgeInsets
                                  .all(3),
                              child:
                              const Center(
                                  child:
                                  Text(
                                    "Geoffnet",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        12),
                                  )),
                            )),
                        Flexible(
                          flex: 7,
                          child: Container(
                            height: 30,
                            padding:
                            const EdgeInsets
                                .all(3),
                            decoration:
                            const BoxDecoration(
                              color:
                              Colors.white,
                              borderRadius:
                              BorderRadius
                                  .only(
                                bottomRight:
                                Radius
                                    .circular(
                                    5),
                                topRight: Radius
                                    .circular(
                                    5),
                              ),
                            ),
                            child: Center(
                                child: Text(
                                  "Öffnungszeiten: $openingTime - $closingTime",
                                  style:
                                  const TextStyle(
                                      fontSize:
                                      12),
                                )),
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding:
            const EdgeInsets.only(left: 10),
            child: RichText(
              text: const TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                      'Mindestbestellwert : ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: ' 0,00 €',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold,
                          color:
                          Colors.orange)),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 10, right: 10, top: 2),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding:
                        const EdgeInsets
                            .all(2),
                        margin: const EdgeInsets
                            .all(3),
                        child: Row(
                          children: [
                            Container(
                              padding:
                              const EdgeInsets
                                  .all(4),
                              decoration: const BoxDecoration(
                                  color:
                                  colorGrey,
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          4))),
                              child: Row(
                                children: [
                                  SvgPicture
                                      .asset(
                                    'assets/images/time.svg',
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    " $collectionTime min ",
                                    style: const TextStyle(
                                        color:
                                        colorBlue,
                                        fontSize:
                                        12,
                                        fontFamily:
                                        fontBold,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            RichText(
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style:
                                const TextStyle(
                                  fontSize:
                                  14.0,
                                  color: Colors
                                      .black,
                                ),
                                children: <
                                    TextSpan>[
                                  TextSpan(
                                      text:
                                      ' $deliveryCharges€ ',
                                      style: const TextStyle(
                                          fontSize:
                                          15,
                                          fontWeight: FontWeight
                                              .bold,
                                          color:
                                          colorOrange)),
                                  const TextSpan(
                                      text:
                                      'Delivery fee',
                                      style: TextStyle(
                                          fontSize:
                                          15,
                                          fontWeight: FontWeight
                                              .bold,
                                          color:
                                          Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment:
                      Alignment.centerLeft,
                      padding:
                      const EdgeInsets.all(
                          8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons
                                .location_on_outlined,
                            color: Color(
                                0xFFF86600),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Flexible(
                            child: Text(
                              location,
                              style: const TextStyle(
                                  color:
                                  colorBlue,
                                  fontSize: 12,
                                  overflow:
                                  TextOverflow
                                      .ellipsis,
                                  fontFamily:
                                  fontBold,
                                  fontWeight:
                                  FontWeight
                                      .normal),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 66,
                width: 66,
                decoration: const BoxDecoration(
                  color: colorGreen,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/txt.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
