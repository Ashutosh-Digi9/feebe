// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationStruct extends FFFirebaseStruct {
  NotificationStruct({
    String? notificationTitle,
    String? descriptions,
    DateTime? timeStamp,
    bool? isRead,
    DateTime? eventDate,
    DocumentReference? schoolRef,
    List<String>? notificationFiles,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _notificationTitle = notificationTitle,
        _descriptions = descriptions,
        _timeStamp = timeStamp,
        _isRead = isRead,
        _eventDate = eventDate,
        _schoolRef = schoolRef,
        _notificationFiles = notificationFiles,
        super(firestoreUtilData);

  // "notification_title" field.
  String? _notificationTitle;
  String get notificationTitle => _notificationTitle ?? '';
  set notificationTitle(String? val) => _notificationTitle = val;

  bool hasNotificationTitle() => _notificationTitle != null;

  // "descriptions" field.
  String? _descriptions;
  String get descriptions => _descriptions ?? '';
  set descriptions(String? val) => _descriptions = val;

  bool hasDescriptions() => _descriptions != null;

  // "timeStamp" field.
  DateTime? _timeStamp;
  DateTime? get timeStamp => _timeStamp;
  set timeStamp(DateTime? val) => _timeStamp = val;

  bool hasTimeStamp() => _timeStamp != null;

  // "isRead" field.
  bool? _isRead;
  bool get isRead => _isRead ?? false;
  set isRead(bool? val) => _isRead = val;

  bool hasIsRead() => _isRead != null;

  // "eventDate" field.
  DateTime? _eventDate;
  DateTime? get eventDate => _eventDate;
  set eventDate(DateTime? val) => _eventDate = val;

  bool hasEventDate() => _eventDate != null;

  // "schoolRef" field.
  DocumentReference? _schoolRef;
  DocumentReference? get schoolRef => _schoolRef;
  set schoolRef(DocumentReference? val) => _schoolRef = val;

  bool hasSchoolRef() => _schoolRef != null;

  // "notification_files" field.
  List<String>? _notificationFiles;
  List<String> get notificationFiles => _notificationFiles ?? const [];
  set notificationFiles(List<String>? val) => _notificationFiles = val;

  void updateNotificationFiles(Function(List<String>) updateFn) {
    updateFn(_notificationFiles ??= []);
  }

  bool hasNotificationFiles() => _notificationFiles != null;

  static NotificationStruct fromMap(Map<String, dynamic> data) =>
      NotificationStruct(
        notificationTitle: data['notification_title'] as String?,
        descriptions: data['descriptions'] as String?,
        timeStamp: data['timeStamp'] as DateTime?,
        isRead: data['isRead'] as bool?,
        eventDate: data['eventDate'] as DateTime?,
        schoolRef: data['schoolRef'] as DocumentReference?,
        notificationFiles: getDataList(data['notification_files']),
      );

  static NotificationStruct? maybeFromMap(dynamic data) => data is Map
      ? NotificationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'notification_title': _notificationTitle,
        'descriptions': _descriptions,
        'timeStamp': _timeStamp,
        'isRead': _isRead,
        'eventDate': _eventDate,
        'schoolRef': _schoolRef,
        'notification_files': _notificationFiles,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'notification_title': serializeParam(
          _notificationTitle,
          ParamType.String,
        ),
        'descriptions': serializeParam(
          _descriptions,
          ParamType.String,
        ),
        'timeStamp': serializeParam(
          _timeStamp,
          ParamType.DateTime,
        ),
        'isRead': serializeParam(
          _isRead,
          ParamType.bool,
        ),
        'eventDate': serializeParam(
          _eventDate,
          ParamType.DateTime,
        ),
        'schoolRef': serializeParam(
          _schoolRef,
          ParamType.DocumentReference,
        ),
        'notification_files': serializeParam(
          _notificationFiles,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static NotificationStruct fromSerializableMap(Map<String, dynamic> data) =>
      NotificationStruct(
        notificationTitle: deserializeParam(
          data['notification_title'],
          ParamType.String,
          false,
        ),
        descriptions: deserializeParam(
          data['descriptions'],
          ParamType.String,
          false,
        ),
        timeStamp: deserializeParam(
          data['timeStamp'],
          ParamType.DateTime,
          false,
        ),
        isRead: deserializeParam(
          data['isRead'],
          ParamType.bool,
          false,
        ),
        eventDate: deserializeParam(
          data['eventDate'],
          ParamType.DateTime,
          false,
        ),
        schoolRef: deserializeParam(
          data['schoolRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['School'],
        ),
        notificationFiles: deserializeParam<String>(
          data['notification_files'],
          ParamType.String,
          true,
        ),
      );

  static NotificationStruct fromAlgoliaData(Map<String, dynamic> data) =>
      NotificationStruct(
        notificationTitle: convertAlgoliaParam(
          data['notification_title'],
          ParamType.String,
          false,
        ),
        descriptions: convertAlgoliaParam(
          data['descriptions'],
          ParamType.String,
          false,
        ),
        timeStamp: convertAlgoliaParam(
          data['timeStamp'],
          ParamType.DateTime,
          false,
        ),
        isRead: convertAlgoliaParam(
          data['isRead'],
          ParamType.bool,
          false,
        ),
        eventDate: convertAlgoliaParam(
          data['eventDate'],
          ParamType.DateTime,
          false,
        ),
        schoolRef: convertAlgoliaParam(
          data['schoolRef'],
          ParamType.DocumentReference,
          false,
        ),
        notificationFiles: convertAlgoliaParam<String>(
          data['notification_files'],
          ParamType.String,
          true,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'NotificationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NotificationStruct &&
        notificationTitle == other.notificationTitle &&
        descriptions == other.descriptions &&
        timeStamp == other.timeStamp &&
        isRead == other.isRead &&
        eventDate == other.eventDate &&
        schoolRef == other.schoolRef &&
        listEquality.equals(notificationFiles, other.notificationFiles);
  }

  @override
  int get hashCode => const ListEquality().hash([
        notificationTitle,
        descriptions,
        timeStamp,
        isRead,
        eventDate,
        schoolRef,
        notificationFiles
      ]);
}

NotificationStruct createNotificationStruct({
  String? notificationTitle,
  String? descriptions,
  DateTime? timeStamp,
  bool? isRead,
  DateTime? eventDate,
  DocumentReference? schoolRef,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NotificationStruct(
      notificationTitle: notificationTitle,
      descriptions: descriptions,
      timeStamp: timeStamp,
      isRead: isRead,
      eventDate: eventDate,
      schoolRef: schoolRef,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NotificationStruct? updateNotificationStruct(
  NotificationStruct? notification, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    notification
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNotificationStructData(
  Map<String, dynamic> firestoreData,
  NotificationStruct? notification,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (notification == null) {
    return;
  }
  if (notification.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && notification.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final notificationData =
      getNotificationFirestoreData(notification, forFieldValue);
  final nestedData =
      notificationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = notification.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNotificationFirestoreData(
  NotificationStruct? notification, [
  bool forFieldValue = false,
]) {
  if (notification == null) {
    return {};
  }
  final firestoreData = mapToFirestore(notification.toMap());

  // Add any Firestore field values
  notification.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNotificationListFirestoreData(
  List<NotificationStruct>? notifications,
) =>
    notifications?.map((e) => getNotificationFirestoreData(e, true)).toList() ??
    [];
