import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namastey_india/constant/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../Provider/CartDataStateMgmt.dart';
import '../models/homeMenuModel.dart';
import '../ui/globals.dart' as globals;

class TabChild extends StatefulWidget {
  final int tabIndex;
  final List<Data> homeData;

  const TabChild({Key? key, required this.tabIndex, required this.homeData})
      : super(key: key);
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<TabChild> {
  //parse double to de locale
  static String deFormat(String val) {
    // final deFormat = NumberFormat.decimalPattern('de',);
    final deFormat = NumberFormat('###.00#', 'de');
    return deFormat.format(double.parse(val));
  }
  //convert back to double
  static num enFormat(String val) {
    final deFormat = NumberFormat.decimalPattern(
      'de',
    );
    return deFormat.parse(val);
  }

  List<Items> itemsList = [];
  List<OptionsModel> optionList = [
    OptionsModel(name: 'Mango-chutney',price: 7.90),
    OptionsModel(name: 'Minzsauce',price: 9.00),
    OptionsModel(name: 'Ohne Sauce',price: 11.00),
  ];
  List<ToppingModel> toppingList = [
    ToppingModel(name: 'Ananas', price: 2.00),
    ToppingModel(name: 'Blumenkohl', price: 2.00),
  ];

  @override
  void initState() {
    loadTabChild(widget.tabIndex, widget.homeData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemsList.length,
        (index) => GestureDetector(
          onTap: () {
            _onItemPressed(index);
          },
          child: Container(
            padding: const EdgeInsets.all(7),
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.width * 0.19,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.19 - 14,
                  width: MediaQuery.of(context).size.width * 0.19 - 14,
                  child: Image.asset(
                    'assets/images/tab_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: 23,
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemsList[index].name.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                deFormat(itemsList[index].price.toString()) +
                                    " €",
                                style: const TextStyle(
                                    color: colorOrange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            _onItemInfoPressed(index);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  9, 4, 6, 9),
                              child:
                                  // Image.asset(
                                  //     "assets/images/info_mark.png"),
                                  SvgPicture.asset(
                                'assets/images/info_mark.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox.shrink()
                ),
                Container(
                  color: Colors.transparent,
                  height: 26,
                  width: 26,
                  child: Consumer<CartStateMgmt>(builder: (context, cart, child) {
                    int? itemCount;
                    try {itemCount = cart.cartItems[cart.cartItems.indexWhere((e) => e.item == itemsList[index])].count;
                    } on RangeError {
                      itemCount = 0;
                    }
                    return Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        color: itemCount == 0 ? Colors.white : const Color(0xFF51C800),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                            // itemsList[index].name.toString()
                          itemCount.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight:FontWeight.w700),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemPressed(int itemIndex) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (context)
    {
      return
        Consumer<CartStateMgmt>(builder: (context, cart, child) {
      return Container(
                  color: const Color(0x00000000),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsetsDirectional.fromSTEB(
                              15, 22, 0, 16),
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.homeData[widget.tabIndex].items![itemIndex]
                                .name
                                .toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                          child: Divider(
                            color: Color(0xFFBAB2E9),
                            height: 10,
                            thickness: 1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.fromSTEB(
                              16, 20, 0, 6),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Option wählen',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 15),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                              itemCount: 3,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    cart.changeOptionIndex(index);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5),
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Icon(
                                                cart.optionIndex == index
                                                    ? Icons.radio_button_checked
                                                    : Icons.radio_button_off,
                                                color: colorOrange
                                            )),
                                        Expanded(
                                            child: Text(optionList[index].name.toString(),
                                                style: const TextStyle(
                                                    color: colorBlue))),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text('${deFormat(optionList[index].price.toString())} €',
                                              style: const TextStyle(color: colorBlue,
                                                  fontWeight: FontWeight
                                                      .w700)),)
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.fromSTEB(
                              16, 8, 0, 6),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Wählen Sie Topping',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 15),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    cart.changeToppingIndex(index);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5),
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Icon(
                                                cart.toppingIndex == index
                                                    ? Icons.radio_button_checked
                                                    : Icons.radio_button_off,
                                                color: colorOrange
                                            )),
                                        Expanded(
                                            child: Text(toppingList[index].name.toString(),
                                                style: const TextStyle(
                                                    color: colorBlue))),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text('${deFormat(toppingList[index].price.toString())} €',
                                              style: const TextStyle(color: colorBlue,
                                                  fontWeight: FontWeight
                                                      .w700)),)
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cart.add(
                                widget.homeData[widget.tabIndex]
                                    .items![itemIndex]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: cart.cartItems
                                  .where((e) =>
                              e.item ==
                                  widget.homeData[widget.tabIndex]
                                      .items![itemIndex])
                                  .isEmpty
                                  ? const Color(0xFFF86600)
                                  : colorGreen,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Weiter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0EEFC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                  ),
                );
          });
    });
  }

  void _onItemInfoPressed(int itemIndex) {
    int? allergenCount =
        widget.homeData[widget.tabIndex].items![itemIndex].allergies!.length;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0x00000000),
            child: Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsetsDirectional.fromSTEB(15, 22, 0, 16),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Produktinfo',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                      child: Divider(
                        color: Color(0xFFBAB2E9),
                        thickness: 1,
                        height: 10,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.fromSTEB(15, 15, 45, 26),
                      child: Text(
                        widget.homeData[widget.tabIndex].items![itemIndex]
                            .description
                            .toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Color(0xFF7C75AF),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Visibility(
                        visible: allergenCount == 0 ? false : true,
                        child: Column(children: [
                          Container(
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 0, 6),
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Allergene',
                              style: TextStyle(
                                  color: Color(0xFF2E266F),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.fromSTEB(
                                16, 12, 25, 20),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: allergenCount,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(3),
                                        width: 10.0,
                                        height: 10.0,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFF86600),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            widget
                                                .homeData[widget.tabIndex]
                                                .items![itemIndex]
                                                .allergies![index]
                                                .name
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color(0xFF7C75AF),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ]))
                  ]),
              decoration: const BoxDecoration(
                color: Color(0xFFF0EEFC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
          );
        });
  }

  void loadTabChild(int index, List<Data> homeData) {

    for (int i = 0; i < widget.homeData[index].items!.length; i++) {
      itemsList.add(widget.homeData[index].items![i]);
    }
  }
}

class OptionsModel {
  String? name;
  double? price;

  OptionsModel(
      {
        this.name,
        this.price
      });
}

class ToppingModel {
  String? name;
  double? price;

  ToppingModel(
      {
        this.name,
        this.price
      });
}
