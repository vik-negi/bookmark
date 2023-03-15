import 'dart:convert';
import 'dart:math';

import 'package:bookmark/model/bill_model.dart';
import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/model/cart_model.dart';
import 'package:bookmark/model/user_model.dart';
import 'package:bookmark/repository/address_repo.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/payment/payment_success.dart';
import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:bookmark/utils/shared_prefer.dart';
import 'package:bookmark/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:http/http.dart' as http;

import 'package:razorpay_flutter/razorpay_flutter.dart';

enum PaymentModeEnum { creditCard, debitCard, cod }

class PaymentVM extends GetxController {
  // List<DateTime> startAndEndDate = [];
  // final monthList = [
  //   'Jan',
  //   'Feb',
  //   'Mar',
  //   'Apr',
  //   'May',
  //   'Jun',
  //   'Jul',
  //   'Aug',
  //   'Sep',
  //   'Oct',
  //   'Nov',
  //   'Dec'
  // ];
  bool preceedForRazorPay = false;

  bool addCard = false;
  String paymentOption = "Debit Card";
  bool addressLoader = false;
  Address? selectedAddress;

  // DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  // DateTime? userSelectedDate;
  // TimeOfDay? userSelectedTime;
  // double getDates(double price) {
  //   if (startAndEndDate.isEmpty) return 0;
  //   if (startAndEndDate[1].difference(startAndEndDate[0]).inDays < 90) {
  //     return startAndEndDate.isNotEmpty
  //         ? startAndEndDate[1].difference(startAndEndDate[0]).inDays == 0
  //             ? price / 60
  //             : (startAndEndDate[1].difference(startAndEndDate[0]).inDays + 1) *
  //                 price /
  //                 60
  //         : price;
  //   } else {
  //     return price;
  //   }
  // }

  // pickDates(context) async {
  //   startAndEndDate = await showOmniDateTimeRangePicker(
  //         context: context,
  //         type: OmniDateTimePickerType.dateAndTime,
  //         primaryColor: Colors.cyan,
  //         backgroundColor: Colors.grey[900],
  //         calendarTextColor: Colors.white,
  //         tabTextColor: Colors.white,
  //         unselectedTabBackgroundColor: Colors.grey[700],
  //         buttonTextColor: Colors.white,
  //         timeSpinnerTextStyle:
  //             const TextStyle(color: Colors.white70, fontSize: 18),
  //         timeSpinnerHighlightedTextStyle:
  //             const TextStyle(color: Colors.white, fontSize: 24),
  //         is24HourMode: false,
  //         isShowSeconds: false,
  //         startInitialDate: DateTime.now(),
  //         startFirstDate: DateTime.now().subtract(const Duration(days: 0)),
  //         startLastDate: DateTime.now().add(
  //           const Duration(days: 3652),
  //         ),
  //         endInitialDate: DateTime.now(),
  //         endFirstDate: DateTime.now().subtract(const Duration(days: 0)),
  //         endLastDate: DateTime.now().add(
  //           const Duration(days: 3652),
  //         ),
  //         borderRadius: const Radius.circular(16),
  //       ) ??
  //       [];
  //   update();
  //   if (startAndEndDate[1].difference(startAndEndDate[0]).inDays < 0) {
  //     Get.snackbar("Invalid selected dates",
  //         "Start date cannot be greater than end date");
  //     startAndEndDate = [];
  //     update();
  //   }
  // }

  ProfileVM profileVm = Get.put(ProfileVM());

  List<Address> address = [];
  AddressRepo addressRepo = AddressRepo();
  // getAddressList() async {
  //   addressLoader = true;
  //   update();
  //   address = await addressRepo.fetchAddress();
  //   selectedAddress = profileVm.address[0];
  //   addressLoader = false;
  //   update();
  // }

  Future<String> getUniqueId() async {
    var response =
        await http.get(Uri.parse("https://test-bk-api.onrender.com/getUid"));
    Map map = jsonDecode(response.body);
    if (response.statusCode == 200 && map["success"]) {
      return map["msg"]["_id"];
    }
    return "error";
  }

