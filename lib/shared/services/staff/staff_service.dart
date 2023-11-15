import 'package:certify/config/firebase/firestore_collections.dart';
import 'package:certify/shared/models/staff/staff_model.dart';
import 'package:certify/shared/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffService {
  static final _instance = FirebaseFirestore.instance
      .collection(FirestoreCollection.staff)
      .withConverter(fromFirestore: Staff.fromFirestore, toFirestore: (Staff staff, options) => staff.toFirestore());

  static Future<Staff?> add(Staff staff) async {
    await AuthService.createCredential(staff.email);

    var documentReference = await _instance.add(staff);
    var documentSnapshot = await documentReference.get();

    return documentSnapshot.data()!;
  }

  static Future<List<Staff>?> findAll() async {
    var querySnapshot = await _instance.limit(20).get();

    var data = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (data.isEmpty) return List<Staff>.empty();

    return data;
  }

  static Future<List<Staff?>> findByTerm(String term) async {
    var querySnapshot = await _instance.where("name", isEqualTo: term).get();

    if (querySnapshot.docs.isEmpty) return List<Staff>.empty();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<Staff?> find(String id) async {
    var querySnapshot = await _instance.where("id", isEqualTo: id).get();

    if (querySnapshot.docs.isEmpty) return null;

    return querySnapshot.docs.first.data();
  }

  static Future<bool> update(Staff staff) async {
    throw UnimplementedError();
  }

  static Future<bool> delete(String id) async {
    return await FirebaseFirestore.instance.collection("staff").doc(id).delete().then((v) => true).onError((e, s) => false);
  }
}
