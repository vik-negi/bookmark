import 'package:avatar_glow/avatar_glow.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:flutter/material.dart';
import 'package:bookmark/widgets/OwnMsgCard.dart';
import 'package:bookmark/widgets/OtherSideMsg.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

bottomModelWidget(BuildContext context) {
  // DiningVM vm = Get.put(DiningVM());
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return GetBuilder<DiningVM>(builder: (vm) {
          return DraggableScrollableSheet(
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: OfflineBuilder(
                            connectivityBuilder: (
                              BuildContext context,
                              ConnectivityResult connectivity,
                              Widget child,
                            ) {
                              final bool connected =
                                  connectivity != ConnectivityResult.none;

                              if (connected) {
                                return SizedBox(
                                    width: Get.width - 20,
                                    // height: height ?? 60,
                                    child: TextFormField(
                                      controller: vm.queryController,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold),
                                      // obscureText: obscure,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade500,
                                          prefixIcon: AvatarGlow(
                                            glowColor: const Color.fromARGB(
                                                255, 226, 53, 53),
                                            endRadius: 30.0,
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            repeat: true,
                                            animate: vm.isAudioListening
                                                ? true
                                                : false,
                                            showTwoGlows: true,
                                            repeatPauseDuration: const Duration(
                                                milliseconds: 10),
                                            child: InkWell(
                                                onTap: () {
                                                  // vm.isAudioListening = true;
                                                  // vm.update();
                                                  vm.startListening(false);
                                                },
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.mic,
                                                    size: 26,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                )),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              vm.update();
                                              vm.sendMessage();
                                            },
                                            child: const Icon(
                                              Icons.send,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          hintText: "Enter your query",
                                          hintStyle: const TextStyle(
                                              fontFamily: 'LexendDeca',
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold),
                                          focusColor: Colors.red,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Please enter your query';
                                        }
                                        return null;
                                      },
                                    ));
                              } else {
                                return SizedBox();
                              }
                            },
                            child: SizedBox()),
                      ),
                      //     const SizedBox(
                      //       height: 15,
                      //     ),
                      //   ],
                      // ),
                      // vm.isLoading
                      //     ? ConstrainedBox(
                      //         constraints: BoxConstraints(
                      //           minHeight: Get.height,
                      //           minWidth: Get.width,
                      //         ),
                      //         child: const Center(
                      //           child: CircularProgressIndicator(),
                      //         ),
                      //       )
                      //     :
                      Container(
                          height: Get.height * 0.8,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: vm.queryMessages.length + 1,
                            itemBuilder: (context, i) {
                              if (vm.queryMessages.isEmpty) {
                                return Container(
                                    // height: Get.height * 0.8,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    child: const Center(
                                      child: Text(
                                          "Ask any question..\ntype 'order Item Name(Paratha) to order'",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ));
                              } else if (i == vm.queryMessages.length) {
                                return vm.replyLoading
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        margin: EdgeInsets.only(
                                            right: Get.width * 0.5,
                                            bottom: 75,
                                            top: 15,
                                            left: 15),
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 25,
                                          left: 10,
                                          right: 75,
                                        ),
                                        child: const Text(
                                          "processing...",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 25,
                                      );
                              }
                              if (!vm.queryMessages[i].isBot) {
                                return OwnMsgCard(
                                    text: vm.queryMessages[i].msg,
                                    time: vm.getTime(
                                        vm.queryMessages[i].time.toString()));
                              } else {
                                return OtherSideMsgCard(
                                    isImage: vm.queryMessages[i].isImage,
                                    text: vm.queryMessages[i].msg.trim(),
                                    time: vm.getTime(
                                        vm.queryMessages[i].time.toString()));
                              }
                            },
                          ))
                    ],
                  ),
                ),
              );
            },
            // ),
          );
        });
      });
}

class TextFormFieldContainer extends StatelessWidget {
  final bool isMobileNumber;
  final String hintText;
  final Function function;
  Function? validator;
  final Widget? suffix;
  final Widget? prefix;
  bool obscure = false;
  double? height;
  double? width;
  TextEditingController controller = TextEditingController();
  TextFormFieldContainer(
      {Key? key,
      this.prefix,
      required this.hintText,
      required this.function,
      required this.controller,
      required this.isMobileNumber,
      this.suffix,
      this.height,
      this.width,
      this.obscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return SizedBox(
          width: width ?? 320,
          // height: height ?? 60,
          child: TextFormField(
            controller: vm.queryController,
            keyboardType:
                isMobileNumber ? TextInputType.number : TextInputType.text,
            style: const TextStyle(
                color: Colors.white70, fontWeight: FontWeight.bold),
            obscureText: obscure,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade500,
                prefixIcon: prefix ?? SizedBox(),
                suffixIcon: suffix ?? SizedBox(),
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontFamily: 'LexendDeca',
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
                focusColor: Colors.red,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter $hintText';
              }
              return null;
            },
          ));
    });
  }
}
