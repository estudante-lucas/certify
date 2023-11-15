import 'dart:ui';

import 'package:certify/shared/models/collaborator/collaborator_training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Collaborator {
  final String? id;
  final String name;
  final String registrationNumber;
  final String role;
  final String cpf;
  final String email;
  final String phone;
  List<CollaboratorTraining>? collaboratorTrainings;
  final Image? image;

  Collaborator(this.name, this.registrationNumber, this.role, this.cpf, this.email, this.phone,
      {this.id, this.collaboratorTrainings, this.image});

  factory Collaborator.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Collaborator.fromMap(snapshot.id, data);
  }

  factory Collaborator.fromMap(String? id, Map<String, dynamic>? data) {
    return Collaborator(
      id: id,
      data?['name'],
      data?['registrationNumber'],
      data?['role'],
      data?['cpf'],
      data?['email'],
      data?['phone'],
      collaboratorTrainings:
          data?['collaboratorTrainings']?.map((value) => CollaboratorTraining.fromFirestore(value)).toList()?.cast<CollaboratorTraining>(),
      image: data?['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "registrationNumber": registrationNumber,
      "role": role,
      "cpf": cpf,
      "email": email,
      "phone": phone,
      "collaboratorTrainings": collaboratorTrainings?.map((c) => c.toFirestore()).toList(),
      if (image != null) "image": image,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "registrationNumber": registrationNumber,
      "role": role,
      "cpf": cpf,
      "email": email,
      "phone": phone,
      "collaboratorTrainings": collaboratorTrainings?.map((c) => c.toFirestore()).toList(),
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
