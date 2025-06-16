import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DeleteaccountRecord extends FirestoreRecord {
  DeleteaccountRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Rejection" field.
  String? _rejection;
  String get rejection => _rejection ?? '';
  bool hasRejection() => _rejection != null;

  // "Time" field.
  DateTime? _time;
  DateTime? get time => _time;
  bool hasTime() => _time != null;

  // "useref" field.
  DocumentReference? _useref;
  DocumentReference? get useref => _useref;
  bool hasUseref() => _useref != null;

  void _initializeFields() {
    _rejection = snapshotData['Rejection'] as String?;
    _time = snapshotData['Time'] as DateTime?;
    _useref = snapshotData['useref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Deleteaccount');

  static Stream<DeleteaccountRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DeleteaccountRecord.fromSnapshot(s));

  static Future<DeleteaccountRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DeleteaccountRecord.fromSnapshot(s));

  static DeleteaccountRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DeleteaccountRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DeleteaccountRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DeleteaccountRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DeleteaccountRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DeleteaccountRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDeleteaccountRecordData({
  String? rejection,
  DateTime? time,
  DocumentReference? useref,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Rejection': rejection,
      'Time': time,
      'useref': useref,
    }.withoutNulls,
  );

  return firestoreData;
}

class DeleteaccountRecordDocumentEquality
    implements Equality<DeleteaccountRecord> {
  const DeleteaccountRecordDocumentEquality();

  @override
  bool equals(DeleteaccountRecord? e1, DeleteaccountRecord? e2) {
    return e1?.rejection == e2?.rejection &&
        e1?.time == e2?.time &&
        e1?.useref == e2?.useref;
  }

  @override
  int hash(DeleteaccountRecord? e) =>
      const ListEquality().hash([e?.rejection, e?.time, e?.useref]);

  @override
  bool isValidKey(Object? o) => o is DeleteaccountRecord;
}
