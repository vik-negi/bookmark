import 'dart:convert';

import 'package:bookmark/constants/api_constants.dart';
import 'package:bookmark/model/user_model.dart';
import 'package:bookmark/remote/apicall_function.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/main/home.dart';
import 'package:bookmark/ui/register/login.dart';
import 'package:bookmark/ui/register/register.dart';
import 'package:bookmark/utils/shared_prefer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import "package:bookmark/utils/snackbar.dart";
import 'package:pinput/pinput.dart';

class LoginVM extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController forgotEmailController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  // address textform field
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController zipController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  bool isLoginLoading = false;
  bool isEmailEntered = false;
  bool isOtpEntered = false;
  bool isForgotPasswordLoading = false;
  FocusNode forgotEmailFocus = FocusNode();
  bool isTermCondAccepted = false;
  bool showPassword = false;
  bool proceedForMailVerification = false;
  bool mailVerificationDone = false;
  String token = "";
  String selectdRegisterEmail = "";
  String selectdRegisterPassword = "";
  String selectdRegisterConfirmPassword = "";

  List<String> types = ["Publisher", "User"]; // Option 2
  String? selectedType;

  XFile? userImg;

  void pickImage() async {
    userImg = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    update();
  }

  DiningVM diningVM = Get.put(DiningVM());
  void login() async {
    // emailController.text = "vikramnegi175@gmail.com";
    // vicky@gmail.com
    // passwordController.text = "123456789";
    if (formKey.currentState!.validate()) {
      isLoginLoading = true;

      update();
      try {
        print("Calling login api");
        final response = await http.post(
          Uri.parse("${base_url}user/login"),
          body: {
            "email": emailController.text,
            "password": passwordController.text,
          },
        );
        if (response != null &&
            (response.statusCode == 200 || response.statusCode == 201)) {
          Map<String, dynamic> data = jsonDecode(response.body);
          print("login $data");
          token = data["msg"]["token"];
          await SharedPrefs.setString(
              "address", jsonEncode(data["msg"]["result"]["address"][0]));
          UserModel userData = UserModel.fromJson(data["msg"]["result"]);
          var image = await http.get(Uri.parse(userData.image!.url));
          var bytes = image.bodyBytes;
          print("email : ${userData.email}");
          await SharedPrefs.setString("token", token);
          await SharedPrefs.setString("email", userData.email ?? "");
          await SharedPrefs.setString("name", userData.name ?? "");
          await SharedPrefs.setString("userName", userData.userName ?? "");
          await SharedPrefs.setString("image", String.fromCharCodes(bytes));
          await SharedPrefs.setString("id", userData.id ?? "");
          await SharedPrefs.setString("updatedAt", userData.updatedAt ?? "");
          print("yaha tak sahi chal raha hai");
          diningVM.isUserLoginedIn = true;
          diningVM.getCurrentUSerData();
          diningVM.loginFunctionality();
          await diningVM.getBookOfSelectedGenre("Horror");
          diningVM.getAllBooks();
          diningVM.update();
          Get.offAll(() => HomeView());
        } else {
          showSnackBar(Get.context!, jsonDecode(response.body)["msg"], true);
          print(response.body);
        }
      } catch (e) {
        showSnackBar(Get.context!, "Something went wrong", true);
        print("login error : $e");
      }
      isLoginLoading = false;
      update();
    }
  }

  void errorScaffold() {
    Get.snackbar("Error", "Something went wrong");
  }

  final emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  bool validateEmail(String email) {
    final regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  void clearTextFormFields() {
    registerEmailController.clear();
    registerPasswordController.clear();
    confirmpasswordController.clear();
    nameController.clear();
    userNameController.clear();
    otpController.clear();
  }

  void register() async {
    if (formKey.currentState!.validate() && formKey3.currentState!.validate()) {
      isLoginLoading = true;
      if (selectdRegisterPassword != selectdRegisterConfirmPassword) {
        showSnackBar(
            Get.context!, "password & confirm password not matched", true);
      }
      update();
      try {
        print("Calling login api");
        print(selectdRegisterEmail);
        print(selectdRegisterPassword);
        var request = http.MultipartRequest(
            "POST", Uri.parse("${base_url}user/register"));
        // request.fields["email"] = selectdRegisterEmail;
        // request.fields["password"] = selectdRegisterPassword;

        request.fields["email"] = registerEmailController.text.trim();
        request.fields["type"] = "primary";
        request.fields["password"] = registerPasswordController.text.trim();
        request.fields["fullName"] = nameController.text.trim();
        request.fields["userName"] = userNameController.text.trim();
        request.fields["addressLine1"] = addressLine1Controller.text.trim();
        request.fields["city"] = cityController.text.trim();
        request.fields["state"] = stateController.text.trim();
        request.fields["zipCode"] = zipController.text.trim();
        request.files
            .add(await http.MultipartFile.fromPath("image", userImg!.path));

        print(request.fields.entries);
        var apiresponse = await request.send();
        var responseData = await apiresponse.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        debugPrint(responseString);
        Map<String, dynamic> map = jsonDecode(responseString);
        // if (response.statusCode == 200) {
        //   return responseString;
        // }
        if (map["success"]) {
          showSnackBar(
              Get.context!, 'Successfully register, Please login', false);
          debugPrint('Post Created Successfully');
          // clearAllFields();
          Get.offAll(() => LoginPage());
        } else {
          showSnackBar(Get.context!, map["msg"], true);
          debugPrint("something went wrong");
        }
        // print(response.body);
        // if (response != null &&
        //     (response.statusCode == 200 || response.statusCode == 201)) {
        //   Map<String, dynamic> data = jsonDecode(response.body);
        //   print(data);
        //   if (data["success"]) {
        //     Get.offAll(() => LoginPage());
        //   } else {
        //     Get.snackbar("Error", "Something went wrong");
        //   }
        // } else {
        //   print(response.body);
        //   Get.snackbar("Error", "Something went wrong");
        // }
      } catch (e) {
        Get.snackbar("Error", "Something went wrong");
        print(e.toString());
      }
      isLoginLoading = false;
      update();
    }
  }

  String otp = "";

  void sendOtp(bool forgotPassword) async {
    isForgotPasswordLoading = true;
    if (forgotPassword) {
      isEmailEntered = true;
      // isForgotPasswordLoading = false;
      // update();
      // return;
    }
    update();
    await callAndErrorHendling(
        callback: (data) {
          if (forgotPassword) {
            isEmailEntered = true;
          } else {
            Get.to(() => RegisterPage2());
          }
          otp = data["msg"].toString();
          update();
        },
        errorOccurFunction: () {},
        url: forgotPassword
            ? "${base_url}user/forgotPassword"
            : "${base_url}user/otp",
        method: "post",
        body: {
          "email": registerEmailController.text.trim(),
        },
        context: Get.context!);
    isForgotPasswordLoading = false;
    update();
    // try {
    //   String url = "${base_url}user/otp";
    //   print("send otp data : ${registerEmailController.text.trim()}");
    //   final res = await http.post(Uri.parse(url), body: {
    //     "email": registerEmailController.text.trim(),
    //   });
    //   if (res.statusCode == 201 && jsonDecode(res.body)["success"]) {
    //     print("send otp data : ${res.body}");
    //     if (forgotPassword) {
    //       isEmailEntered = true;
    //     } else {
    //       Get.to(() => RegisterPage2());
    //     }
    //   } else {
    //     print("send otp data : ${res.body}");
    //     showSnackBar(Get.context!, "Invalid Email", true);
    //   }
    //   isForgotPasswordLoading = false;
    //   update();
    // } catch (e) {
    //   print("catch error otp send : $e");
    // }
  }

  void verifyOtp(forgotPassword) async {
    isForgotPasswordLoading = true;
    if (forgotPassword) {
      isOtpEntered = true;
      // isForgotPasswordLoading = false;
      // update();
      // return;
    }
    Map body = {
      "email": registerEmailController.text.trim(),
      "otp": otpController.text.trim(),
    };
    print("verify otp : $body");

    update();
    await callAndErrorHendling(
        callback: (data) {
          if (forgotPassword) {
            isOtpEntered = true;
          } else {
            Get.to(() => RegisterPage3());
          }
        },
        errorOccurFunction: () {},
        url: forgotPassword
            ? "${base_url}user/forgotPassword/OtpVerify"
            : "${base_url}user/otp",
        method: forgotPassword ? "post" : "put",
        body: {
          "email": registerEmailController.text.trim(),
          "otp": otpController.text.trim(),
        },
        context: Get.context!);
    isForgotPasswordLoading = false;
    update();
    // try {
    //   String url = "${base_url}user/otp";
    //   final res = await http.put(Uri.parse(url), body: {
    //     "email": registerEmailController.text.trim(),
    //     "otp": otpController.text.trim(),
    //   });
    //   if (res.statusCode == 201 && jsonDecode(res.body)["success"]) {
    //     if (forgotPassword) {
    //       isOtpEntered = true;
    //     } else {
    //       Get.to(() => RegisterPage3());
    //     }
    //   } else {
    //     showSnackBar(Get.context!, "Invalid OTP", true);
    //   }
    //   print("send otp data : ${res.body}");
    //   isForgotPasswordLoading = false;
    //   update();
    // } catch (e) {
    //   print("catch error otp send : $e");
    // }
  }

  void changeForgotPassword() async {
    isForgotPasswordLoading = true;
    update();
    Map body = {
      "email": forgotEmailController.text.trim(),
      "newPassword": passwordController.text.trim(),
      "confirmPassword": confirmpasswordController.text.trim(),
    };
    print("forgot password body : $body");
    await callAndErrorHendling(
        callback: (data) {
          print(data);
          if (data["success"]) {
            showSnackBar(Get.context!, "Successfully chage Password", false);
            otpController.clear();
            registerEmailController.clear();
            passwordController.clear();
            confirmpasswordController.clear();
          } else {
            showSnackBar(
                Get.context!, data["msg"] ?? "Something went wrong", true);
          }
        },
        errorOccurFunction: () {},
        url: "${base_url}user/updatePassword",
        method: "post",
        body: {
          "email": forgotEmailController.text.trim(),
          "newPassword": passwordController.text.trim(),
          "confirmPassword": confirmpasswordController.text.trim(),
        },
        context: Get.context!);
    isForgotPasswordLoading = false;
    update();
  }

  InputDecoration TextFFDecoration({IconData? icon, String? hint}) {
    return InputDecoration(
        filled: true,
        hintText: hint ?? 'Enter here',
        hintStyle: TextStyle(color: Theme.of(Get.context!).primaryColor),
        prefixIcon: Icon(
          icon ?? Icons.text_snippet,
          color: Theme.of(Get.context!).primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36.0),
          borderSide: BorderSide.none,
        ),
        // fillColor: Colors.grey.shade900,
        focusColor: Colors.white);
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
  );
}
