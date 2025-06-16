// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationUSerefStruct extends FFFirebaseStruct {
  NotificationUSerefStruct({
    List<DocumentReference>? noticeUsref,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _noticeUsref = noticeUsref,
        super(firestoreUtilData);

  // "NoticeUsref" field.
  List<DocumentReference>? _noticeUsref;
  List<DocumentReference> get noticeUsref => _noticeUsref ?? const [];
  set noticeUsref(List<DocumentReference>? val) => _noticeUsref = val;

  void updateNoticeUsref(Function(List<DocumentReference>) updateFn) {
    updateFn(_noticeUsref ??= []);
  }

  bool hasNoticeUsref() => _noticeUsref != null;

  static NotificationUSerefStruct fromMap(Map<String, dynamic> data) =>
      NotificationUSerefStruct(
        noticeUsref: getDataList(data['NoticeUsref']),
      );

  static NotificationUSerefStruct? maybeFromMap(dynamic data) => data is Map
      ? NotificationUSerefStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'NoticeUsref': _noticeUsref,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'NoticeUsref': serializeParam(
          _noticeUsref,
          ParamType.DocumentReference,
          isList: true,
        ),
      }.withoutNulls;

  static NotificationUSerefStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      NotificationUSerefStruct(
        noticeUsref: deserializeParam<DocumentReference>(
          data['NoticeUsref'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['Users'],
        ),
      );

  static NotificationUSerefStruct fromAlgoliaData(Map<String, dynamic> data) =>
      NotificationUSerefStruct(
        noticeUsref: convertAlgoliaParam<DocumentReference>(
          data['NoticeUsref'],
          ParamType.DocumentReference,
          true,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'NotificationUSerefStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NotificationUSerefStruct &&
        listEquality.equals(noticeUsref, other.noticeUsref);
  }

  @override
  int get hashCode => const ListEquality().hash([noticeUsref]);
}

NotificationUSerefStruct createNotificationUSerefStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NotificationUSerefStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NotificationUSerefStruct? updateNotificationUSerefStruct(
  NotificationUSerefStruct? notificationUSeref, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    notificationUSeref
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNotificationUSerefStructData(
  Map<String, dynamic> firestoreData,
  NotificationUSerefStruct? notificationUSeref,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (notificationUSeref == null) {
    return;
  }
  if (notificationUSeref.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && notificationUSeref.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final notificationUSerefData =
      getNotificationUSerefFirestoreData(notificationUSeref, forFieldValue);
  final nestedData =
      notificationUSerefData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      notificationUSeref.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNotificationUSerefFirestoreData(
  NotificationUSerefStruct? notificationUSeref, [
  bool forFieldValue = false,
]) {
  if (notificationUSeref == null) {
    return {};
  }
  final firestoreData = mapToFirestore(notificationUSeref.toMap());

  // Add any Firestore field values
  notificationUSeref.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNotificationUSerefListFirestoreData(
  List<NotificationUSerefStruct>? notificationUSerefs,
) =>
    notificationUSerefs
        ?.map((e) => getNotificationUSerefFirestoreData(e, true))
        .toList() ??
    [];
