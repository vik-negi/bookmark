// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class Book {
  int? id;
  String? asin;
  String? categories;
  String? address;
  String? distance;
  Price? price;
  double? currentPrice;
  Reviews? reviews;
  String? url;
  bool checkValue = false;
  String? score;
  String? des;
  bool? sponsored;
  List<String>? topTags;
  List<String>? bottomTags;
  List? item = [];
  List<String>? specialTags;
  bool? amazonChoice;
  bool? bestSeller;
  int quantity = 0;
  int value = 0;
  bool isLiked = false;
  bool? amazonPrime;
  String? title;
  String? thumbnail;

  Book(
      {this.id,
      this.des,
      this.asin,
      this.address,
      this.value = 0,
      this.item,
      this.distance,
      this.checkValue = false,
      this.categories,
      this.bottomTags,
      this.quantity = 0,
      this.specialTags,
      this.price,
      this.reviews,
      this.topTags,
      this.url,
      this.isLiked = false,
      this.currentPrice,
      this.score,
      this.sponsored,
      this.amazonChoice,
      this.bestSeller,
      this.amazonPrime,
      this.title,
      this.thumbnail});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['position'] != null ? json['position']["global_position"] : null;
    asin = json['asin'];
    checkValue = false;
    isLiked = false;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    currentPrice =
        json['price'] != null ? json["price"]["current_price"] * 80.0 : 0.0;
    reviews =
        json['reviews'] != null ? Reviews.fromJson(json['reviews']) : null;
    url = json['url'];
    score = json['score'];
    sponsored = json['sponsored'];
    amazonChoice = json['amazonChoice'];
    bestSeller = json['bestSeller'];
    amazonPrime = json['amazonPrime'];
    title = json['title'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['position'] = id;
    }
    data['asin'] = asin;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.toJson();
    }
    data['url'] = url;
    data['score'] = score;
    data['sponsored'] = sponsored;
    data['amazonChoice'] = amazonChoice;
    data['bestSeller'] = bestSeller;
    data['amazonPrime'] = amazonPrime;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class Price {
  bool? discounted;
  double? currentPrice;
  String? currency;
  double? beforePrice;
  double? savingsAmount;
  double? savingsPercent;

  Price(
      {this.discounted,
      this.currentPrice,
      this.currency,
      this.beforePrice,
      this.savingsAmount,
      this.savingsPercent});

  Price.fromJson(Map<String, dynamic> json) {
    discounted = json['discounted'];
    currentPrice = json['current_price'] * 1.0;
    currency = json['currency'];
    beforePrice = json['before_price'] * 1.0;
    savingsAmount = json['savings_amount'] * 1.0;
    savingsPercent = json['savings_percent'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discounted'] = discounted;
    data['current_price'] = currentPrice;
    data['currency'] = currency;
    data['before_price'] = beforePrice;
    data['savings_amount'] = savingsAmount;
    data['savings_percent'] = savingsPercent;
    return data;
  }
}

class Reviews {
  int? totalReviews;
  double? rating;

  Reviews({this.totalReviews, this.rating});

  Reviews.fromJson(Map<String, dynamic> json) {
    totalReviews = json['total_reviews'];
    rating = json['rating'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_reviews'] = totalReviews;
    data['rating'] = rating;
    return data;
  }
}

class Userbook {
  int id;
  String? categories;
  double? currentPrice;
  bool checkValue = false;
  String? des;
  bool? sponsored;
  List? item = [];
  List<String>? specialTags;
  int quantity = 0;
  bool isLiked = false;
  bool? amazonPrime;
  String? title;
  String? language;
  XFile? image;
  Userbook(
      {required this.id,
      this.categories,
      this.currentPrice,
      required this.checkValue,
      this.des,
      this.sponsored,
      this.item,
      this.specialTags,
      required this.quantity,
      required this.isLiked,
      this.amazonPrime,
      this.title,
      this.image,
      this.language});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categories': categories,
      'currentPrice': currentPrice,
      'checkValue': checkValue,
      'des': des,
      'sponsored': sponsored,
      'item': item,
      'specialTags': specialTags,
      'quantity': quantity,
      'isLiked': isLiked,
      'amazonPrime': amazonPrime,
      'title': title,
      'image': image,
      'language': language
    };
  }

  factory Userbook.fromMap(Map<String, dynamic> map) {
    return Userbook(
        id: map['id'] as int,
        categories:
            map['categories'] != null ? map['categories'] as String : null,
        currentPrice:
            map['currentPrice'] != null ? map['currentPrice'] as double : null,
        checkValue: map['checkValue'] as bool,
        des: map['des'] != null ? map['des'] as String : null,
        sponsored: map['sponsored'] != null ? map['sponsored'] as bool : null,
        item: map['item'] != null ? List.from(map['item'] as List) : null,
        specialTags: map['specialTags'] != null
            ? List<String>.from((map['specialTags'] as List<String>))
            : null,
        quantity: map['quantity'] as int,
        isLiked: map['isLiked'] as bool,
        amazonPrime:
            map['amazonPrime'] != null ? map['amazonPrime'] as bool : null,
        title: map['title'] != null ? map['title'] as String : null,
        image: map['image'] != null ? map['XFile'] : null,
        language: map['language'] != null ? map['language'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory Userbook.fromJson(String source) =>
      Userbook.fromMap(json.decode(source) as Map<String, dynamic>);
}
