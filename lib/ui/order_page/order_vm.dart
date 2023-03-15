import 'dart:convert';

import 'package:bookmark/constants/api_constants.dart';
import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/model/order_model.dart';
import 'package:bookmark/utils/shared_prefer.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class OrderVM extends GetxController with GetSingleTickerProviderStateMixin {
  List<OrderModel> userOrderList = [];
  List<OrderModel> activeUserOrderList = [];
  List<String> activeIndexList = [
    "new",
    "processing",
    "dispatched",
    "delivered",
    "cancelled",
    "returned"
  ];

  bool getUserOrderLoader = false;
  late TabController tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Active'),
    Tab(text: 'All'),
  ];

  void getUserOrder() async {
    getUserOrderLoader = true;
    update();
    await callAndErrorHendling(
      callback: (data) {
        print("user order data : $data");
        if (data["msg"]["result"].isEmpty) {
          showSnackBar(Get.context!, "Doesn't have any order", true);
          return;
        }
        userOrderList = List<OrderModel>.from(data["msg"]["result"]
                .map((e) => OrderModel.fromMap(e))
                .toList())
            .reversed
            .toList();
        activeUserOrderList = userOrderList.where((e) {
          return e.info.status != "delivered" &&
              e.info.paymentStatus == "success";
        }).toList();
        print(userOrderList[0].info.razorpayOrderId);
      },
      errorOccurFunction: (e) {
        showSnackBar(Get.context!, e, true);
      },
      url: "${base_url}order",
      method: "get",
      body: {},
    );
    getUserOrderLoader = false;
    update();
  }

  bool cancelOrderLoader = false;
  void cancelOrder(String id) async {
    cancelOrderLoader = true;
    // String token = (await SharedPrefs.getString("token")) ?? "";
    // try {
    //   final res = await http.post(
    //       Uri.parse("https://test-bk-api.onrender.com/client/order/cancel/$id"),
    //       headers: {
    //         "authorization": "Bearer $token",
    //       });
    //   print(res.body);
    // } catch (e) {
    //   print(e);
    // }
    await callAndErrorHendling(
        callback: (data) {
          print("cancel order data : $data");
        },
        errorOccurFunction: (error) {
          showSnackBar(Get.context!, error, true);
        },
        url: "https://test-bk-api.onrender.com/client/order/cancel/$id",
        method: "post",
        body: {});
  }

  Future<void> launchPhone(String schema, String path) async {
    final Uri _phoneUri = Uri(scheme: schema, path: path);
    try {
      if (await canLaunch(_phoneUri.toString())) {
        await launch(_phoneUri.toString());
      }
    } catch (e) {
      showSnackBar(Get.context!, "Cannot Make Call", true);
      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserOrder();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  Future callAndErrorHendling(
      {required Function callback,
      required Function errorOccurFunction,
      required String url,
      required String method,
      required Map body,
      bool? loader,
      String? error}) async {
    try {
      String token = (await SharedPrefs.getString("token")) ?? "";
      print("token : $token");
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
      } else {
        response = await http.put(Uri.parse(url), body: body, headers: {
          "authorization": "Bearer $token",
        });
      }
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data["success"]) {
          callback(data);
        } else {
          errorOccurFunction("sometghing went wrong");
        }
      } else {
        errorOccurFunction("sometghing went wrong");
      }
    } catch (e) {
      print("catch error : $e");
      errorOccurFunction(e.toString());
    }
  }
}
