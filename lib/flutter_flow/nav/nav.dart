import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

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
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? const DashboardWidget() : const LaunchWidget(),
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
          builder: (context, params) => const DashboardWidget(),
        ),
        FFRoute(
          name: 'NewSchoolDetails_SA',
          path: '/newSchoolDetailsSA',
          builder: (context, params) => const NewSchoolDetailsSAWidget(),
        ),
        FFRoute(
          name: 'Calender_parent',
          path: '/calenderParent',
          builder: (context, params) => const CalenderParentWidget(),
        ),
        FFRoute(
          name: 'notification_parent',
          path: '/calender_day_view',
          builder: (context, params) => const NotificationParentWidget(),
        ),
        FFRoute(
          name: 'dashboard_parent',
          path: '/dashboardParent',
          builder: (context, params) => const DashboardParentWidget(),
        ),
        FFRoute(
          name: 'parent_profile',
          path: '/Profile',
          builder: (context, params) => ParentProfileWidget(
            userref: params.getParam(
              'userref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Users'],
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
          builder: (context, params) => EditprofileParentWidget(
            userref: params.getParam(
              'userref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Users'],
            ),
          ),
        ),
        FFRoute(
          name: 'SearchPage_SA',
          path: '/searchPageSA',
          builder: (context, params) => const SearchPageSAWidget(),
        ),
        FFRoute(
          name: 'edit_child',
          path: '/editprofileCopy',
          builder: (context, params) => const EditChildWidget(),
        ),
        FFRoute(
          name: 'calender_view',
          path: '/calenderView',
          builder: (context, params) => const CalenderViewWidget(),
        ),
        FFRoute(
          name: 'EditProfile_SA',
          path: '/editProfileSA',
          builder: (context, params) => EditProfileSAWidget(
            userref: params.getParam(
              'userref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Users'],
            ),
          ),
        ),
        FFRoute(
          name: 'notifications_detials',
          path: '/notificationsDetials',
          builder: (context, params) => const NotificationsDetialsWidget(),
        ),
        FFRoute(
          name: 'child_timeline_updates',
          path: '/child_timeline',
          builder: (context, params) => const ChildTimelineUpdatesWidget(),
        ),
        FFRoute(
          name: 'gallery',
          path: '/gallery',
          builder: (context, params) => const GalleryWidget(),
        ),
        FFRoute(
          name: 'SubscriptionPlan_SA',
          path: '/subscriptionPlanSA',
          builder: (context, params) => const SubscriptionPlanSAWidget(),
        ),
        FFRoute(
          name: 'attendence',
          path: '/attendence',
          builder: (context, params) => const AttendenceWidget(),
        ),
        FFRoute(
          name: 'DeletePage_SA',
          path: '/deletePageSA',
          builder: (context, params) => const DeletePageSAWidget(),
        ),
        FFRoute(
          name: 'add_teacher_QR_Admin',
          path: '/addTeacherQRAdmin',
          builder: (context, params) => const AddTeacherQRAdminWidget(),
        ),
        FFRoute(
          name: 'add_Teacher_manually_Admin',
          path: '/addTeacherManuallyAdmin',
          builder: (context, params) => const AddTeacherManuallyAdminWidget(),
        ),
        FFRoute(
          name: 'Noticeboard',
          path: '/Noticeboard',
          builder: (context, params) => const NoticeboardWidget(),
        ),
        FFRoute(
          name: 'Signup_SA',
          path: '/signupSA',
          builder: (context, params) => const SignupSAWidget(),
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
            schoolref: params.getParam(
              'schoolref',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['School'],
            ),
          ),
        ),
        FFRoute(
          name: 'Class_dashboard',
          path: '/classDashboard',
          builder: (context, params) => const ClassDashboardWidget(),
        ),
        FFRoute(
          name: 'PasswordChanged',
          path: '/passwordChanged',
          builder: (context, params) => const PasswordChangedWidget(),
        ),
        FFRoute(
          name: 'Signup_A',
          path: '/signupA',
          builder: (context, params) => const SignupAWidget(),
        ),
        FFRoute(
          name: 'DashboardAdmin',
          path: '/dashboardAdmin',
          builder: (context, params) => const DashboardAdminWidget(),
        ),
        FFRoute(
          name: 'Teacher_profile',
          path: '/teacherProfile',
          builder: (context, params) => const TeacherProfileWidget(),
        ),
        FFRoute(
          name: 'AddBranch_SA',
          path: '/addBranchSA',
          builder: (context, params) => const AddBranchSAWidget(),
        ),
        FFRoute(
          name: 'Profile_Admin',
          path: '/profileAdmin',
          builder: (context, params) => const ProfileAdminWidget(),
        ),
        FFRoute(
          name: 'AddClassAdmin',
          path: '/addClassAdmin',
          builder: (context, params) => const AddClassAdminWidget(),
        ),
        FFRoute(
          name: 'Notification_admin',
          path: '/notificationAdmin',
          builder: (context, params) => const NotificationAdminWidget(),
        ),
        FFRoute(
          name: 'teacher_updates',
          path: '/teacherUpdates',
          builder: (context, params) => const TeacherUpdatesWidget(),
        ),
        FFRoute(
          name: 'AddClass2Admin',
          path: '/addClass2Admin',
          builder: (context, params) => const AddClass2AdminWidget(),
        ),
        FFRoute(
          name: 'Teacher_attendence_History',
          path: '/teacherAttendenceHistory',
          builder: (context, params) => const TeacherAttendenceHistoryWidget(),
        ),
        FFRoute(
          name: 'AddClass3Admin',
          path: '/addClass3Admin',
          builder: (context, params) => const AddClass3AdminWidget(),
        ),
        FFRoute(
          name: 'teacher_timeline',
          path: '/Teacher_attendence_HistoryCopy',
          builder: (context, params) => const TeacherTimelineWidget(),
        ),
        FFRoute(
          name: 'class_attendence',
          path: '/classAttendence',
          builder: (context, params) => const ClassAttendenceWidget(),
        ),
        FFRoute(
          name: 'calender_AddeventAdmin',
          path: '/calenderAddeventAdmin',
          builder: (context, params) => const CalenderAddeventAdminWidget(),
        ),
        FFRoute(
          name: 'class_attendence_history',
          path: '/classAttendenceHistory',
          builder: (context, params) => const ClassAttendenceHistoryWidget(),
        ),
        FFRoute(
          name: 'mark_attendence',
          path: '/AddClass2AdminCopy',
          builder: (context, params) => const MarkAttendenceWidget(),
        ),
        FFRoute(
          name: 'edit_class',
          path: '/editClass',
          builder: (context, params) => const EditClassWidget(),
        ),
        FFRoute(
          name: 'edit_class2',
          path: '/editClass2',
          builder: (context, params) => const EditClass2Widget(),
        ),
        FFRoute(
          name: 'edit_class3',
          path: '/editClass3',
          builder: (context, params) => const EditClass3Widget(),
        ),
        FFRoute(
          name: 'add_student_manually',
          path: '/addStudentManually',
          builder: (context, params) => const AddStudentManuallyWidget(),
        ),
        FFRoute(
          name: 'EventPostedAdmin',
          path: '/eventPostedAdmin',
          builder: (context, params) => const EventPostedAdminWidget(),
        ),
        FFRoute(
          name: 'StudentsViewAdmin',
          path: '/studentsViewAdmin',
          builder: (context, params) => const StudentsViewAdminWidget(),
        ),
        FFRoute(
          name: 'SelectStudentAdmin',
          path: '/selectStudentAdmin',
          builder: (context, params) => const SelectStudentAdminWidget(),
        ),
        FFRoute(
          name: 'add_parent_details',
          path: '/add_students',
          builder: (context, params) => const AddParentDetailsWidget(),
        ),
        FFRoute(
          name: 'StudentsAddedtoclass',
          path: '/studentsAddedtoclass',
          builder: (context, params) => const StudentsAddedtoclassWidget(),
        ),
        FFRoute(
          name: 'IndiStudentAdmin',
          path: '/indiStudentAdmin',
          builder: (context, params) => const IndiStudentAdminWidget(),
        ),
        FFRoute(
          name: 'add_student_class',
          path: '/add_student_class',
          builder: (context, params) => const AddStudentClassWidget(),
        ),
        FFRoute(
          name: 'StudentDeleted',
          path: '/studentDeleted',
          builder: (context, params) => const StudentDeletedWidget(),
        ),
        FFRoute(
          name: 'dashboardAdmin2',
          path: '/dashboardAdmin2',
          builder: (context, params) => const DashboardAdmin2Widget(),
        ),
        FFRoute(
          name: 'notifications_detialsAdmin',
          path: '/notificationsDetialsAdmin',
          builder: (context, params) => const NotificationsDetialsAdminWidget(),
        ),
        FFRoute(
          name: 'ForgotPassword',
          path: '/forgotPassword',
          builder: (context, params) => const ForgotPasswordWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
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
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

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

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
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
