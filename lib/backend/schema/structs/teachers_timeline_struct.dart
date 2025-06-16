// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeachersTimelineStruct extends FFFirebaseStruct {
  TeachersTimelineStruct({
    int? id,
    DateTime? date,
    String? className,
    int? noofStudents,
    List<DocumentReference>? studentref,
    int? eventid,
    String? eventName,
    String? eventDescr,
    String? images,
    String? timelinevideo,
    String? activityvideo,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _date = date,
        _className = className,
        _noofStudents = noofStudents,
        _studentref = studentref,
        _eventid = eventid,
        _eventName = eventName,
        _eventDescr = eventDescr,
        _images = images,
        _timelinevideo = timelinevideo,
        _activityvideo = activityvideo,
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

  // "class_name" field.
  String? _className;
  String get className => _className ?? '';
  set className(String? val) => _className = val;

  bool hasClassName() => _className != null;

  // "noofStudents" field.
  int? _noofStudents;
  int get noofStudents => _noofStudents ?? 0;
  set noofStudents(int? val) => _noofStudents = val;

  void incrementNoofStudents(int amount) =>
      noofStudents = noofStudents + amount;

  bool hasNoofStudents() => _noofStudents != null;

  // "studentref" field.
  List<DocumentReference>? _studentref;
  List<DocumentReference> get studentref => _studentref ?? const [];
  set studentref(List<DocumentReference>? val) => _studentref = val;

  void updateStudentref(Function(List<DocumentReference>) updateFn) {
    updateFn(_studentref ??= []);
  }

  bool hasStudentref() => _studentref != null;

  // "eventid" field.
  int? _eventid;
  int get eventid => _eventid ?? 0;
  set eventid(int? val) => _eventid = val;

  void incrementEventid(int amount) => eventid = eventid + amount;

  bool hasEventid() => _eventid != null;

  // "eventName" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  set eventName(String? val) => _eventName = val;

  bool hasEventName() => _eventName != null;

  // "eventDescr" field.
  String? _eventDescr;
  String get eventDescr => _eventDescr ?? '';
  set eventDescr(String? val) => _eventDescr = val;

  bool hasEventDescr() => _eventDescr != null;

  // "images" field.
  String? _images;
  String get images => _images ?? '';
  set images(String? val) => _images = val;

  bool hasImages() => _images != null;

  // "timelinevideo" field.
  String? _timelinevideo;
  String get timelinevideo => _timelinevideo ?? '';
  set timelinevideo(String? val) => _timelinevideo = val;

  bool hasTimelinevideo() => _timelinevideo != null;

  // "activityvideo" field.
  String? _activityvideo;
  String get activityvideo => _activityvideo ?? '';
  set activityvideo(String? val) => _activityvideo = val;

  bool hasActivityvideo() => _activityvideo != null;

  static TeachersTimelineStruct fromMap(Map<String, dynamic> data) =>
      TeachersTimelineStruct(
        id: castToType<int>(data['id']),
        date: data['date'] as DateTime?,
        className: data['class_name'] as String?,
        noofStudents: castToType<int>(data['noofStudents']),
        studentref: getDataList(data['studentref']),
        eventid: castToType<int>(data['eventid']),
        eventName: data['eventName'] as String?,
        eventDescr: data['eventDescr'] as String?,
        images: data['images'] as String?,
        timelinevideo: data['timelinevideo'] as String?,
        activityvideo: data['activityvideo'] as String?,
      );

  static TeachersTimelineStruct? maybeFromMap(dynamic data) => data is Map
      ? TeachersTimelineStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'date': _date,
        'class_name': _className,
        'noofStudents': _noofStudents,
        'studentref': _studentref,
        'eventid': _eventid,
        'eventName': _eventName,
        'eventDescr': _eventDescr,
        'images': _images,
        'timelinevideo': _timelinevideo,
        'activityvideo': _activityvideo,
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
        'class_name': serializeParam(
          _className,
          ParamType.String,
        ),
        'noofStudents': serializeParam(
          _noofStudents,
          ParamType.int,
        ),
        'studentref': serializeParam(
          _studentref,
          ParamType.DocumentReference,
          isList: true,
        ),
        'eventid': serializeParam(
          _eventid,
          ParamType.int,
        ),
        'eventName': serializeParam(
          _eventName,
          ParamType.String,
        ),
        'eventDescr': serializeParam(
          _eventDescr,
          ParamType.String,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
        ),
        'timelinevideo': serializeParam(
          _timelinevideo,
          ParamType.String,
        ),
        'activityvideo': serializeParam(
          _activityvideo,
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
        className: deserializeParam(
          data['class_name'],
          ParamType.String,
          false,
        ),
        noofStudents: deserializeParam(
          data['noofStudents'],
          ParamType.int,
          false,
        ),
        studentref: deserializeParam<DocumentReference>(
          data['studentref'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['Students'],
        ),
        eventid: deserializeParam(
          data['eventid'],
          ParamType.int,
          false,
        ),
        eventName: deserializeParam(
          data['eventName'],
          ParamType.String,
          false,
        ),
        eventDescr: deserializeParam(
          data['eventDescr'],
          ParamType.String,
          false,
        ),
        images: deserializeParam(
          data['images'],
          ParamType.String,
          false,
        ),
        timelinevideo: deserializeParam(
          data['timelinevideo'],
          ParamType.String,
          false,
        ),
        activityvideo: deserializeParam(
          data['activityvideo'],
          ParamType.String,
          false,
        ),
      );

  static TeachersTimelineStruct fromAlgoliaData(Map<String, dynamic> data) =>
      TeachersTimelineStruct(
        id: convertAlgoliaParam(
          data['id'],
          ParamType.int,
          false,
        ),
        date: convertAlgoliaParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        className: convertAlgoliaParam(
          data['class_name'],
          ParamType.String,
          false,
        ),
        noofStudents: convertAlgoliaParam(
          data['noofStudents'],
          ParamType.int,
          false,
        ),
        studentref: convertAlgoliaParam<DocumentReference>(
          data['studentref'],
          ParamType.DocumentReference,
          true,
        ),
        eventid: convertAlgoliaParam(
          data['eventid'],
          ParamType.int,
          false,
        ),
        eventName: convertAlgoliaParam(
          data['eventName'],
          ParamType.String,
          false,
        ),
        eventDescr: convertAlgoliaParam(
          data['eventDescr'],
          ParamType.String,
          false,
        ),
        images: convertAlgoliaParam(
          data['images'],
          ParamType.String,
          false,
        ),
        timelinevideo: convertAlgoliaParam(
          data['timelinevideo'],
          ParamType.String,
          false,
        ),
        activityvideo: convertAlgoliaParam(
          data['activityvideo'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'TeachersTimelineStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TeachersTimelineStruct &&
        id == other.id &&
        date == other.date &&
        className == other.className &&
        noofStudents == other.noofStudents &&
        listEquality.equals(studentref, other.studentref) &&
        eventid == other.eventid &&
        eventName == other.eventName &&
        eventDescr == other.eventDescr &&
        images == other.images &&
        timelinevideo == other.timelinevideo &&
        activityvideo == other.activityvideo;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        date,
        className,
        noofStudents,
        studentref,
        eventid,
        eventName,
        eventDescr,
        images,
        timelinevideo,
        activityvideo
      ]);
}

TeachersTimelineStruct createTeachersTimelineStruct({
  int? id,
  DateTime? date,
  String? className,
  int? noofStudents,
  int? eventid,
  String? eventName,
  String? eventDescr,
  String? images,
  String? timelinevideo,
  String? activityvideo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TeachersTimelineStruct(
      id: id,
      date: date,
      className: className,
      noofStudents: noofStudents,
      eventid: eventid,
      eventName: eventName,
      eventDescr: eventDescr,
      images: images,
      timelinevideo: timelinevideo,
      activityvideo: activityvideo,
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
