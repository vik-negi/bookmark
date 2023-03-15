// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/model/user_model.dart';

class Info {
  double internetHandlingFees;
  double deliveryFees;
  double serviceFees;
  double totalAmountBeforeCharges;
  double totalAmountAfterCharges;
  String status;
  String createdAt;
  String updatedAt;
  String razorpayOrderId;
  String paymentStatus;
  String? razorpaySignature;
  String? razorpayPaymentId;
  Courier? courier;
  Info({
    required this.internetHandlingFees,
    required this.deliveryFees,
    required this.serviceFees,
    required this.totalAmountBeforeCharges,
    required this.totalAmountAfterCharges,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.razorpayOrderId,
    required this.paymentStatus,
    this.razorpaySignature,
    this.razorpayPaymentId,
    this.courier,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'internetHandlingFees': internetHandlingFees,
      'deliveryFees': deliveryFees,
      'serviceFees': serviceFees,
      'totalAmountBeforeCharges': totalAmountBeforeCharges,
      'totalAmountAfterCharges': totalAmountAfterCharges,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'razorpayOrderId': razorpayOrderId,
      'paymentStatus': paymentStatus,
      'razorpaySignature': razorpaySignature,
      'razorpayPaymentId': razorpayPaymentId,
      'courier': courier?.toMap(),
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      internetHandlingFees: map['internetHandlingFees'] != null
          ? map['internetHandlingFees'] * 1.0
          : 0.0,
      deliveryFees:
          map['deliveryFees'] != null ? map['deliveryFees'] * 1.0 : 0.0,
      serviceFees: map['serviceFees'] != null ? map['serviceFees'] * 1.0 : 0.0,
      totalAmountBeforeCharges: map['totalAmountBeforeCharges'] != null
          ? map['totalAmountBeforeCharges'] * 1.0
          : 0.0,
      totalAmountAfterCharges: map['totalAmountAfterCharges'] != null
          ? map['totalAmountAfterCharges'] * 1.0
          : 0.0,
      status: map['status'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      razorpayOrderId: map['razorpayOrderId'] as String,
      paymentStatus: map['paymentStatus'] as String,
      razorpaySignature: map['razorpaySignature'] != null
          ? map['razorpaySignature'] as String
          : null,
      razorpayPaymentId: map['razorpayPaymentId'] != null
          ? map['razorpayPaymentId'] as String
          : null,
      courier: map['courier'] != null
          ? Courier.fromMap(map['courier'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderModel {
  Address address;
  Info info;
  List<OrderItem> items;
  OrderModel({
    required this.address,
    required this.info,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address.toMap(),
      'info': info.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      info: Info.fromMap(map['info'] as Map<String, dynamic>),
      items: List<OrderItem>.from(
        map['items'].map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderItem {
  BookModel books;
  int noOfDays;
  double rentPerDay;
  double amount;
  String id;
  OrderItem({
    required this.books,
    required this.noOfDays,
    required this.rentPerDay,
    required this.amount,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'books': books.toMap(),
      'noOfDays': noOfDays,
      'rentPerDay': rentPerDay,
      'amount': amount,
      'id': id,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      books: BookModel.fromMap(map['itemId'] as Map<String, dynamic>),
      noOfDays: map['noOfDays'] as int,
      rentPerDay: map['rentPerDay'] != null ? map['rentPerDay'] * 1.0 : 0.0,
      amount: map['amount'] != null ? map['amount'] * 1.0 : 0.0,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Courier {
  String id;
  String courierName;
  String? email;
  int phone;
  String? address;
  bool? approved;
  String? createdAt;
  String? updatedAt;
  ImageModel? image;
  Courier({
    required this.id,
    required this.courierName,
    this.email,
    required this.phone,
    this.address,
    this.approved,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courierName': courierName,
      'email': email,
      'phone': phone,
      'address': address,
      'approved': approved,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'image': image?.toMap(),
    };
  }

  factory Courier.fromMap(Map<String, dynamic> map) {
    return Courier(
      id: map['_id'] as String,
      courierName: map['courierName'] as String,
      email: map['email'] != null ? map['email'] as String : "",
      phone: map['phone'] as int,
      address: map['address'] != null ? map['address'] as String : "",
      approved: map['approved'] != null ? map['approved'] as bool : false,
      createdAt: map['createdAt'] as String?,
      updatedAt: map['updatedAt'] as String?,
      image: map['image'] != null
          ? ImageModel.fromMap(map['image'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Courier.fromJson(String source) =>
      Courier.fromMap(json.decode(source) as Map<String, dynamic>);
}
