// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ParentsDetailsStruct extends FFFirebaseStruct {
  ParentsDetailsStruct({
    int? parentsId,
    String? parentsName,
    String? parentImage,
    String? parentsEmail,
    String? parentsPhone,
    DocumentReference? userRef,
    String? parentRelation,
    String? document,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _parentsId = parentsId,
        _parentsName = parentsName,
        _parentImage = parentImage,
        _parentsEmail = parentsEmail,
        _parentsPhone = parentsPhone,
        _userRef = userRef,
        _parentRelation = parentRelation,
        _document = document,
        super(firestoreUtilData);

  // "parents_id" field.
  int? _parentsId;
  int get parentsId => _parentsId ?? 0;
  set parentsId(int? val) => _parentsId = val;

  void incrementParentsId(int amount) => parentsId = parentsId + amount;

  bool hasParentsId() => _parentsId != null;

  // "parents_name" field.
  String? _parentsName;
  String get parentsName => _parentsName ?? '';
  set parentsName(String? val) => _parentsName = val;

  bool hasParentsName() => _parentsName != null;

  // "parentImage" field.
  String? _parentImage;
  String get parentImage => _parentImage ?? '';
  set parentImage(String? val) => _parentImage = val;

  bool hasParentImage() => _parentImage != null;

  // "parents_email" field.
  String? _parentsEmail;
  String get parentsEmail => _parentsEmail ?? '';
  set parentsEmail(String? val) => _parentsEmail = val;

  bool hasParentsEmail() => _parentsEmail != null;

  // "parents_phone" field.
  String? _parentsPhone;
  String get parentsPhone => _parentsPhone ?? '';
  set parentsPhone(String? val) => _parentsPhone = val;

  bool hasParentsPhone() => _parentsPhone != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  // "ParentRelation" field.
  String? _parentRelation;
  String get parentRelation => _parentRelation ?? '';
  set parentRelation(String? val) => _parentRelation = val;

  bool hasParentRelation() => _parentRelation != null;

  // "document" field.
  String? _document;
  String get document => _document ?? '';
  set document(String? val) => _document = val;

  bool hasDocument() => _document != null;

  static ParentsDetailsStruct fromMap(Map<String, dynamic> data) =>
      ParentsDetailsStruct(
        parentsId: castToType<int>(data['parents_id']),
        parentsName: data['parents_name'] as String?,
        parentImage: data['parentImage'] as String?,
        parentsEmail: data['parents_email'] as String?,
        parentsPhone: data['parents_phone'] as String?,
        userRef: data['userRef'] as DocumentReference?,
        parentRelation: data['ParentRelation'] as String?,
        document: data['document'] as String?,
      );

  static ParentsDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? ParentsDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'parents_id': _parentsId,
        'parents_name': _parentsName,
        'parentImage': _parentImage,
        'parents_email': _parentsEmail,
        'parents_phone': _parentsPhone,
        'userRef': _userRef,
        'ParentRelation': _parentRelation,
        'document': _document,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'parents_id': serializeParam(
          _parentsId,
          ParamType.int,
        ),
        'parents_name': serializeParam(
          _parentsName,
          ParamType.String,
        ),
        'parentImage': serializeParam(
          _parentImage,
          ParamType.String,
        ),
        'parents_email': serializeParam(
          _parentsEmail,
          ParamType.String,
        ),
        'parents_phone': serializeParam(
          _parentsPhone,
          ParamType.String,
        ),
        'userRef': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'ParentRelation': serializeParam(
          _parentRelation,
          ParamType.String,
        ),
        'document': serializeParam(
          _document,
          ParamType.String,
        ),
      }.withoutNulls;

  static ParentsDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ParentsDetailsStruct(
        parentsId: deserializeParam(
          data['parents_id'],
          ParamType.int,
          false,
        ),
        parentsName: deserializeParam(
          data['parents_name'],
          ParamType.String,
          false,
        ),
        parentImage: deserializeParam(
          data['parentImage'],
          ParamType.String,
          false,
        ),
        parentsEmail: deserializeParam(
          data['parents_email'],
          ParamType.String,
          false,
        ),
        parentsPhone: deserializeParam(
          data['parents_phone'],
          ParamType.String,
          false,
        ),
        userRef: deserializeParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Users'],
        ),
        parentRelation: deserializeParam(
          data['ParentRelation'],
          ParamType.String,
          false,
        ),
        document: deserializeParam(
          data['document'],
          ParamType.String,
          false,
        ),
      );

  static ParentsDetailsStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ParentsDetailsStruct(
        parentsId: convertAlgoliaParam(
          data['parents_id'],
          ParamType.int,
          false,
        ),
        parentsName: convertAlgoliaParam(
          data['parents_name'],
          ParamType.String,
          false,
        ),
        parentImage: convertAlgoliaParam(
          data['parentImage'],
          ParamType.String,
          false,
        ),
        parentsEmail: convertAlgoliaParam(
          data['parents_email'],
          ParamType.String,
          false,
        ),
        parentsPhone: convertAlgoliaParam(
          data['parents_phone'],
          ParamType.String,
          false,
        ),
        userRef: convertAlgoliaParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
        ),
        parentRelation: convertAlgoliaParam(
          data['ParentRelation'],
          ParamType.String,
          false,
        ),
        document: convertAlgoliaParam(
          data['document'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ParentsDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ParentsDetailsStruct &&
        parentsId == other.parentsId &&
        parentsName == other.parentsName &&
        parentImage == other.parentImage &&
        parentsEmail == other.parentsEmail &&
        parentsPhone == other.parentsPhone &&
        userRef == other.userRef &&
        parentRelation == other.parentRelation &&
        document == other.document;
  }

  @override
  int get hashCode => const ListEquality().hash([
        parentsId,
        parentsName,
        parentImage,
        parentsEmail,
        parentsPhone,
        userRef,
        parentRelation,
        document
      ]);
}

ParentsDetailsStruct createParentsDetailsStruct({
  int? parentsId,
  String? parentsName,
  String? parentImage,
  String? parentsEmail,
  String? parentsPhone,
  DocumentReference? userRef,
  String? parentRelation,
  String? document,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ParentsDetailsStruct(
      parentsId: parentsId,
      parentsName: parentsName,
      parentImage: parentImage,
      parentsEmail: parentsEmail,
      parentsPhone: parentsPhone,
      userRef: userRef,
      parentRelation: parentRelation,
      document: document,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ParentsDetailsStruct? updateParentsDetailsStruct(
  ParentsDetailsStruct? parentsDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    parentsDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addParentsDetailsStructData(
  Map<String, dynamic> firestoreData,
  ParentsDetailsStruct? parentsDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (parentsDetails == null) {
    return;
  }
  if (parentsDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && parentsDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final parentsDetailsData =
      getParentsDetailsFirestoreData(parentsDetails, forFieldValue);
  final nestedData =
      parentsDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = parentsDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getParentsDetailsFirestoreData(
  ParentsDetailsStruct? parentsDetails, [
  bool forFieldValue = false,
]) {
  if (parentsDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(parentsDetails.toMap());

  // Add any Firestore field values
  parentsDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getParentsDetailsListFirestoreData(
  List<ParentsDetailsStruct>? parentsDetailss,
) =>
    parentsDetailss
        ?.map((e) => getParentsDetailsFirestoreData(e, true))
        .toList() ??
    [];
