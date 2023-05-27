import 'dart:convert';

import 'package:bookmark/constants/api_constants.dart';
import 'package:bookmark/model/city_model.dart';
import 'package:bookmark/model/state_model.dart';
import 'package:bookmark/model/user_model.dart';
import 'package:bookmark/ui/profile/address/add_address.dart';
import 'package:bookmark/utils/location.dart';
import 'package:bookmark/utils/shared_prefer.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileVM extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  // address textform field
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  final profileFormKey = GlobalKey<FormState>();
  final addAddressFormKey = GlobalKey<FormState>();
  // GetLocation getLocation = GetLocation();
  List<Address> address = [];
  String? userImage;
  String selectedAddressForEdit = "";
  bool loader = false;
  bool loaderInit = false;
  bool addressLoading = false;
  bool isError = false;
  bool errorUpdateProfilePage = false;
  bool addAddressOpen = false;
  bool addAddressLoader = false;
  int i = 0;
  UserModel? userData;

  void load(e) {
    loader = e;
    print(e);
    update();
  }

  void errorOccur() {
    isError = !isError;
    update();
  }

  void fetchProfileData() async {
    // load(true);
    loaderInit = true;
    print("fetch user Data");
    String url = "https://test-bk-api.onrender.com/client/user/get-single-user";

    await callAndErrorHendling(
      callback: (data) {
        userData = UserModel.fromJson(data["msg"]);
        // print(" response : ${data['msg']['address'][0]} ?? hi");
        userImage = userData!.image!.url;
        nameController.text = userData!.name ?? "";
        userNameController.text = userData!.userName ?? "";
        mobileController.text = userData!.phone.toString();
        emailController.text = userData!.email ?? "";
        // address = userData!.address ?? [];
        // addressController.text = "lajpat Nagar, New Delhi";
        // countryController.text = "India";
        // pinController.text = "186860";
        // update();
      },
      url: url,
      method: "get",
      body: {},
      error: "Something went wrong",
      errorFunction: () {
        errorUpdateProfilePage = true;
        update();
      },
    );
    // load(false);
    loaderInit = false;
    update();
    // final response = await http.get(Uri.parse(url));
    // var json = jsonDecode(response.body);

    // userData = UserModel.fromJson(json["msg"]);
    // print(" response : ${userData!.email}");
    // userImage = userData!.image!.url;
    // nameController.text = "Vikram Negi";
    // userNameController.text = userData!.userName ?? "";
    // mobileController.text = userData!.phone ?? "";
    // emailController.text = userData!.email ?? "";
    // addressController.text = "lajpat Nagar, New Delhi";
    // countryController.text = "India";
    // pinController.text = "186860";
  }

  final ImagePicker picker = ImagePicker();
  XFile? bookImage;
  void pickImage() async {
    bookImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    update();
  }

  void updateUserProfile() async {
    // load(true);
    loader = true;
    update();
    String id = (await SharedPrefs.getString("id"))!;
    String url = "https://test-bk-api.onrender.com/client/user/update-user";
    Map body = {};
    if (userData!.email != emailController.text) {
      body["email"] = emailController.text;
    }
    if (userData!.phone != mobileController.text) {
      body["phone"] = mobileController.text;
    }
    if (userData!.name != nameController.text) {
      body["fullName"] = nameController.text;
    }
    // if (userData!.city != cityController.text) {
    //   body["city"] = cityController.text;
    // }
    if (userData!.userName != userNameController.text) {
      body["userName"] = userNameController.text;
    }

    await callAndErrorHendling(
      callback: (data) {
        print("data : ${data["msg"]}");
        Get.snackbar("Success", "Profile Updated Successfully");
      },
      url: url,
      method: "put",
      body: body,
      error: "Something went wrong",
      errorFunction: () {},
    );
    // final response = await http.put(Uri.parse(url), body: body);
    // var json = jsonDecode(response.body);
    // print("response : ${json["msg"]}");
    // load(false);
    loader = false;
    update();
  }

  void updateController(Address address) {
    addressLine1Controller.text = address.addressLine1;
    addressLine2Controller.text = address.addressLine2 ?? "";
    pinController.text = address.zipCode.toString();
    landmarkController.text = address.landmark ?? "";
    selectedAddressForEdit = address.id;
    Get.to(() => AddAddress());
    update();
  }

  void clearController() {
    addressLine1Controller.text = "";
    addressLine2Controller.text = "";
    pinController.text = "";
    landmarkController.text = "";
    selectedAddressForEdit = "";
  }

  void clearControllerAndAddAddress() async {
    addAddressOpen = true;
    addAddressLoader = true;
    clearController();
    update();
    Get.to(() => AddAddress());
    getStatesList();
    getCitiesList();
    addAddressLoader = false;
    update();
  }

  String selectedStateValue = "Select";
  String selectedCityValue = "Select";

  void updateAddress() async {
    print("Selected Address : $selectedAddressForEdit");
    String url =
        "https://test-bk-api.onrender.com/client/user/update-address/$selectedAddressForEdit";
    Map body = {
      "addressLine1": addressLine1Controller.text,
      "addressLine2": addressLine2Controller.text,
      "zipCode": pinController.text,
      "landmark": landmarkController.text
    };
    await callAndErrorHendling(
      callback: (data) {
        print("data : ${data["msg"]}");

        showSnackBar(Get.context!, "Address Updated Successfully", false);
        // Get.back();
        getAddressList();
      },
      url: url,
      method: "put",
      body: body,
      error: "Something went wrong",
      errorFunction: () {},
    );
  }

  void createAddress() async {
    String url = "${base_url}user/create-address";
    Map body = {
      "addressLine1": addressLine1Controller.text,
      "addressLine2": addressLine2Controller.text,
      "zipCode": pinController.text,
      "landmark": landmarkController.text,
      "city": cityController.text,
      "state": stateController.text,
      "country": "India"
    };
    print("body : $body");
    await callAndErrorHendling(
      callback: (data) {
        print("data : ${data["msg"]}");
        showSnackBar(Get.context!, "Address created Successfully", false);
        clearController();
        Get.back();
        getAddressList();
      },
      url: url,
      method: "post",
      body: body,
      error: "Something went wrong",
      errorFunction: () {},
    );
  }

  void deleteUserAddress(String addressId) async {
    Address add = address.where((element) => element.id == addressId).first;
    address.remove(add);
    print("id : $addressId");
    update();
    String url =
        "https://test-bk-api.onrender.com/client/user/delete-single-address/$addressId";
    Map body = {};
    await callAndErrorHendling(
      callback: (data) {
        print("data : ${data}");

        showSnackBar(Get.context!, "Address Deleted Successfully", false);
        Get.back();
        getAddressList();
      },
      url: url,
      method: "delete",
      body: body,
      error: "Something went wrong",
      errorFunction: () {
        address.add(add);
        update();
      },
    );
  }

  void getAddressList() async {
    addressLoading = true;
    update();
    String url = "https://test-bk-api.onrender.com/client/user/get-address";
    await callAndErrorHendling(
      callback: (data) {
        // print("data : ${data["msg"]}");
        address = data["msg"]["result"]["address"]
            .map<Address>((e) => Address.fromMap(e))
            .toList();
        update();
        // Get.snackbar("Success", "Profile Updated Successfully");
      },
      url: url,
      method: "get",
      body: {},
      error: "Something went wrong",
      errorFunction: () {},
    );
    addressLoading = false;
    update();
  }

  List<StateModel> statesList = [];
  List<CityModel> citiesList = [];

  void getStatesList() async {
    await callAndErrorHendling(
      callback: (data) {
        statesList = data["msg"]["result"]
            .map<StateModel>((e) => StateModel.fromMap(e))
            .toList();
        update();
      },
      url: "https://test-bk-api.onrender.com/state/get-states",
      method: "get",
      body: {},
      errorFunction: () {},
    );
  }

  void getCitiesList() async {
    await callAndErrorHendling(
      callback: (data) {
        citiesList = data["msg"]["result"]
            .map<CityModel>((e) => CityModel.fromMap(e))
            .toList();
        update();
      },
      url: "https://test-bk-api.onrender.com/city/get-cities",
      method: "get",
      body: {},
      errorFunction: () {},
    );
  }

  void fetchAddress() async {
    // Map<String, dynamic> addInfo = await getLocation.determinePosition();
    addAddressFormKey.currentState!.reset();
    update();
  }

  @override
  void onInit() {
    fetchProfileData();
    super.onInit();
  }

  Future callAndErrorHendling(
      {required Function callback,
      required String url,
      required String method,
      required Map body,
      bool? loader,
      required Function errorFunction,
      String? error}) async {
    try {
      String token = (await SharedPrefs.getString("token"))!;
      print("Calling get book api");
      final response;
      if (method == "get") {
        response = await http.get(Uri.parse(url), headers: {
          "authorization": "Bearer $token",
        });
      } else if (method == "post") {
        response = await http.post(Uri.parse(url), body: body, headers: {
          "authorization": "Bearer $token",
        });
      } else if (method == "put") {
        response = await http.put(Uri.parse(url), body: body, headers: {
          "authorization": "Bearer $token",
        });
      } else {
        response = await http.delete(Uri.parse(url), body: body, headers: {
          "authorization": "Bearer $token",
        });
      }
      print("statuscode : ${response.statusCode}");
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        if (data["success"]) {
          callback(data);
        } else {
          errorOccur();
          // update();
          errorFunction();
          // showSnackBar(Get.context!, "Something went wrong", true);
        }
      } else {
        print(response.body);
        errorOccur();
        Map<String, dynamic> data = jsonDecode(response.body);
        errorFunction();
        // update();
        // showSnackBar(Get.context!, data["msg"] ?? "something went wrong", true);
      }
    } catch (e) {
      errorOccur();
      errorFunction();
      // showSnackBar(Get.context!, error ?? "Something went wrong", true);
      // update();
      print("catch error $e");
    }
  }
}

class AddAddressScreen {}
