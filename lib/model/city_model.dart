import 'dart:convert';
import 'package:bookmark/model/state_model.dart';

class CityModel {
  String id;
  String city;
  StateModel state;
  String createdAt;
  String updatedAt;
  CityModel({
    required this.id,
    required this.city,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'city': city,
      'state': state.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] as String,
      city: map['city'] as String,
      state: StateModel.fromMap(map['state'] as Map<String, dynamic>),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
