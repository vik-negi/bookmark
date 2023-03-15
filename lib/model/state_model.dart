import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//       "_id": "63e4b872303e38711603ce1b",
//       "state": "Karnataka",
//       "createdAt": "2023-02-09T09:10:47.028Z",
//       "updatedAt": "2023-02-09T09:10:47.028Z",
//       "__v": 0
//     }

class StateModel {
  String id;
  String state;
  String createdAt;
  String updatedAt;
  StateModel({
    required this.id,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'state': state,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      id: map['id'] as String,
      state: map['state'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateModel.fromJson(String source) =>
      StateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
