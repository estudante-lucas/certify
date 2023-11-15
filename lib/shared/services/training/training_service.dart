import 'package:certify/config/firebase/firestore_collections.dart';
import 'package:certify/shared/models/training/training_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingService {
  static final _instance = FirebaseFirestore.instance
      .collection(FirestoreCollection.training)
      .withConverter(fromFirestore: Training.fromFirestore, toFirestore: (Training training, options) => training.toFirestore());

  static Future<Training> add(Training training) async {
    var documentReference = await _instance.add(training);
    var documentSnapshot = await documentReference.get();

    return documentSnapshot.data()!;
  }

  static Future<List<Training>?> findAll() async {
    var querySnapshot = await _instance.limit(20).get();

    var data = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (data.isEmpty) return List<Training>.empty();

    return data;
  }

  static Future<List<Training?>> findByTerm(String term) async {
    var querySnapshot = await _instance.where("name", isEqualTo: term).get();

    if (querySnapshot.docs.isEmpty) return List<Training>.empty();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<Training?> find(String id) async {
    var querySnapshot = await _instance.where("id", isEqualTo: id).get();

    if (querySnapshot.docs.isEmpty) return null;

    return querySnapshot.docs.first.data();
  }

  static Future<bool> update(Training training) async {
    throw UnimplementedError();
  }

  static Future<bool> delete(String id) async {
    return await FirebaseFirestore.instance.collection("training").doc(id).delete().then((v) => true).onError((e, s) => false);
  }
}
