// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StudentListStruct extends FFFirebaseStruct {
  StudentListStruct({
    String? studentName,
    DocumentReference? studentId,
    String? studentImage,
    List<DocumentReference>? parentList,
    bool? isAddedinClass,
    List<DocumentReference>? classref,
    bool? isDraft,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _studentName = studentName,
        _studentId = studentId,
        _studentImage = studentImage,
        _parentList = parentList,
        _isAddedinClass = isAddedinClass,
        _classref = classref,
        _isDraft = isDraft,
        super(firestoreUtilData);

  // "Student_name" field.
  String? _studentName;
  String get studentName => _studentName ?? '';
  set studentName(String? val) => _studentName = val;

  bool hasStudentName() => _studentName != null;

  // "Student_id" field.
  DocumentReference? _studentId;
  DocumentReference? get studentId => _studentId;
  set studentId(DocumentReference? val) => _studentId = val;

  bool hasStudentId() => _studentId != null;

  // "student_image" field.
  String? _studentImage;
  String get studentImage => _studentImage ?? '';
  set studentImage(String? val) => _studentImage = val;

  bool hasStudentImage() => _studentImage != null;

  // "parent_list" field.
  List<DocumentReference>? _parentList;
  List<DocumentReference> get parentList => _parentList ?? const [];
  set parentList(List<DocumentReference>? val) => _parentList = val;

  void updateParentList(Function(List<DocumentReference>) updateFn) {
    updateFn(_parentList ??= []);
  }

  bool hasParentList() => _parentList != null;

  // "isAddedinClass" field.
  bool? _isAddedinClass;
  bool get isAddedinClass => _isAddedinClass ?? false;
  set isAddedinClass(bool? val) => _isAddedinClass = val;

  bool hasIsAddedinClass() => _isAddedinClass != null;

  // "classref" field.
  List<DocumentReference>? _classref;
  List<DocumentReference> get classref => _classref ?? const [];
  set classref(List<DocumentReference>? val) => _classref = val;

  void updateClassref(Function(List<DocumentReference>) updateFn) {
    updateFn(_classref ??= []);
  }

  bool hasClassref() => _classref != null;

  // "isDraft" field.
  bool? _isDraft;
  bool get isDraft => _isDraft ?? false;
  set isDraft(bool? val) => _isDraft = val;

  bool hasIsDraft() => _isDraft != null;

  static StudentListStruct fromMap(Map<String, dynamic> data) =>
      StudentListStruct(
        studentName: data['Student_name'] as String?,
        studentId: data['Student_id'] as DocumentReference?,
        studentImage: data['student_image'] as String?,
        parentList: getDataList(data['parent_list']),
        isAddedinClass: data['isAddedinClass'] as bool?,
        classref: getDataList(data['classref']),
        isDraft: data['isDraft'] as bool?,
      );

  static StudentListStruct? maybeFromMap(dynamic data) => data is Map
      ? StudentListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Student_name': _studentName,
        'Student_id': _studentId,
        'student_image': _studentImage,
        'parent_list': _parentList,
        'isAddedinClass': _isAddedinClass,
        'classref': _classref,
        'isDraft': _isDraft,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Student_name': serializeParam(
          _studentName,
          ParamType.String,
        ),
        'Student_id': serializeParam(
          _studentId,
          ParamType.DocumentReference,
        ),
        'student_image': serializeParam(
          _studentImage,
          ParamType.String,
        ),
        'parent_list': serializeParam(
          _parentList,
          ParamType.DocumentReference,
          isList: true,
        ),
        'isAddedinClass': serializeParam(
          _isAddedinClass,
          ParamType.bool,
        ),
        'classref': serializeParam(
          _classref,
          ParamType.DocumentReference,
          isList: true,
        ),
        'isDraft': serializeParam(
          _isDraft,
          ParamType.bool,
        ),
      }.withoutNulls;

  static StudentListStruct fromSerializableMap(Map<String, dynamic> data) =>
      StudentListStruct(
        studentName: deserializeParam(
          data['Student_name'],
          ParamType.String,
          false,
        ),
        studentId: deserializeParam(
          data['Student_id'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['Students'],
        ),
        studentImage: deserializeParam(
          data['student_image'],
          ParamType.String,
          false,
        ),
        parentList: deserializeParam<DocumentReference>(
          data['parent_list'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['Users'],
        ),
        isAddedinClass: deserializeParam(
          data['isAddedinClass'],
          ParamType.bool,
          false,
        ),
        classref: deserializeParam<DocumentReference>(
          data['classref'],
          ParamType.DocumentReference,
          true,
          collectionNamePath: ['School_class'],
        ),
        isDraft: deserializeParam(
          data['isDraft'],
          ParamType.bool,
          false,
        ),
      );

  static StudentListStruct fromAlgoliaData(Map<String, dynamic> data) =>
      StudentListStruct(
        studentName: convertAlgoliaParam(
          data['Student_name'],
          ParamType.String,
          false,
        ),
        studentId: convertAlgoliaParam(
          data['Student_id'],
          ParamType.DocumentReference,
          false,
        ),
        studentImage: convertAlgoliaParam(
          data['student_image'],
          ParamType.String,
          false,
        ),
        parentList: convertAlgoliaParam<DocumentReference>(
          data['parent_list'],
          ParamType.DocumentReference,
          true,
        ),
        isAddedinClass: convertAlgoliaParam(
          data['isAddedinClass'],
          ParamType.bool,
          false,
        ),
        classref: convertAlgoliaParam<DocumentReference>(
          data['classref'],
          ParamType.DocumentReference,
          true,
        ),
        isDraft: convertAlgoliaParam(
          data['isDraft'],
          ParamType.bool,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'StudentListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is StudentListStruct &&
        studentName == other.studentName &&
        studentId == other.studentId &&
        studentImage == other.studentImage &&
        listEquality.equals(parentList, other.parentList) &&
        isAddedinClass == other.isAddedinClass &&
        listEquality.equals(classref, other.classref) &&
        isDraft == other.isDraft;
  }

  @override
  int get hashCode => const ListEquality().hash([
        studentName,
        studentId,
        studentImage,
        parentList,
        isAddedinClass,
        classref,
        isDraft
      ]);
}

StudentListStruct createStudentListStruct({
  String? studentName,
  DocumentReference? studentId,
  String? studentImage,
  bool? isAddedinClass,
  bool? isDraft,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StudentListStruct(
      studentName: studentName,
      studentId: studentId,
      studentImage: studentImage,
      isAddedinClass: isAddedinClass,
      isDraft: isDraft,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StudentListStruct? updateStudentListStruct(
  StudentListStruct? studentList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    studentList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStudentListStructData(
  Map<String, dynamic> firestoreData,
  StudentListStruct? studentList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (studentList == null) {
    return;
  }
  if (studentList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && studentList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final studentListData =
      getStudentListFirestoreData(studentList, forFieldValue);
  final nestedData =
      studentListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = studentList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStudentListFirestoreData(
  StudentListStruct? studentList, [
  bool forFieldValue = false,
]) {
  if (studentList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(studentList.toMap());

  // Add any Firestore field values
  studentList.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStudentListListFirestoreData(
  List<StudentListStruct>? studentLists,
) =>
    studentLists?.map((e) => getStudentListFirestoreData(e, true)).toList() ??
    [];
