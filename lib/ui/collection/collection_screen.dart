import 'package:bookmark/model/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionScreen extends StatelessWidget {
  Book? data;
  CollectionScreen({this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 20),
                  height: 450,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      image: DecorationImage(
                        image: NetworkImage(
                          data!.thumbnail!,
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.4,
                      )),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      data!.thumbnail!,
                      fit: BoxFit.cover,
                    ),
                    // PhotoView(
                    //   // customSize: Size(Get.width - 40, 450),
                    //   backgroundDecoration: const BoxDecoration(
                    //     color: Colors.transparent,

                    //   ),
                    //   imageProvider:

                    // NetworkImage(
                    //   data!.image,

                    // ),

                    // ),
                  ),
                ),
                Positioned(
                    top: 20,
                    left: 10,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black45,
                          child: Icon(CupertinoIcons.back)),
                    ))
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: data!.item!.length * 155,
              // height: 4,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return const SizedBox(height: 15);
                },
                separatorBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(children: [
                      Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 135,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: const AssetImage(
                                        "assets/images/defaultt.png"),
                                    image: NetworkImage(data!.item![i]))),
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor:
                                      data!.isLiked ? Colors.white : Colors.red,
                                  child: Icon(
                                    CupertinoIcons.heart_fill,
                                    color: data!.isLiked
                                        ? Colors.red.shade500
                                        : Colors.white,
                                  ))),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        height: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data!.title!,
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 208, 0),
                                  child: Center(
                                    child: Icon(Icons.star,
                                        size: 20, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  " - 4.5",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: Get.width - 215,
                              child: RichText(
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: data!.des ??
                                        "Tjis skfdvk vdkfmi vfid j vfjdif",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                            // Text(
                            //   data!.des!,
                            //   style: const TextStyle(
                            //       fontSize: 22,
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.w500),
                            // ),
                          ],
                        ),
                      ),
                    ]),
                  );
                },
                itemCount: data!.item!.length,
                // itemCount: 4,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
