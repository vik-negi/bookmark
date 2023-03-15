// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookmark/model/book_model.dart';

class UserModel {
  String? id;
  ImageModel? image;
  String? name;
  String? email;
  String? phone;
  String? role = "user";
  List<Address>? address;
  bool? approved;
  String? createdAt;
  String? updatedAt;
  String? userName;
  List<String>? booksAdded;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.role,
      this.address,
      this.approved,
      this.createdAt,
      this.updatedAt,
      this.userName,
      this.booksAdded});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['fullName'] ?? "";
    email = json['email'];
    phone = json['phone'] != null ? json['phone'].toString() : "";
    role = "user";
    approved = json['approved'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address = json['address'] != null
        ? List<Address>.from(json['address'].map((e) => Address.fromMap(e)))
        : [];
    userName = json['userName'];
    booksAdded = json['booksAdded'].cast<String>();
    image = json['image'] != null ? ImageModel.fromMap(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['fullName'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['approved'] = this.approved;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userName'] = this.userName;
    data['booksAdded'] = this.booksAdded;
    if (this.address != null) {
      data['address'] = this.address;
    }

    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Address {
  String id;
  String addressLine1;
  String? addressLine2;
  String? landmark;
  String? city;
  String? state;
  int zipCode;
  String? country;
  String createdAt;
  String updatedAt;
  bool selectedAdd;
  Address({
    required this.id,
    required this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    required this.zipCode,
    this.country,
    this.landmark,
    this.selectedAdd = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'addressLine1': addressLine1,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['_id'] as String,
      addressLine1: map['addressLine1'] as String,
      addressLine2:
          map['addressLine2'] != null ? map['addressLine2'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      zipCode: map['zipCode'] as int,
      country: map['country'] != null ? map['country'] as String : null,
      landmark: map['landmark'] != null ? map['landmark'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);
}
