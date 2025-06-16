// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ParentStudentStruct extends FFFirebaseStruct {
  ParentStudentStruct({
    String? name,
    DateTime? dob,
    String? bloodgrp,
    String? gender,
    String? allergy,
    String? address,
    String? doc,
    String? image,
    DocumentReference? docref,
    int? index,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _dob = dob,
        _bloodgrp = bloodgrp,
        _gender = gender,
        _allergy = allergy,
        _address = address,
        _doc = doc,
        _image = image,
        _docref = docref,
        _index = index,
        super(firestoreUtilData);

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "DOB" field.
  DateTime? _dob;
  DateTime? get dob => _dob;
  set dob(DateTime? val) => _dob = val;

  bool hasDob() => _dob != null;

  // "Bloodgrp" field.
  String? _bloodgrp;
  String get bloodgrp => _bloodgrp ?? '';
  set bloodgrp(String? val) => _bloodgrp = val;

  bool hasBloodgrp() => _bloodgrp != null;

  // "Gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  set gender(String? val) => _gender = val;

  bool hasGender() => _gender != null;

  // "allergy" field.
  String? _allergy;
  String get allergy => _allergy ?? '';
  set allergy(String? val) => _allergy = val;

  bool hasAllergy() => _allergy != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  // "doc" field.
  String? _doc;
  String get doc => _doc ?? '';
  set doc(String? val) => _doc = val;

  bool hasDoc() => _doc != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "docref" field.
  DocumentReference? _docref;
  DocumentReference? get docref => _docref;
  set docref(DocumentReference? val) => _docref = val;

  bool hasDocref() => _docref != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  set index(int? val) => _index = val;

  void incrementIndex(int amount) => index = index + amount;

  bool hasIndex() => _index != null;

  static ParentStudentStruct fromMap(Map<String, dynamic> data) =>
      ParentStudentStruct(
        name: data['Name'] as String?,
        dob: data['DOB'] as DateTime?,
        bloodgrp: data['Bloodgrp'] as String?,
        gender: data['Gender'] as String?,
        allergy: data['allergy'] as String?,
        address: data['address'] as String?,
        doc: data['doc'] as String?,
        image: data['image'] as String?,
        docref: data['docref'] as DocumentReference?,
        index: castToType<int>(data['index']),
      );

  static ParentStudentStruct? maybeFromMap(dynamic data) => data is Map
      ? ParentStudentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Name': _name,
        'DOB': _dob,
        'Bloodgrp': _bloodgrp,
        'Gender': _gender,
        'allergy': _allergy,
        'address': _address,
        'doc': _doc,
        'image': _image,
        'docref': _docref,
        'index': _index,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Name': serializeParam(
          _name,
          ParamType.String,
        ),
        'DOB': serializeParam(
          _dob,
          ParamType.DateTime,
        ),
        'Bloodgrp': serializeParam(
          _bloodgrp,
          ParamType.String,
        ),
        'Gender': serializeParam(
          _gender,
          ParamType.String,
        ),
        'allergy': serializeParam(
          _allergy,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
        'doc': serializeParam(
          _doc,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'docref': serializeParam(
          _docref,
          ParamType.DocumentReference,
        ),
        'index': serializeParam(
          _index,
          ParamType.int,
        ),
      }.withoutNulls;

  static ParentStudentStruct fromSerializableMap(Map<String, dynamic> data) =>
      ParentStudentStruct(
        name: deserializeParam(
          data['Name'],
          ParamType.String,
          false,
        ),
        dob: deserializeParam(
          data['DOB'],
          ParamType.DateTime,
          false,
        ),
        bloodgrp: deserializeParam(
          data['Bloodgrp'],
          ParamType.String,
          false,
        ),
        gender: deserializeParam(
          data['Gender'],
          ParamType.String,
          false,
        ),
        allergy: deserializeParam(
          data['allergy'],
          ParamType.String,
          false,
        ),
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
        doc: deserializeParam(
          data['doc'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        docref: deserializeParam(
          data['docref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Students'],
        ),
        index: deserializeParam(
          data['index'],
          ParamType.int,
          false,
        ),
      );

  static ParentStudentStruct fromAlgoliaData(Map<String, dynamic> data) =>
      ParentStudentStruct(
        name: convertAlgoliaParam(
          data['Name'],
          ParamType.String,
          false,
        ),
        dob: convertAlgoliaParam(
          data['DOB'],
          ParamType.DateTime,
          false,
        ),
        bloodgrp: convertAlgoliaParam(
          data['Bloodgrp'],
          ParamType.String,
          false,
        ),
        gender: convertAlgoliaParam(
          data['Gender'],
          ParamType.String,
          false,
        ),
        allergy: convertAlgoliaParam(
          data['allergy'],
          ParamType.String,
          false,
        ),
        address: convertAlgoliaParam(
          data['address'],
          ParamType.String,
          false,
        ),
        doc: convertAlgoliaParam(
          data['doc'],
          ParamType.String,
          false,
        ),
        image: convertAlgoliaParam(
          data['image'],
          ParamType.String,
          false,
        ),
        docref: convertAlgoliaParam(
          data['docref'],
          ParamType.DocumentReference,
          false,
        ),
        index: convertAlgoliaParam(
          data['index'],
          ParamType.int,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ParentStudentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ParentStudentStruct &&
        name == other.name &&
        dob == other.dob &&
        bloodgrp == other.bloodgrp &&
        gender == other.gender &&
        allergy == other.allergy &&
        address == other.address &&
        doc == other.doc &&
        image == other.image &&
        docref == other.docref &&
        index == other.index;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        dob,
        bloodgrp,
        gender,
        allergy,
        address,
        doc,
        image,
        docref,
        index
      ]);
}

ParentStudentStruct createParentStudentStruct({
  String? name,
  DateTime? dob,
  String? bloodgrp,
  String? gender,
  String? allergy,
  String? address,
  String? doc,
  String? image,
  DocumentReference? docref,
  int? index,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ParentStudentStruct(
      name: name,
      dob: dob,
      bloodgrp: bloodgrp,
      gender: gender,
      allergy: allergy,
      address: address,
      doc: doc,
      image: image,
      docref: docref,
      index: index,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ParentStudentStruct? updateParentStudentStruct(
  ParentStudentStruct? parentStudent, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    parentStudent
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addParentStudentStructData(
  Map<String, dynamic> firestoreData,
  ParentStudentStruct? parentStudent,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (parentStudent == null) {
    return;
  }
  if (parentStudent.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && parentStudent.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final parentStudentData =
      getParentStudentFirestoreData(parentStudent, forFieldValue);
  final nestedData =
      parentStudentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = parentStudent.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getParentStudentFirestoreData(
  ParentStudentStruct? parentStudent, [
  bool forFieldValue = false,
]) {
  if (parentStudent == null) {
    return {};
  }
  final firestoreData = mapToFirestore(parentStudent.toMap());

  // Add any Firestore field values
  parentStudent.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getParentStudentListFirestoreData(
  List<ParentStudentStruct>? parentStudents,
) =>
    parentStudents
        ?.map((e) => getParentStudentFirestoreData(e, true))
        .toList() ??
    [];
