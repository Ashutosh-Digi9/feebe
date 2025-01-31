import 'dart:async';

import 'serialization_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({super.key, required this.child});

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).secondary,
          child: Image.asset(
            'assets/images/eebe_(500_x_200_px).png',
            fit: BoxFit.contain,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => const ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Launch': ParameterData.none(),
  'Login': ParameterData.none(),
  'Dashboard': (data) async => ParameterData(
        allParams: {
          'tabindex': getParameter<int>(data, 'tabindex'),
        },
      ),
  'NewSchoolDetails_SA': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'Calender_parent': (data) async => ParameterData(
        allParams: {
          'classref': getParameter<DocumentReference>(data, 'classref'),
        },
      ),
  'notification_parent': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'timelinedetails': (data) async => ParameterData(
        allParams: {
          'studentRef': getParameter<DocumentReference>(data, 'studentRef'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'date': getParameter<DateTime>(data, 'date'),
        },
      ),
  'parent_profile': (data) async => const ParameterData(
        allParams: {},
      ),
  'Notifications_SA': ParameterData.none(),
  'Add_School_QR_SA': ParameterData.none(),
  'Add_School_manually_SA': ParameterData.none(),
  'editprofile_parent': ParameterData.none(),
  'SearchPage_SA': ParameterData.none(),
  'EditProfile_SA': ParameterData.none(),
  'attendence_parent': (data) async => ParameterData(
        allParams: {
          'classref': getParameter<DocumentReference>(data, 'classref'),
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
        },
      ),
  'SchoolRejected': ParameterData.none(),
  'add_Teacher_manually_Admin': (data) async => ParameterData(
        allParams: {
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
        },
      ),
  'ChangePassword': ParameterData.none(),
  'ExistingSchoolDetails_SA': (data) async => ParameterData(
        allParams: {
          'schoolrefMain':
              getParameter<DocumentReference>(data, 'schoolrefMain'),
        },
      ),
  'Class_view': (data) async => ParameterData(
        allParams: {
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'datePick': getParameter<DateTime>(data, 'datePick'),
        },
      ),
  'PasswordChanged': ParameterData.none(),
  'class_dashboard': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'tabindex': getParameter<int>(data, 'tabindex'),
          'classname': getParameter<String>(data, 'classname'),
        },
      ),
  'Teacher_profile': (data) async => ParameterData(
        allParams: {
          'teacherRef': getParameter<DocumentReference>(data, 'teacherRef'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'AddBranch_SA': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'userref': getParameter<DocumentReference>(data, 'userref'),
        },
      ),
  'AddClassAdmin': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'Notification_admin': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'SelectStudentsAdmin': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'classref': getParameter<DocumentReference>(data, 'classref'),
        },
      ),
  'Teacher_attendence_History': (data) async => ParameterData(
        allParams: {
          'techerref': getParameter<DocumentReference>(data, 'techerref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'teacher_timeline': (data) async => ParameterData(
        allParams: {
          'teachersref': getParameter<DocumentReference>(data, 'teachersref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'class_attendence': (data) async => ParameterData(
        allParams: {
          'classRef': getParameter<DocumentReference>(data, 'classRef'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'classattendence': getParameter<bool>(data, 'classattendence'),
          'classes': getParameter<bool>(data, 'classes'),
        },
      ),
  'class_attendence_history': (data) async => ParameterData(
        allParams: {
          'classref': getParameter<DocumentReference>(data, 'classref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'mark_attendence': (data) async => ParameterData(
        allParams: {
          'classRef': getParameter<DocumentReference>(data, 'classRef'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'add_student_manually': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'StudentsAddedtoclass': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'IndiStudentAdmin': (data) async => ParameterData(
        allParams: {
          'studentsref': getParameter<DocumentReference>(data, 'studentsref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'noticedetails_class': (data) async => ParameterData(
        allParams: {
          'eventid': getParameter<int>(data, 'eventid'),
          'classref': getParameter<DocumentReference>(data, 'classref'),
        },
      ),
  'ForgotPassword': ParameterData.none(),
  'editSchool_SA': (data) async => ParameterData(
        allParams: {
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
          'mainschoolref':
              getParameter<DocumentReference>(data, 'mainschoolref'),
        },
      ),
  'EditBranchSA': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'mainschoolref':
              getParameter<DocumentReference>(data, 'mainschoolref'),
        },
      ),
  'add_events_details': (data) async => ParameterData(
        allParams: {
          'selectedDate': getParameter<DateTime>(data, 'selectedDate'),
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
        },
      ),
  'editclassadmin': (data) async => ParameterData(
        allParams: {
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'AttendanceMarked': (data) async => ParameterData(
        allParams: {
          'classref': getParameter<DocumentReference>(data, 'classref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'add_noticeboard_class': (data) async => ParameterData(
        allParams: {
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
        },
      ),
  'indi_edit_students': (data) async => ParameterData(
        allParams: {
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'Add_Student_Admin_QR': (data) async => ParameterData(
        allParams: {
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
          'editclass': getParameter<bool>(data, 'editclass'),
          'classRef': getParameter<DocumentReference>(data, 'classRef'),
        },
      ),
  'studentsprofile': (data) async => ParameterData(
        allParams: {
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'ChangeSubscriptionPlan_SA': (data) async => ParameterData(
        allParams: {
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
        },
      ),
  'students_timeline_activities': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'classref': getParameter<DocumentReference>(data, 'classref'),
          'activityId': getParameter<int>(data, 'activityId'),
          'activityName': getParameter<String>(data, 'activityName'),
        },
      ),
  'TeacherdeletedSuccesfully': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'Edit_TeacherAdmin': (data) async => ParameterData(
        allParams: {
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
          'teacherref': getParameter<DocumentReference>(data, 'teacherref'),
        },
      ),
  'Teacherdetailsedited': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'teacheref': getParameter<DocumentReference>(data, 'teacheref'),
        },
      ),
  'Teachers_Gallery': (data) async => ParameterData(
        allParams: {
          'teacher': getParameter<DocumentReference>(data, 'teacher'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'Add_School_link': ParameterData.none(),
  'calender_class': (data) async => ParameterData(
        allParams: {
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'mainpage': getParameter<bool>(data, 'mainpage'),
        },
      ),
  'Student_gallery': (data) async => ParameterData(
        allParams: {
          'student': getParameter<DocumentReference>(data, 'student'),
        },
      ),
  'indivi_image_view': (data) async => ParameterData(
        allParams: {
          'student': getParameter<DocumentReference>(data, 'student'),
          'index': getParameter<int>(data, 'index'),
        },
      ),
  'add_calender_details': (data) async => ParameterData(
        allParams: {
          'selectedDate': getParameter<DateTime>(data, 'selectedDate'),
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
          'tabindex': getParameter<int>(data, 'tabindex'),
          'classname': getParameter<String>(data, 'classname'),
        },
      ),
  'subscription': (data) async => ParameterData(
        allParams: {
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
        },
      ),
  'edi_teacher': (data) async => ParameterData(
        allParams: {
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
          'teacherref': getParameter<DocumentReference>(data, 'teacherref'),
        },
      ),
  'SearchPage_admin': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'Notification_Teacher': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'SchoolAdded': ParameterData.none(),
  'Schoolapproved': ParameterData.none(),
  'Schooldeletedsuccessfully': ParameterData.none(),
  'BranchUpdated': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'mainschoolref':
              getParameter<DocumentReference>(data, 'mainschoolref'),
        },
      ),
  'SchoolUpdated': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'BranchAdded': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'attendence_history_teacher': (data) async => ParameterData(
        allParams: {
          'techerref': getParameter<DocumentReference>(data, 'techerref'),
        },
      ),
  'amount_not_paidd': ParameterData.none(),
  'subscriptionended': ParameterData.none(),
  'Teacher_Timeline_new': (data) async => ParameterData(
        allParams: {
          'teacherRef': getParameter<DocumentReference>(data, 'teacherRef'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'class_notice': (data) async => ParameterData(
        allParams: {
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'Teacher_notice': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'teacherref': getParameter<DocumentReference>(data, 'teacherref'),
        },
      ),
  'Teacher_noticeTeacher': ParameterData.none(),
  'calender_list_parent': (data) async => ParameterData(
        allParams: {
          'selectedDate': getParameter<DateTime>(data, 'selectedDate'),
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
        },
      ),
  'notice_parent': (data) async => ParameterData(
        allParams: {
          'clasref': getParameter<DocumentReference>(data, 'clasref'),
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
        },
      ),
  'addnoticeAllSchools': ParameterData.none(),
  'School_notice_view': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'subscribtioplan': ParameterData.none(),
  'Edit_childParent': (data) async => ParameterData(
        allParams: {
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
        },
      ),
  'ChildDetailsUpdated': ParameterData.none(),
  'PareentProfileUpdated': ParameterData.none(),
  'ClassNotice_Admin_Teacher': (data) async => ParameterData(
        allParams: {
          'classref': getParameter<DocumentReference>(data, 'classref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'date': getParameter<DateTime>(data, 'date'),
        },
      ),
  'NotificationVIew': (data) async => ParameterData(
        allParams: {
          'notificationref':
              getParameter<DocumentReference>(data, 'notificationref'),
        },
      ),
  'New_student': (data) async => ParameterData(
        allParams: {
          'studentsref': getParameter<DocumentReference>(data, 'studentsref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'new_student_edit': (data) async => ParameterData(
        allParams: {
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'Profile_view': ParameterData.none(),
  'indistudentmainpages': (data) async => ParameterData(
        allParams: {
          'studentsref': getParameter<DocumentReference>(data, 'studentsref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'indivi_image_viewTeacher': (data) async => ParameterData(
        allParams: {
          'teacher': getParameter<DocumentReference>(data, 'teacher'),
          'index': getParameter<int>(data, 'index'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'add_student_manuallyCopy': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'classref': getParameter<DocumentReference>(data, 'classref'),
        },
      ),
  'selectedstudents_sadmin': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'classref': getParameter<DocumentReference>(data, 'classref'),
        },
      ),
  'draft_student_maually': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'student_draft': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
        },
      ),
  'indivi_video_view': (data) async => ParameterData(
        allParams: {
          'student': getParameter<DocumentReference>(data, 'student'),
          'index': getParameter<int>(data, 'index'),
        },
      ),
  'calender_details_parent': (data) async => const ParameterData(
        allParams: {},
      ),
  'attendance_history_students_card': (data) async => ParameterData(
        allParams: {
          'classRef': getParameter<DocumentReference>(data, 'classRef'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'date': getParameter<DateTime>(data, 'date'),
        },
      ),
  'Notice_details': (data) async => const ParameterData(
        allParams: {},
      ),
  'event_details': (data) async => const ParameterData(
        allParams: {},
      ),
  'guest_page': ParameterData.none(),
  'Deletepage': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
