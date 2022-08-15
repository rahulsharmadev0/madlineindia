import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madlineindia/logic/models/announcement.dart';
import '../../ui/cosnts/config.dart';

// ignore_for_file: file_names

class AnouncementRepo with ChangeNotifier {
  Anouncement? _data;
  Anouncement get data => _data!;
  bool get isEmpty => _data == null;
  late final DocumentReference<Map<String, dynamic>> _root;

  // Specified Firestore path in constructor.
  // Location of review collection in firebase
  AnouncementRepo(String collectionPath, String documentPath)
      : _root = FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(documentPath) {
    featchData().then(
      (value) => printLog('AnouncementRepo : ${_data?.toJson()}'),
    );
  }

  Future<bool> upgradeAnouncement(Anouncement anouncement) async {
    try {
      await _root.update(anouncement.toMap());
      _data = anouncement;
      notifyListeners();
      return true;
    } on FirebaseException catch (error) {
      var msg = error.message ?? 'Firebase Exception occurs';
      printLog(msg);
      messenger.showSnackBar(SnackBar(content: Text(msg)));
      return false;
    }
  }

  Future<void> featchData() async {
    try {
      var snapshot = await _root.get();
      if (!snapshot.exists) {
        _data = null;

        messenger.showSnackBar(
            const SnackBar(content: Text('Anouncement Not Found!')));
      } else {
        _data = Anouncement.fromMap(snapshot.data()!);
      }
    } on FirebaseException catch (error) {
      _data = null;
      var msg = error.message ?? 'Firebase Exception occurs';
      messenger.showSnackBar(SnackBar(content: Text(msg)));
      throw error.message ?? msg;
    }
    notifyListeners();
  }
}
