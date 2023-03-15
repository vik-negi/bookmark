import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/register/login.dart';
import 'package:bookmark/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void LoginFirstDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
          content: Container(
            width: Get.width,
            height: 210,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Icon(Icons.error_outline_outlined,
                    color: Color.fromARGB(255, 165, 60, 52), size: 65),
                Text(
                  "Login First",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "You need to login to access this feature",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(26)),
                    child: Center(
                      child: InkWell(
                          onTap: () {
                            Get.off(() => LoginPage());
                          },
                          child: Text("Login",
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor))),
                    ))
              ],
            ),
          ),
        );
      });
}

void showDialogBox(context, String? title, String? msg, bool showBtn) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
          content: Container(
            width: Get.width,
            height: 210,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Icon(Icons.error_outline_outlined,
                    color: Color.fromARGB(255, 165, 60, 52), size: 65),
                Text(
                  title ?? "",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  msg ?? "",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                showBtn
                    ? InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                            height: 45,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(26)),
                            child: Center(
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor),
                              ),
                            )),
                      )
                    : SizedBox()
              ],
            ),
          ),
        );
      });
}

Future<void> noOfDaysDialogBox(context, controller, id, i, singlebook) {
  return showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<DiningVM>(builder: (vm) {
          return AlertDialog(
            contentPadding:
                EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
            content: Container(
              width: Get.width,
              height: 220,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.close,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  Text(
                    "Update Days",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "   Enter no of days, By Default it's 3 days",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    // focusNode: vm.forgotEmailFocus,
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(36),
                      ),
                      fillColor: Color.fromARGB(255, 243, 243, 243),
                      hintText: "",
                      contentPadding: const EdgeInsets.only(
                          left: 15, top: 15, bottom: 15, right: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(36),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      height: 45,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(26)),
                      child: Center(
                        child: InkWell(
                            onTap: () async {
                              await vm.updateNoOfDays(id, i, singlebook);
                              return;
                              // Get.back();
                            },
                            child: vm.callForUpdateDays
                                ? CircularProgressIndicator()
                                : Text("Update",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .backgroundColor))),
                      ))
                ],
              ),
            ),
          );
        });
      });
}
