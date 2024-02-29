import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:namastey_india/Provider/CartDataStateMgmt.dart';
import 'package:provider/provider.dart';
import '../constant/colors.dart';

class homeHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<CartStateMgmt>(builder: (context, cart, child) {
      return
        Column(
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
                                    '${cart.restaurantData?.review ?? 5 }',
                                    style: const TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        17,
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
                                  BoxDecoration(
                                    color:
                                    cart.restaurantData?.isActive == true ? colorGreen : colorOrange,
                                    borderRadius:
                                    const BorderRadius
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
                                  Center(
                                      child:
                                      FittedBox(
                                        child: Text(
                                          cart.restaurantData?.isActive == true ? "Geoffnet" : "Geschlossen",
                                          style: const TextStyle(
                                              color: Colors
                                                  .white,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                              12),
                                        ),
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
                                      "Öffnungszeiten: ${cart.restaurantData?.openTime??'--:--'} - ${cart.restaurantData?.closeTime ?? '--:--'}",
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
                  text:TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text:
                          'Mindestbestellwert : ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                              FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: '${cart.restaurantData?.minimumOrder ?? '0'},00 €',
                          style: const TextStyle(
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
                                        " ${cart.restaurantData?.collectionTime ?? '-'} min ",
                                        style: const TextStyle(
                                            color:
                                            colorBlue,
                                            fontSize:
                                            12,
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
                                          ' ${cart.restaurantData?.deliveryCharges??'0'} € ',
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
                                  cart.restaurantData?.location??'loading..',
                                  style: const TextStyle(
                                      color:
                                      colorBlue,
                                      fontSize: 12,
                                      overflow:
                                      TextOverflow
                                          .ellipsis,
                                      fontWeight:
                                      FontWeight
                                          .w500),
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
    },);

  }
}