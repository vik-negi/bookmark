// https://wa.me/919808923821
import 'package:bookmark/ui/register/login_vm.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:bookmark/widgets/change_password_widget.dart';
import 'package:bookmark/widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isOtpSend = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginVM>(builder: (vm) {
      return InkWell(
        onTap: () {
          if (vm.forgotEmailFocus.hasFocus) {
            vm.forgotEmailFocus.unfocus();
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Color.fromARGB(255, 241, 241, 241),
          ),
          height: 440,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  successPins(vm.isEmailEntered),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: successPins(vm.isOtpEntered),
                  ),
                  successPins(false),
                ],
              ),
              const SizedBox(height: 20),
              vm.isForgotPasswordLoading
                  ? Center(child: CircularProgressIndicator())
                  : (!vm.isEmailEntered
                      ? EnterEmailForgotWidget()
                      : (!vm.isOtpEntered
                          ? EnterOtpWidget()
                          : ForgetPasswordWidget()))
            ],
          ),
        ),
      );
    });
  }

  Icon successPins(bool done) {
    return Icon(Icons.circle,
        size: 8, color: done ? Color(0xffD2137B) : Colors.grey.shade500);
  }
}

class EnterEmailForgotWidget extends StatelessWidget {
  EnterEmailForgotWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginVM>(builder: (vm) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Forgot Password",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20),
          Text(
            "Please Enter your E-mail to get verification code on your mail.",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Text("E-mail",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              )),
          const SizedBox(height: 20),
          TextFormField(
            focusNode: vm.forgotEmailFocus,
            controller: vm.registerEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(36),
              ),
              prefixIcon: const Icon(Icons.email),
              fillColor: Colors.white,
              hintText: "example@abc.com",
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
              if (vm.forgotEmailController.text.trim() == "") {
                showSnackBar(Get.context!, "Please enter email", true);
              } else if (!vm
                  .validateEmail(vm.forgotEmailController.text.trim())) {
                showSnackBar(Get.context!, "Please enter valid email", true);
              } else {
                vm.sendOtp(true);
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
