// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookmark/model/book_model.dart';

class CartModel {
  String id;
  BookModel book;
  int noOfDays;
  CartModel({required this.book, required this.id, required this.noOfDays});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'book': book.toMap(),
      'noOfDays': noOfDays,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['_id'] as String,
      book: BookModel.fromMap(map['itemId'] as Map<String, dynamic>),
      noOfDays: map['noOfDays'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
