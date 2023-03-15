import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:bookmark/model/mobile_model.dart';
import 'package:get/get.dart';

class ProductView extends GetxController {
  List<Mobile> mobileList = [];
  bool isLoading = false;

  void fetchMobileData() async {
    isLoading = true;
    update();
    final String response =
        await rootBundle.loadString('assets/data/mobilephone.json');
    List data = await json.decode(response);
    mobileList = data.map((e) => Mobile.fromJson(e)).toList();
    isLoading = false;
    update();
    print(mobileList[0]);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMobileData();
  }
}
