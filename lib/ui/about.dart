import 'package:flutter/material.dart';
import 'package:namastey_india/constant/colors.dart';

import '../sidemenu/side_menu.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  List<String> images = [
    "https://thumbs.dreamstime.com/b/print-219198729.jpg",
    "https://thumbs.dreamstime.com/b/print-219198729.jpg",
    "https://thumbs.dreamstime.com/b/print-219198729.jpg",
    "https://thumbs.dreamstime.com/b/print-219198729.jpg",
    "https://thumbs.dreamstime.com/b/print-219198729.jpg",
    "https://thumbs.dreamstime.com/b/print-219198729.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon:
                      const Icon(Icons.bar_chart_rounded, color: Colors.black),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              );
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
                color: Colors.black,
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                }),
          ],
        ),
        body: Container(
            color: const Color(0xFFF0EEFC),
            child: ListView(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Image.asset(
                  'assets/images/bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 85,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Container(
                      margin: const EdgeInsets.only(top: 25, left: 17),
                      child: const Text(
                        " About Us ",
                        style: TextStyle(
                            color: colorBlack,
                            fontSize: 22,
                            fontWeight: FontWeight.w500 ),
                      ))),
              Container(
                  margin: const EdgeInsets.only(left: 15, right: 25, top: 15),
                  child: const Text(
                    " Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
                    style: TextStyle(
                        color: Color(0xFF7C75AF),
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.w400),
                  )),
              Container(
                  height: 280,
                  width: 300,
                  // constraints: const BoxConstraints.tightForFinite(width: 200, height: double.maxFinite ) ,
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6.0,
                            mainAxisSpacing: 6.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(images[index]);
                    },
                  )),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                child: Text(
                  'more..',
                ),
              )
            ])));
  }
}
