// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SchoolDetailsStruct extends FFFirebaseStruct {
  SchoolDetailsStruct({
    int? schoolId,
    String? schoolName,
    String? address,
    String? pincode,
    String? city,
    String? state,
    int? noOfStudents,
    int? noOfFaculties,
    int? noOfBranches,
    String? schoolImage,
    List<DocumentReference>? listOfclasses,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _schoolId = schoolId,
        _schoolName = schoolName,
        _address = address,
        _pincode = pincode,
        _city = city,
        _state = state,
        _noOfStudents = noOfStudents,
        _noOfFaculties = noOfFaculties,
        _noOfBranches = noOfBranches,
        _schoolImage = schoolImage,
        _listOfclasses = listOfclasses,
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

  // "pincode" field.
  String? _pincode;
  String get pincode => _pincode ?? '';
  set pincode(String? val) => _pincode = val;

  bool hasPincode() => _pincode != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  set state(String? val) => _state = val;

  bool hasState() => _state != null;

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

  // "ListOfclasses" field.
  List<DocumentReference>? _listOfclasses;
  List<DocumentReference> get listOfclasses => _listOfclasses ?? const [];
  set listOfclasses(List<DocumentReference>? val) => _listOfclasses = val;

  void updateListOfclasses(Function(List<DocumentReference>) updateFn) {
    updateFn(_listOfclasses ??= []);
  }

  bool hasListOfclasses() => _listOfclasses != null;

  static SchoolDetailsStruct fromMap(Map<String, dynamic> data) =>
      SchoolDetailsStruct(
        schoolId: castToType<int>(data['school_id']),
        schoolName: data['school_name'] as String?,
        address: data['Address'] as String?,
        pincode: data['pincode'] as String?,
        city: data['city'] as String?,
        state: data['state'] as String?,
        noOfStudents: castToType<int>(data['no_of_students']),
        noOfFaculties: castToType<int>(data['no_of_faculties']),
        noOfBranches: castToType<int>(data['no_of_branches']),
        schoolImage: data['school_image'] as String?,
        listOfclasses: getDataList(data['ListOfclasses']),
      );

  static SchoolDetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? SchoolDetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'school_id': _schoolId,
        'school_name': _schoolName,
        'Address': _address,
        'pincode': _pincode,
        'city': _city,
        'state': _state,
        'no_of_students': _noOfStudents,
        'no_of_faculties': _noOfFaculties,
        'no_of_branches': _noOfBranches,
        'school_image': _schoolImage,
        'ListOfclasses': _listOfclasses,
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
        'pincode': serializeParam(
          _pincode,
          ParamType.String,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'state': serializeParam(
          _state,
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
        'ListOfclasses': serializeParam(
          _listOfclasses,
          ParamType.DocumentReference,
          isList: true,
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
        pincode: deserializeParam(
          data['pincode'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        state: deserializeParam(
          data['state'],
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
        listOfclasses: deserializeParam<DocumentReference>(
          data['ListOfclasses'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['School_class'],
        ),
      );

  static SchoolDetailsStruct fromAlgoliaData(Map<String, dynamic> data) =>
      SchoolDetailsStruct(
        schoolId: convertAlgoliaParam(
          data['school_id'],
          ParamType.int,
          false,
        ),
        schoolName: convertAlgoliaParam(
          data['school_name'],
          ParamType.String,
          false,
        ),
        address: convertAlgoliaParam(
          data['Address'],
          ParamType.String,
          false,
        ),
        pincode: convertAlgoliaParam(
          data['pincode'],
          ParamType.String,
          false,
        ),
        city: convertAlgoliaParam(
          data['city'],
          ParamType.String,
          false,
        ),
        state: convertAlgoliaParam(
          data['state'],
          ParamType.String,
          false,
        ),
        noOfStudents: convertAlgoliaParam(
          data['no_of_students'],
          ParamType.int,
          false,
        ),
        noOfFaculties: convertAlgoliaParam(
          data['no_of_faculties'],
          ParamType.int,
          false,
        ),
        noOfBranches: convertAlgoliaParam(
          data['no_of_branches'],
          ParamType.int,
          false,
        ),
        schoolImage: convertAlgoliaParam(
          data['school_image'],
          ParamType.String,
          false,
        ),
        listOfclasses: convertAlgoliaParam<DocumentReference>(
          data['ListOfclasses'],
          ParamType.DocumentReference,
          true,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'SchoolDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SchoolDetailsStruct &&
        schoolId == other.schoolId &&
        schoolName == other.schoolName &&
        address == other.address &&
        pincode == other.pincode &&
        city == other.city &&
        state == other.state &&
        noOfStudents == other.noOfStudents &&
        noOfFaculties == other.noOfFaculties &&
        noOfBranches == other.noOfBranches &&
        schoolImage == other.schoolImage &&
        listEquality.equals(listOfclasses, other.listOfclasses);
  }

  @override
  int get hashCode => const ListEquality().hash([
        schoolId,
        schoolName,
        address,
        pincode,
        city,
        state,
        noOfStudents,
        noOfFaculties,
        noOfBranches,
        schoolImage,
        listOfclasses
      ]);
}

SchoolDetailsStruct createSchoolDetailsStruct({
  int? schoolId,
  String? schoolName,
  String? address,
  String? pincode,
  String? city,
  String? state,
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
      pincode: pincode,
      city: city,
      state: state,
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
