import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../ui/cosnts/config.dart';
import '../models/details.dart';

class DetailsRepo with ChangeNotifier {
  Details? _data;
  Details get data => _data!;
  bool get isEmpty => _data == null;
  late final DocumentReference<Map<String, dynamic>> _root;

  // Specified Firestore path in constructor.
  // Location of review collection in firebase
  DetailsRepo(String collectionPath, String documentPath) {
    _root =
        FirebaseFirestore.instance.collection(collectionPath).doc(documentPath);
    featchData().then(
      (value) => printLog('DetailsRepo : ${_data?.toJson()}'),
    );
  }

  Future<bool> upgradeDetails(Details newDetails) async {
    try {
      await _root.update(newDetails.toMap());
      _data = newDetails;
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
        messenger
            .showSnackBar(const SnackBar(content: Text('Details Not Found!')));
        _data = null;
      } else {
        _data = Details.fromMap(snapshot.data()!);
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
