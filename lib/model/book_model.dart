// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModel {
  ImageModel image1;
  String id;
  String bookName;
  String? author;
  bool availability = true;
  Genre? genre;
  Language? language;
  String? description;
  int? rentPerDay;
  bool? approved;
  String? uploadedBy;
  String? createdAt;
  bool? checkValue;
  String? updatedAt;
  int? quantity = 1;
  int value = 0;
  bool isLiked = false;
  String state;
  String city;
  BookModel(
      {required this.image1,
      required this.id,
      required this.bookName,
      required this.availability,
      this.genre,
      this.language,
      this.description,
      this.rentPerDay,
      this.approved,
      this.uploadedBy,
      this.createdAt,
      this.updatedAt,
      this.author,
      this.quantity = 0,
      this.value = 0,
      required this.state,
      required this.city,
      this.checkValue = false,
      this.isLiked = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'image': image1,
      'id': id,
      'bookName': bookName,
      'genre': genre,
      'language': language,
      'description': description,
      'rentPerDay': rentPerDay,
      'approved': approved,
      'uploadedBy': uploadedBy,
      "author": author,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      "availability": availability,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      image1: ImageModel.fromMap(map['image1'] as Map<String, dynamic>),
      id: map['_id'] as String,
      availability: map["availability"],
      bookName: map['bookName'] as String,
      author: map["author"] != null ? map["author"] : "",
      genre: map['genre'] != null
          ? Genre.fromMap(map['genre'] as Map<String, dynamic>)
          : null,
      language: map['language'] != null
          ? Language.fromMap(map['language'] as Map<String, dynamic>)
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      rentPerDay: map['rentPerDay'] != null ? map['rentPerDay'] as int : null,
      approved: map['approved'] != null ? map['approved'] as bool : null,
      uploadedBy:
          map['uploadedBy'] != null ? map['uploadedBy'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      state: map['state'] != null ? map["state"] : "",
      city: map["city"] != null ? map["city"] : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ImageModel {
  String publicId;
  String url;
  ImageModel({
    required this.publicId,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'public_id': publicId,
      'url': url,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      publicId: map['public_id'] != null ? map['public_id'] as String : "",
      url: map['url'] != null ? map['url'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Genre {
  ImageModel? image;
  String id;
  String genre;
  String createdAt;
  String updatedAt;
  bool selected = false;
  Genre(
      {this.image,
      required this.id,
      required this.genre,
      required this.createdAt,
      required this.updatedAt,
      this.selected = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image?.toMap(),
      '_id': id,
      'genre': genre,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      image: map['image'] != null
          ? ImageModel.fromMap(map['image'] as Map<String, dynamic>)
          : null,
      id: map['_id'] as String,
      genre: map['genre'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Genre.fromJson(String source) =>
      Genre.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Language {
  String id;
  String language;
  String createdAt;
  String updatedAt;
  Language({
    required this.id,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'language': language,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      id: map['_id'] as String,
      language: map['language'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) =>
      Language.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Fees {
  double? internetHandlingFees;
  double? deliveryFees;
  double? serviceFees;
  double rentalCharge = 0;
  double grandtotal = 0;
  Fees({
    this.internetHandlingFees,
    this.deliveryFees,
    required this.rentalCharge,
    required this.grandtotal,
    this.serviceFees,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'internetHandlingFees': internetHandlingFees,
      'deliveryFees': deliveryFees,
      'serviceFees': serviceFees,
      "rentalCharge": rentalCharge,
      "total": grandtotal,
    };
  }

  factory Fees.fromMap(Map<String, dynamic> map) {
    return Fees(
      internetHandlingFees: map['internetHandlingFees'] != null
          ? map['internetHandlingFees'] * 1.0
          : 0.0,
      deliveryFees:
          map['deliveryFees'] != null ? map['deliveryFees'] * 1.0 : 0.0,
      serviceFees: map['serviceFees'] != null ? map['serviceFees'] * 1.0 : 0.0,
      rentalCharge: map['totalAmountBeforeCharges'] != null
          ? map['totalAmountBeforeCharges'] * 1.0
          : 0.0,
      grandtotal: map['totalAmountAfterCharges'] != null
          ? map['totalAmountAfterCharges'] * 1.0
          : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fees.fromJson(String source) =>
      Fees.fromMap(json.decode(source) as Map<String, dynamic>);
}
