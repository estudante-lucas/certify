import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Training {
  final String? id;

  final String name;

  final String description;

  final Image? image;

  Training(this.name, this.description, {this.id, this.image});

  factory Training.fromMap(Map<String, dynamic> map) {
    return Training(map['name'], map['description']);
  }

  factory Training.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Training(
      id: snapshot.id,
      data?['name'],
      data?['description'],
      image: data?['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "description": description,
      if (image != null) "image": image,
    };
  }
}
