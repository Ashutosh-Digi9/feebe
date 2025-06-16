import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TeachersRecord extends FirestoreRecord {
  TeachersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "teacher_name" field.
  String? _teacherName;
  String get teacherName => _teacherName ?? '';
  bool hasTeacherName() => _teacherName != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "email_id" field.
  String? _emailId;
  String get emailId => _emailId ?? '';
  bool hasEmailId() => _emailId != null;

  // "teacher_attendance" field.
  List<TeachersAttendanceStruct>? _teacherAttendance;
  List<TeachersAttendanceStruct> get teacherAttendance =>
      _teacherAttendance ?? const [];
  bool hasTeacherAttendance() => _teacherAttendance != null;

  // "teacher_timeline" field.
  List<TeachersTimelineStruct>? _teacherTimeline;
  List<TeachersTimelineStruct> get teacherTimeline =>
      _teacherTimeline ?? const [];
  bool hasTeacherTimeline() => _teacherTimeline != null;

  // "Uploaded_pictures" field.
  List<String>? _uploadedPictures;
  List<String> get uploadedPictures => _uploadedPictures ?? const [];
  bool hasUploadedPictures() => _uploadedPictures != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "teacher_image" field.
  String? _teacherImage;
  String get teacherImage => _teacherImage ?? '';
  bool hasTeacherImage() => _teacherImage != null;

  // "useref" field.
  DocumentReference? _useref;
  DocumentReference? get useref => _useref;
  bool hasUseref() => _useref != null;

  // "notices" field.
  List<EventsNoticeStruct>? _notices;
  List<EventsNoticeStruct> get notices => _notices ?? const [];
  bool hasNotices() => _notices != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "checkin" field.
  DateTime? _checkin;
  DateTime? get checkin => _checkin;
  bool hasCheckin() => _checkin != null;

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  bool hasPath() => _path != null;

  // "timelinevideo" field.
  List<String>? _timelinevideo;
  List<String> get timelinevideo => _timelinevideo ?? const [];
  bool hasTimelinevideo() => _timelinevideo != null;

  // "isemail" field.
  bool? _isemail;
  bool get isemail => _isemail ?? false;
  bool hasIsemail() => _isemail != null;

  void _initializeFields() {
    _teacherName = snapshotData['teacher_name'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _emailId = snapshotData['email_id'] as String?;
    _teacherAttendance = getStructList(
      snapshotData['teacher_attendance'],
      TeachersAttendanceStruct.fromMap,
    );
    _teacherTimeline = getStructList(
      snapshotData['teacher_timeline'],
      TeachersTimelineStruct.fromMap,
    );
    _uploadedPictures = getDataList(snapshotData['Uploaded_pictures']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _teacherImage = snapshotData['teacher_image'] as String?;
    _useref = snapshotData['useref'] as DocumentReference?;
    _notices = getStructList(
      snapshotData['notices'],
      EventsNoticeStruct.fromMap,
    );
    _images = getDataList(snapshotData['images']);
    _checkin = snapshotData['checkin'] as DateTime?;
    _path = snapshotData['path'] as String?;
    _timelinevideo = getDataList(snapshotData['timelinevideo']);
    _isemail = snapshotData['isemail'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Teachers');

  static Stream<TeachersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TeachersRecord.fromSnapshot(s));

  static Future<TeachersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TeachersRecord.fromSnapshot(s));

  static TeachersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TeachersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TeachersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TeachersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TeachersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TeachersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTeachersRecordData({
  String? teacherName,
  String? phoneNumber,
  String? emailId,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? teacherImage,
  DocumentReference? useref,
  DateTime? checkin,
  String? path,
  bool? isemail,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'teacher_name': teacherName,
      'phone_number': phoneNumber,
      'email_id': emailId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'teacher_image': teacherImage,
      'useref': useref,
      'checkin': checkin,
      'path': path,
      'isemail': isemail,
    }.withoutNulls,
  );

  return firestoreData;
}

class TeachersRecordDocumentEquality implements Equality<TeachersRecord> {
  const TeachersRecordDocumentEquality();

  @override
  bool equals(TeachersRecord? e1, TeachersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.teacherName == e2?.teacherName &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.emailId == e2?.emailId &&
        listEquality.equals(e1?.teacherAttendance, e2?.teacherAttendance) &&
        listEquality.equals(e1?.teacherTimeline, e2?.teacherTimeline) &&
        listEquality.equals(e1?.uploadedPictures, e2?.uploadedPictures) &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.teacherImage == e2?.teacherImage &&
        e1?.useref == e2?.useref &&
        listEquality.equals(e1?.notices, e2?.notices) &&
        listEquality.equals(e1?.images, e2?.images) &&
        e1?.checkin == e2?.checkin &&
        e1?.path == e2?.path &&
        listEquality.equals(e1?.timelinevideo, e2?.timelinevideo) &&
        e1?.isemail == e2?.isemail;
  }

  @override
  int hash(TeachersRecord? e) => const ListEquality().hash([
        e?.teacherName,
        e?.phoneNumber,
        e?.emailId,
        e?.teacherAttendance,
        e?.teacherTimeline,
        e?.uploadedPictures,
        e?.createdAt,
        e?.updatedAt,
        e?.teacherImage,
        e?.useref,
        e?.notices,
        e?.images,
        e?.checkin,
        e?.path,
        e?.timelinevideo,
        e?.isemail
      ]);

  @override
  bool isValidKey(Object? o) => o is TeachersRecord;
}
