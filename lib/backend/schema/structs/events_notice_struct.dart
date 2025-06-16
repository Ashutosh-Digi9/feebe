// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsNoticeStruct extends FFFirebaseStruct {
  EventsNoticeStruct({
    int? eventId,
    String? eventName,
    String? eventTitle,
    String? eventDescription,
    DateTime? eventDate,
    List<String>? eventfiles,
    List<DocumentReference>? classref,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _eventId = eventId,
        _eventName = eventName,
        _eventTitle = eventTitle,
        _eventDescription = eventDescription,
        _eventDate = eventDate,
        _eventfiles = eventfiles,
        _classref = classref,
        super(firestoreUtilData);

  // "Event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  set eventId(int? val) => _eventId = val;

  void incrementEventId(int amount) => eventId = eventId + amount;

  bool hasEventId() => _eventId != null;

  // "Event_name" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  set eventName(String? val) => _eventName = val;

  bool hasEventName() => _eventName != null;

  // "Event_Title" field.
  String? _eventTitle;
  String get eventTitle => _eventTitle ?? '';
  set eventTitle(String? val) => _eventTitle = val;

  bool hasEventTitle() => _eventTitle != null;

  // "Event_description" field.
  String? _eventDescription;
  String get eventDescription => _eventDescription ?? '';
  set eventDescription(String? val) => _eventDescription = val;

  bool hasEventDescription() => _eventDescription != null;

  // "Event_date" field.
  DateTime? _eventDate;
  DateTime? get eventDate => _eventDate;
  set eventDate(DateTime? val) => _eventDate = val;

  bool hasEventDate() => _eventDate != null;

  // "eventfiles" field.
  List<String>? _eventfiles;
  List<String> get eventfiles => _eventfiles ?? const [];
  set eventfiles(List<String>? val) => _eventfiles = val;

  void updateEventfiles(Function(List<String>) updateFn) {
    updateFn(_eventfiles ??= []);
  }

  bool hasEventfiles() => _eventfiles != null;

  // "classref" field.
  List<DocumentReference>? _classref;
  List<DocumentReference> get classref => _classref ?? const [];
  set classref(List<DocumentReference>? val) => _classref = val;

  void updateClassref(Function(List<DocumentReference>) updateFn) {
    updateFn(_classref ??= []);
  }

  bool hasClassref() => _classref != null;

  static EventsNoticeStruct fromMap(Map<String, dynamic> data) =>
      EventsNoticeStruct(
        eventId: castToType<int>(data['Event_id']),
        eventName: data['Event_name'] as String?,
        eventTitle: data['Event_Title'] as String?,
        eventDescription: data['Event_description'] as String?,
        eventDate: data['Event_date'] as DateTime?,
        eventfiles: getDataList(data['eventfiles']),
        classref: getDataList(data['classref']),
      );

  static EventsNoticeStruct? maybeFromMap(dynamic data) => data is Map
      ? EventsNoticeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Event_id': _eventId,
        'Event_name': _eventName,
        'Event_Title': _eventTitle,
        'Event_description': _eventDescription,
        'Event_date': _eventDate,
        'eventfiles': _eventfiles,
        'classref': _classref,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Event_id': serializeParam(
          _eventId,
          ParamType.int,
        ),
        'Event_name': serializeParam(
          _eventName,
          ParamType.String,
        ),
        'Event_Title': serializeParam(
          _eventTitle,
          ParamType.String,
        ),
        'Event_description': serializeParam(
          _eventDescription,
          ParamType.String,
        ),
        'Event_date': serializeParam(
          _eventDate,
          ParamType.DateTime,
        ),
        'eventfiles': serializeParam(
          _eventfiles,
          ParamType.String,
          isList: true,
        ),
        'classref': serializeParam(
          _classref,
          ParamType.DocumentReference,
          isList: true,
        ),
      }.withoutNulls;

  static EventsNoticeStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventsNoticeStruct(
        eventId: deserializeParam(
          data['Event_id'],
          ParamType.int,
          false,
        ),
        eventName: deserializeParam(
          data['Event_name'],
          ParamType.String,
          false,
        ),
        eventTitle: deserializeParam(
          data['Event_Title'],
          ParamType.String,
          false,
        ),
        eventDescription: deserializeParam(
          data['Event_description'],
          ParamType.String,
          false,
        ),
        eventDate: deserializeParam(
          data['Event_date'],
          ParamType.DateTime,
          false,
        ),
        eventfiles: deserializeParam<String>(
          data['eventfiles'],
          ParamType.String,
          true,
        ),
        classref: deserializeParam<DocumentReference>(
          data['classref'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['School_class'],
        ),
      );

  static EventsNoticeStruct fromAlgoliaData(Map<String, dynamic> data) =>
      EventsNoticeStruct(
        eventId: convertAlgoliaParam(
          data['Event_id'],
          ParamType.int,
          false,
        ),
        eventName: convertAlgoliaParam(
          data['Event_name'],
          ParamType.String,
          false,
        ),
        eventTitle: convertAlgoliaParam(
          data['Event_Title'],
          ParamType.String,
          false,
        ),
        eventDescription: convertAlgoliaParam(
          data['Event_description'],
          ParamType.String,
          false,
        ),
        eventDate: convertAlgoliaParam(
          data['Event_date'],
          ParamType.DateTime,
          false,
        ),
        eventfiles: convertAlgoliaParam<String>(
          data['eventfiles'],
          ParamType.String,
          true,
        ),
        classref: convertAlgoliaParam<DocumentReference>(
          data['classref'],
          ParamType.DocumentReference,
          true,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'EventsNoticeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EventsNoticeStruct &&
        eventId == other.eventId &&
        eventName == other.eventName &&
        eventTitle == other.eventTitle &&
        eventDescription == other.eventDescription &&
        eventDate == other.eventDate &&
        listEquality.equals(eventfiles, other.eventfiles) &&
        listEquality.equals(classref, other.classref);
  }

  @override
  int get hashCode => const ListEquality().hash([
        eventId,
        eventName,
        eventTitle,
        eventDescription,
        eventDate,
        eventfiles,
        classref
      ]);
}

EventsNoticeStruct createEventsNoticeStruct({
  int? eventId,
  String? eventName,
  String? eventTitle,
  String? eventDescription,
  DateTime? eventDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventsNoticeStruct(
      eventId: eventId,
      eventName: eventName,
      eventTitle: eventTitle,
      eventDescription: eventDescription,
      eventDate: eventDate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventsNoticeStruct? updateEventsNoticeStruct(
  EventsNoticeStruct? eventsNotice, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventsNotice
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventsNoticeStructData(
  Map<String, dynamic> firestoreData,
  EventsNoticeStruct? eventsNotice,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventsNotice == null) {
    return;
  }
  if (eventsNotice.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventsNotice.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventsNoticeData =
      getEventsNoticeFirestoreData(eventsNotice, forFieldValue);
  final nestedData =
      eventsNoticeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = eventsNotice.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventsNoticeFirestoreData(
  EventsNoticeStruct? eventsNotice, [
  bool forFieldValue = false,
]) {
  if (eventsNotice == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventsNotice.toMap());

  // Add any Firestore field values
  eventsNotice.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventsNoticeListFirestoreData(
  List<EventsNoticeStruct>? eventsNotices,
) =>
    eventsNotices?.map((e) => getEventsNoticeFirestoreData(e, true)).toList() ??
    [];
