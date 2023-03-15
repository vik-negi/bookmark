import 'dart:convert';
import 'package:bookmark/model/user_model.dart';

class BillModel {
  Address address;
  List<BillItemModel> items;
  int internetHandlingFees;
  double deliveryFees;
  double serviceFees;
  double totalAmountBeforeCharges;
  double totalAmountAfterCharges;

  BillModel({
    required this.address,
    required this.items,
    required this.internetHandlingFees,
    required this.deliveryFees,
    required this.serviceFees,
    required this.totalAmountBeforeCharges,
    required this.totalAmountAfterCharges,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      address: Address.fromJson(json['address']),
      items: List<BillItemModel>.from(
          json['items'].map((x) => BillItemModel.fromJson(x))),
      internetHandlingFees: json['internetHandlingFees'] != null
          ? json['internetHandlingFees'] * 1
          : 0,
      deliveryFees:
          json['deliveryFees'] != null ? json['deliveryFees'] * 1.0 : 0.0,
      serviceFees:
          json['serviceFees'] != null ? json['serviceFees'] * 1.0 : 0.0,
      totalAmountBeforeCharges: json['totalAmountBeforeCharges'] != null
          ? json['totalAmountBeforeCharges'] * 1.0
          : 0.0,
      totalAmountAfterCharges: json['totalAmountAfterCharges'] != null
          ? json['totalAmountAfterCharges'] * 1.0
          : 0.0,
    );
  }
}

class BillItemModel {
  String itemId;
  int noOfDays;
  double rentPerDay;
  double amount;

  BillItemModel({
    required this.itemId,
    required this.noOfDays,
    required this.rentPerDay,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'noOfDays': noOfDays,
      'rentPerDay': rentPerDay,
      'amount': amount,
    };
  }

  factory BillItemModel.fromMap(Map<String, dynamic> map) {
    return BillItemModel(
      itemId: map['itemId'] as String,
      noOfDays: 3,
      rentPerDay: map['rentPerDay'] != null ? map['rentPerDay'] * 1.0 : 0.0,
      amount: map['amount'] != null ? map['amount'] * 1.0 : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillItemModel.fromJson(String source) =>
      BillItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
