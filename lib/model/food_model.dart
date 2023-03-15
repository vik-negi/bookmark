import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FoodModel {
  String image;
  String name;
  int id;
  bool? checkValue;
  List? topTags;
  List? bottomTags;
  List? specialTags;
  String? des;
  String? time;
  String? distance;
  String? address;
  double price;
  List? item;
  bool? isLiked;
  int quantity = 0;
  int? value;
  int? noOfItem;
  FoodModel({
    required this.image,
    required this.name,
    required this.id,
    this.bottomTags,
    this.checkValue = false,
    this.address,
    this.topTags,
    this.specialTags,
    this.des,
    this.item,
    this.value,
    this.time,
    this.distance,
    required this.price,
    this.isLiked = false,
    this.noOfItem,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'des': des,
      'time': time,
      'distance': distance,
      'price': price,
      'isLiked': isLiked,
      'noOfItem': noOfItem,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      image: map['image'] as String,
      id: map['id'] as int,
      name: map['name'] as String,
      des: map['des'] != null ? map['des'] as String : null,
      time: map['time'] as String,
      distance: map['distance'] as String,
      price: map['price'] as double,
      isLiked: map['isLiked'] as bool,
      noOfItem: map['noOfItem'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OptionHor1 {
  String image;
  String? name;
  String? des;
  String? time;
  String? distance;
  double? price;
  bool? isLiked;
  int? quantity;
  int? value;
  OptionHor1({
    required this.image,
    this.des,
    this.name,
    this.quantity,
    this.time,
    this.distance,
    this.price,
    this.value,
    this.isLiked = false,
  });
}

class BookModel {
  String image;
  String name;
  String? categories;
  int id;
  bool? checkValue;
  List? topTags;
  List? bottomTags;
  List? specialTags;
  String? des;
  String? time;
  String? distance;
  String? address;
  double price;
  List? item;
  bool? isLiked;
  int quantity = 0;
  int? value;
  int? noOfItem;
  BookModel({
    required this.image,
    required this.name,
    required this.id,
    this.bottomTags,
    this.checkValue = false,
    this.address,
    this.categories,
    this.topTags,
    this.specialTags,
    this.des,
    this.item,
    this.value,
    this.time,
    this.distance,
    required this.price,
    this.isLiked = false,
    this.noOfItem,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'des': des,
      'time': time,
      'distance': distance,
      'price': price,
      'isLiked': isLiked,
      'noOfItem': noOfItem,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      image: map['image'] as String,
      id: map['id'] as int,
      name: map['name'] as String,
      des: map['des'] != null ? map['des'] as String : null,
      time: map['time'] as String,
      distance: map['distance'] as String,
      price: map['price'] as double,
      isLiked: map['isLiked'] as bool,
      noOfItem: map['noOfItem'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
