// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class TeachersTimelineStruct extends FFFirebaseStruct {
  TeachersTimelineStruct({
    int? id,
    DateTime? date,
    DateTime? classStartTime,
    DateTime? classEndTime,
    String? className,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _date = date,
        _classStartTime = classStartTime,
        _classEndTime = classEndTime,
        _className = className,
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

  // "class_start_time" field.
  DateTime? _classStartTime;
  DateTime? get classStartTime => _classStartTime;
  set classStartTime(DateTime? val) => _classStartTime = val;

  bool hasClassStartTime() => _classStartTime != null;

  // "class_end_time" field.
  DateTime? _classEndTime;
  DateTime? get classEndTime => _classEndTime;
  set classEndTime(DateTime? val) => _classEndTime = val;

  bool hasClassEndTime() => _classEndTime != null;

  // "class_name" field.
  String? _className;
  String get className => _className ?? '';
  set className(String? val) => _className = val;

  bool hasClassName() => _className != null;

  static TeachersTimelineStruct fromMap(Map<String, dynamic> data) =>
      TeachersTimelineStruct(
        id: castToType<int>(data['id']),
        date: data['date'] as DateTime?,
        classStartTime: data['class_start_time'] as DateTime?,
        classEndTime: data['class_end_time'] as DateTime?,
        className: data['class_name'] as String?,
      );

  static TeachersTimelineStruct? maybeFromMap(dynamic data) => data is Map
      ? TeachersTimelineStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'date': _date,
        'class_start_time': _classStartTime,
        'class_end_time': _classEndTime,
        'class_name': _className,
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
        'class_start_time': serializeParam(
          _classStartTime,
          ParamType.DateTime,
        ),
        'class_end_time': serializeParam(
          _classEndTime,
          ParamType.DateTime,
        ),
        'class_name': serializeParam(
          _className,
          ParamType.String,
        ),
      }.withoutNulls;

  static TeachersTimelineStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TeachersTimelineStruct(
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
        classStartTime: deserializeParam(
          data['class_start_time'],
          ParamType.DateTime,
          false,
        ),
        classEndTime: deserializeParam(
          data['class_end_time'],
          ParamType.DateTime,
          false,
        ),
        className: deserializeParam(
          data['class_name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TeachersTimelineStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TeachersTimelineStruct &&
        id == other.id &&
        date == other.date &&
        classStartTime == other.classStartTime &&
        classEndTime == other.classEndTime &&
        className == other.className;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, date, classStartTime, classEndTime, className]);
}

TeachersTimelineStruct createTeachersTimelineStruct({
  int? id,
  DateTime? date,
  DateTime? classStartTime,
  DateTime? classEndTime,
  String? className,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TeachersTimelineStruct(
      id: id,
      date: date,
      classStartTime: classStartTime,
      classEndTime: classEndTime,
      className: className,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TeachersTimelineStruct? updateTeachersTimelineStruct(
  TeachersTimelineStruct? teachersTimeline, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    teachersTimeline
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTeachersTimelineStructData(
  Map<String, dynamic> firestoreData,
  TeachersTimelineStruct? teachersTimeline,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (teachersTimeline == null) {
    return;
  }
  if (teachersTimeline.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && teachersTimeline.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final teachersTimelineData =
      getTeachersTimelineFirestoreData(teachersTimeline, forFieldValue);
  final nestedData =
      teachersTimelineData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = teachersTimeline.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTeachersTimelineFirestoreData(
  TeachersTimelineStruct? teachersTimeline, [
  bool forFieldValue = false,
]) {
  if (teachersTimeline == null) {
    return {};
  }
  final firestoreData = mapToFirestore(teachersTimeline.toMap());

  // Add any Firestore field values
  teachersTimeline.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTeachersTimelineListFirestoreData(
  List<TeachersTimelineStruct>? teachersTimelines,
) =>
    teachersTimelines
        ?.map((e) => getTeachersTimelineFirestoreData(e, true))
        .toList() ??
    [];
