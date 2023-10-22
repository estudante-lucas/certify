import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  final String id;
  final String name;
  final String role;
  final Image? image;

  Worker(this.id, this.name, this.role, {this.image});

  factory Worker.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Worker(
      snapshot.id,
      data?['name'],
      data?['role'],
      image: data?['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "role": role,
      if (image != null) "image": image,
    };
  }

  String getInitials() {
    var split = name.split(" ");
    if (split.length > 1) {
      var firstInitial = split[0].substring(0, 1);
      var lastInitial = split[split.length - 1].substring(0, 1);

      return firstInitial.toUpperCase() + lastInitial.toUpperCase();
    }
    return name.substring(0, 2);
  }
}
