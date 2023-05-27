import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherSideMsgCard extends StatelessWidget {
  const OtherSideMsgCard(
      {Key? key, required this.text, required this.time, required this.isImage})
      : super(key: key);
  final String text;
  final String time;
  final bool isImage;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            // color: Colors.white,
            color: Theme.of(context).scaffoldBackgroundColor,
            margin: const EdgeInsets.only(top: 15, left: 15),
            child: Stack(
              children: [
                isImage
                    ? Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/defaultt.png',
                                  image: text,
                                ).image,
                                fit: BoxFit.cover)))
                    : Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: ((text.length % 47)) < 38 ? 10 : 25,
                          left: 10,
                          right: text.length > 37 ? 20 : 75,
                        ),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        )),
                text.length > 30
                    ? const SizedBox(
                        width: 45,
                      )
                    : const SizedBox(width: 0),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Text(time,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
