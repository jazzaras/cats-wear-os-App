import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.cat});

  final Map cat;

  @override
  Widget build(BuildContext context) {
    double ratio = cat['width'] / cat['height'];

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 3, 26, 0),
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
        child: (ratio > 1.0)
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 150,
                        child: Center(
                          child: Text(
                            cat["breeds"][0]["name"],
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Hero(
                          tag: cat['url'],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              cat['url'],
                              width: MediaQuery.of(context).size.width - 50,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return SizedBox(
                                    height: 10,
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
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                        ),
                        width: MediaQuery.of(context).size.width - 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cat["breeds"][0]["description"],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              )
            : Center(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Hero(
                        tag: cat['url'],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            cat['url'],
                            width: MediaQuery.of(context).size.width / 2,
                            loadingBuilder: (context, child, loadingProgress) {
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              cat["breeds"][0]["name"],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                            Text(
                              cat["breeds"][0]["description"],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 60)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: const Color.fromARGB(255, 5, 0, 31),
    //   body: Center(
    //     child: Row(
    //       children: [
    //         InkWell(
    //           onTap: () => Navigator.of(context).pop(),
    //           child: Hero(
    //             tag: cat['url'],
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(20),
    //               child: Image.network(
    //                 cat['url'],
    //                 width: MediaQuery.of(context).size.width / 2,
    //                 loadingBuilder: (context, child, loadingProgress) {
    //                   if (loadingProgress == null) {
    //                     return child;
    //                   } else {
    //                     return Center(
    //                       child: LoadingAnimationWidget.inkDrop(
    //                         color: Colors.white,
    //                         size: 20,
    //                       ),
    //                     );
    //                   }
    //                 },
    //               ),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 14,
    //           ),
    //           width: MediaQuery.of(context).size.width / 2,
    //           child: SingleChildScrollView(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const SizedBox(height: 40),
    //                 Text(
    //                   cat["breeds"][0]["name"],
    //                   style: const TextStyle(fontSize: 15, color: Colors.white),
    //                 ),
    //                 Text(
    //                   cat["breeds"][0]["description"],
    //                   style: const TextStyle(
    //                     fontSize: 10,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 60)
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
