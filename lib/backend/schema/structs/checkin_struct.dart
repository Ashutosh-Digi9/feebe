// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CheckinStruct extends FFFirebaseStruct {
  CheckinStruct({
    DateTime? date,
    bool? checkin,
    bool? chekout,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _checkin = checkin,
        _chekout = chekout,
        super(firestoreUtilData);

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "checkin" field.
  bool? _checkin;
  bool get checkin => _checkin ?? false;
  set checkin(bool? val) => _checkin = val;

  bool hasCheckin() => _checkin != null;

  // "chekout" field.
  bool? _chekout;
  bool get chekout => _chekout ?? false;
  set chekout(bool? val) => _chekout = val;

  bool hasChekout() => _chekout != null;

  static CheckinStruct fromMap(Map<String, dynamic> data) => CheckinStruct(
        date: data['date'] as DateTime?,
        checkin: data['checkin'] as bool?,
        chekout: data['chekout'] as bool?,
      );

  static CheckinStruct? maybeFromMap(dynamic data) =>
      data is Map ? CheckinStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'checkin': _checkin,
        'chekout': _chekout,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'checkin': serializeParam(
          _checkin,
          ParamType.bool,
        ),
        'chekout': serializeParam(
          _chekout,
          ParamType.bool,
        ),
      }.withoutNulls;

  static CheckinStruct fromSerializableMap(Map<String, dynamic> data) =>
      CheckinStruct(
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        checkin: deserializeParam(
          data['checkin'],
          ParamType.bool,
          false,
        ),
        chekout: deserializeParam(
          data['chekout'],
          ParamType.bool,
          false,
        ),
      );

  static CheckinStruct fromAlgoliaData(Map<String, dynamic> data) =>
      CheckinStruct(
        date: convertAlgoliaParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        checkin: convertAlgoliaParam(
          data['checkin'],
          ParamType.bool,
          false,
        ),
        chekout: convertAlgoliaParam(
          data['chekout'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'CheckinStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CheckinStruct &&
        date == other.date &&
        checkin == other.checkin &&
        chekout == other.chekout;
  }

  @override
  int get hashCode => const ListEquality().hash([date, checkin, chekout]);
}

CheckinStruct createCheckinStruct({
  DateTime? date,
  bool? checkin,
  bool? chekout,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CheckinStruct(
      date: date,
      checkin: checkin,
      chekout: chekout,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CheckinStruct? updateCheckinStruct(
  CheckinStruct? checkinStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    checkinStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCheckinStructData(
  Map<String, dynamic> firestoreData,
  CheckinStruct? checkinStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (checkinStruct == null) {
    return;
  }
  if (checkinStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && checkinStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final checkinStructData =
      getCheckinFirestoreData(checkinStruct, forFieldValue);
  final nestedData =
      checkinStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = checkinStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCheckinFirestoreData(
  CheckinStruct? checkinStruct, [
  bool forFieldValue = false,
]) {
  if (checkinStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(checkinStruct.toMap());

  // Add any Firestore field values
  checkinStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCheckinListFirestoreData(
  List<CheckinStruct>? checkinStructs,
) =>
    checkinStructs?.map((e) => getCheckinFirestoreData(e, true)).toList() ?? [];
