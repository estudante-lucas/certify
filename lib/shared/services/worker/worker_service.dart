import 'package:certify/config/firebase/firestore_collections.dart';
import 'package:certify/shared/models/worker/worker_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkerService {
  static final _instance = FirebaseFirestore.instance
      .collection(FirestoreCollection.worker)
      .withConverter(fromFirestore: Worker.fromFirestore, toFirestore: (Worker worker, options) => worker.toFirestore());

  static Future<List<Worker>?> findAll() async {
    var querySnapshot = await _instance.get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<List<Worker?>> findByTerm(String term) async {
    var querySnapshot = await _instance.where("name", isEqualTo: term).get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<Worker> add(Worker worker) async {
    var documentReference = await _instance.add(worker);
    var documentSnapshot = await documentReference.get();

    return documentSnapshot.data()!;
  }
}
