import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:namastey_india/Provider/UserDataStateMgmt.dart';
import 'package:namastey_india/main.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shimmer/shimmer.dart';
import '../constant/colors.dart';
import '../Provider/CartDataStateMgmt.dart';
import '../models/homeMenuModel.dart';
import '../models/restaurantProfileModel.dart';
import '../networking/api_base_helper.dart';
import '../permissons/userLocation.dart';
import '../sidemenu/side_menu.dart';
import '../ui/tab_child.dart';
import '../ui/food_cart.dart';
import 'homeDetailsHeader.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  List<Data> data = <Data>[];
  List<Data> dataCopy = <Data>[];
  Future? getRestaurantDataInstance;
  late Future<List<Data>> getHomeDataInstance;
  late TabController tabController;
  int currentTabIndex = 0;
  AutoScrollController itemsAutoScrollController = AutoScrollController();
  AutoScrollController menuAutoScrollController = AutoScrollController();
  late UserLocation userLocation;
  late var cart = Provider.of<CartStateMgmt>(context,listen: false);
  double _scrollPosition = 0;

  @override
  void initState() {

    itemsAutoScrollController.addListener(() {

      // menuAutoScrollController.position;
      _scrollPosition = itemsAutoScrollController.position.pixels;

      print(_scrollPosition);
      print(itemsAutoScrollController.position);

      setState(() {
      });

    });

    getHomeDataInstance = getHomeData();
    getRestaurantDataInstance = getRestaurantData();
    userLocation = UserLocation(context);
    Future.delayed(Duration.zero,() {
      loadUserLocation(context);
    });
    //getHomeMenuData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                              Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: const Color(0x1FF0EEFC).withOpacity(0.1),
                                period: const Duration(milliseconds: 1300),
                                direction: ShimmerDirection.ltr,
                                enabled: true,
                                child: SvgPicture.asset(
                                  'assets/images/home_pre_top.svg',
                                  height: 320,
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 20, top: 19),
                                height: 45,
                                width: 45,
                                child: const RefreshProgressIndicator(
                                  backgroundColor: Colors.white,
                                  color: colorOrange,
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: colorGrey,
                                direction: ShimmerDirection.rtl,
                                period: const Duration(milliseconds: 1300),
                                enabled: true,
                                child: SvgPicture.asset(
                                  'assets/images/home_pre_bottom.svg',
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                ),
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
                        }else {
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
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.white),
                                    ),
                                    child: const Text(
                                      "Close",
                                      style: TextStyle(color: colorBlue),
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const HomePage();
                                      }));
                                    },
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(colorOrange),
                                    ),
                                    child: const Text("Retry")),
                              ],
                            );
                          } else {
                            return CustomScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: itemsAutoScrollController,
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
                                      child: homeHeader(),
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
                                        ), //
                                        onChanged: (v){

                                          filterSearchResults(v);
                                        },// InputDecoration
                                      ), // TextField
                                    )), //searchBar
                                SliverAppBar(
                                  elevation: 1,
                                  shadowColor: colorGrey,
                                  pinned: true,
                                  leading: const SizedBox.shrink(),
                                  backgroundColor: colorGrey,
                                  collapsedHeight: 55,
                                  toolbarHeight: 40,
                                  flexibleSpace: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 0, bottom: 0, left: 0, right: 0),
                                        height: 55,
                                        width: double.infinity,
                                        child: SingleChildScrollView(
                                          controller: menuAutoScrollController,
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 11),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: List.generate(
                                                  dataCopy.length,
                                                      (index) {
                                                    return AutoScrollTag(
                                                      key: ValueKey(index),
                                                      controller: menuAutoScrollController,
                                                      index: index,
                                                      highlightColor:
                                                      Colors.black.withOpacity(0.06),
                                                      child: Container(
                                                        margin:
                                                        const EdgeInsets.only(top: 9, left: 6, bottom: 11),
                                                        height: 36,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            itemsAutoScrollController
                                                                .scrollToIndex(index,
                                                                duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                    1200),
                                                                preferPosition:
                                                                AutoScrollPosition
                                                                    .begin)
                                                                .then((_) {
                                                              itemsAutoScrollController
                                                                  .highlight(index);
                                                            });
                                                            FocusManager.instance.primaryFocus?.unfocus();
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
                                                          child: Text(
                                                            dataCopy[index].name.toString(),
                                                            style: const TextStyle(
                                                              color: colorBlue,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image : DecorationImage(
                                            image:  const AssetImage('assets/images/linearGradient.png'),
                                            colorFilter: ColorFilter.mode(colorGrey.withOpacity(0.2), BlendMode.softLight),
                                              fit: BoxFit.fill,
                                          ),
                                          ),
                                          height: 55,
                                          width: 30,

                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        child: RotatedBox(
                                          quarterTurns: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image : DecorationImage(
                                                image:  const AssetImage('assets/images/linearGradient.png'),
                                                colorFilter: ColorFilter.mode(colorGrey.withOpacity(0.5), BlendMode.softLight),
                                                fit: BoxFit.fitHeight,
                                                alignment: Alignment.centerLeft
                                              ),
                                            ),
                                            height: 55,
                                            width: 18,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ), // tabBar
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    return AutoScrollTag(
                                      key: ValueKey(index),
                                      controller: itemsAutoScrollController,
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
                                              fit: BoxFit.contain,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                dataCopy[index].name.toString(),
                                                style: const TextStyle(
                                                  color: colorLightBlue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TabChild(
                                            tabIndex: index,
                                            homeData: dataCopy,
                                          ),
                                        ],
                                      ),
                                    );
                                  }, childCount: dataCopy.length),
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
                                  color: colorGreen,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(7)),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${cart.cartItems.length} Item  /  ${CartStateMgmt.deFormat(cart.getSubTotal().toStringAsFixed(2))} €',
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
                                  Get.to(
                                          () => const FoodCart(), //next page class
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.linear,
                                      transition: Transition.rightToLeftWithFade//transition effect
                                  );
                                  FocusManager.instance.primaryFocus?.unfocus();
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
          )),
    );
  }

  Future<void> loadUserLocation(BuildContext context) async {
    final userData = Provider.of<UserDataStateMgmt>(context,listen: false);
    userData.userAddressByLoc = await userLocation.getLocation();
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
    print("home menu model response");
    try {
      final response = await ApiBaseHelper()
          .getwith("${ApiBaseHelper.home}/6273613dcec5ef002379dcfd");
      //62148771e77a130023ba78ce

      HomeMenuModel model = HomeMenuModel
          .fromJson(ApiBaseHelper().returnResponse(context, response));

      HomeMenuModel modelCopy = HomeMenuModel
          .fromJson(ApiBaseHelper().returnResponse(context, response));

      if (model.success == true) {
        if (model.data!.isNotEmpty) {
          data = model.data!;
          dataCopy = modelCopy.data!;
          print("DATA: ${data.length}");
        }
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
    print("restaurant profile model response");
    try {
      final response = await ApiBaseHelper().getwith(
          "${ApiBaseHelper.restaurantProfile}/6273613dcec5ef002379dcfd");
      //62148771e77a130023ba78ce
      if (response.statusCode == 200) {

        RestaurantProfileModel rpm = restaurantProfileModelFromJson(response.body.toString());
        cart = Provider.of<CartStateMgmt>(context, listen: false);
        cart.restaurantData = rpm.data;
        final UserDataStateMgmt user = Provider.of<UserDataStateMgmt>(context,listen: false);
        user.acceptedPostcodes = cart.restaurantData?.acceptedPostcodes ?? [];

      }
    } catch (e) {
      print(e.toString());
    }
  }

  void filterSearchResults(String v) {
    final List<Data> menuList = data;
    List<Data> searchMenuList = <Data>[];

    if(v.isEmpty){
      print('empty');
      searchMenuList = menuList;

    }else{
      print('not empty');
      print(v);


      // for loop method
      for (Data menu in menuList) {

        List<Item> searchItemList = <Item>[];

        for (Item item in menu.items!) {
          if (item.name!.toLowerCase().contains(v.toLowerCase())) {
            searchItemList.add(item);
          }
        }

        if(searchItemList.isNotEmpty){
          menu.items?.clear();
          menu.items?.addAll(searchItemList);
          searchMenuList.add(menu);
        }
      }

      //where method
      //   searchMenuList = menuList.where((cat) {
      //     cat.items = cat.items!.where((item) => item.name!.toLowerCase().contains(v.toLowerCase())).toList();
      //     return cat.items!.isNotEmpty ? true: false;
      //   }).toList();

    }

    dataCopy.clear();
    setState(() {
      dataCopy = searchMenuList;
    });
    return;
  }
}
