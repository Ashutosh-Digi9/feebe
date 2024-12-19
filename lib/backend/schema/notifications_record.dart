import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsRecord extends FirestoreRecord {
  NotificationsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  bool hasContent() => _content != null;

  // "schoolref" field.
  List<DocumentReference>? _schoolref;
  List<DocumentReference> get schoolref => _schoolref ?? const [];
  bool hasSchoolref() => _schoolref != null;

  // "Descri" field.
  String? _descri;
  String get descri => _descri ?? '';
  bool hasDescri() => _descri != null;

  // "datetimeofevent" field.
  DateTime? _datetimeofevent;
  DateTime? get datetimeofevent => _datetimeofevent;
  bool hasDatetimeofevent() => _datetimeofevent != null;

  // "isread" field.
  bool? _isread;
  bool get isread => _isread ?? false;
  bool hasIsread() => _isread != null;

  // "notification" field.
  NotificationStruct? _notification;
  NotificationStruct get notification => _notification ?? NotificationStruct();
  bool hasNotification() => _notification != null;

  // "createDate" field.
  DateTime? _createDate;
  DateTime? get createDate => _createDate;
  bool hasCreateDate() => _createDate != null;

  // "tag" field.
  String? _tag;
  String get tag => _tag ?? '';
  bool hasTag() => _tag != null;

  // "userref" field.
  List<DocumentReference>? _userref;
  List<DocumentReference> get userref => _userref ?? const [];
  bool hasUserref() => _userref != null;

  // "ReadUseref" field.
  List<DocumentReference>? _readUseref;
  List<DocumentReference> get readUseref => _readUseref ?? const [];
  bool hasReadUseref() => _readUseref != null;

  void _initializeFields() {
    _content = snapshotData['content'] as String?;
    _schoolref = getDataList(snapshotData['schoolref']);
    _descri = snapshotData['Descri'] as String?;
    _datetimeofevent = snapshotData['datetimeofevent'] as DateTime?;
    _isread = snapshotData['isread'] as bool?;
    _notification = snapshotData['notification'] is NotificationStruct
        ? snapshotData['notification']
        : NotificationStruct.maybeFromMap(snapshotData['notification']);
    _createDate = snapshotData['createDate'] as DateTime?;
    _tag = snapshotData['tag'] as String?;
    _userref = getDataList(snapshotData['userref']);
    _readUseref = getDataList(snapshotData['ReadUseref']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Notifications');

  static Stream<NotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationsRecord.fromSnapshot(s));

  static Future<NotificationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificationsRecord.fromSnapshot(s));

  static NotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationsRecordData({
  String? content,
  String? descri,
  DateTime? datetimeofevent,
  bool? isread,
  NotificationStruct? notification,
  DateTime? createDate,
  String? tag,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'content': content,
      'Descri': descri,
      'datetimeofevent': datetimeofevent,
      'isread': isread,
      'notification': NotificationStruct().toMap(),
      'createDate': createDate,
      'tag': tag,
    }.withoutNulls,
  );

  // Handle nested data for "notification" field.
  addNotificationStructData(firestoreData, notification, 'notification');

  return firestoreData;
}

class NotificationsRecordDocumentEquality
    implements Equality<NotificationsRecord> {
  const NotificationsRecordDocumentEquality();

  @override
  bool equals(NotificationsRecord? e1, NotificationsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.content == e2?.content &&
        listEquality.equals(e1?.schoolref, e2?.schoolref) &&
        e1?.descri == e2?.descri &&
        e1?.datetimeofevent == e2?.datetimeofevent &&
        e1?.isread == e2?.isread &&
        e1?.notification == e2?.notification &&
        e1?.createDate == e2?.createDate &&
        e1?.tag == e2?.tag &&
        listEquality.equals(e1?.userref, e2?.userref) &&
        listEquality.equals(e1?.readUseref, e2?.readUseref);
  }

  @override
  int hash(NotificationsRecord? e) => const ListEquality().hash([
        e?.content,
        e?.schoolref,
        e?.descri,
        e?.datetimeofevent,
        e?.isread,
        e?.notification,
        e?.createDate,
        e?.tag,
        e?.userref,
        e?.readUseref
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationsRecord;
}
