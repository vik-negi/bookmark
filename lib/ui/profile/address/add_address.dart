import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key, this.id});
  String? id;

  ProfileVM vm =
      Get.isRegistered<ProfileVM>() ? Get.find() : Get.put(ProfileVM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Address'),
        ),
        body: GetBuilder<ProfileVM>(builder: (vm) {
          return SingleChildScrollView(
            child: vm.addAddressLoader
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Form(
                            key: vm.addAddressFormKey,
                            child: Column(
                              children: [
                                CommonFormField(
                                  controller: vm.addressLine1Controller,
                                  hintText: 'Address Line 1',
                                  validation: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter address';
                                    }
                                    return null;
                                  },
                                ),
                                CommonFormField(
                                  controller: vm.addressLine2Controller,
                                  hintText: 'Address Line 2',
                                  validation: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter address';
                                    }
                                    return null;
                                  },
                                ),
                                // CommonFormField(
                                //   controller: vm.countryController,
                                //   hintText: 'Country',
                                //   validation: (value) {
                                //     if (value.isEmpty) {
                                //       return 'Please enter country';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropDownField(
                                      controller: vm.stateController,
                                      value: vm.selectedStateValue,
                                      required: true,
                                      strict: true,
                                      hintText: "Select State",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                      // labelText: 'State *',
                                      // icon: Icon(Icons.account_balance),
                                      items: vm.statesList
                                          .map((e) => e.state)
                                          .toList(),
                                      setter: (dynamic newValue) {
                                        vm.selectedStateValue = newValue;
                                        vm.update();
                                      }),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropDownField(
                                      controller: vm.cityController,
                                      value: vm.selectedCityValue,
                                      required: true,
                                      strict: true,
                                      hintText: "Select City",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                      // labelText: 'State *',
                                      // icon: Icon(Icons.account_balance),
                                      items: vm.citiesList
                                          .map((e) => e.city)
                                          .toList(),
                                      setter: (dynamic newValue) {
                                        vm.selectedStateValue = newValue;
                                        vm.update();
                                      }),
                                ),
                                CommonFormField(
                                  controller: vm.landmarkController,
                                  hintText: 'Landmark',
                                  validation: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter landmark';
                                    }
                                    return null;
                                  },
                                ),
                                CommonFormField(
                                  controller: vm.pinController,
                                  hintText: 'Pin',
                                  validation: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter pin';
                                    }
                                    return null;
                                  },
                                ),
                                // CommonFormField(
                                //   controller: vm.cityController,
                                //   hintText: 'City',
                                //   validation: (value) {
                                //     if (value.isEmpty) {
                                //       return 'Please enter city';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    if (vm.addAddressFormKey.currentState!
                                        .validate()) {
                                      print("validate");
                                      if (vm.addAddressOpen) {
                                        // abc
                                        vm.createAddress();
                                      } else {
                                        vm.updateAddress();
                                      }
                                      // updateProfile();
                                    }
                                  },
                                  child: Container(
                                    width: Get.width - 40,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(Get.context!).primaryColor,
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    child: Center(
                                      child: Text('Save',
                                          style: TextStyle(
                                            color: Theme.of(Get.context!)
                                                .backgroundColor,
                                            fontSize: 20,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )),
          );
        }));
  }
}

class CommonFormField extends StatelessWidget {
  CommonFormField(
      {Key? key, required this.controller, this.hintText, this.validation})
      : super(key: key);
  TextEditingController controller;
  String? hintText;
  Function(String val)? validation;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText ?? "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: BoxConstraints(maxHeight: 80, minHeight: 50),
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade800,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (val) => validation!(val!),
      ),
    );
  }
}
