import 'dart:async';

import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "user_role" field.
  int? _userRole;
  int get userRole => _userRole ?? 0;
  bool hasUserRole() => _userRole != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "ListofSchool" field.
  List<DocumentReference>? _listofSchool;
  List<DocumentReference> get listofSchool => _listofSchool ?? const [];
  bool hasListofSchool() => _listofSchool != null;

  // "relation" field.
  String? _relation;
  String get relation => _relation ?? '';
  bool hasRelation() => _relation != null;

  // "subscriptionStatus" field.
  int? _subscriptionStatus;
  int get subscriptionStatus => _subscriptionStatus ?? 0;
  bool hasSubscriptionStatus() => _subscriptionStatus != null;

  // "subscriptionstartDate" field.
  DateTime? _subscriptionstartDate;
  DateTime? get subscriptionstartDate => _subscriptionstartDate;
  bool hasSubscriptionstartDate() => _subscriptionstartDate != null;

  // "subcriptiondetails" field.
  SubscribtionDetailsStruct? _subcriptiondetails;
  SubscribtionDetailsStruct get subcriptiondetails =>
      _subcriptiondetails ?? SubscribtionDetailsStruct();
  bool hasSubcriptiondetails() => _subcriptiondetails != null;

  // "checkin" field.
  DateTime? _checkin;
  DateTime? get checkin => _checkin;
  bool hasCheckin() => _checkin != null;

  // "notifications" field.
  List<NotificationStruct>? _notifications;
  List<NotificationStruct> get notifications => _notifications ?? const [];
  bool hasNotifications() => _notifications != null;

  // "document" field.
  String? _document;
  String get document => _document ?? '';
  bool hasDocument() => _document != null;

  // "IsNew" field.
  bool? _isNew;
  bool get isNew => _isNew ?? false;
  bool hasIsNew() => _isNew != null;

  // "popupdate" field.
  DateTime? _popupdate;
  DateTime? get popupdate => _popupdate;
  bool hasPopupdate() => _popupdate != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _userRole = castToType<int>(snapshotData['user_role']);
    _address = snapshotData['address'] as String?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _listofSchool = getDataList(snapshotData['ListofSchool']);
    _relation = snapshotData['relation'] as String?;
    _subscriptionStatus = castToType<int>(snapshotData['subscriptionStatus']);
    _subscriptionstartDate = snapshotData['subscriptionstartDate'] as DateTime?;
    _subcriptiondetails =
        snapshotData['subcriptiondetails'] is SubscribtionDetailsStruct
            ? snapshotData['subcriptiondetails']
            : SubscribtionDetailsStruct.maybeFromMap(
                snapshotData['subcriptiondetails']);
    _checkin = snapshotData['checkin'] as DateTime?;
    _notifications = getStructList(
      snapshotData['notifications'],
      NotificationStruct.fromMap,
    );
    _document = snapshotData['document'] as String?;
    _isNew = snapshotData['IsNew'] as bool?;
    _popupdate = snapshotData['popupdate'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  static UsersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      UsersRecord.getDocumentFromData(
        {
          'email': snapshot.data['email'],
          'display_name': snapshot.data['display_name'],
          'photo_url': snapshot.data['photo_url'],
          'uid': snapshot.data['uid'],
          'phone_number': snapshot.data['phone_number'],
          'user_role': convertAlgoliaParam(
            snapshot.data['user_role'],
            ParamType.int,
            false,
          ),
          'address': snapshot.data['address'],
          'updatedAt': convertAlgoliaParam(
            snapshot.data['updatedAt'],
            ParamType.DateTime,
            false,
          ),
          'created_time': convertAlgoliaParam(
            snapshot.data['created_time'],
            ParamType.DateTime,
            false,
          ),
          'ListofSchool': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['ListofSchool'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'relation': snapshot.data['relation'],
          'subscriptionStatus': convertAlgoliaParam(
            snapshot.data['subscriptionStatus'],
            ParamType.int,
            false,
          ),
          'subscriptionstartDate': convertAlgoliaParam(
            snapshot.data['subscriptionstartDate'],
            ParamType.DateTime,
            false,
          ),
          'subcriptiondetails': SubscribtionDetailsStruct.fromAlgoliaData(
                  snapshot.data['subcriptiondetails'] ?? {})
              .toMap(),
          'checkin': convertAlgoliaParam(
            snapshot.data['checkin'],
            ParamType.DateTime,
            false,
          ),
          'notifications': safeGet(
            () => (snapshot.data['notifications'] as Iterable)
                .map((d) => NotificationStruct.fromAlgoliaData(d).toMap())
                .toList(),
          ),
          'document': snapshot.data['document'],
          'IsNew': snapshot.data['IsNew'],
          'popupdate': convertAlgoliaParam(
            snapshot.data['popupdate'],
            ParamType.DateTime,
            false,
          ),
        },
        UsersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<UsersRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Users',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
  int? userRole,
  String? address,
  DateTime? updatedAt,
  DateTime? createdTime,
  String? relation,
  int? subscriptionStatus,
  DateTime? subscriptionstartDate,
  SubscribtionDetailsStruct? subcriptiondetails,
  DateTime? checkin,
  String? document,
  bool? isNew,
  DateTime? popupdate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
      'user_role': userRole,
      'address': address,
      'updatedAt': updatedAt,
      'created_time': createdTime,
      'relation': relation,
      'subscriptionStatus': subscriptionStatus,
      'subscriptionstartDate': subscriptionstartDate,
      'subcriptiondetails': SubscribtionDetailsStruct().toMap(),
      'checkin': checkin,
      'document': document,
      'IsNew': isNew,
      'popupdate': popupdate,
    }.withoutNulls,
  );

  // Handle nested data for "subcriptiondetails" field.
  addSubscribtionDetailsStructData(
      firestoreData, subcriptiondetails, 'subcriptiondetails');

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.userRole == e2?.userRole &&
        e1?.address == e2?.address &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.createdTime == e2?.createdTime &&
        listEquality.equals(e1?.listofSchool, e2?.listofSchool) &&
        e1?.relation == e2?.relation &&
        e1?.subscriptionStatus == e2?.subscriptionStatus &&
        e1?.subscriptionstartDate == e2?.subscriptionstartDate &&
        e1?.subcriptiondetails == e2?.subcriptiondetails &&
        e1?.checkin == e2?.checkin &&
        listEquality.equals(e1?.notifications, e2?.notifications) &&
        e1?.document == e2?.document &&
        e1?.isNew == e2?.isNew &&
        e1?.popupdate == e2?.popupdate;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.phoneNumber,
        e?.userRole,
        e?.address,
        e?.updatedAt,
        e?.createdTime,
        e?.listofSchool,
        e?.relation,
        e?.subscriptionStatus,
        e?.subscriptionstartDate,
        e?.subcriptiondetails,
        e?.checkin,
        e?.notifications,
        e?.document,
        e?.isNew,
        e?.popupdate
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
