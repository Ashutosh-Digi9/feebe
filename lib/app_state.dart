import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _imageurl =
      'https://firebasestorage.googleapis.com/v0/b/feebee-4c7b2.firebasestorage.app/o/default_images%2FAdd%20profile%20pic%20(2).png?alt=media&token=4068e21d-193a-45b5-a497-885600aff209';
  String get imageurl => _imageurl;
  set imageurl(String value) {
    _imageurl = value;
  }

  bool _profileimagechanged = false;
  bool get profileimagechanged => _profileimagechanged;
  set profileimagechanged(bool value) {
    _profileimagechanged = value;
  }

  String _schoolimage =
      'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FAdd%20profile%20pic%20(1).png?alt=media&token=ab5b8754-dedf-4955-99d5-a241862451dd';
  String get schoolimage => _schoolimage;
  set schoolimage(String value) {
    _schoolimage = value;
  }
}
