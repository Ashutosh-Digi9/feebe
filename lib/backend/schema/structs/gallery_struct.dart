// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class GalleryStruct extends FFFirebaseStruct {
  GalleryStruct({
    String? images,
    String? video,
    DateTime? date,
    String? addedby,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _images = images,
        _video = video,
        _date = date,
        _addedby = addedby,
        super(firestoreUtilData);

  // "images" field.
  String? _images;
  String get images => _images ?? '';
  set images(String? val) => _images = val;

  bool hasImages() => _images != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  set video(String? val) => _video = val;

  bool hasVideo() => _video != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "addedby" field.
  String? _addedby;
  String get addedby => _addedby ?? '';
  set addedby(String? val) => _addedby = val;

  bool hasAddedby() => _addedby != null;

  static GalleryStruct fromMap(Map<String, dynamic> data) => GalleryStruct(
        images: data['images'] as String?,
        video: data['video'] as String?,
        date: data['date'] as DateTime?,
        addedby: data['addedby'] as String?,
      );

  static GalleryStruct? maybeFromMap(dynamic data) =>
      data is Map ? GalleryStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'images': _images,
        'video': _video,
        'date': _date,
        'addedby': _addedby,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'images': serializeParam(
          _images,
          ParamType.String,
        ),
        'video': serializeParam(
          _video,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'addedby': serializeParam(
          _addedby,
          ParamType.String,
        ),
      }.withoutNulls;

  static GalleryStruct fromSerializableMap(Map<String, dynamic> data) =>
      GalleryStruct(
        images: deserializeParam(
          data['images'],
          ParamType.String,
          false,
        ),
        video: deserializeParam(
          data['video'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        addedby: deserializeParam(
          data['addedby'],
          ParamType.String,
          false,
        ),
      );

  static GalleryStruct fromAlgoliaData(Map<String, dynamic> data) =>
      GalleryStruct(
        images: convertAlgoliaParam(
          data['images'],
          ParamType.String,
          false,
        ),
        video: convertAlgoliaParam(
          data['video'],
          ParamType.String,
          false,
        ),
        date: convertAlgoliaParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        addedby: convertAlgoliaParam(
          data['addedby'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'GalleryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GalleryStruct &&
        images == other.images &&
        video == other.video &&
        date == other.date &&
        addedby == other.addedby;
  }

  @override
  int get hashCode => const ListEquality().hash([images, video, date, addedby]);
}

GalleryStruct createGalleryStruct({
  String? images,
  String? video,
  DateTime? date,
  String? addedby,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GalleryStruct(
      images: images,
      video: video,
      date: date,
      addedby: addedby,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GalleryStruct? updateGalleryStruct(
  GalleryStruct? gallery, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    gallery
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGalleryStructData(
  Map<String, dynamic> firestoreData,
  GalleryStruct? gallery,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (gallery == null) {
    return;
  }
  if (gallery.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && gallery.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final galleryData = getGalleryFirestoreData(gallery, forFieldValue);
  final nestedData = galleryData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = gallery.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGalleryFirestoreData(
  GalleryStruct? gallery, [
  bool forFieldValue = false,
]) {
  if (gallery == null) {
    return {};
  }
  final firestoreData = mapToFirestore(gallery.toMap());

  // Add any Firestore field values
  gallery.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGalleryListFirestoreData(
  List<GalleryStruct>? gallerys,
) =>
    gallerys?.map((e) => getGalleryFirestoreData(e, true)).toList() ?? [];
