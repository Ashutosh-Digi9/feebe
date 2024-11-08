// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StudentTimelineStruct extends FFFirebaseStruct {
  StudentTimelineStruct({
    int? id,
    DateTime? date,
    List<int>? activityId,
    List<String>? activityName,
    List<String>? activityDescription,
    List<String>? images,
    List<String>? addedBy,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _date = date,
        _activityId = activityId,
        _activityName = activityName,
        _activityDescription = activityDescription,
        _images = images,
        _addedBy = addedBy,
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
  List<int>? _activityId;
  List<int> get activityId => _activityId ?? const [];
  set activityId(List<int>? val) => _activityId = val;

  void updateActivityId(Function(List<int>) updateFn) {
    updateFn(_activityId ??= []);
  }

  bool hasActivityId() => _activityId != null;

  // "activity_name" field.
  List<String>? _activityName;
  List<String> get activityName => _activityName ?? const [];
  set activityName(List<String>? val) => _activityName = val;

  void updateActivityName(Function(List<String>) updateFn) {
    updateFn(_activityName ??= []);
  }

  bool hasActivityName() => _activityName != null;

  // "activity_description" field.
  List<String>? _activityDescription;
  List<String> get activityDescription => _activityDescription ?? const [];
  set activityDescription(List<String>? val) => _activityDescription = val;

  void updateActivityDescription(Function(List<String>) updateFn) {
    updateFn(_activityDescription ??= []);
  }

  bool hasActivityDescription() => _activityDescription != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  set images(List<String>? val) => _images = val;

  void updateImages(Function(List<String>) updateFn) {
    updateFn(_images ??= []);
  }

  bool hasImages() => _images != null;

  // "added_by" field.
  List<String>? _addedBy;
  List<String> get addedBy => _addedBy ?? const [];
  set addedBy(List<String>? val) => _addedBy = val;

  void updateAddedBy(Function(List<String>) updateFn) {
    updateFn(_addedBy ??= []);
  }

  bool hasAddedBy() => _addedBy != null;

  static StudentTimelineStruct fromMap(Map<String, dynamic> data) =>
      StudentTimelineStruct(
        id: castToType<int>(data['id']),
        date: data['date'] as DateTime?,
        activityId: getDataList(data['activity_id']),
        activityName: getDataList(data['activity_name']),
        activityDescription: getDataList(data['activity_description']),
        images: getDataList(data['images']),
        addedBy: getDataList(data['added_by']),
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
        'images': _images,
        'added_by': _addedBy,
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
          isList: true,
        ),
        'activity_name': serializeParam(
          _activityName,
          ParamType.String,
          isList: true,
        ),
        'activity_description': serializeParam(
          _activityDescription,
          ParamType.String,
          isList: true,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
          isList: true,
        ),
        'added_by': serializeParam(
          _addedBy,
          ParamType.String,
          isList: true,
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
        activityId: deserializeParam<int>(
          data['activity_id'],
          ParamType.int,
          true,
        ),
        activityName: deserializeParam<String>(
          data['activity_name'],
          ParamType.String,
          true,
        ),
        activityDescription: deserializeParam<String>(
          data['activity_description'],
          ParamType.String,
          true,
        ),
        images: deserializeParam<String>(
          data['images'],
          ParamType.String,
          true,
        ),
        addedBy: deserializeParam<String>(
          data['added_by'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'StudentTimelineStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is StudentTimelineStruct &&
        id == other.id &&
        date == other.date &&
        listEquality.equals(activityId, other.activityId) &&
        listEquality.equals(activityName, other.activityName) &&
        listEquality.equals(activityDescription, other.activityDescription) &&
        listEquality.equals(images, other.images) &&
        listEquality.equals(addedBy, other.addedBy);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        date,
        activityId,
        activityName,
        activityDescription,
        images,
        addedBy
      ]);
}

StudentTimelineStruct createStudentTimelineStruct({
  int? id,
  DateTime? date,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StudentTimelineStruct(
      id: id,
      date: date,
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