  String orderIid = "";
  void placeOrder(String paymentId, String signature, String orderId) async {
    Map body = {
      "addressId": selectedAddress!.id,
      "paymentId": paymentId,
      "signature": signature,
      "orderId": orderId,
    };
    if (diningVm.isSingleBookPurchase) {
      body['itemId'] = diningVm.singleBookPurchase!.id;
      body['noOfDays'] = diningVm.singleBookDays.toString();
    }
    String url = diningVm.isSingleBookPurchase
        ? "https://test-bk-api.onrender.com/client/order/single/"
        : "https://test-bk-api.onrender.com/client/order";
    String token = (await SharedPrefs.getString("token")) ?? "";
    print(url);
    print("body of place order paymeny_viewmodel: ${body.toString()}");
    var res = await http.post(Uri.parse(url), body: body, headers: {
      "authorization": "Bearer $token",
    });
    print("res of order paymeny_viewmodel: ${res.body}");
    diningVm.afterPaymentLoader = false;
    diningVm.isSingleBookPurchase = false;
    diningVm.update();
    if (jsonDecode(res.body)["success"]) {
      diningVm.cartfoods.clear();

      Get.back();
      Get.off(() => PaymentSuccess(orderId: orderId, paymentId: paymentId));
    } else {
      Get.back();
      Get.back();
      showSnackBar(Get.context!, "Something went wrong", true);
    }
  }

  void orderFailed(String error, String code, String orderId) async {
    Map body = {
      "addressId": selectedAddress!.id,
      "errorCode": code,
      "errorDescription": error,
      "orderId": orderId,
    };
    String token = (await SharedPrefs.getString("token")) ?? "";
    var res = await http.post(
        Uri.parse("https://test-bk-api.onrender.com/client/order"),
        body: body,
        headers: {
          "authorization": "Bearer $token",
        });
    print("res of order paymeny_viewmodel: ${res.body}");
    if (!jsonDecode(res.body)["success"]) {
      // diningVm.afterPaymentLoader = false;
    }
    diningVm.update();
    showSnackBar(Get.context!, error, true);
  }

  List<BillItemModel> billItems = [];
  Fees chargesByAddress = Fees(
    rentalCharge: 0,
    grandtotal: 0,
    deliveryFees: 0,
    internetHandlingFees: 0,
    serviceFees: 0,
  );
  bool loadBill = false;
  List<Map<String, double>> variousFeesList = [];

  void getBills() async {
    loadBill = true;
    update();
    Map body = {"addressId": selectedAddress!.id, "billOnly": "true"};
    String url = diningVm.isSingleBookPurchase
        ? "https://test-bk-api.onrender.com/client/order/single/bill"
        : "https://test-bk-api.onrender.com/client/order/bill";
    print("single book : $url");
    String token = (await SharedPrefs.getString("token")) ?? "";

    diningVm.update();
    if (diningVm.isSingleBookPurchase) {
      body["itemId"] = diningVm.singleBookPurchase!.id;
      body["noOfDays"] = diningVm.singleBookDays.toString();
    }
    print("body of order paymeny_viewmodel: ${body.toString()}");
    var res = await http.post(Uri.parse(url), body: body, headers: {
      "authorization": "Bearer $token",
    });
    print("res of order paymeny_viewmodel: ${res.body}");

    if (res.statusCode == 201) {
      Map map = jsonDecode(res.body);
      if (map["success"]) {
        variousFeesList.clear();
        print("hii");
        chargesByAddress = Fees.fromMap(map["msg"]["total"]);
        print("chargesByAddress: ${chargesByAddress.deliveryFees}");
        if (diningVm.isSingleBookPurchase) {
          billItems = List<BillItemModel>.from(map["msg"]["items"]
              .map((e) => BillItemModel.fromMap(e))
              .toList());
          diningVm.cartfoods.clear();
          diningVm.cartfoods.add(CartModel(
            book: BookModel(
              city: "",
              state: "",
              availability: false,
              id: billItems[0].itemId,
              quantity: 1,
              image1: diningVm.singleBookPurchase!.image1,
              rentPerDay: billItems[0].rentPerDay.toInt(),
              bookName: 'Book Name',
            ),
            id: "",
            noOfDays: billItems[0].noOfDays,
          ));
          diningVm.update();
        }

        chargesByAddress.toMap().forEach((key, value) {
          variousFeesList
              .add({camelToSentence(key): value != null ? value * 1.0 : 0.0});
          update();
        });
        print("variousFeesList: ${variousFeesList.toString()}");
        update();
      }
    }
    loadBill = false;
    update();
  }

