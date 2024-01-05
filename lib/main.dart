// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:watch/details.dart';
// import 'package:transparent_image/transparent_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List cats = [];

  Future getBreeds() async {
    Uri uri = Uri.https("api.thecatapi.com", "v1/breeds");

    var response = await http.get(uri);

    return jsonDecode(response.body);
  }

  Future getCat() async {
    Uri uri = Uri.https(
      "api.thecatapi.com",
      "v1/images/search",
      {
        "limit": '10',
        "has_breeds": "true",
      },
    );

    var response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "x-api-key":
            "live_d2i79i01h05QnyG50TOfplAybMka88txVeuLi19bbT9YmYS4MnLYu5wuGKDlQ53E"
      },
    );

    // print(jsonDecode(response.body)[0].runtimeType);
    // return jsonDecode(response.body);

    setState(() {
      cats.addAll(jsonDecode(response.body));
      cats = cats.where(
        (cat) {
          double ratio = cat['width'] / cat['height'];
          return ratio > 1.1 || ratio < 0.9;
        },
      ).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCat();
  }

  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      // backgroundColor: const Color.fromARGB(255, 1, 10, 0),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color.fromARGB(255, 11, 5, 44),
            Color.fromARGB(255, 26, 103, 192)
          ],
        )),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: cats.length,
                disableGesture: true,
                carouselController: carouselController,
                itemBuilder: (context, int item, int pageIndex) {
                  // var index = item ~/ 2;
                  print(pageIndex);
                  if (item >= cats.length - 10) {
                    getCat();
                    print("half of the items");
                  }

                  // if the ration is under 0.95 then the  widget should be treted differently
                  // double ratio = cats[item]['width'] / cats[item]['height'];

                  // if (ratio < 0.95) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailsScreen(cat: cats[item]);
                        })),
                        child: Hero(
                          tag: cats[item]['url'],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              cats[item]['url'],
                              height: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: LoadingAnimationWidget.inkDrop(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black26,
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1.5,
                          ),
                          child: Text(
                            cats[item]["breeds"][0]["name"],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  );
                },
                options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  enableInfiniteScroll: false,
                  viewportFraction: .99999,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
