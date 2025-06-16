// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ImagesStruct extends FFFirebaseStruct {
  ImagesStruct({
    String? imagepath,
    String? addedby,
    DateTime? datetime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _imagepath = imagepath,
        _addedby = addedby,
        _datetime = datetime,
        super(firestoreUtilData);

  // "imagepath" field.
  String? _imagepath;
  String get imagepath => _imagepath ?? '';
  set imagepath(String? val) => _imagepath = val;

  bool hasImagepath() => _imagepath != null;

  // "addedby" field.
  String? _addedby;
  String get addedby => _addedby ?? '';
  set addedby(String? val) => _addedby = val;

  bool hasAddedby() => _addedby != null;

  // "datetime" field.
  DateTime? _datetime;
  DateTime? get datetime => _datetime;
  set datetime(DateTime? val) => _datetime = val;

  bool hasDatetime() => _datetime != null;

  static ImagesStruct fromMap(Map<String, dynamic> data) => ImagesStruct(
        imagepath: data['imagepath'] as String?,
        addedby: data['addedby'] as String?,
        datetime: data['datetime'] as DateTime?,
      );

  static ImagesStruct? maybeFromMap(dynamic data) =>
      data is Map ? ImagesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'imagepath': _imagepath,
        'addedby': _addedby,
        'datetime': _datetime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'imagepath': serializeParam(
          _imagepath,
          ParamType.String,
        ),
        'addedby': serializeParam(
          _addedby,
          ParamType.String,
        ),
        'datetime': serializeParam(
          _datetime,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ImagesStruct fromSerializableMap(Map<String, dynamic> data) =>
      ImagesStruct(
        imagepath: deserializeParam(
          data['imagepath'],
          ParamType.String,
          false,
        ),
        addedby: deserializeParam(
          data['addedby'],
          ParamType.String,
          false,
        ),
        datetime: deserializeParam(
          data['datetime'],
          ParamType.DateTime,
          false,
        ),
      );

  static ImagesStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ImagesStruct(
        imagepath: convertAlgoliaParam(
          data['imagepath'],
          ParamType.String,
          false,
        ),
        addedby: convertAlgoliaParam(
          data['addedby'],
          ParamType.String,
          false,
        ),
        datetime: convertAlgoliaParam(
          data['datetime'],
          ParamType.DateTime,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ImagesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ImagesStruct &&
        imagepath == other.imagepath &&
        addedby == other.addedby &&
        datetime == other.datetime;
  }

  @override
  int get hashCode => const ListEquality().hash([imagepath, addedby, datetime]);
}

ImagesStruct createImagesStruct({
  String? imagepath,
  String? addedby,
  DateTime? datetime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ImagesStruct(
      imagepath: imagepath,
      addedby: addedby,
      datetime: datetime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ImagesStruct? updateImagesStruct(
  ImagesStruct? images, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    images
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addImagesStructData(
  Map<String, dynamic> firestoreData,
  ImagesStruct? images,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (images == null) {
    return;
  }
  if (images.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && images.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final imagesData = getImagesFirestoreData(images, forFieldValue);
  final nestedData = imagesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = images.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getImagesFirestoreData(
  ImagesStruct? images, [
  bool forFieldValue = false,
]) {
  if (images == null) {
    return {};
  }
  final firestoreData = mapToFirestore(images.toMap());

  // Add any Firestore field values
  images.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getImagesListFirestoreData(
  List<ImagesStruct>? imagess,
) =>
    imagess?.map((e) => getImagesFirestoreData(e, true)).toList() ?? [];
