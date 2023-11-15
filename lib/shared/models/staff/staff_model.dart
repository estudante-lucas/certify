import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  final String? id;
  final String name;
  final String role;
  final String cpf;
  final String email;
  final String phone;
  final Image? image;

  Staff(this.name, this.role, this.cpf, this.email, this.phone, {this.id, this.image});

  factory Staff.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Staff(
      id: snapshot.id,
      data?['name'],
      data?['role'],
      data?['cpf'],
      data?['email'],
      data?['phone'],
      image: data?['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "role": cpf,
      "cpf": cpf,
      "email": email,
      "phone": phone,
      if (image != null) "image": image,
    };
  }
}
