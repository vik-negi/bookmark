import 'package:bookmark/ui/register/login_vm.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginVM>(builder: (vm) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Reset Password",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          // const SizedBox(height: 20),
          Text(
            "Please Enter your new password.",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text("Password",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              )),
          const SizedBox(height: 10),
          TextFormField(
            // focusNode: vm.forgotEmailFocus,
            controller: vm.passwordController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(36),
              ),
              prefixIcon: const Icon(Icons.email),
              fillColor: Colors.white,
              hintText: "123@&abc^AL",
              contentPadding: const EdgeInsets.only(
                  left: 15, top: 15, bottom: 15, right: 15),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text("Confirm - Password",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              )),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: vm.forgotEmailFocus,
            controller: vm.confirmpasswordController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(36),
              ),
              prefixIcon: const Icon(Icons.email),
              fillColor: Colors.white,
              hintText: "123@&abc^AL",
              contentPadding: const EdgeInsets.only(
                  left: 15, top: 15, bottom: 15, right: 15),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // _mobileNoFocus.unfocus();
              if (vm.passwordController.text.trim() == "" ||
                  vm.confirmpasswordController.text.trim() == "") {
                showSnackBar(Get.context!, "Please enter all fields", true);
              } else if (vm.passwordController.text.trim() !=
                  vm.confirmpasswordController.text.trim()) {
                showSnackBar(Get.context!,
                    "Password and confirm password must be same", true);
              } else {
                vm.changeForgotPassword();
              }
            },
            child: Container(
              height: 55,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
