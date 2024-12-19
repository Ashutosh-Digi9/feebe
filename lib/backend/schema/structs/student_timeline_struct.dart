// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class StudentTimelineStruct extends FFFirebaseStruct {
  StudentTimelineStruct({
    int? id,
    DateTime? date,
    int? activityId,
    String? activityName,
    String? activityDescription,
    String? activityAddedby,
    String? activityImages,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _date = date,
        _activityId = activityId,
        _activityName = activityName,
        _activityDescription = activityDescription,
        _activityAddedby = activityAddedby,
        _activityImages = activityImages,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "activity_id" field.
  int? _activityId;
  int get activityId => _activityId ?? 0;
  set activityId(int? val) => _activityId = val;

  void incrementActivityId(int amount) => activityId = activityId + amount;

  bool hasActivityId() => _activityId != null;

  // "activity_name" field.
  String? _activityName;
  String get activityName => _activityName ?? '';
  set activityName(String? val) => _activityName = val;

  bool hasActivityName() => _activityName != null;

  // "activity_description" field.
  String? _activityDescription;
  String get activityDescription => _activityDescription ?? '';
  set activityDescription(String? val) => _activityDescription = val;

  bool hasActivityDescription() => _activityDescription != null;

  // "activity_addedby" field.
  String? _activityAddedby;
  String get activityAddedby => _activityAddedby ?? '';
  set activityAddedby(String? val) => _activityAddedby = val;

  bool hasActivityAddedby() => _activityAddedby != null;

  // "activity_images" field.
  String? _activityImages;
  String get activityImages => _activityImages ?? '';
  set activityImages(String? val) => _activityImages = val;

  bool hasActivityImages() => _activityImages != null;

  static StudentTimelineStruct fromMap(Map<String, dynamic> data) =>
      StudentTimelineStruct(
        id: castToType<int>(data['id']),
        date: data['date'] as DateTime?,
        activityId: castToType<int>(data['activity_id']),
        activityName: data['activity_name'] as String?,
        activityDescription: data['activity_description'] as String?,
        activityAddedby: data['activity_addedby'] as String?,
        activityImages: data['activity_images'] as String?,
      );

  static StudentTimelineStruct? maybeFromMap(dynamic data) => data is Map
      ? StudentTimelineStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'date': _date,
        'activity_id': _activityId,
        'activity_name': _activityName,
        'activity_description': _activityDescription,
        'activity_addedby': _activityAddedby,
        'activity_images': _activityImages,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'activity_id': serializeParam(
          _activityId,
          ParamType.int,
        ),
        'activity_name': serializeParam(
          _activityName,
          ParamType.String,
        ),
        'activity_description': serializeParam(
          _activityDescription,
          ParamType.String,
        ),
        'activity_addedby': serializeParam(
          _activityAddedby,
          ParamType.String,
        ),
        'activity_images': serializeParam(
          _activityImages,
          ParamType.String,
        ),
      }.withoutNulls;

  static StudentTimelineStruct fromSerializableMap(Map<String, dynamic> data) =>
      StudentTimelineStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        activityId: deserializeParam(
          data['activity_id'],
          ParamType.int,
          false,
        ),
        activityName: deserializeParam(
          data['activity_name'],
          ParamType.String,
          false,
        ),
        activityDescription: deserializeParam(
          data['activity_description'],
          ParamType.String,
          false,
        ),
        activityAddedby: deserializeParam(
          data['activity_addedby'],
          ParamType.String,
          false,
        ),
        activityImages: deserializeParam(
          data['activity_images'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'StudentTimelineStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StudentTimelineStruct &&
        id == other.id &&
        date == other.date &&
        activityId == other.activityId &&
        activityName == other.activityName &&
        activityDescription == other.activityDescription &&
        activityAddedby == other.activityAddedby &&
        activityImages == other.activityImages;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        date,
        activityId,
        activityName,
        activityDescription,
        activityAddedby,
        activityImages
      ]);
}

StudentTimelineStruct createStudentTimelineStruct({
  int? id,
  DateTime? date,
  int? activityId,
  String? activityName,
  String? activityDescription,
  String? activityAddedby,
  String? activityImages,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StudentTimelineStruct(
      id: id,
      date: date,
      activityId: activityId,
      activityName: activityName,
      activityDescription: activityDescription,
      activityAddedby: activityAddedby,
      activityImages: activityImages,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StudentTimelineStruct? updateStudentTimelineStruct(
  StudentTimelineStruct? studentTimeline, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    studentTimeline
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStudentTimelineStructData(
  Map<String, dynamic> firestoreData,
  StudentTimelineStruct? studentTimeline,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (studentTimeline == null) {
    return;
  }
  if (studentTimeline.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && studentTimeline.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final studentTimelineData =
      getStudentTimelineFirestoreData(studentTimeline, forFieldValue);
  final nestedData =
      studentTimelineData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = studentTimeline.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStudentTimelineFirestoreData(
  StudentTimelineStruct? studentTimeline, [
  bool forFieldValue = false,
]) {
  if (studentTimeline == null) {
    return {};
  }
  final firestoreData = mapToFirestore(studentTimeline.toMap());

  // Add any Firestore field values
  studentTimeline.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStudentTimelineListFirestoreData(
  List<StudentTimelineStruct>? studentTimelines,
) =>
    studentTimelines
        ?.map((e) => getStudentTimelineFirestoreData(e, true))
        .toList() ??
    [];
