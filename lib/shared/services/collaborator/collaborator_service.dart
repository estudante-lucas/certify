import 'package:certify/config/firebase/firestore_collections.dart';
import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollaboratorService {
  static final _instance = FirebaseFirestore.instance.collection(FirestoreCollection.collaborator).withConverter(
      fromFirestore: Collaborator.fromFirestore, toFirestore: (Collaborator collaborator, options) => collaborator.toFirestore());

  static Future<Collaborator> add(Collaborator collaborator) async {
    var documentReference = await _instance.add(collaborator);
    var documentSnapshot = await documentReference.get();

    return documentSnapshot.data()!;
  }

  static Future<List<Collaborator>?> findAll() async {
    var querySnapshot = await _instance.limit(10).get();

    var data = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (data.isEmpty) return List<Collaborator>.empty();

    return data;
  }

  static Future<List<Collaborator>?> findByTerm(String term) async {
    var querySnapshot = await _instance.where("name", isEqualTo: term).get();

    if (querySnapshot.docs.isEmpty) return List<Collaborator>.empty();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<Collaborator?> find(String id) async {
    var querySnapshot = await _instance.where("id", isEqualTo: id).get();

    if (querySnapshot.docs.isEmpty) return null;

    return querySnapshot.docs.first.data();
  }

  static Future<bool> update(Collaborator collaborator) async {
    return await _instance.doc(collaborator.id).update(collaborator.toFirestore()).then((v) => true).onError((e, s) => false);
  }

  static Future<bool> delete(String id) async {
    return await _instance.doc(id).delete().then((v) => true).onError((e, s) => false);
  }
}
