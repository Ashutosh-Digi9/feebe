import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubScriptionRecord extends FirestoreRecord {
  SubScriptionRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "features_list" field.
  List<String>? _featuresList;
  List<String> get featuresList => _featuresList ?? const [];
  bool hasFeaturesList() => _featuresList != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "frequency" field.
  String? _frequency;
  String get frequency => _frequency ?? '';
  bool hasFrequency() => _frequency != null;

  // "subId" field.
  int? _subId;
  int get subId => _subId ?? 0;
  bool hasSubId() => _subId != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _featuresList = getDataList(snapshotData['features_list']);
    _amount = castToType<double>(snapshotData['amount']);
    _frequency = snapshotData['frequency'] as String?;
    _subId = castToType<int>(snapshotData['subId']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subScription');

  static Stream<SubScriptionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubScriptionRecord.fromSnapshot(s));

  static Future<SubScriptionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubScriptionRecord.fromSnapshot(s));

  static SubScriptionRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubScriptionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubScriptionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubScriptionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubScriptionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubScriptionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubScriptionRecordData({
  String? name,
  double? amount,
  String? frequency,
  int? subId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'amount': amount,
      'frequency': frequency,
      'subId': subId,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubScriptionRecordDocumentEquality
    implements Equality<SubScriptionRecord> {
  const SubScriptionRecordDocumentEquality();

  @override
  bool equals(SubScriptionRecord? e1, SubScriptionRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        listEquality.equals(e1?.featuresList, e2?.featuresList) &&
        e1?.amount == e2?.amount &&
        e1?.frequency == e2?.frequency &&
        e1?.subId == e2?.subId;
  }

  @override
  int hash(SubScriptionRecord? e) => const ListEquality()
      .hash([e?.name, e?.featuresList, e?.amount, e?.frequency, e?.subId]);

  @override
  bool isValidKey(Object? o) => o is SubScriptionRecord;
}
