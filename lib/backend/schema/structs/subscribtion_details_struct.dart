// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscribtionDetailsStruct extends FFFirebaseStruct {
  SubscribtionDetailsStruct({
    int? subId,
    String? subName,
    double? subAmount,
    String? frequency,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? subScriptionFeature,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _subId = subId,
        _subName = subName,
        _subAmount = subAmount,
        _frequency = frequency,
        _startDate = startDate,
        _endDate = endDate,
        _subScriptionFeature = subScriptionFeature,
        super(firestoreUtilData);

  // "sub_id" field.
  int? _subId;
  int get subId => _subId ?? 0;
  set subId(int? val) => _subId = val;

  void incrementSubId(int amount) => subId = subId + amount;

  bool hasSubId() => _subId != null;

  // "sub_name" field.
  String? _subName;
  String get subName => _subName ?? '';
  set subName(String? val) => _subName = val;

  bool hasSubName() => _subName != null;

  // "sub_amount" field.
  double? _subAmount;
  double get subAmount => _subAmount ?? 0.0;
  set subAmount(double? val) => _subAmount = val;

  void incrementSubAmount(double amount) => subAmount = subAmount + amount;

  bool hasSubAmount() => _subAmount != null;

  // "frequency" field.
  String? _frequency;
  String get frequency => _frequency ?? '';
  set frequency(String? val) => _frequency = val;

  bool hasFrequency() => _frequency != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? val) => _startDate = val;

  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  set endDate(DateTime? val) => _endDate = val;

  bool hasEndDate() => _endDate != null;

  // "subScription_feature" field.
  List<String>? _subScriptionFeature;
  List<String> get subScriptionFeature => _subScriptionFeature ?? const [];
  set subScriptionFeature(List<String>? val) => _subScriptionFeature = val;

  void updateSubScriptionFeature(Function(List<String>) updateFn) {
    updateFn(_subScriptionFeature ??= []);
  }

  bool hasSubScriptionFeature() => _subScriptionFeature != null;

  static SubscribtionDetailsStruct fromMap(Map<String, dynamic> data) =>
      SubscribtionDetailsStruct(
        subId: castToType<int>(data['sub_id']),
        subName: data['sub_name'] as String?,
        subAmount: castToType<double>(data['sub_amount']),
        frequency: data['frequency'] as String?,
        startDate: data['start_date'] as DateTime?,
        endDate: data['end_date'] as DateTime?,
        subScriptionFeature: getDataList(data['subScription_feature']),
      );

  static SubscribtionDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? SubscribtionDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'sub_id': _subId,
        'sub_name': _subName,
        'sub_amount': _subAmount,
        'frequency': _frequency,
        'start_date': _startDate,
        'end_date': _endDate,
        'subScription_feature': _subScriptionFeature,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'sub_id': serializeParam(
          _subId,
          ParamType.int,
        ),
        'sub_name': serializeParam(
          _subName,
          ParamType.String,
        ),
        'sub_amount': serializeParam(
          _subAmount,
          ParamType.double,
        ),
        'frequency': serializeParam(
          _frequency,
          ParamType.String,
        ),
        'start_date': serializeParam(
          _startDate,
          ParamType.DateTime,
        ),
        'end_date': serializeParam(
          _endDate,
          ParamType.DateTime,
        ),
        'subScription_feature': serializeParam(
          _subScriptionFeature,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static SubscribtionDetailsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SubscribtionDetailsStruct(
        subId: deserializeParam(
          data['sub_id'],
          ParamType.int,
          false,
        ),
        subName: deserializeParam(
          data['sub_name'],
          ParamType.String,
          false,
        ),
        subAmount: deserializeParam(
          data['sub_amount'],
          ParamType.double,
          false,
        ),
        frequency: deserializeParam(
          data['frequency'],
          ParamType.String,
          false,
        ),
        startDate: deserializeParam(
          data['start_date'],
          ParamType.DateTime,
          false,
        ),
        endDate: deserializeParam(
          data['end_date'],
          ParamType.DateTime,
          false,
        ),
        subScriptionFeature: deserializeParam<String>(
          data['subScription_feature'],
          ParamType.String,
          true,
        ),
      );

  static SubscribtionDetailsStruct fromAlgoliaData(Map<String, dynamic> data) =>
      SubscribtionDetailsStruct(
        subId: convertAlgoliaParam(
          data['sub_id'],
          ParamType.int,
          false,
        ),
        subName: convertAlgoliaParam(
          data['sub_name'],
          ParamType.String,
          false,
        ),
        subAmount: convertAlgoliaParam(
          data['sub_amount'],
          ParamType.double,
          false,
        ),
        frequency: convertAlgoliaParam(
          data['frequency'],
          ParamType.String,
          false,
        ),
        startDate: convertAlgoliaParam(
          data['start_date'],
          ParamType.DateTime,
          false,
        ),
        endDate: convertAlgoliaParam(
          data['end_date'],
          ParamType.DateTime,
          false,
        ),
        subScriptionFeature: convertAlgoliaParam<String>(
          data['subScription_feature'],
          ParamType.String,
          true,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'SubscribtionDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SubscribtionDetailsStruct &&
        subId == other.subId &&
        subName == other.subName &&
        subAmount == other.subAmount &&
        frequency == other.frequency &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        listEquality.equals(subScriptionFeature, other.subScriptionFeature);
  }

  @override
  int get hashCode => const ListEquality().hash([
        subId,
        subName,
        subAmount,
        frequency,
        startDate,
        endDate,
        subScriptionFeature
      ]);
}

SubscribtionDetailsStruct createSubscribtionDetailsStruct({
  int? subId,
  String? subName,
  double? subAmount,
  String? frequency,
  DateTime? startDate,
  DateTime? endDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SubscribtionDetailsStruct(
      subId: subId,
      subName: subName,
      subAmount: subAmount,
      frequency: frequency,
      startDate: startDate,
      endDate: endDate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SubscribtionDetailsStruct? updateSubscribtionDetailsStruct(
  SubscribtionDetailsStruct? subscribtionDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    subscribtionDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSubscribtionDetailsStructData(
  Map<String, dynamic> firestoreData,
  SubscribtionDetailsStruct? subscribtionDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (subscribtionDetails == null) {
    return;
  }
  if (subscribtionDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && subscribtionDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final subscribtionDetailsData =
      getSubscribtionDetailsFirestoreData(subscribtionDetails, forFieldValue);
  final nestedData =
      subscribtionDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      subscribtionDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSubscribtionDetailsFirestoreData(
  SubscribtionDetailsStruct? subscribtionDetails, [
  bool forFieldValue = false,
]) {
  if (subscribtionDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(subscribtionDetails.toMap());

  // Add any Firestore field values
  subscribtionDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSubscribtionDetailsListFirestoreData(
  List<SubscribtionDetailsStruct>? subscribtionDetailss,
) =>
    subscribtionDetailss
        ?.map((e) => getSubscribtionDetailsFirestoreData(e, true))
        .toList() ??
    [];
