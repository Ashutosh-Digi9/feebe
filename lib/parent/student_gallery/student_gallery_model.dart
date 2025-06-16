import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'student_gallery_widget.dart' show StudentGalleryWidget;
import 'package:flutter/material.dart';

class StudentGalleryModel extends FlutterFlowModel<StudentGalleryWidget> {
  ///  Local state fields for this page.

  List<GalleryStruct> gallery = [];
  void addToGallery(GalleryStruct item) => gallery.add(item);
  void removeFromGallery(GalleryStruct item) => gallery.remove(item);
  void removeAtIndexFromGallery(int index) => gallery.removeAt(index);
  void insertAtIndexInGallery(int index, GalleryStruct item) =>
      gallery.insert(index, item);
  void updateGalleryAtIndex(int index, Function(GalleryStruct) updateFn) =>
      gallery[index] = updateFn(gallery[index]);

  int? pageno = 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
