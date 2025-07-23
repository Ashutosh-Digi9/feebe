import 'dart:async';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

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
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
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
          color: Colors.transparent,
          child: Image.asset(
            'assets/images/Screenshot_2025-02-21_at_11.58.19.png',
            fit: BoxFit.fitHeight,
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
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Launch': ParameterData.none(),
  'Login': ParameterData.none(),
  'Dashboard': (data) async => ParameterData(
        allParams: {
          'tabindex': getParameter<int>(data, 'tabindex'),
          'fromlogin': getParameter<bool>(data, 'fromlogin'),
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
  'parent_profile': (data) async => ParameterData(
        allParams: {
          'address': getParameter<String>(data, 'address'),
        },
      ),
  'Notifications_SA': ParameterData.none(),
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
  'class_dashboard': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'tabindex': getParameter<int>(data, 'tabindex'),
          'classname': getParameter<String>(data, 'classname'),
          'pageno': getParameter<int>(data, 'pageno'),
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
  'calender_class': (data) async => ParameterData(
        allParams: {
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'mainpage': getParameter<bool>(data, 'mainpage'),
          'studentpage': getParameter<bool>(data, 'studentpage'),
        },
      ),
  'Student_gallery': (data) async => ParameterData(
        allParams: {
          'student': getParameter<DocumentReference>(data, 'student'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'indivi_image_view': (data) async => ParameterData(
        allParams: {
          'student': getParameter<DocumentReference>(data, 'student'),
          'imagepath': getParameter<String>(data, 'imagepath'),
        },
      ),
  'add_calender_details': (data) async => ParameterData(
        allParams: {
          'selectedDate': getParameter<DateTime>(data, 'selectedDate'),
          'schoolclassref':
              getParameter<DocumentReference>(data, 'schoolclassref'),
          'tabindex': getParameter<int>(data, 'tabindex'),
          'classname': getParameter<String>(data, 'classname'),
          'classpage': getParameter<bool>(data, 'classpage'),
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
  'ClassNotice_Admin_Teacher': (data) async => ParameterData(
        allParams: {
          'classref': getParameter<DocumentReference>(data, 'classref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'notice': getParameter<bool>(data, 'notice'),
          'studentpage': getParameter<bool>(data, 'studentpage'),
        },
      ),
  'NotificationVIew': (data) async => ParameterData(
        allParams: {
          'notiref': getParameter<DocumentReference>(data, 'notiref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'index': getParameter<int>(data, 'index'),
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
          'mainpage': getParameter<bool>(data, 'mainpage'),
        },
      ),
  'indivi_image_viewTeacher': (data) async => ParameterData(
        allParams: {
          'teacher': getParameter<DocumentReference>(data, 'teacher'),
          'index': getParameter<int>(data, 'index'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'selectedstudents_sadmin': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'classref': getParameter<DocumentReference>(data, 'classref'),
          'className': getParameter<String>(data, 'className'),
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
        },
      ),
  'calender_details_parent': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'attendance_history_students_card': (data) async => ParameterData(
        allParams: {
          'classRef': getParameter<DocumentReference>(data, 'classRef'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'date': getParameter<DateTime>(data, 'date'),
        },
      ),
  'Notice_details': (data) async => ParameterData(
        allParams: {
          'classRef': getParameter<String>(data, 'classRef'),
        },
      ),
  'event_details': (data) async => ParameterData(
        allParams: {
          'classRef': getParameter<String>(data, 'classRef'),
        },
      ),
  'guest_page': ParameterData.none(),
  'Deletepage': ParameterData.none(),
  'teacher_image_view': (data) async => ParameterData(
        allParams: {
          'teacher': getParameter<DocumentReference>(data, 'teacher'),
          'index': getParameter<int>(data, 'index'),
          'school': getParameter<DocumentReference>(data, 'school'),
        },
      ),
  'teacher_video_view': (data) async => ParameterData(
        allParams: {
          'teacher': getParameter<DocumentReference>(data, 'teacher'),
          'index': getParameter<int>(data, 'index'),
          'school': getParameter<DocumentReference>(data, 'school'),
        },
      ),
  'totalStudentListss': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'classref': getParameter<DocumentReference>(data, 'classref'),
          'className': getParameter<String>(data, 'className'),
        },
      ),
  'EditAdmin': (data) async => ParameterData(
        allParams: {
          'schoolRef': getParameter<DocumentReference>(data, 'schoolRef'),
          'mainschoolref':
              getParameter<DocumentReference>(data, 'mainschoolref'),
        },
      ),
  'edit_parent': (data) async => ParameterData(
        allParams: {
          'address': getParameter<String>(data, 'address'),
        },
      ),
  'addNewadmin': (data) async => ParameterData(
        allParams: {
          'mainschoolref':
              getParameter<DocumentReference>(data, 'mainschoolref'),
        },
      ),
  'EditAdminCopy': (data) async => ParameterData(
        allParams: {
          'mainschoolref':
              getParameter<DocumentReference>(data, 'mainschoolref'),
          'adminref': getParameter<DocumentReference>(data, 'adminref'),
        },
      ),
  'app_update': ParameterData.none(),
  'Staff_notice_view': (data) async => ParameterData(
        allParams: {
          'teacherRef': getParameter<DocumentReference>(data, 'teacherRef'),
        },
      ),
  'requestLocation': ParameterData.none(),
  'edit_parentCopy': (data) async => ParameterData(
        allParams: {
          'address': getParameter<String>(data, 'address'),
        },
      ),
  'otpScreen': (data) async => ParameterData(
        allParams: {
          'phoneNumber': getParameter<String>(data, 'phoneNumber'),
        },
      ),
  'edit_class_student': (data) async => ParameterData(
        allParams: {
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'edit_class_studentCopy': (data) async => ParameterData(
        allParams: {
          'studentref': getParameter<DocumentReference>(data, 'studentref'),
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
        },
      ),
  'add_student_manuallyCopy2': (data) async => ParameterData(
        allParams: {
          'schoolref': getParameter<DocumentReference>(data, 'schoolref'),
          'classref': getParameter<DocumentReference>(data, 'classref'),
        },
      ),
  'eventdetailsparent': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
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
