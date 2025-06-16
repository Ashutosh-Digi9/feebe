import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';
export '/backend/firebase_dynamic_links/firebase_dynamic_links.dart'
    show generateCurrentPageLink;

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => _RouteErrorBuilder(
        state: state,
        child: appStateNotifier.loggedIn ? DashboardWidget() : LaunchWidget(),
      ),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? DashboardWidget() : LaunchWidget(),
        ),
        FFRoute(
          name: LaunchWidget.routeName,
          path: LaunchWidget.routePath,
          builder: (context, params) => LaunchWidget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: DashboardWidget.routeName,
          path: DashboardWidget.routePath,
          builder: (context, params) => DashboardWidget(
            tabindex: params.getParam(
              'tabindex',
              ParamType.int,
            ),
            fromlogin: params.getParam(
              'fromlogin',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: NewSchoolDetailsSAWidget.routeName,
          path: NewSchoolDetailsSAWidget.routePath,
          builder: (context, params) => NewSchoolDetailsSAWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: CalenderParentWidget.routeName,
          path: CalenderParentWidget.routePath,
          builder: (context, params) => CalenderParentWidget(
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
          ),
        ),
        FFRoute(
          name: NotificationParentWidget.routeName,
          path: NotificationParentWidget.routePath,
          builder: (context, params) => NotificationParentWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: TimelinedetailsWidget.routeName,
          path: TimelinedetailsWidget.routePath,
          builder: (context, params) => TimelinedetailsWidget(
            studentRef: params.getParam(
              'studentRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            date: params.getParam(
              'date',
              ParamType.DateTime,
            ),
          ),
        ),
        FFRoute(
          name: ParentProfileWidget.routeName,
          path: ParentProfileWidget.routePath,
          builder: (context, params) => ParentProfileWidget(
            studentref: params.getParam<DocumentReference>(
              'studentref',
              ParamType.DocumentReference,
              isList: true,
              collectionNamePath: ['Students'],
            ),
            parentlist: params.getParam<ParentsDetailsStruct>(
              'parentlist',
              ParamType.DataStruct,
              isList: true,
              structBuilder: ParentsDetailsStruct.fromSerializableMap,
            ),
            address: params.getParam(
              'address',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: NotificationsSAWidget.routeName,
          path: NotificationsSAWidget.routePath,
          builder: (context, params) => NotificationsSAWidget(),
        ),
        FFRoute(
          name: AddSchoolQRSAWidget.routeName,
          path: AddSchoolQRSAWidget.routePath,
          builder: (context, params) => AddSchoolQRSAWidget(),
        ),
        FFRoute(
          name: AddSchoolManuallySAWidget.routeName,
          path: AddSchoolManuallySAWidget.routePath,
          builder: (context, params) => AddSchoolManuallySAWidget(),
        ),
        FFRoute(
          name: EditprofileParentWidget.routeName,
          path: EditprofileParentWidget.routePath,
          builder: (context, params) => EditprofileParentWidget(),
        ),
        FFRoute(
          name: SearchPageSAWidget.routeName,
          path: SearchPageSAWidget.routePath,
          builder: (context, params) => SearchPageSAWidget(),
        ),
        FFRoute(
          name: EditProfileSAWidget.routeName,
          path: EditProfileSAWidget.routePath,
          builder: (context, params) => EditProfileSAWidget(),
        ),
        FFRoute(
          name: AttendenceParentWidget.routeName,
          path: AttendenceParentWidget.routePath,
          builder: (context, params) => AttendenceParentWidget(
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            studentref: params.getParam(
              'studentref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
          ),
        ),
        FFRoute(
          name: AddTeacherManuallyAdminWidget.routeName,
          path: AddTeacherManuallyAdminWidget.routePath,
          builder: (context, params) => AddTeacherManuallyAdminWidget(
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: ChangePasswordWidget.routeName,
          path: ChangePasswordWidget.routePath,
          builder: (context, params) => ChangePasswordWidget(),
        ),
        FFRoute(
          name: ExistingSchoolDetailsSAWidget.routeName,
          path: ExistingSchoolDetailsSAWidget.routePath,
          builder: (context, params) => ExistingSchoolDetailsSAWidget(
            schoolrefMain: params.getParam(
              'schoolrefMain',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: ClassViewWidget.routeName,
          path: ClassViewWidget.routePath,
          builder: (context, params) => ClassViewWidget(
            schoolclassref: params.getParam(
              'schoolclassref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            datePick: params.getParam(
              'datePick',
              ParamType.DateTime,
            ),
          ),
        ),
        FFRoute(
          name: PasswordChangedWidget.routeName,
          path: PasswordChangedWidget.routePath,
          builder: (context, params) => PasswordChangedWidget(),
        ),
        FFRoute(
          name: ClassDashboardWidget.routeName,
          path: ClassDashboardWidget.routePath,
          builder: (context, params) => ClassDashboardWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            tabindex: params.getParam(
              'tabindex',
              ParamType.int,
            ),
            classname: params.getParam(
              'classname',
              ParamType.String,
            ),
            pageno: params.getParam(
              'pageno',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: TeacherProfileWidget.routeName,
          path: TeacherProfileWidget.routePath,
          builder: (context, params) => TeacherProfileWidget(
            teacherRef: params.getParam(
              'teacherRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: AddBranchSAWidget.routeName,
          path: AddBranchSAWidget.routePath,
          builder: (context, params) => AddBranchSAWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            userref: params.getParam(
              'userref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Users'],
            ),
          ),
        ),
        FFRoute(
          name: AddClassAdminWidget.routeName,
          path: AddClassAdminWidget.routePath,
          builder: (context, params) => AddClassAdminWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: NotificationAdminWidget.routeName,
          path: NotificationAdminWidget.routePath,
          builder: (context, params) => NotificationAdminWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: SelectStudentsAdminWidget.routeName,
          path: SelectStudentsAdminWidget.routePath,
          builder: (context, params) => SelectStudentsAdminWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
          ),
        ),
        FFRoute(
          name: TeacherAttendenceHistoryWidget.routeName,
          path: TeacherAttendenceHistoryWidget.routePath,
          builder: (context, params) => TeacherAttendenceHistoryWidget(
            techerref: params.getParam(
              'techerref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: TeacherTimelineWidget.routeName,
          path: TeacherTimelineWidget.routePath,
          builder: (context, params) => TeacherTimelineWidget(
            teachersref: params.getParam(
              'teachersref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: ClassAttendenceWidget.routeName,
          path: ClassAttendenceWidget.routePath,
          builder: (context, params) => ClassAttendenceWidget(
            classRef: params.getParam(
              'classRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            classattendence: params.getParam(
              'classattendence',
              ParamType.bool,
            ),
            classes: params.getParam(
              'classes',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: ClassAttendenceHistoryWidget.routeName,
          path: ClassAttendenceHistoryWidget.routePath,
          builder: (context, params) => ClassAttendenceHistoryWidget(
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: MarkAttendenceWidget.routeName,
          path: MarkAttendenceWidget.routePath,
          builder: (context, params) => MarkAttendenceWidget(
            classRef: params.getParam(
              'classRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: AddStudentManuallyWidget.routeName,
          path: AddStudentManuallyWidget.routePath,
          builder: (context, params) => AddStudentManuallyWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: StudentsAddedtoclassWidget.routeName,
          path: StudentsAddedtoclassWidget.routePath,
          builder: (context, params) => StudentsAddedtoclassWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: NoticedetailsClassWidget.routeName,
          path: NoticedetailsClassWidget.routePath,
          builder: (context, params) => NoticedetailsClassWidget(
            eventid: params.getParam(
              'eventid',
              ParamType.int,
            ),
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
          ),
        ),
        FFRoute(
          name: ForgotPasswordWidget.routeName,
          path: ForgotPasswordWidget.routePath,
          builder: (context, params) => ForgotPasswordWidget(),
        ),
        FFRoute(
          name: EditSchoolSAWidget.routeName,
          path: EditSchoolSAWidget.routePath,
          builder: (context, params) => EditSchoolSAWidget(
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            mainschoolref: params.getParam(
              'mainschoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: EditBranchSAWidget.routeName,
          path: EditBranchSAWidget.routePath,
          builder: (context, params) => EditBranchSAWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            mainschoolref: params.getParam(
              'mainschoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: AddEventsDetailsWidget.routeName,
          path: AddEventsDetailsWidget.routePath,
          builder: (context, params) => AddEventsDetailsWidget(
            selectedDate: params.getParam(
              'selectedDate',
              ParamType.DateTime,
            ),
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: EditclassadminWidget.routeName,
          path: EditclassadminWidget.routePath,
          builder: (context, params) => EditclassadminWidget(
            schoolclassref: params.getParam(
              'schoolclassref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: AttendanceMarkedWidget.routeName,
          path: AttendanceMarkedWidget.routePath,
          builder: (context, params) => AttendanceMarkedWidget(
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: AddStudentAdminQRWidget.routeName,
          path: AddStudentAdminQRWidget.routePath,
          builder: (context, params) => AddStudentAdminQRWidget(
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            editclass: params.getParam(
              'editclass',
              ParamType.bool,
            ),
            classRef: params.getParam(
              'classRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
          ),
        ),
        FFRoute(
          name: ChangeSubscriptionPlanSAWidget.routeName,
          path: ChangeSubscriptionPlanSAWidget.routePath,
          builder: (context, params) => ChangeSubscriptionPlanSAWidget(
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: StudentsTimelineActivitiesWidget.routeName,
          path: StudentsTimelineActivitiesWidget.routePath,
          builder: (context, params) => StudentsTimelineActivitiesWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            activityId: params.getParam(
              'activityId',
              ParamType.int,
            ),
            activityName: params.getParam(
              'activityName',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: TeacherdeletedSuccesfullyWidget.routeName,
          path: TeacherdeletedSuccesfullyWidget.routePath,
          builder: (context, params) => TeacherdeletedSuccesfullyWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: EditTeacherAdminWidget.routeName,
          path: EditTeacherAdminWidget.routePath,
          builder: (context, params) => EditTeacherAdminWidget(
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            teacherref: params.getParam(
              'teacherref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            teacher: params.getParam(
              'teacher',
              ParamType.DataStruct,
              isList: false,
              structBuilder: TeacherListStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: TeacherdetailseditedWidget.routeName,
          path: TeacherdetailseditedWidget.routePath,
          builder: (context, params) => TeacherdetailseditedWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            teacheref: params.getParam(
              'teacheref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
          ),
        ),
        FFRoute(
          name: TeachersGalleryWidget.routeName,
          path: TeachersGalleryWidget.routePath,
          builder: (context, params) => TeachersGalleryWidget(
            teacher: params.getParam(
              'teacher',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: AddSchoolLinkWidget.routeName,
          path: AddSchoolLinkWidget.routePath,
          builder: (context, params) => AddSchoolLinkWidget(),
        ),
        FFRoute(
          name: CalenderClassWidget.routeName,
          path: CalenderClassWidget.routePath,
          builder: (context, params) => CalenderClassWidget(
            schoolclassref: params.getParam(
              'schoolclassref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            mainpage: params.getParam(
              'mainpage',
              ParamType.bool,
            ),
            studentpage: params.getParam(
              'studentpage',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: StudentGalleryWidget.routeName,
          path: StudentGalleryWidget.routePath,
          builder: (context, params) => StudentGalleryWidget(
            student: params.getParam(
              'student',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: IndiviImageViewWidget.routeName,
          path: IndiviImageViewWidget.routePath,
          builder: (context, params) => IndiviImageViewWidget(
            student: params.getParam(
              'student',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            imagepath: params.getParam(
              'imagepath',
              ParamType.String,
            ),
            gallery: params.getParam(
              'gallery',
              ParamType.DataStruct,
              isList: false,
              structBuilder: GalleryStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: AddCalenderDetailsWidget.routeName,
          path: AddCalenderDetailsWidget.routePath,
          builder: (context, params) => AddCalenderDetailsWidget(
            selectedDate: params.getParam(
              'selectedDate',
              ParamType.DateTime,
            ),
            schoolclassref: params.getParam(
              'schoolclassref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            tabindex: params.getParam(
              'tabindex',
              ParamType.int,
            ),
            classname: params.getParam(
              'classname',
              ParamType.String,
            ),
            classpage: params.getParam(
              'classpage',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: SubscriptionWidget.routeName,
          path: SubscriptionWidget.routePath,
          builder: (context, params) => SubscriptionWidget(
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: EdiTeacherWidget.routeName,
          path: EdiTeacherWidget.routePath,
          builder: (context, params) => EdiTeacherWidget(
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            teacherref: params.getParam(
              'teacherref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
          ),
        ),
        FFRoute(
          name: SearchPageAdminWidget.routeName,
          path: SearchPageAdminWidget.routePath,
          builder: (context, params) => SearchPageAdminWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: NotificationTeacherWidget.routeName,
          path: NotificationTeacherWidget.routePath,
          builder: (context, params) => NotificationTeacherWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: SchoolAddedWidget.routeName,
          path: SchoolAddedWidget.routePath,
          builder: (context, params) => SchoolAddedWidget(),
        ),
        FFRoute(
          name: SchoolapprovedWidget.routeName,
          path: SchoolapprovedWidget.routePath,
          builder: (context, params) => SchoolapprovedWidget(),
        ),
        FFRoute(
          name: SchooldeletedsuccessfullyWidget.routeName,
          path: SchooldeletedsuccessfullyWidget.routePath,
          builder: (context, params) => SchooldeletedsuccessfullyWidget(),
        ),
        FFRoute(
          name: BranchUpdatedWidget.routeName,
          path: BranchUpdatedWidget.routePath,
          builder: (context, params) => BranchUpdatedWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            mainschoolref: params.getParam(
              'mainschoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: SchoolUpdatedWidget.routeName,
          path: SchoolUpdatedWidget.routePath,
          builder: (context, params) => SchoolUpdatedWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: BranchAddedWidget.routeName,
          path: BranchAddedWidget.routePath,
          builder: (context, params) => BranchAddedWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: AttendenceHistoryTeacherWidget.routeName,
          path: AttendenceHistoryTeacherWidget.routePath,
          builder: (context, params) => AttendenceHistoryTeacherWidget(
            techerref: params.getParam(
              'techerref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
          ),
        ),
        FFRoute(
          name: AmountNotPaiddWidget.routeName,
          path: AmountNotPaiddWidget.routePath,
          builder: (context, params) => AmountNotPaiddWidget(),
        ),
        FFRoute(
          name: SubscriptionendedWidget.routeName,
          path: SubscriptionendedWidget.routePath,
          builder: (context, params) => SubscriptionendedWidget(),
        ),
        FFRoute(
          name: TeacherTimelineNewWidget.routeName,
          path: TeacherTimelineNewWidget.routePath,
          builder: (context, params) => TeacherTimelineNewWidget(
            teacherRef: params.getParam(
              'teacherRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: TeacherNoticeWidget.routeName,
          path: TeacherNoticeWidget.routePath,
          builder: (context, params) => TeacherNoticeWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            teacherref: params.getParam(
              'teacherref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
          ),
        ),
        FFRoute(
          name: TeacherNoticeTeacherWidget.routeName,
          path: TeacherNoticeTeacherWidget.routePath,
          builder: (context, params) => TeacherNoticeTeacherWidget(),
        ),
        FFRoute(
          name: CalenderListParentWidget.routeName,
          path: CalenderListParentWidget.routePath,
          builder: (context, params) => CalenderListParentWidget(
            selectedDate: params.getParam(
              'selectedDate',
              ParamType.DateTime,
            ),
            schoolclassref: params.getParam(
              'schoolclassref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
          ),
        ),
        FFRoute(
          name: NoticeParentWidget.routeName,
          path: NoticeParentWidget.routePath,
          builder: (context, params) => NoticeParentWidget(
            clasref: params.getParam(
              'clasref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            studentref: params.getParam(
              'studentref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
          ),
        ),
        FFRoute(
          name: AddnoticeAllSchoolsWidget.routeName,
          path: AddnoticeAllSchoolsWidget.routePath,
          builder: (context, params) => AddnoticeAllSchoolsWidget(),
        ),
        FFRoute(
          name: SchoolNoticeViewWidget.routeName,
          path: SchoolNoticeViewWidget.routePath,
          builder: (context, params) => SchoolNoticeViewWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: SubscribtioplanWidget.routeName,
          path: SubscribtioplanWidget.routePath,
          builder: (context, params) => SubscribtioplanWidget(),
        ),
        FFRoute(
          name: EditChildParentWidget.routeName,
          path: EditChildParentWidget.routePath,
          builder: (context, params) => EditChildParentWidget(
            studentref: params.getParam(
              'studentref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
          ),
        ),
        FFRoute(
          name: ChildDetailsUpdatedWidget.routeName,
          path: ChildDetailsUpdatedWidget.routePath,
          builder: (context, params) => ChildDetailsUpdatedWidget(),
        ),
        FFRoute(
          name: ClassNoticeAdminTeacherWidget.routeName,
          path: ClassNoticeAdminTeacherWidget.routePath,
          builder: (context, params) => ClassNoticeAdminTeacherWidget(
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            notice: params.getParam(
              'notice',
              ParamType.bool,
            ),
            studentpage: params.getParam(
              'studentpage',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: NotificationVIewWidget.routeName,
          path: NotificationVIewWidget.routePath,
          builder: (context, params) => NotificationVIewWidget(
            notiref: params.getParam(
              'notiref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Notifications'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: NewStudentWidget.routeName,
          path: NewStudentWidget.routePath,
          builder: (context, params) => NewStudentWidget(
            studentsref: params.getParam(
              'studentsref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: NewStudentEditWidget.routeName,
          path: NewStudentEditWidget.routePath,
          builder: (context, params) => NewStudentEditWidget(
            studentref: params.getParam(
              'studentref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: ProfileViewWidget.routeName,
          path: ProfileViewWidget.routePath,
          builder: (context, params) => ProfileViewWidget(),
        ),
        FFRoute(
          name: IndistudentmainpagesWidget.routeName,
          path: IndistudentmainpagesWidget.routePath,
          builder: (context, params) => IndistudentmainpagesWidget(
            studentsref: params.getParam(
              'studentsref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            mainpage: params.getParam(
              'mainpage',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: IndiviImageViewTeacherWidget.routeName,
          path: IndiviImageViewTeacherWidget.routePath,
          builder: (context, params) => IndiviImageViewTeacherWidget(
            teacher: params.getParam(
              'teacher',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: SelectedstudentsSadminWidget.routeName,
          path: SelectedstudentsSadminWidget.routePath,
          builder: (context, params) => SelectedstudentsSadminWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            className: params.getParam(
              'className',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StudentDraftWidget.routeName,
          path: StudentDraftWidget.routePath,
          builder: (context, params) => StudentDraftWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            studentref: params.getParam(
              'studentref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
          ),
        ),
        FFRoute(
          name: IndiviVideoViewWidget.routeName,
          path: IndiviVideoViewWidget.routePath,
          builder: (context, params) => IndiviVideoViewWidget(
            student: params.getParam(
              'student',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            gallery: params.getParam(
              'gallery',
              ParamType.DataStruct,
              isList: false,
              structBuilder: GalleryStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: CalenderDetailsParentWidget.routeName,
          path: CalenderDetailsParentWidget.routePath,
          builder: (context, params) => CalenderDetailsParentWidget(
            eventDetails: params.getParam(
              'eventDetails',
              ParamType.DataStruct,
              isList: false,
              structBuilder: EventsNoticeStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: AttendanceHistoryStudentsCardWidget.routeName,
          path: AttendanceHistoryStudentsCardWidget.routePath,
          builder: (context, params) => AttendanceHistoryStudentsCardWidget(
            classRef: params.getParam(
              'classRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            date: params.getParam(
              'date',
              ParamType.DateTime,
            ),
          ),
        ),
        FFRoute(
          name: NoticeDetailsWidget.routeName,
          path: NoticeDetailsWidget.routePath,
          builder: (context, params) => NoticeDetailsWidget(
            eventDetails: params.getParam(
              'eventDetails',
              ParamType.DataStruct,
              isList: false,
              structBuilder: EventsNoticeStruct.fromSerializableMap,
            ),
            classRef: params.getParam(
              'classRef',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EventDetailsWidget.routeName,
          path: EventDetailsWidget.routePath,
          builder: (context, params) => EventDetailsWidget(
            eventDetails: params.getParam(
              'eventDetails',
              ParamType.DataStruct,
              isList: false,
              structBuilder: EventsNoticeStruct.fromSerializableMap,
            ),
            classRef: params.getParam(
              'classRef',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: GuestPageWidget.routeName,
          path: GuestPageWidget.routePath,
          builder: (context, params) => GuestPageWidget(),
        ),
        FFRoute(
          name: DeletepageWidget.routeName,
          path: DeletepageWidget.routePath,
          builder: (context, params) => DeletepageWidget(),
        ),
        FFRoute(
          name: TeacherImageViewWidget.routeName,
          path: TeacherImageViewWidget.routePath,
          builder: (context, params) => TeacherImageViewWidget(
            teacher: params.getParam(
              'teacher',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
            school: params.getParam(
              'school',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: TeacherVideoViewWidget.routeName,
          path: TeacherVideoViewWidget.routePath,
          builder: (context, params) => TeacherVideoViewWidget(
            teacher: params.getParam(
              'teacher',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
            school: params.getParam(
              'school',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: TotalStudentListssWidget.routeName,
          path: TotalStudentListssWidget.routePath,
          builder: (context, params) => TotalStudentListssWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
            className: params.getParam(
              'className',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EditAdminWidget.routeName,
          path: EditAdminWidget.routePath,
          builder: (context, params) => EditAdminWidget(
            schoolRef: params.getParam(
              'schoolRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            mainschoolref: params.getParam(
              'mainschoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: EditParentWidget.routeName,
          path: EditParentWidget.routePath,
          builder: (context, params) => EditParentWidget(
            studentref: params.getParam<DocumentReference>(
              'studentref',
              ParamType.DocumentReference,
              isList: true,
              collectionNamePath: ['Students'],
            ),
            parent: params.getParam(
              'parent',
              ParamType.DataStruct,
              isList: false,
              structBuilder: ParentsDetailsStruct.fromSerializableMap,
            ),
            parentdetails: params.getParam<ParentsDetailsStruct>(
              'parentdetails',
              ParamType.DataStruct,
              isList: true,
              structBuilder: ParentsDetailsStruct.fromSerializableMap,
            ),
            address: params.getParam(
              'address',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AddNewadminWidget.routeName,
          path: AddNewadminWidget.routePath,
          builder: (context, params) => AddNewadminWidget(
            schoolRef: params.getParam<DocumentReference>(
              'schoolRef',
              ParamType.DocumentReference,
              isList: true,
              collectionNamePath: ['School'],
            ),
            mainschoolref: params.getParam(
              'mainschoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: EditAdminCopyWidget.routeName,
          path: EditAdminCopyWidget.routePath,
          builder: (context, params) => EditAdminCopyWidget(
            mainschoolref: params.getParam(
              'mainschoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            adminref: params.getParam(
              'adminref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Users'],
            ),
          ),
        ),
        FFRoute(
          name: AppUpdateWidget.routeName,
          path: AppUpdateWidget.routePath,
          builder: (context, params) => AppUpdateWidget(),
        ),
        FFRoute(
          name: StaffNoticeViewWidget.routeName,
          path: StaffNoticeViewWidget.routePath,
          builder: (context, params) => StaffNoticeViewWidget(
            eventDetails: params.getParam(
              'eventDetails',
              ParamType.DataStruct,
              isList: false,
              structBuilder: EventsNoticeStruct.fromSerializableMap,
            ),
            teacherRef: params.getParam(
              'teacherRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Teachers'],
            ),
          ),
        ),
        FFRoute(
          name: RequestLocationWidget.routeName,
          path: RequestLocationWidget.routePath,
          builder: (context, params) => RequestLocationWidget(),
        ),
        FFRoute(
          name: EditParentCopyWidget.routeName,
          path: EditParentCopyWidget.routePath,
          builder: (context, params) => EditParentCopyWidget(
            studentref: params.getParam<DocumentReference>(
              'studentref',
              ParamType.DocumentReference,
              isList: true,
              collectionNamePath: ['Students'],
            ),
            parent: params.getParam(
              'parent',
              ParamType.DataStruct,
              isList: false,
              structBuilder: ParentsDetailsStruct.fromSerializableMap,
            ),
            parentdetails: params.getParam<ParentsDetailsStruct>(
              'parentdetails',
              ParamType.DataStruct,
              isList: true,
              structBuilder: ParentsDetailsStruct.fromSerializableMap,
            ),
            address: params.getParam(
              'address',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: OtpScreenWidget.routeName,
          path: OtpScreenWidget.routePath,
          builder: (context, params) => OtpScreenWidget(
            phoneNumber: params.getParam(
              'phoneNumber',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EditClassStudentWidget.routeName,
          path: EditClassStudentWidget.routePath,
          builder: (context, params) => EditClassStudentWidget(
            studentref: params.getParam(
              'studentref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: EditClassStudentCopyWidget.routeName,
          path: EditClassStudentCopyWidget.routePath,
          builder: (context, params) => EditClassStudentCopyWidget(
            studentref: params.getParam(
              'studentref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: AddStudentManuallyCopy2Widget.routeName,
          path: AddStudentManuallyCopy2Widget.routePath,
          builder: (context, params) => AddStudentManuallyCopy2Widget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
            classref: params.getParam(
              'classref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
          ),
        ),
        FFRoute(
          name: EventdetailsparentWidget.routeName,
          path: EventdetailsparentWidget.routePath,
          builder: (context, params) => EventdetailsparentWidget(
            eventDetails: params.getParam(
              'eventDetails',
              ParamType.DataStruct,
              isList: false,
              structBuilder: EventsNoticeStruct.fromSerializableMap,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/launch';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/Screenshot_2025-02-21_at_11.58.19.png',
                    fit: BoxFit.fitHeight,
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 300),
      );
}

class _RouteErrorBuilder extends StatefulWidget {
  const _RouteErrorBuilder({
    Key? key,
    required this.state,
    required this.child,
  }) : super(key: key);

  final GoRouterState state;
  final Widget child;

  @override
  State<_RouteErrorBuilder> createState() => _RouteErrorBuilderState();
}

class _RouteErrorBuilderState extends State<_RouteErrorBuilder> {
  @override
  void initState() {
    super.initState();

    // Handle erroneous links from Firebase Dynamic Links.

    String? location;

    /*
    Handle `links` routes that have dynamic-link entangled with deep-link 
    */
    if (widget.state.uri.toString().startsWith('/link') &&
        widget.state.uri.queryParameters.containsKey('deep_link_id')) {
      final deepLinkId = widget.state.uri.queryParameters['deep_link_id'];
      if (deepLinkId != null) {
        final deepLinkUri = Uri.parse(deepLinkId);
        final link = deepLinkUri.toString();
        final host = deepLinkUri.host;
        location = link.split(host).last;
      }
    }

    if (widget.state.uri.toString().startsWith('/link') &&
        widget.state.uri.toString().contains('request_ip_version')) {
      location = '/';
    }

    if (location != null) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => context.go(location!));
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
