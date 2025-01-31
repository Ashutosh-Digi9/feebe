import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _recentsearchitem = prefs
              .getStringList('ff_recentsearchitem')
              ?.map((x) {
                try {
                  return SearchitemsStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _recentsearchitem;
    });
    _safeInit(() {
      _recentSearchAdmin = prefs
              .getStringList('ff_recentSearchAdmin')
              ?.map((x) {
                try {
                  return RecentsearchAdminStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _recentSearchAdmin;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_checkin')) {
        try {
          final serializedData = prefs.getString('ff_checkin') ?? '{}';
          _checkin =
              CheckinStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _checkout = prefs.containsKey('ff_checkout')
          ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('ff_checkout')!)
          : _checkout;
    });
    _safeInit(() {
      _superadminref =
          prefs.getString('ff_superadminref')?.ref ?? _superadminref;
    });
    _safeInit(() {
      _currentdate = prefs.containsKey('ff_currentdate')
          ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('ff_currentdate')!)
          : _currentdate;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _imageurl =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
  String get imageurl => _imageurl;
  set imageurl(String value) {
    _imageurl = value;
  }

  bool _profileimagechanged = false;
  bool get profileimagechanged => _profileimagechanged;
  set profileimagechanged(bool value) {
    _profileimagechanged = value;
  }

  String _schoolimage =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
  String get schoolimage => _schoolimage;
  set schoolimage(String value) {
    _schoolimage = value;
  }

  bool _schoolimagechanged = false;
  bool get schoolimagechanged => _schoolimagechanged;
  set schoolimagechanged(bool value) {
    _schoolimagechanged = value;
  }

  List<SearchitemsStruct> _recentsearchitem = [];
  List<SearchitemsStruct> get recentsearchitem => _recentsearchitem;
  set recentsearchitem(List<SearchitemsStruct> value) {
    _recentsearchitem = value;
    prefs.setStringList(
        'ff_recentsearchitem', value.map((x) => x.serialize()).toList());
  }

  void addToRecentsearchitem(SearchitemsStruct value) {
    recentsearchitem.add(value);
    prefs.setStringList('ff_recentsearchitem',
        _recentsearchitem.map((x) => x.serialize()).toList());
  }

  void removeFromRecentsearchitem(SearchitemsStruct value) {
    recentsearchitem.remove(value);
    prefs.setStringList('ff_recentsearchitem',
        _recentsearchitem.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromRecentsearchitem(int index) {
    recentsearchitem.removeAt(index);
    prefs.setStringList('ff_recentsearchitem',
        _recentsearchitem.map((x) => x.serialize()).toList());
  }

  void updateRecentsearchitemAtIndex(
    int index,
    SearchitemsStruct Function(SearchitemsStruct) updateFn,
  ) {
    recentsearchitem[index] = updateFn(_recentsearchitem[index]);
    prefs.setStringList('ff_recentsearchitem',
        _recentsearchitem.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInRecentsearchitem(int index, SearchitemsStruct value) {
    recentsearchitem.insert(index, value);
    prefs.setStringList('ff_recentsearchitem',
        _recentsearchitem.map((x) => x.serialize()).toList());
  }

  List<DocumentReference> _SelectedTeachers = [];
  List<DocumentReference> get SelectedTeachers => _SelectedTeachers;
  set SelectedTeachers(List<DocumentReference> value) {
    _SelectedTeachers = value;
  }

  void addToSelectedTeachers(DocumentReference value) {
    SelectedTeachers.add(value);
  }

  void removeFromSelectedTeachers(DocumentReference value) {
    SelectedTeachers.remove(value);
  }

  void removeAtIndexFromSelectedTeachers(int index) {
    SelectedTeachers.removeAt(index);
  }

  void updateSelectedTeachersAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    SelectedTeachers[index] = updateFn(_SelectedTeachers[index]);
  }

  void insertAtIndexInSelectedTeachers(int index, DocumentReference value) {
    SelectedTeachers.insert(index, value);
  }

  List<DocumentReference> _selectedstudents = [];
  List<DocumentReference> get selectedstudents => _selectedstudents;
  set selectedstudents(List<DocumentReference> value) {
    _selectedstudents = value;
  }

  void addToSelectedstudents(DocumentReference value) {
    selectedstudents.add(value);
  }

  void removeFromSelectedstudents(DocumentReference value) {
    selectedstudents.remove(value);
  }

  void removeAtIndexFromSelectedstudents(int index) {
    selectedstudents.removeAt(index);
  }

  void updateSelectedstudentsAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    selectedstudents[index] = updateFn(_selectedstudents[index]);
  }

  void insertAtIndexInSelectedstudents(int index, DocumentReference value) {
    selectedstudents.insert(index, value);
  }

  bool _editclass = false;
  bool get editclass => _editclass;
  set editclass(bool value) {
    _editclass = value;
  }

  EventsNoticeStruct _eventDetails = EventsNoticeStruct();
  EventsNoticeStruct get eventDetails => _eventDetails;
  set eventDetails(EventsNoticeStruct value) {
    _eventDetails = value;
  }

  void updateEventDetailsStruct(Function(EventsNoticeStruct) updateFn) {
    updateFn(_eventDetails);
  }

  SubscribtionDetailsStruct _subscription = SubscribtionDetailsStruct();
  SubscribtionDetailsStruct get subscription => _subscription;
  set subscription(SubscribtionDetailsStruct value) {
    _subscription = value;
  }

  void updateSubscriptionStruct(Function(SubscribtionDetailsStruct) updateFn) {
    updateFn(_subscription);
  }

  int _loopmin = 0;
  int get loopmin => _loopmin;
  set loopmin(int value) {
    _loopmin = value;
  }

  String _classname = '';
  String get classname => _classname;
  set classname(String value) {
    _classname = value;
  }

  int _selectedSubscriptionId = 10;
  int get selectedSubscriptionId => _selectedSubscriptionId;
  set selectedSubscriptionId(int value) {
    _selectedSubscriptionId = value;
  }

  List<RecentsearchAdminStruct> _recentSearchAdmin = [];
  List<RecentsearchAdminStruct> get recentSearchAdmin => _recentSearchAdmin;
  set recentSearchAdmin(List<RecentsearchAdminStruct> value) {
    _recentSearchAdmin = value;
    prefs.setStringList(
        'ff_recentSearchAdmin', value.map((x) => x.serialize()).toList());
  }

  void addToRecentSearchAdmin(RecentsearchAdminStruct value) {
    recentSearchAdmin.add(value);
    prefs.setStringList('ff_recentSearchAdmin',
        _recentSearchAdmin.map((x) => x.serialize()).toList());
  }

  void removeFromRecentSearchAdmin(RecentsearchAdminStruct value) {
    recentSearchAdmin.remove(value);
    prefs.setStringList('ff_recentSearchAdmin',
        _recentSearchAdmin.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromRecentSearchAdmin(int index) {
    recentSearchAdmin.removeAt(index);
    prefs.setStringList('ff_recentSearchAdmin',
        _recentSearchAdmin.map((x) => x.serialize()).toList());
  }

  void updateRecentSearchAdminAtIndex(
    int index,
    RecentsearchAdminStruct Function(RecentsearchAdminStruct) updateFn,
  ) {
    recentSearchAdmin[index] = updateFn(_recentSearchAdmin[index]);
    prefs.setStringList('ff_recentSearchAdmin',
        _recentSearchAdmin.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInRecentSearchAdmin(
      int index, RecentsearchAdminStruct value) {
    recentSearchAdmin.insert(index, value);
    prefs.setStringList('ff_recentSearchAdmin',
        _recentSearchAdmin.map((x) => x.serialize()).toList());
  }

  CheckinStruct _checkin = CheckinStruct();
  CheckinStruct get checkin => _checkin;
  set checkin(CheckinStruct value) {
    _checkin = value;
    prefs.setString('ff_checkin', value.serialize());
  }

  void updateCheckinStruct(Function(CheckinStruct) updateFn) {
    updateFn(_checkin);
    prefs.setString('ff_checkin', _checkin.serialize());
  }

  DateTime? _checkout = DateTime.fromMillisecondsSinceEpoch(1732626000000);
  DateTime? get checkout => _checkout;
  set checkout(DateTime? value) {
    _checkout = value;
    value != null
        ? prefs.setInt('ff_checkout', value.millisecondsSinceEpoch)
        : prefs.remove('ff_checkout');
  }

  int _loopminparent = 0;
  int get loopminparent => _loopminparent;
  set loopminparent(int value) {
    _loopminparent = value;
  }

  DocumentReference? _superadminref =
      FirebaseFirestore.instance.doc('/Users/q8tbtQg9nzdQlEg2sOl4X8QOCu33');
  DocumentReference? get superadminref => _superadminref;
  set superadminref(DocumentReference? value) {
    _superadminref = value;
    value != null
        ? prefs.setString('ff_superadminref', value.path)
        : prefs.remove('ff_superadminref');
  }

  List<DocumentReference> _selectedteachersuserref = [];
  List<DocumentReference> get selectedteachersuserref =>
      _selectedteachersuserref;
  set selectedteachersuserref(List<DocumentReference> value) {
    _selectedteachersuserref = value;
  }

  void addToSelectedteachersuserref(DocumentReference value) {
    selectedteachersuserref.add(value);
  }

  void removeFromSelectedteachersuserref(DocumentReference value) {
    selectedteachersuserref.remove(value);
  }

  void removeAtIndexFromSelectedteachersuserref(int index) {
    selectedteachersuserref.removeAt(index);
  }

  void updateSelectedteachersuserrefAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    selectedteachersuserref[index] = updateFn(_selectedteachersuserref[index]);
  }

  void insertAtIndexInSelectedteachersuserref(
      int index, DocumentReference value) {
    selectedteachersuserref.insert(index, value);
  }

  String _studenttimelineimage = '';
  String get studenttimelineimage => _studenttimelineimage;
  set studenttimelineimage(String value) {
    _studenttimelineimage = value;
  }

  DocumentReference? _classteacher;
  DocumentReference? get classteacher => _classteacher;
  set classteacher(DocumentReference? value) {
    _classteacher = value;
  }

  List<TeacherListStruct> _AddTeachersClass = [];
  List<TeacherListStruct> get AddTeachersClass => _AddTeachersClass;
  set AddTeachersClass(List<TeacherListStruct> value) {
    _AddTeachersClass = value;
  }

  void addToAddTeachersClass(TeacherListStruct value) {
    AddTeachersClass.add(value);
  }

  void removeFromAddTeachersClass(TeacherListStruct value) {
    AddTeachersClass.remove(value);
  }

  void removeAtIndexFromAddTeachersClass(int index) {
    AddTeachersClass.removeAt(index);
  }

  void updateAddTeachersClassAtIndex(
    int index,
    TeacherListStruct Function(TeacherListStruct) updateFn,
  ) {
    AddTeachersClass[index] = updateFn(_AddTeachersClass[index]);
  }

  void insertAtIndexInAddTeachersClass(int index, TeacherListStruct value) {
    AddTeachersClass.insert(index, value);
  }

  List<StudentListStruct> _AddStudentClass = [];
  List<StudentListStruct> get AddStudentClass => _AddStudentClass;
  set AddStudentClass(List<StudentListStruct> value) {
    _AddStudentClass = value;
  }

  void addToAddStudentClass(StudentListStruct value) {
    AddStudentClass.add(value);
  }

  void removeFromAddStudentClass(StudentListStruct value) {
    AddStudentClass.remove(value);
  }

  void removeAtIndexFromAddStudentClass(int index) {
    AddStudentClass.removeAt(index);
  }

  void updateAddStudentClassAtIndex(
    int index,
    StudentListStruct Function(StudentListStruct) updateFn,
  ) {
    AddStudentClass[index] = updateFn(_AddStudentClass[index]);
  }

  void insertAtIndexInAddStudentClass(int index, StudentListStruct value) {
    AddStudentClass.insert(index, value);
  }

  List<DocumentReference> _selectedschoolref = [];
  List<DocumentReference> get selectedschoolref => _selectedschoolref;
  set selectedschoolref(List<DocumentReference> value) {
    _selectedschoolref = value;
  }

  void addToSelectedschoolref(DocumentReference value) {
    selectedschoolref.add(value);
  }

  void removeFromSelectedschoolref(DocumentReference value) {
    selectedschoolref.remove(value);
  }

  void removeAtIndexFromSelectedschoolref(int index) {
    selectedschoolref.removeAt(index);
  }

  void updateSelectedschoolrefAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    selectedschoolref[index] = updateFn(_selectedschoolref[index]);
  }

  void insertAtIndexInSelectedschoolref(int index, DocumentReference value) {
    selectedschoolref.insert(index, value);
  }

  DateTime? _currentdate = DateTime.fromMillisecondsSinceEpoch(1733032740000);
  DateTime? get currentdate => _currentdate;
  set currentdate(DateTime? value) {
    _currentdate = value;
    value != null
        ? prefs.setInt('ff_currentdate', value.millisecondsSinceEpoch)
        : prefs.remove('ff_currentdate');
  }

  List<String> _eventnoticeimage = [];
  List<String> get eventnoticeimage => _eventnoticeimage;
  set eventnoticeimage(List<String> value) {
    _eventnoticeimage = value;
  }

  void addToEventnoticeimage(String value) {
    eventnoticeimage.add(value);
  }

  void removeFromEventnoticeimage(String value) {
    eventnoticeimage.remove(value);
  }

  void removeAtIndexFromEventnoticeimage(int index) {
    eventnoticeimage.removeAt(index);
  }

  void updateEventnoticeimageAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    eventnoticeimage[index] = updateFn(_eventnoticeimage[index]);
  }

  void insertAtIndexInEventnoticeimage(int index, String value) {
    eventnoticeimage.insert(index, value);
  }

  String _studentimage = '';
  String get studentimage => _studentimage;
  set studentimage(String value) {
    _studentimage = value;
  }

  String _studenttimelinevideo = '';
  String get studenttimelinevideo => _studenttimelinevideo;
  set studenttimelinevideo(String value) {
    _studenttimelinevideo = value;
  }

  String _studentphotovideo = '';
  String get studentphotovideo => _studentphotovideo;
  set studentphotovideo(String value) {
    _studentphotovideo = value;
  }

  String _url = '';
  String get url => _url;
  set url(String value) {
    _url = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
