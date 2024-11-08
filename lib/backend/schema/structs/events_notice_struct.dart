// ignore_for_file: unnecessary_getters_setters

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
    List<String>? eventImages,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _eventId = eventId,
        _eventName = eventName,
        _eventTitle = eventTitle,
        _eventDescription = eventDescription,
        _eventDate = eventDate,
        _eventImages = eventImages,
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

  // "Event_images" field.
  List<String>? _eventImages;
  List<String> get eventImages => _eventImages ?? const [];
  set eventImages(List<String>? val) => _eventImages = val;

  void updateEventImages(Function(List<String>) updateFn) {
    updateFn(_eventImages ??= []);
  }

  bool hasEventImages() => _eventImages != null;

  static EventsNoticeStruct fromMap(Map<String, dynamic> data) =>
      EventsNoticeStruct(
        eventId: castToType<int>(data['Event_id']),
        eventName: data['Event_name'] as String?,
        eventTitle: data['Event_Title'] as String?,
        eventDescription: data['Event_description'] as String?,
        eventDate: data['Event_date'] as DateTime?,
        eventImages: getDataList(data['Event_images']),
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
        'Event_images': _eventImages,
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
        'Event_images': serializeParam(
          _eventImages,
          ParamType.String,
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
        eventImages: deserializeParam<String>(
          data['Event_images'],
          ParamType.String,
          true,
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
        listEquality.equals(eventImages, other.eventImages);
  }

  @override
  int get hashCode => const ListEquality().hash([
        eventId,
        eventName,
        eventTitle,
        eventDescription,
        eventDate,
        eventImages
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
