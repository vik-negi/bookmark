import 'package:bookmark/ui/register/login_vm.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class EnterOtpWidget extends StatelessWidget {
  EnterOtpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginVM>(builder: (vm) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter 4 digit OTP",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20),
          Text(
            "Please Enter OTP sent to get entred mail. If you didn't get OTP, please click on Resend OTP",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          Text("Enter OTP",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              )),
          const SizedBox(height: 20),
          Pinput(
            controller: vm.otpController,
            defaultPinTheme: vm.defaultPinTheme,
            focusedPinTheme: vm.defaultPinTheme.copyDecorationWith(
              border: Border.all(color: Color(0xffD2137B).withOpacity(0.7)),
              borderRadius: BorderRadius.circular(8),
            ),
            submittedPinTheme: vm.defaultPinTheme.copyWith(
              decoration: vm.defaultPinTheme.decoration!.copyWith(
                color: Colors.white,
              ),
            ),
            separator: const SizedBox(width: 30),
            validator: (s) {
              return s!.length < 4 ? 'Pin is incorrect' : null;
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 55,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2 - 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  "Re-send",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              vm.otp == "" ? const SizedBox() : Text(vm.otp),
              InkWell(
                onTap: () {
                  // _mobileNoFocus.unfocus();
                  if (vm.otpController.text.trim() == "") {
                    showSnackBar(Get.context!, "Please enter OTP", true);
                  } else if (vm.otpController.text.trim().length < 4) {
                    showSnackBar(Get.context!, "Please enter all fields", true);
                  } else {
                    vm.verifyOtp(true);
                  }
                },
                child: Container(
                  height: 55,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2 - 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
