import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ShowImage extends StatefulWidget {
  String image;
  String tag;
  String name;
  bool isFileImage = false;
  ShowImage(
      {super.key,
      required this.image,
      required this.name,
      required this.tag,
      this.isFileImage = false});

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            elevation: 0,
            title: SizedBox(
              width: Get.width - 100,
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), onPressed: () => Get.back())),
        body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: Get.width,
            height: Get.height,
            child: Hero(
              tag: widget.tag,
              child: widget.isFileImage
                  ? Image.file(File(widget.image))
                  : FadeInImage.assetNetwork(
                      placeholder: 'assets/images/defaultt.png',
                      image: widget.image),
            )));
  }
}
