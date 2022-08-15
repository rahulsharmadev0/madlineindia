// ignore_for_file: file_names

import '../../ui/cosnts/config.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/mentor.dart';

class MentorRepo with ChangeNotifier {
  List<Mentor>? _list;
  List<Mentor> get list => _list!;
  bool get isEmpty => _list == null;
  late final CollectionReference<Map<String, dynamic>> _root;

  // Specified Firestore path in constructor.
  // Location of mentor collection in firebase
  MentorRepo(String collectionPath) {
    _root = FirebaseFirestore.instance.collection(collectionPath);
    fetchAllMentor()
        .then((value) => printLog('DetailsRepo : ${_list!.length}'));
  }

  Future<bool> upgradeMentor(Mentor mentor) async {
    try {
      await _root.doc(mentor.id).update(mentor.toMap());
      if (_list != null) {
        _list![_list!.indexWhere((e) => e.id == mentor.id)] = mentor;
        notifyListeners();
      }
      return true;
    } on FirebaseException catch (error) {
      var msg = error.message ?? 'Firebase Exception occurs';
      printLog(msg);
      messenger.showSnackBar(SnackBar(content: Text(msg)));
      return false;
    }
  }

  Future<bool> addNewMentor(Mentor mentor) async {
    final randomId = const Uuid().v1();
    final newProduct = mentor.copyWith(id: randomId);
    try {
      await _root.doc(randomId).set(newProduct.toMap());
      if (_list != null) {
        _list!.add(newProduct);
        notifyListeners();
      }
      return true;
    } on FirebaseException catch (error) {
      var msg = error.message ?? 'Firebase Exception occurs';
      printLog(msg);
      messenger.showSnackBar(SnackBar(content: Text(msg)));
      return false;
    }
  }

  Future<Mentor?> getById(String id) async =>
      (await _exceptionHandler(_root.where('id', isEqualTo: id).get()))?.first;

  /// Refresh Existing mentor list, if list is not `null`
  Future<void> refreshList() async {
    if (_list != null) {
      _list = (await _exceptionHandler(
          _root.orderBy('id').limit(_list!.length).get()));
      notifyListeners();
    }
  }

  Future<List<Mentor>?> getByIds(List<String> ids) =>
      _exceptionHandler(_root.where('id', whereIn: ids).get());

  Future<void> fetchAllMentor() async {
    _list = (await _exceptionHandler(_root.get())) ?? [];
    notifyListeners();
  }

// Very Very Important
  Future<List<Mentor>?> _exceptionHandler(
      Future<QuerySnapshot<Map<String, dynamic>>> fun) async {
    try {
      var snapshot = await fun;
      printLog(snapshot.docs);
      if (snapshot.docs.isEmpty) {
        messenger
            .showSnackBar(const SnackBar(content: Text('Mentor Not Found!')));
        return null;
      } else {
        return snapshot.docs.map((e) => Mentor.fromMap(e.data())).toList();
      }
    } on FirebaseException catch (error) {
      var msg = error.message ?? 'Firebase Exception occurs';
      messenger.showSnackBar(SnackBar(content: Text(msg)));
      throw error.message ?? msg;
    }
  }
}
