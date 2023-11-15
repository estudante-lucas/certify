import 'package:certify/shared/models/training/training_model.dart';

class CollaboratorTraining {
  final String? id;

  final Training training;

  final DateTime deadline;

  CollaboratorTraining(this.training, this.deadline, {this.id});

  factory CollaboratorTraining.fromFirestore(Map<String, dynamic> map) {
    return CollaboratorTraining(
      Training.fromMap(map['training']),
      DateTime.fromMillisecondsSinceEpoch(map['deadline']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "training": training.toFirestore(),
      "deadline": deadline.millisecondsSinceEpoch,
    };
  }
}
