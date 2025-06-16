// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelectedDropDownStruct extends FFFirebaseStruct {
  SelectedDropDownStruct({
    String? classNAMe,
    DocumentReference? classreference,
    List<EventsNoticeStruct>? eventsDataList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _classNAMe = classNAMe,
        _classreference = classreference,
        _eventsDataList = eventsDataList,
        super(firestoreUtilData);

  // "classNAMe" field.
  String? _classNAMe;
  String get classNAMe => _classNAMe ?? '';
  set classNAMe(String? val) => _classNAMe = val;

  bool hasClassNAMe() => _classNAMe != null;

  // "classreference" field.
  DocumentReference? _classreference;
  DocumentReference? get classreference => _classreference;
  set classreference(DocumentReference? val) => _classreference = val;

  bool hasClassreference() => _classreference != null;

  // "eventsDataList" field.
  List<EventsNoticeStruct>? _eventsDataList;
  List<EventsNoticeStruct> get eventsDataList => _eventsDataList ?? const [];
  set eventsDataList(List<EventsNoticeStruct>? val) => _eventsDataList = val;

  void updateEventsDataList(Function(List<EventsNoticeStruct>) updateFn) {
    updateFn(_eventsDataList ??= []);
  }

  bool hasEventsDataList() => _eventsDataList != null;

  static SelectedDropDownStruct fromMap(Map<String, dynamic> data) =>
      SelectedDropDownStruct(
        classNAMe: data['classNAMe'] as String?,
        classreference: data['classreference'] as DocumentReference?,
        eventsDataList: getStructList(
          data['eventsDataList'],
          EventsNoticeStruct.fromMap,
        ),
      );

  static SelectedDropDownStruct? maybeFromMap(dynamic data) => data is Map
      ? SelectedDropDownStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'classNAMe': _classNAMe,
        'classreference': _classreference,
        'eventsDataList': _eventsDataList?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'classNAMe': serializeParam(
          _classNAMe,
          ParamType.String,
        ),
        'classreference': serializeParam(
          _classreference,
          ParamType.DocumentReference,
        ),
        'eventsDataList': serializeParam(
          _eventsDataList,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SelectedDropDownStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SelectedDropDownStruct(
        classNAMe: deserializeParam(
          data['classNAMe'],
          ParamType.String,
          false,
        ),
        classreference: deserializeParam(
          data['classreference'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['School_class'],
        ),
        eventsDataList: deserializeStructParam<EventsNoticeStruct>(
          data['eventsDataList'],
          ParamType.DataStruct,
          true,
          structBuilder: EventsNoticeStruct.fromSerializableMap,
        ),
      );

  static SelectedDropDownStruct fromAlgoliaData(Map<String, dynamic> data) =>
      SelectedDropDownStruct(
        classNAMe: convertAlgoliaParam(
          data['classNAMe'],
          ParamType.String,
          false,
        ),
        classreference: convertAlgoliaParam(
          data['classreference'],
          ParamType.DocumentReference,
          false,
        ),
        eventsDataList: convertAlgoliaParam<EventsNoticeStruct>(
          data['eventsDataList'],
          ParamType.DataStruct,
          true,
          structBuilder: EventsNoticeStruct.fromAlgoliaData,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'SelectedDropDownStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SelectedDropDownStruct &&
        classNAMe == other.classNAMe &&
        classreference == other.classreference &&
        listEquality.equals(eventsDataList, other.eventsDataList);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([classNAMe, classreference, eventsDataList]);
}

SelectedDropDownStruct createSelectedDropDownStruct({
  String? classNAMe,
  DocumentReference? classreference,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SelectedDropDownStruct(
      classNAMe: classNAMe,
      classreference: classreference,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SelectedDropDownStruct? updateSelectedDropDownStruct(
  SelectedDropDownStruct? selectedDropDown, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    selectedDropDown
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSelectedDropDownStructData(
  Map<String, dynamic> firestoreData,
  SelectedDropDownStruct? selectedDropDown,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (selectedDropDown == null) {
    return;
  }
  if (selectedDropDown.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && selectedDropDown.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final selectedDropDownData =
      getSelectedDropDownFirestoreData(selectedDropDown, forFieldValue);
  final nestedData =
      selectedDropDownData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = selectedDropDown.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSelectedDropDownFirestoreData(
  SelectedDropDownStruct? selectedDropDown, [
  bool forFieldValue = false,
]) {
  if (selectedDropDown == null) {
    return {};
  }
  final firestoreData = mapToFirestore(selectedDropDown.toMap());

  // Add any Firestore field values
  selectedDropDown.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSelectedDropDownListFirestoreData(
  List<SelectedDropDownStruct>? selectedDropDowns,
) =>
    selectedDropDowns
        ?.map((e) => getSelectedDropDownFirestoreData(e, true))
        .toList() ??
    [];
