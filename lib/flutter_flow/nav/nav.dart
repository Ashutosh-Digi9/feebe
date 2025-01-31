import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

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
        child: appStateNotifier.loggedIn ? const DashboardWidget() : const LaunchWidget(),
      ),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? const DashboardWidget() : const LaunchWidget(),
        ),
        FFRoute(
          name: 'Launch',
          path: '/launch',
          builder: (context, params) => const LaunchWidget(),
        ),
        FFRoute(
          name: 'Login',
          path: '/login',
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: 'Dashboard',
          path: '/dashboard',
          builder: (context, params) => DashboardWidget(
            tabindex: params.getParam(
              'tabindex',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: 'NewSchoolDetails_SA',
          path: '/newSchoolDetailsSA',
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
          name: 'Calender_parent',
          path: '/calenderParent',
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
          name: 'notification_parent',
          path: '/calender_day_view',
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
          name: 'timelinedetails',
          path: '/timelinedetails',
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
          name: 'parent_profile',
          path: '/Profile',
          builder: (context, params) => ParentProfileWidget(
            studentref: params.getParam<DocumentReference>(
              'studentref',
              ParamType.DocumentReference,
              isList: true,
              collectionNamePath: ['Students'],
            ),
          ),
        ),
        FFRoute(
          name: 'Notifications_SA',
          path: '/notificationsSA',
          builder: (context, params) => const NotificationsSAWidget(),
        ),
        FFRoute(
          name: 'Add_School_QR_SA',
          path: '/addSchoolQRSA',
          builder: (context, params) => const AddSchoolQRSAWidget(),
        ),
        FFRoute(
          name: 'Add_School_manually_SA',
          path: '/addSchoolManuallySA',
          builder: (context, params) => const AddSchoolManuallySAWidget(),
        ),
        FFRoute(
          name: 'editprofile_parent',
          path: '/editprofile',
          builder: (context, params) => const EditprofileParentWidget(),
        ),
        FFRoute(
          name: 'SearchPage_SA',
          path: '/searchPageSA',
          builder: (context, params) => const SearchPageSAWidget(),
        ),
        FFRoute(
          name: 'EditProfile_SA',
          path: '/editProfileSA',
          builder: (context, params) => const EditProfileSAWidget(),
        ),
        FFRoute(
          name: 'attendence_parent',
          path: '/attendence',
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
          name: 'SchoolRejected',
          path: '/schoolRejected',
          builder: (context, params) => const SchoolRejectedWidget(),
        ),
        FFRoute(
          name: 'add_Teacher_manually_Admin',
          path: '/addTeacherManuallyAdmin',
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
          name: 'ChangePassword',
          path: '/changePassword',
          builder: (context, params) => const ChangePasswordWidget(),
        ),
        FFRoute(
          name: 'ExistingSchoolDetails_SA',
          path: '/existingSchoolDetailsSA',
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
          name: 'Class_view',
          path: '/classView',
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
          name: 'PasswordChanged',
          path: '/passwordChanged',
          builder: (context, params) => const PasswordChangedWidget(),
        ),
        FFRoute(
          name: 'class_dashboard',
          path: '/classDashboard',
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
          ),
        ),
        FFRoute(
          name: 'Teacher_profile',
          path: '/teacherProfile',
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
          name: 'AddBranch_SA',
          path: '/addBranchSA',
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
          name: 'AddClassAdmin',
          path: '/addClassAdmin',
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
          name: 'Notification_admin',
          path: '/notificationAdmin',
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
          name: 'SelectStudentsAdmin',
          path: '/selectStudentsAdmin',
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
          name: 'Teacher_attendence_History',
          path: '/teacherAttendenceHistory',
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
          name: 'teacher_timeline',
          path: '/Teacher_attendence_HistoryCopy',
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
          name: 'class_attendence',
          path: '/classAttendence',
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
          name: 'class_attendence_history',
          path: '/classAttendenceHistory',
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
          name: 'mark_attendence',
          path: '/AddClass2AdminCopy',
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
          name: 'add_student_manually',
          path: '/addStudentManually',
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
          name: 'StudentsAddedtoclass',
          path: '/studentsAddedtoclass',
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
          name: 'IndiStudentAdmin',
          path: '/indiStudentAdmin',
          builder: (context, params) => IndiStudentAdminWidget(
            studentsref: params.getParam(
              'studentsref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            classref: params.getParam<DocumentReference>(
              'classref',
              ParamType.DocumentReference,
              isList: true,
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
          name: 'noticedetails_class',
          path: '/noticedetailsClass',
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
          name: 'ForgotPassword',
          path: '/forgotPassword',
          builder: (context, params) => const ForgotPasswordWidget(),
        ),
        FFRoute(
          name: 'editSchool_SA',
          path: '/editSchoolSA',
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
          name: 'EditBranchSA',
          path: '/editBranchSA',
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
          name: 'add_events_details',
          path: '/addEventsDetails',
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
          name: 'editclassadmin',
          path: '/editclassadmin',
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
          name: 'AttendanceMarked',
          path: '/attendanceMarked',
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
          name: 'add_noticeboard_class',
          path: '/addNoticeboardClass',
          builder: (context, params) => AddNoticeboardClassWidget(
            schoolclassref: params.getParam(
              'schoolclassref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School_class'],
            ),
          ),
        ),
        FFRoute(
          name: 'indi_edit_students',
          path: '/indiEditStudents',
          builder: (context, params) => IndiEditStudentsWidget(
            classref: params.getParam<DocumentReference>(
              'classref',
              ParamType.DocumentReference,
              isList: true,
              collectionNamePath: ['School_class'],
            ),
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
          name: 'Add_Student_Admin_QR',
          path: '/addStudentAdminQR',
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
          name: 'studentsprofile',
          path: '/studentsprofile',
          builder: (context, params) => StudentsprofileWidget(
            studentref: params.getParam(
              'studentref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            classref: params.getParam<DocumentReference>(
              'classref',
              ParamType.DocumentReference,
              isList: true,
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
          name: 'ChangeSubscriptionPlan_SA',
          path: '/changeSubscriptionPlanSA',
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
          name: 'students_timeline_activities',
          path: '/studentsTimelineActivities',
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
          name: 'TeacherdeletedSuccesfully',
          path: '/teacherdeletedSuccesfully',
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
          name: 'Edit_TeacherAdmin',
          path: '/editTeacherAdmin',
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
          ),
        ),
        FFRoute(
          name: 'Teacherdetailsedited',
          path: '/teacherdetailsedited',
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
          name: 'Teachers_Gallery',
          path: '/teachersGallery',
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
          name: 'Add_School_link',
          path: '/addSchoolLink',
          builder: (context, params) => const AddSchoolLinkWidget(),
        ),
        FFRoute(
          name: 'calender_class',
          path: '/calenderClass',
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
          ),
        ),
        FFRoute(
          name: 'Student_gallery',
          path: '/studentGallery',
          builder: (context, params) => StudentGalleryWidget(
            student: params.getParam(
              'student',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
          ),
        ),
        FFRoute(
          name: 'indivi_image_view',
          path: '/indiviImageView',
          builder: (context, params) => IndiviImageViewWidget(
            student: params.getParam(
              'student',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: 'add_calender_details',
          path: '/addCalenderDetails',
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
          ),
        ),
        FFRoute(
          name: 'subscription',
          path: '/subscription',
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
          name: 'edi_teacher',
          path: '/ediTeacher',
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
          name: 'SearchPage_admin',
          path: '/searchPageAdmin',
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
          name: 'Notification_Teacher',
          path: '/notificationTeacher',
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
          name: 'SchoolAdded',
          path: '/schoolAdded',
          builder: (context, params) => const SchoolAddedWidget(),
        ),
        FFRoute(
          name: 'Schoolapproved',
          path: '/schoolapproved',
          builder: (context, params) => const SchoolapprovedWidget(),
        ),
        FFRoute(
          name: 'Schooldeletedsuccessfully',
          path: '/schooldeletedsuccessfully',
          builder: (context, params) => const SchooldeletedsuccessfullyWidget(),
        ),
        FFRoute(
          name: 'BranchUpdated',
          path: '/branchUpdated',
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
          name: 'SchoolUpdated',
          path: '/schoolUpdated',
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
          name: 'BranchAdded',
          path: '/branchAdded',
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
          name: 'attendence_history_teacher',
          path: '/teacher_attendence_history',
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
          name: 'amount_not_paidd',
          path: '/amountNotPaidd',
          builder: (context, params) => const AmountNotPaiddWidget(),
        ),
        FFRoute(
          name: 'subscriptionended',
          path: '/subscriptionended',
          builder: (context, params) => const SubscriptionendedWidget(),
        ),
        FFRoute(
          name: 'Teacher_Timeline_new',
          path: '/teacherTimelineNew',
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
          name: 'class_notice',
          path: '/classNotice',
          builder: (context, params) => ClassNoticeWidget(
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
          name: 'Teacher_notice',
          path: '/teacherNotice',
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
          name: 'Teacher_noticeTeacher',
          path: '/teacherNoticeTeacher',
          builder: (context, params) => const TeacherNoticeTeacherWidget(),
        ),
        FFRoute(
          name: 'calender_list_parent',
          path: '/calenderListParent',
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
          name: 'notice_parent',
          path: '/noticeParent',
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
          name: 'addnoticeAllSchools',
          path: '/addnoticeAllSchools',
          builder: (context, params) => const AddnoticeAllSchoolsWidget(),
        ),
        FFRoute(
          name: 'School_notice_view',
          path: '/schoolNoticeView',
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
          name: 'subscribtioplan',
          path: '/subscribtioplan',
          builder: (context, params) => const SubscribtioplanWidget(),
        ),
        FFRoute(
          name: 'Edit_childParent',
          path: '/editprofileParent',
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
          name: 'ChildDetailsUpdated',
          path: '/childDetailsUpdated',
          builder: (context, params) => const ChildDetailsUpdatedWidget(),
        ),
        FFRoute(
          name: 'PareentProfileUpdated',
          path: '/pareentProfileUpdated',
          builder: (context, params) => const PareentProfileUpdatedWidget(),
        ),
        FFRoute(
          name: 'ClassNotice_Admin_Teacher',
          path: '/classNoticeAdminTeacher',
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
            date: params.getParam(
              'date',
              ParamType.DateTime,
            ),
          ),
        ),
        FFRoute(
          name: 'NotificationVIew',
          path: '/notificationVIew',
          builder: (context, params) => NotificationVIewWidget(
            notificationref: params.getParam(
              'notificationref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Notifications'],
            ),
          ),
        ),
        FFRoute(
          name: 'New_student',
          path: '/newStudent',
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
          name: 'new_student_edit',
          path: '/newStudentEdit',
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
          name: 'Profile_view',
          path: '/profileView',
          builder: (context, params) => const ProfileViewWidget(),
        ),
        FFRoute(
          name: 'indistudentmainpages',
          path: '/indistudentmainpages',
          builder: (context, params) => IndistudentmainpagesWidget(
            studentsref: params.getParam(
              'studentsref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            classref: params.getParam<DocumentReference>(
              'classref',
              ParamType.DocumentReference,
              isList: true,
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
          name: 'indivi_image_viewTeacher',
          path: '/indiviImageViewTeacher',
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
          name: 'add_student_manuallyCopy',
          path: '/addStudentManuallyCopy',
          builder: (context, params) => AddStudentManuallyCopyWidget(
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
          name: 'selectedstudents_sadmin',
          path: '/selectedstudentsSadmin',
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
          ),
        ),
        FFRoute(
          name: 'draft_student_maually',
          path: '/draftStudentMaually',
          builder: (context, params) => DraftStudentMauallyWidget(
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: 'student_draft',
          path: '/studentDraft',
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
          name: 'indivi_video_view',
          path: '/indiviVideoView',
          builder: (context, params) => IndiviVideoViewWidget(
            student: params.getParam(
              'student',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Students'],
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: 'calender_details_parent',
          path: '/calenderDetailsParent',
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
          name: 'attendance_history_students_card',
          path: '/AddClass2AdminCcard',
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
          name: 'Notice_details',
          path: '/noticeDetails',
          builder: (context, params) => NoticeDetailsWidget(
            eventDetails: params.getParam(
              'eventDetails',
              ParamType.DataStruct,
              isList: false,
              structBuilder: EventsNoticeStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: 'event_details',
          path: '/eventDetails',
          builder: (context, params) => EventDetailsWidget(
            eventDetails: params.getParam(
              'eventDetails',
              ParamType.DataStruct,
              isList: false,
              structBuilder: EventsNoticeStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: 'guest_page',
          path: '/guestPage',
          builder: (context, params) => const GuestPageWidget(),
        ),
        FFRoute(
          name: 'Deletepage',
          path: '/deletepage',
          builder: (context, params) => const DeletepageWidget(),
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
                  color: FlutterFlowTheme.of(context).secondary,
                  child: Image.asset(
                    'assets/images/eebe_(500_x_200_px).png',
                    fit: BoxFit.contain,
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

  static TransitionInfo appDefault() => const TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 300),
      );
}

class _RouteErrorBuilder extends StatefulWidget {
  const _RouteErrorBuilder({
    required this.state,
    required this.child,
  });

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
