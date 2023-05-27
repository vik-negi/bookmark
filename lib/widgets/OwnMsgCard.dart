import 'package:flutter/material.dart';

class OwnMsgCard extends StatelessWidget {
  const OwnMsgCard({Key? key, required this.text, required this.time})
      : super(key: key);
  final String text;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // color: const Color(0xffdcf8c6),
          color: Color(0xffb3b3ff),
          // color: Theme.of(context).primaryColor,
          margin: const EdgeInsets.only(top: 15, right: 15),
          child: Stack(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 15,
                    left: 10,
                    right: text.length > 37 ? 20 : 75,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  )),
              text.length > 30
                  ? const SizedBox(
                      width: 45,
                    )
                  : const SizedBox(width: 0),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(time,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
