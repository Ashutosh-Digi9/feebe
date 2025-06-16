// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ActivitiesStruct extends FFFirebaseStruct {
  ActivitiesStruct({
    String? activityName,
    String? activityDescription,
    DateTime? activityDate,
    String? addedbyName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _activityName = activityName,
        _activityDescription = activityDescription,
        _activityDate = activityDate,
        _addedbyName = addedbyName,
        super(firestoreUtilData);

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

  // "activity_date" field.
  DateTime? _activityDate;
  DateTime? get activityDate => _activityDate;
  set activityDate(DateTime? val) => _activityDate = val;

  bool hasActivityDate() => _activityDate != null;

  // "addedby_name" field.
  String? _addedbyName;
  String get addedbyName => _addedbyName ?? '';
  set addedbyName(String? val) => _addedbyName = val;

  bool hasAddedbyName() => _addedbyName != null;

  static ActivitiesStruct fromMap(Map<String, dynamic> data) =>
      ActivitiesStruct(
        activityName: data['activity_name'] as String?,
        activityDescription: data['activity_description'] as String?,
        activityDate: data['activity_date'] as DateTime?,
        addedbyName: data['addedby_name'] as String?,
      );

  static ActivitiesStruct? maybeFromMap(dynamic data) => data is Map
      ? ActivitiesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'activity_name': _activityName,
        'activity_description': _activityDescription,
        'activity_date': _activityDate,
        'addedby_name': _addedbyName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'activity_name': serializeParam(
          _activityName,
          ParamType.String,
        ),
        'activity_description': serializeParam(
          _activityDescription,
          ParamType.String,
        ),
        'activity_date': serializeParam(
          _activityDate,
          ParamType.DateTime,
        ),
        'addedby_name': serializeParam(
          _addedbyName,
          ParamType.String,
        ),
      }.withoutNulls;

  static ActivitiesStruct fromSerializableMap(Map<String, dynamic> data) =>
      ActivitiesStruct(
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
        activityDate: deserializeParam(
          data['activity_date'],
          ParamType.DateTime,
          false,
        ),
        addedbyName: deserializeParam(
          data['addedby_name'],
          ParamType.String,
          false,
        ),
      );

  static ActivitiesStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ActivitiesStruct(
        activityName: convertAlgoliaParam(
          data['activity_name'],
          ParamType.String,
          false,
        ),
        activityDescription: convertAlgoliaParam(
          data['activity_description'],
          ParamType.String,
          false,
        ),
        activityDate: convertAlgoliaParam(
          data['activity_date'],
          ParamType.DateTime,
          false,
        ),
        addedbyName: convertAlgoliaParam(
          data['addedby_name'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ActivitiesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ActivitiesStruct &&
        activityName == other.activityName &&
        activityDescription == other.activityDescription &&
        activityDate == other.activityDate &&
        addedbyName == other.addedbyName;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([activityName, activityDescription, activityDate, addedbyName]);
}

ActivitiesStruct createActivitiesStruct({
  String? activityName,
  String? activityDescription,
  DateTime? activityDate,
  String? addedbyName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ActivitiesStruct(
      activityName: activityName,
      activityDescription: activityDescription,
      activityDate: activityDate,
      addedbyName: addedbyName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ActivitiesStruct? updateActivitiesStruct(
  ActivitiesStruct? activities, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    activities
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addActivitiesStructData(
  Map<String, dynamic> firestoreData,
  ActivitiesStruct? activities,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (activities == null) {
    return;
  }
  if (activities.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && activities.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final activitiesData = getActivitiesFirestoreData(activities, forFieldValue);
  final nestedData = activitiesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = activities.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getActivitiesFirestoreData(
  ActivitiesStruct? activities, [
  bool forFieldValue = false,
]) {
  if (activities == null) {
    return {};
  }
  final firestoreData = mapToFirestore(activities.toMap());

  // Add any Firestore field values
  activities.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getActivitiesListFirestoreData(
  List<ActivitiesStruct>? activitiess,
) =>
    activitiess?.map((e) => getActivitiesFirestoreData(e, true)).toList() ?? [];
