import 'dart:convert';

import 'package:bookmark/model/user_model.dart';
import 'package:bookmark/utils/shared_prefer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddressRepo {
  Future<List<Address>> fetchAddress() async {
    String url = "https://test-bk-api.onrender.com/client/user/get-address";
    return await callAndErrorHendling(
      callback: (data) {
        print("data : ${data["msg"]}");
        List<Address> address = data["msg"]["result"]["address"]
            .map<Address>((e) => Address.fromMap(e))
            .toList();
        return address;
      },
      url: url,
      method: "get",
      body: {},
      error: "Something went wrong",
      errorFunction: () {},
    );
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
          return callback(data);
        } else {
          errorFunction();
          Get.snackbar("Error", "Something went wrong");
        }
      } else {
        print(response.body);
        errorFunction();
        Get.snackbar("Error", error ?? "Something went wrong");
      }
    } catch (e) {
      errorFunction();
      Get.snackbar("Error", "Something went wrong");
      print(e.toString());
    }
  }
}
