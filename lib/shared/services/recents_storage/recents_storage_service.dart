import 'dart:convert';

import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentsStorageService {
  static String recents = 'recents';

  static Future<List<Collaborator>> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? serializedList = prefs.getString(recents);
    if (serializedList != null) {
      List<dynamic> decodedList = json.decode(serializedList);
      return decodedList.map((item) => Collaborator.fromMap(item['id'], item)).toList();
    }
    return [];
  }

  static void add(Collaborator collaborator) {
    RecentsStorageService.get().then((collaborators) {
      if (collaborators.any((c) => collaborator.email == c.email)) return;
      collaborators.add(collaborator);
      RecentsStorageService._save(collaborators);
    });
  }

  static Future<void> _save(List<Collaborator> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(recents, json.encode(list.map((item) => item.toMap()).toList()));
  }
}
