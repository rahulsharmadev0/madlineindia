// ignore_for_file: file_names

import '../../ui/cosnts/config.dart';
import '../models/course.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CoursesRepo with ChangeNotifier {
  List<Course>? list;
  bool get isEmpty => list == null;
  late final CollectionReference<Map<String, dynamic>> _root;

  // Specified Firestore path in constructor.
  // Location of course collection in firebase
  CoursesRepo(String collectionPath) {
    _root = FirebaseFirestore.instance.collection(collectionPath);
    fetchAllCourses().then((value) => printLog(list));
  }

  Future<bool> upgradeCourse(Course course) async {
    try {
      await _root.doc(course.id).update(course.toMap());
      if (list != null) {
        list![list!.indexWhere((e) => e.id == course.id)] = course;
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

  Future<bool> addNewCourse(Course course) async {
    final randomId = const Uuid().v1();
    final newProduct = course.copyWith(id: randomId);
    try {
      await _root.doc(randomId).set(newProduct.toMap());
      if (list != null) {
        list!.add(newProduct);
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

  Future<Course?> getById(String id) async =>
      (await _exceptionHandler(_root.where('id', isEqualTo: id).get()))?.first;

  /// Refresh Existing course list, if list is not `null`
  Future<void> refreshList() async {
    if (list != null) {
      list = (await _exceptionHandler(
          _root.orderBy('id').limit(list!.length).get()));
      notifyListeners();
    }
  }

  Future<List<Course>?> getByIds(List<String> ids) =>
      _exceptionHandler(_root.where('id', whereIn: ids).get());

  Future<void> fetchAllCourses() async {
    list = (await _exceptionHandler(_root.get())) ?? [];
    notifyListeners();
  }

// Very Very Important
  Future<List<Course>?> _exceptionHandler(
      Future<QuerySnapshot<Map<String, dynamic>>> fun) async {
    try {
      var snapshot = await fun;
      printLog(snapshot.docs);
      if (snapshot.docs.isEmpty) {
        messenger
            .showSnackBar(const SnackBar(content: Text('Course Not Found!')));
        return null;
      } else {
        return snapshot.docs.map((e) => Course.fromMap(e.data())).toList();
      }
    } on FirebaseException catch (error) {
      var msg = error.message ?? 'Firebase Exception occurs';
      messenger.showSnackBar(SnackBar(content: Text(msg)));
      throw error.message ?? msg;
    }
  }
}
