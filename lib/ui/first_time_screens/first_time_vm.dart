import 'dart:convert';

import 'package:bookmark/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FirstTimeVM extends GetxController {
  List<Language> languageList = [];
  List<Language> selectedLanguageList = [];

  void fetchLanguages() async {
    try {
      var response = await http.get(
          Uri.parse("https://test-bk-api.onrender.com/language/get-languages"));
      // languageList = response;
      print("get Language ${response.body}");
      Map jsonData = jsonDecode(response.body);
      if (jsonData["success"] && response.statusCode == 200) {
        languageList = jsonData["msg"]["result"]
            .map<Language>((e) => Language.fromMap(e))
            .toList();
      }
      update();
    } catch (err) {
      print("Error in get language $err");
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  void addAndRemoveLang(Language language) {
    if (selectedLanguageList.contains(language)) {
      selectedLanguageList.remove(language);
    } else {
      selectedLanguageList.add(language);
    }
    update();
  }

  bool isLangSelected(Language language) {
    return selectedLanguageList.contains(language);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchLanguages();
  }
}
