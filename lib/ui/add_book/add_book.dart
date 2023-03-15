import 'dart:io';

import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/ui/add_book/add_book_vm.dart';
import 'package:bookmark/ui/add_book/image.dart';
import 'package:bookmark/ui/animation/fade_animation.dart';
import 'package:bookmark/utils/dialog_loader.dart';
import 'package:bookmark/widgets/my_drawer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBook extends StatefulWidget {
  AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  AddBookVM vm = Get.put(AddBookVM());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBookVM>(builder: (vm) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Add Book'),
          ),
          drawer: MyDrawer(),
          body: vm.loader
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FadeAnimation(
                  1.4,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: Get.width,
                              height: Get.width * (1080 / 1920),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColorGrey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: vm.bookImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        File(vm.bookImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Center(
                                      child: InkWell(
                                        onTap: () {
                                          vm.pickImage();
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 70,
                                              // color: AppColors.accentTextColor,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Icon(
                                                Icons.camera_alt_outlined,
                                                // color: AppColors.accentColor,
                                              ),
                                            ),
                                            const Text("Select Image"),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 15,
                              child: InkWell(
                                onTap: () {
                                  if (vm.bookImage != null) {
                                    Get.to(
                                      ShowImage(
                                        image: vm.bookImage!.path,
                                        isFileImage: true,
                                        name: vm.titleController.text == null
                                            ? ""
                                            : vm.titleController.text,
                                        tag: "1",
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(222, 57, 57, 57),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.zoom_out_map,
                                    color: Colors.white,
                                    size: 17,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Form(
                          key: vm.addBookFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
                                          Text(
                                            'Book Name',
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
                                      left: 15.0, right: 15.0, top: 2.0),
                                  child: TextFormField(
                                    controller: vm.titleController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter Book Name",
                                    ),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 25.0),
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 2.0),
                                  child: TextFormField(
                                    maxLength: 200,
                                    controller: vm.descriptionController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Book Description"),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 25.0),
                                  child: Text(
                                    'Rent per Day',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 2.0),
                                  child: TextFormField(
                                    controller: vm.priceController,
                                    decoration: const InputDecoration(
                                        hintText: "999.00"),
                                  )),
                              vm.genreList.isEmpty
                                  ? SizedBox()
                                  : const Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.0, right: 15.0, top: 25.0),
                                      child: Text(
                                        'Category',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                              vm.genreList.isEmpty
                                  ? SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0, top: 2.0),
                                      child:
                                          // TextFormField(
                                          //   controller: vm.categoryController,
                                          //   decoration: const InputDecoration(
                                          //       hintText: "Select Category"),
                                          // )
                                          DropdownButton(
                                        dropdownColor:
                                            Theme.of(context).backgroundColor,
                                        hint: Container(
                                          width: Get.width - 75,
                                          child: Text('Please Genre'),
                                        ), // Not necessary for Option 1
                                        value: vm.selectedGenre.isNotEmpty
                                            ? vm.selectedGenre
                                            : null,
                                        onChanged: (newValue) {
                                          setState(() {
                                            vm.selectedGenre = newValue!;
                                            vm.update();
                                          });
                                        },
                                        items: vm.genreNameList.map((genre) {
                                          return DropdownMenuItem(
                                            child: Text(genre),
                                            value: genre,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                              vm.languageList.isEmpty
                                  ? SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0, top: 25.0),
                                      child: Text(
                                        'Language',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                              // Row(
                              //   mainAxisSize: MainAxisSize.max,
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: const [
                              //     Expanded(
                              //       flex: 2,
                              //       child: Text(
                              //         'Author Name',
                              //         style: TextStyle(
                              //             fontSize: 16.0,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       flex: 2,
                              //       child: Text(
                              //         'Select Language',
                              //         style: TextStyle(
                              //             fontSize: 16.0,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //   ],
                              // )
                              vm.languageList.isEmpty
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.0, right: 15.0, top: 2.0),
                                      child: DropdownButton(
                                        dropdownColor:
                                            Theme.of(context).backgroundColor,

                                        hint: Container(
                                          width: Get.width - 75,
                                          child: Text('Please Language'),
                                        ), // Not necessary for Option 1
                                        value: vm.selectedLanguage.isNotEmpty
                                            ? vm.selectedLanguage
                                            : null,
                                        onChanged: (newValue) {
                                          setState(() {
                                            vm.selectedLanguage = newValue!;
                                            vm.update();
                                          });
                                        },
                                        items:
                                            vm.languageNameList.map((language) {
                                          return DropdownMenuItem(
                                            child: Text(language),
                                            value: language,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
                                          Text(
                                            'Author Name',
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
                                      left: 15.0, right: 15.0, top: 2.0),
                                  child: TextFormField(
                                    controller: vm.authorController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter Author Name",
                                    ),
                                  )),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: (Get.width - 20) / 2,
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 25.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Text(
                                                  'City',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: vm.cityController,
                                          decoration: const InputDecoration(
                                              hintText: "Book at City"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: (Get.width - 20) / 2,
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 25.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Text(
                                                  'State',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        TextFormField(
                                          controller: vm.stateController,
                                          decoration: const InputDecoration(
                                              hintText: "Book at State"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  // showLoader(Get.context!);
                                  vm.addUserBook();
                                },
                                onDoubleTap: () => Get.back(),
                                child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius:
                                            BorderRadius.circular(26)),
                                    child: const Center(
                                      child: Text("Add Book",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18)),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ));
    });
  }
}
