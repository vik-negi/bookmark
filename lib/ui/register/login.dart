import 'package:bookmark/ui/main/home.dart';
import 'package:bookmark/ui/register/login_vm.dart';
import 'package:bookmark/ui/register/register.dart';
import 'package:bookmark/widgets/enter_mobileNo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;

  // Email Validation
  final emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  bool validateEmail(String email) {
    final regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  // Sign In Function
  // void login() {
  //   if (_formKey.currentState!.validate()) {
  //     vm.isLoginLoading = true;
  //     setState(() {});
  //     Future.delayed(const Duration(seconds: 2), () {
  //       vm.isLoginLoading = false;
  //       setState(() {});
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeView()),
  //       );
  //     });
  //   }
  // }

  LoginVM vm = Get.put(LoginVM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<LoginVM>(builder: (vm) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                const SizedBox(height: 50),
                // const Align(
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     'Login',
                //     style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                //   ),
                // ),
                const SizedBox(height: 50),
                ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.asset(
                    "assets/images/logo_big.png",
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
                    scale: 4,
                  ),
                ),
                Form(
                  key: vm.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: vm.emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your email';
                          }
                          if (!validateEmail(vm.emailController.text)) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        // style: const TextStyle(color: Colors.white),
                        decoration: TextFFDecoration(
                            icon: Icons.email, hint: 'Enter your email'),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: vm.passwordController,
                        obscureText: showPassword ? false : true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter Password';
                          }
                          // if (val.length < 8) {
                          //   return 'Password Must be 8 character long';
                          // } else if (!val.contains(RegExp(r'[A-Z]'))) {
                          //   return 'Password Must contain at least one Capital letter';
                          // } else if (!val.contains(RegExp(r'[0-9]'))) {
                          //   return 'Password Must contain at least one  number';
                          // } else if (!val
                          //     .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          //   return 'Password Must contain at least one special character';
                          // } else if (!val.contains(RegExp(r'[a-z]'))) {
                          //   return 'Password Must contain at least one lowercase letter';
                          // }
                          return null;
                        },
                        // style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Enter your password',
                          // hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.security,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(
                              showPassword
                                  ? Icons.visibility_off
                                  : Icons.remove_red_eye,
                              // color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(36.0),
                            borderSide: BorderSide.none,
                          ),
                          // fillColor: Colors.grey.shade900,
                          focusColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          vm.isEmailEntered = false;
                          vm.isOtpEntered = false;
                          vm.update();
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            anchorPoint: const Offset(0, 0),
                            isScrollControlled: true,
                            isDismissible: true,
                            context: context,
                            builder: (builder) {
                              // return const MoreOptionsToSend();
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: VerifyEmail(),
                              );
                              // DraggableScrollableSheet(
                              //   initialChildSize: 0.5, //set this as you want
                              //   maxChildSize: 0.5, //set this as you want
                              //   minChildSize: 0.5, //set this as you want
                              //   expand: true,
                              //   builder: (context, scrollController) {
                              //     return const VerifyEmail();
                              //   },
                              // );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          vm.login();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            // color: Colors.grey.shade900,
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Center(
                            child: vm.isLoginLoading
                                ? Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Theme.of(context).backgroundColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text('Don\'t have an account? '),
                          InkWell(
                            onTap: () => Get.off(() => RegisterPage()),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  InputDecoration TextFFDecoration({IconData? icon, String? hint}) {
    return InputDecoration(
        filled: true,
        hintText: hint ?? 'Enter here',
        // hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(
          icon ?? Icons.text_snippet,
          color: Theme.of(context).primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36.0),
          borderSide: BorderSide.none,
        ),
        // fillColor: Colors.grey.shade900,
        focusColor: Colors.white);
  }
}
