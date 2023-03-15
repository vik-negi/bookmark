import 'dart:convert';

// import 'package:bookmark/model/book.dart';
import 'package:bookmark/model/book_model.dart';
// import 'package:bookmark/model/food_model.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/utils/dialog_loader.dart';
import 'package:bookmark/utils/shared_prefer.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddBookVM extends GetxController {
  final addBookFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? bookImage;

  void pickImage() async {
    bookImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    // final List<XFile>? images = await picker.pickMultiImage(
    //   imageQuality: 25,
    // );
    // if (images != null && images.isNotEmpty) {
    //   if (images.length <= 4 - selectedImages.length) {
    //     selectedImages.addAll(images);
    //   } else {
    //     Get.snackbar("Maximum 4 Images",
    //         "You can select ${4 - selectedImages.length} more images",
    //         snackPosition: SnackPosition.BOTTOM,
    //         margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10));
    //   }
    // }
    update();
  }

  List<Language> languageList = [];
  List<String> languageNameList = ["select"];
  String selectedLanguage = "select";
  List<Genre> genreList = [];
  List<String> genreNameList = ["select"];
  String selectedGenre = "select";
  bool loader = false;
  void load() {
    loader = !loader;
    update();
  }

  void getLanguages() async {
    load();
    try {
      var res = await http.get(
          Uri.parse("https://test-bk-api.onrender.com/language/get-languages"));
      var lang_data = jsonDecode(res.body);
      print("res.body :: ${lang_data["msg"]["result"]}");
      languageList = lang_data["msg"]["result"]
          .map<Language>((e) => Language.fromMap(e))
          .toList();
      print("language :: ${languageList[0].language}");
      for (var each in languageList) {
        languageNameList.add(each.language);
        print("lang == ${each.language}");
      }
      update();
    } catch (err) {
      print(err);
    }
    load();
  }

  void getGenres() async {
    try {
      print("funcyion get genre call");
      var res = await http
          .get(Uri.parse("https://test-bk-api.onrender.com/genre/get-genres"));
      var lang_data = jsonDecode(res.body);
      genreList = lang_data["msg"]["result"]
          .map<Genre>((e) => Genre.fromMap(e))
          .toList();
      print("genre : $lang_data");
      for (var each in genreList) {
        genreNameList.add(each.genre);
      }
      update();
    } catch (err) {
      print(err);
    }
  }

  void getAddress() async {
    cityController.text = await SharedPrefs.getString("city") ?? "";
    stateController.text = await SharedPrefs.getString("state") ?? "";
    update();
  }

  void clearFields() {
    titleController.clear();
    authorController.clear();
    publisherController.clear();
    priceController.clear();
    descriptionController.clear();
    categoryController.clear();
    languageController.clear();
    bookImage = null;
    update();
  }

  String errorStr = "";
  bool validate() {
    if (titleController.text.trim() == "") {
      errorStr = "Please Enter Book Name";
      return false;
    } else if (descriptionController.text.trim() == "") {
      errorStr = "Please Enter description";
      return false;
    } else if (selectedLanguage == "" && selectedLanguage == "select") {
      errorStr = "Please Enter language";
      return false;
    } else if (priceController.text.trim() == "") {
      errorStr = "Please Enter price";
      return false;
    } else if (selectedGenre == "" || selectedGenre == "select") {
      errorStr = "Please Enter category";
      return false;
    } else if (bookImage == null) {
      errorStr = "Please Select Image";
    } else if (authorController.text.trim() == "") {
      errorStr = "Please Enter Author Name";
    }
    return true;
  }

  DiningVM diningVM = Get.put(DiningVM());
  void addUserBook() async {
    if (!validate()) {
      showSnackBar(Get.context!, errorStr, true);
    }

    showLoaderDialog(Get.context!);
    try {
      String id = (await SharedPrefs.getString("id"))!;
      String selectLand = languageList
          .firstWhere((element) => element.language == selectedLanguage)
          .id;
      String selectGenre =
          genreList.firstWhere((element) => element.genre == selectedGenre).id;
      print("Calling get book api");
      var res =
          await http.get(Uri.parse("https://test-bk-api.onrender.com/getUid"));
      String uid = jsonDecode(res.body)["msg"]["_id"];
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          "https://test-bk-api.onrender.com/client/book",
        ),
      );
      request.headers["Authorization"] =
          "Bearer ${await SharedPrefs.getString("token")}";
      // request.fields["uploadedBy"] = id;
      request.fields["description"] = descriptionController.text;
      request.fields["rentPerDay"] = priceController.text;
      request.fields["language"] = selectLand;
      request.fields["city"] = cityController.text.trim();
      request.fields["state"] = stateController.text.trim();
      request.fields["genre"] = selectGenre;
      request.fields["uniqueId"] = uid;
      request.fields["bookName"] = titleController.text;
      request.fields["author"] = authorController.text;
      request.files
          .add(await http.MultipartFile.fromPath("image1", bookImage!.path));
      print(request.fields.entries);
      var apiresponse = await request.send();
      var responseData = await apiresponse.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      debugPrint(responseString.toString());

      var jsonData = jsonDecode(responseString);
      print("json Data : ${jsonData}");
      Get.back();

      if (jsonData["success"]) {
        clearFields();
        BookModel books = BookModel.fromMap(jsonData["msg"]);
        diningVM.userBook.add(books);
        showSnackBar(Get.context!, "Book Added Successfully", false);
        diningVM.update();
      } else {
        showSnackBar(Get.context!, "Something went wrong", true);
      }
    } catch (e) {
      Get.back();
      showSnackBar(Get.context!, "Something went wrong", true);
      print("Error catch add book : $e");
    }
  }

  @override
  void onInit() {
    getAddress();
    getLanguages();
    getGenres();
    super.onInit();
  }
}