  void createOrder(int amount) async {
    String username = "rzp_test_n3dFqbNPtBu0qC";
    String passvd = "xVHxK5j6H9JQvRtvlimqgle1";
    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$passvd'))}";
    Map<String, dynamic> body = {
      "amount": amount,
      "currency": "INR",
      "receipt": "rcptid_11",
      "payment_capture": 1
    };
    var res = await http.post(Uri.parse("https://api.razorpay.com/v1/orders"),
        headers: <String, String>{
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(body));
    if (res.statusCode == 200) {
      print("res of order paymeny_viewmodel: ${res.body}");
      orderIid = jsonDecode(res.body)["id"];
      update();
      razorpayPayment(amount.toString(), jsonDecode(res.body)["id"]);
    } else {
      print("res of order paymeny_viewmodel: ${res.body}");
    }
  }

  Razorpay _razorpay = Razorpay();
  void razorpayPayment(String amount, String id) async {
    print("Razorpay Payment");
    String name = await SharedPrefs.getString("name") ?? "name";
    String email = await SharedPrefs.getString("email") ?? "email";

    var options = {
      'key': 'rzp_test_n3dFqbNPtBu0qC',
      'amount': amount, //is in paise
      'name': 'BookMark',
      'order_id': id, // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 900, // in seconds
      'prefill': {'contact': '8178945004', 'email': email, 'name': name},
    };

    try {
      _razorpay.open(options);
      preceedForRazorPay = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  DiningVM diningVm =
      Get.isRegistered<DiningVM>() ? Get.find() : Get.put(DiningVM());
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(
        "paymentId: ${response.paymentId}, orderId : ${response.orderId}, signature : ${response.signature}");
    print("Payment Success ${response.paymentId} -- ${response.orderId} -- ");

    diningVm.variousFees = Fees(rentalCharge: 0, grandtotal: 0);
    // if (diningVm.isSingleBookPurchase == false) {
    diningVm.afterPaymentLoader = true;
    // diningVm.isSingleBookPurchase = false;
    diningVm.update();
    placeOrder(response.paymentId ?? "", response.signature ?? "",
        response.orderId ?? "");
    // } else {
    //   diningVm.cartfoods.clear();
    //   diningVm.update();
    //   Get.back();
    //   Get.off(() => PaymentSuccess(
    //       orderId: response.orderId ?? "",
    //       paymentId: response.paymentId ?? ""));
    // }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error ${response.code} -- ${response.message}");
    // if (diningVm.isSingleBookPurchase == false) {
    orderFailed(response.message ?? "", response.code.toString(), orderIid);
    // diningVm.afterPaymentLoader = true;
    //  diningVm.update();
    // } else {
    diningVm.isSingleBookPurchase = false;
    // showSnackBar(Get.context!, response.message ?? "", true);
    // }
    diningVm.variousFees = Fees(rentalCharge: 0, grandtotal: 0);
    diningVm.update();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet ${response.walletName}");
  }

  String camelToSentence(String input) {
    StringBuffer sentence = new StringBuffer();
    for (int i = 0; i < input.length; i++) {
      if (i == 0) {
        sentence.write(input[i].toUpperCase());
      } else if (input[i].toUpperCase() == input[i]) {
        sentence.write(" ");
        sentence.write(input[i]);
      } else {
        sentence.write(input[i]);
      }
    }
    return sentence.toString();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // profileVm.getAddressList();
    // await getAddressList();
  }

  @override
  void onClose() {
    _razorpay.clear();
  }
}
