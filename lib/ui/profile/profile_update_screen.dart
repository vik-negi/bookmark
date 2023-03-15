import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:get/get.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  ProfileVM vm = Get.put(ProfileVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVM>(builder: (vm) {
      return Scaffold(
          appBar: AppBar(
            // backgroundColor: AppColors.whiteColor,
            // foregroundColor: AppColors.blackColor,
            elevation: 0.3,
            title: const Text('EDIT PROFILE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  // fontFamily: 'sans-serif-light',
                  // color: Colors.black
                )),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                // color: Colors.black,
                size: 22.0,
              ),
            ),
          ),
          body: vm.loaderInit
              ? const Center(child: CircularProgressIndicator())
              : vm.errorUpdateProfilePage
                  ? Center(child: Text("Something went wrong"))
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height: 200.0,
                            // color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child:
                                  Stack(fit: StackFit.loose, children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: 140.0,
                                        height: 140.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image:
                                                // ExactAssetImage(
                                                //     'assets/images/default_person.png'),
                                                NetworkImage(vm.userImage!),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 90.0, left: 100.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (context) {
                                            //     return Container(
                                            //         width: Get.width * 0.9,
                                            //         height: 50,
                                            //         decoration: BoxDecoration(
                                            //             color: Theme.of(context)
                                            //                 .backgroundColor),
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .spaceAround,
                                            //           children: [
                                            //             Icon(Icons.camera_alt,
                                            //                 size: 45),
                                            //             Icon(Icons.image,
                                            //                 size: 45)
                                            //           ],
                                            //         ));
                                            //   },
                                            // );
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 25.0,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ]),
                            ),
                          ),
                          Form(
                            key: vm.profileFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const <Widget>[
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: TextFormField(
                                      controller: vm.nameController,
                                      decoration: const InputDecoration(
                                        hintText: "",
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const <Widget>[
                                            Text(
                                              'Username',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: TextFormField(
                                      controller: vm.userNameController,
                                      decoration: const InputDecoration(
                                        hintText: "",
                                      ),
                                    )),
                                const Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Text(
                                      'Email ID',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: TextFormField(
                                      controller: vm.emailController,
                                      decoration: const InputDecoration(
                                          hintText: "vikram@gmail.com"),
                                    )),
                                const Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: TextFormField(
                                      controller: vm.mobileController,
                                      decoration: const InputDecoration(
                                          hintText: "98977686888"),
                                    )),
                                // const Padding(
                                //     padding: EdgeInsets.only(
                                //         left: 25.0, right: 25.0, top: 25.0),
                                //     child: Text(
                                //       'City',
                                //       style: TextStyle(
                                //           fontSize: 16.0,
                                //           fontWeight: FontWeight.bold),
                                //     )),
                                // Padding(
                                //     padding: const EdgeInsets.only(
                                //         left: 25.0, right: 25.0, top: 2.0),
                                //     child: TextFormField(
                                //       controller: vm.cityController,
                                //       decoration: const InputDecoration(
                                //           hintText: "city"),
                                //     )),
                                // Padding(
                                //     padding: const EdgeInsets.only(
                                //         left: 25.0, right: 25.0, top: 25.0),
                                //     child: Row(
                                //       mainAxisSize: MainAxisSize.max,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.start,
                                //       children: const [
                                //         Expanded(
                                //           flex: 2,
                                //           child: Text(
                                //             'Pin Code',
                                //             style: TextStyle(
                                //                 fontSize: 16.0,
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ),
                                //         Expanded(
                                //           flex: 2,
                                //           child: Text(
                                //             'Country',
                                //             style: TextStyle(
                                //                 fontSize: 16.0,
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ),
                                //       ],
                                //     )),
                                // Padding(
                                //     padding: const EdgeInsets.only(
                                //         left: 25.0, right: 25.0, top: 2.0),
                                //     child: Row(
                                //       mainAxisSize: MainAxisSize.max,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.start,
                                //       children: [
                                //         Padding(
                                //           padding: const EdgeInsets.only(
                                //               right: 10.0),
                                //           child: Container(
                                //             width: Get.width * 0.4,
                                //             child: TextFormField(
                                //               controller: vm.pinController,
                                //               decoration: const InputDecoration(
                                //                   hintText: "Enter Pin Code"),
                                //             ),
                                //           ),
                                //         ),
                                //         Container(
                                //           width: Get.width * 0.4,
                                //           child: TextFormField(
                                //             controller: vm.countryController,
                                //             decoration: const InputDecoration(
                                //                 hintText: "Enter Country"),
                                //           ),
                                //         ),
                                //       ],
                                //     )),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () => vm.updateUserProfile(),
                                  child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 25),
                                      decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius:
                                              BorderRadius.circular(26)),
                                      child: const Center(
                                        child: Text("Update",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18)),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
    });
  }
}
