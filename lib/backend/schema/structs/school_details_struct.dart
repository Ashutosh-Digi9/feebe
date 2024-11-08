// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class SchoolDetailsStruct extends FFFirebaseStruct {
  SchoolDetailsStruct({
    int? schoolId,
    String? schoolName,
    String? address,
    int? noOfStudents,
    int? noOfFaculties,
    int? noOfBranches,
    String? schoolImage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _schoolId = schoolId,
        _schoolName = schoolName,
        _address = address,
        _noOfStudents = noOfStudents,
        _noOfFaculties = noOfFaculties,
        _noOfBranches = noOfBranches,
        _schoolImage = schoolImage,
        super(firestoreUtilData);

  // "school_id" field.
  int? _schoolId;
  int get schoolId => _schoolId ?? 0;
  set schoolId(int? val) => _schoolId = val;

  void incrementSchoolId(int amount) => schoolId = schoolId + amount;

  bool hasSchoolId() => _schoolId != null;

  // "school_name" field.
  String? _schoolName;
  String get schoolName => _schoolName ?? '';
  set schoolName(String? val) => _schoolName = val;

  bool hasSchoolName() => _schoolName != null;

  // "Address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  // "no_of_students" field.
  int? _noOfStudents;
  int get noOfStudents => _noOfStudents ?? 0;
  set noOfStudents(int? val) => _noOfStudents = val;

  void incrementNoOfStudents(int amount) =>
      noOfStudents = noOfStudents + amount;

  bool hasNoOfStudents() => _noOfStudents != null;

  // "no_of_faculties" field.
  int? _noOfFaculties;
  int get noOfFaculties => _noOfFaculties ?? 0;
  set noOfFaculties(int? val) => _noOfFaculties = val;

  void incrementNoOfFaculties(int amount) =>
      noOfFaculties = noOfFaculties + amount;

  bool hasNoOfFaculties() => _noOfFaculties != null;

  // "no_of_branches" field.
  int? _noOfBranches;
  int get noOfBranches => _noOfBranches ?? 0;
  set noOfBranches(int? val) => _noOfBranches = val;

  void incrementNoOfBranches(int amount) =>
      noOfBranches = noOfBranches + amount;

  bool hasNoOfBranches() => _noOfBranches != null;

  // "school_image" field.
  String? _schoolImage;
  String get schoolImage => _schoolImage ?? '';
  set schoolImage(String? val) => _schoolImage = val;

  bool hasSchoolImage() => _schoolImage != null;

  static SchoolDetailsStruct fromMap(Map<String, dynamic> data) =>
      SchoolDetailsStruct(
        schoolId: castToType<int>(data['school_id']),
        schoolName: data['school_name'] as String?,
        address: data['Address'] as String?,
        noOfStudents: castToType<int>(data['no_of_students']),
        noOfFaculties: castToType<int>(data['no_of_faculties']),
        noOfBranches: castToType<int>(data['no_of_branches']),
        schoolImage: data['school_image'] as String?,
      );

  static SchoolDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? SchoolDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'school_id': _schoolId,
        'school_name': _schoolName,
        'Address': _address,
        'no_of_students': _noOfStudents,
        'no_of_faculties': _noOfFaculties,
        'no_of_branches': _noOfBranches,
        'school_image': _schoolImage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'school_id': serializeParam(
          _schoolId,
          ParamType.int,
        ),
        'school_name': serializeParam(
          _schoolName,
          ParamType.String,
        ),
        'Address': serializeParam(
          _address,
          ParamType.String,
        ),
        'no_of_students': serializeParam(
          _noOfStudents,
          ParamType.int,
        ),
        'no_of_faculties': serializeParam(
          _noOfFaculties,
          ParamType.int,
        ),
        'no_of_branches': serializeParam(
          _noOfBranches,
          ParamType.int,
        ),
        'school_image': serializeParam(
          _schoolImage,
          ParamType.String,
        ),
      }.withoutNulls;

  static SchoolDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      SchoolDetailsStruct(
        schoolId: deserializeParam(
          data['school_id'],
          ParamType.int,
          false,
        ),
        schoolName: deserializeParam(
          data['school_name'],
          ParamType.String,
          false,
        ),
        address: deserializeParam(
          data['Address'],
          ParamType.String,
          false,
        ),
        noOfStudents: deserializeParam(
          data['no_of_students'],
          ParamType.int,
          false,
        ),
        noOfFaculties: deserializeParam(
          data['no_of_faculties'],
          ParamType.int,
          false,
        ),
        noOfBranches: deserializeParam(
          data['no_of_branches'],
          ParamType.int,
          false,
        ),
        schoolImage: deserializeParam(
          data['school_image'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SchoolDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SchoolDetailsStruct &&
        schoolId == other.schoolId &&
        schoolName == other.schoolName &&
        address == other.address &&
        noOfStudents == other.noOfStudents &&
        noOfFaculties == other.noOfFaculties &&
        noOfBranches == other.noOfBranches &&
        schoolImage == other.schoolImage;
  }

  @override
  int get hashCode => const ListEquality().hash([
        schoolId,
        schoolName,
        address,
        noOfStudents,
        noOfFaculties,
        noOfBranches,
        schoolImage
      ]);
}

SchoolDetailsStruct createSchoolDetailsStruct({
  int? schoolId,
  String? schoolName,
  String? address,
  int? noOfStudents,
  int? noOfFaculties,
  int? noOfBranches,
  String? schoolImage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SchoolDetailsStruct(
      schoolId: schoolId,
      schoolName: schoolName,
      address: address,
      noOfStudents: noOfStudents,
      noOfFaculties: noOfFaculties,
      noOfBranches: noOfBranches,
      schoolImage: schoolImage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SchoolDetailsStruct? updateSchoolDetailsStruct(
  SchoolDetailsStruct? schoolDetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    schoolDetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSchoolDetailsStructData(
  Map<String, dynamic> firestoreData,
  SchoolDetailsStruct? schoolDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (schoolDetails == null) {
    return;
  }
  if (schoolDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && schoolDetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final schoolDetailsData =
      getSchoolDetailsFirestoreData(schoolDetails, forFieldValue);
  final nestedData =
      schoolDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = schoolDetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSchoolDetailsFirestoreData(
  SchoolDetailsStruct? schoolDetails, [
  bool forFieldValue = false,
]) {
  if (schoolDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(schoolDetails.toMap());

  // Add any Firestore field values
  schoolDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSchoolDetailsListFirestoreData(
  List<SchoolDetailsStruct>? schoolDetailss,
) =>
    schoolDetailss
        ?.map((e) => getSchoolDetailsFirestoreData(e, true))
        .toList() ??
    [];
