// import 'package:flutter/material.dart';
// import 'package:bookmark/model/food_model.dart';
// import 'package:get/get.dart';

// class DetailsPageVM extends GetxController {
//   FoodModel? data;
//   double totalPrice = 0;
//   @override
//   void onInit() {
//     // data = Get.arguments["data"] ??
//     data = FoodModel(
//       image:
//           'https://cdn.pixabay.com/photo/2018/08/16/23/06/ice-3611722_1280.jpg',
//       name: "Sundae",
//       time: "30-40 min",
//       distance: "1.5 km",
//       value: 150,
//       quantity: 0,
//       price: 150.0,
//     );
//     // initialValues(data);
//     super.onInit();
//   }

//   // void initialValues(FoodModel? data) {
//   //   // totalPrice = data!.price;
//   //   // cartfoods.add(data);
//   //   // data.quantity = data.quantity + 1;
//   //   // update();
//   // }

//   void totalPriceFun(double price, int quantity) {
//     totalPrice = price * quantity;
//     update();
//   }

//   List<FoodModel> cartfoods = [];

//   void increaseQuantity(double price) {
//     if (data!.quantity == 0) {
//       addInCartList();
//     }
//     data!.quantity = data!.quantity + 1;
//     totalPrice += price;
//     update();
//   }

//   void addInCartList() {
//     if (!cartfoods.contains(data)) {
//       cartfoods.add(data!);
//     }
//     update();
//   }

//   void removeFromCartList() {
//     if (data!.quantity > 0) {
//       cartfoods.remove(data);
//     }
//     update();
//   }

//   void decreaseQuantity() {
//     if (data!.quantity == 1) {
//       removeFromCartList();
//     }
//     if (data!.quantity > 0) {
//       data!.quantity = data!.quantity - 1;
//       totalPrice -= data!.price;
//     }
//     update();
//   }
//   // FoodModel? data = argm
// }
