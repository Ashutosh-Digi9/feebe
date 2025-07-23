import '/admin_dashboard/deletenotification/deletenotification_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbarteacher/navbarteacher_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_teacher_model.dart';
export 'notification_teacher_model.dart';

class NotificationTeacherWidget extends StatefulWidget {
  const NotificationTeacherWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  static String routeName = 'Notification_Teacher';
  static String routePath = '/notificationTeacher';

  @override
  State<NotificationTeacherWidget> createState() =>
      _NotificationTeacherWidgetState();
}

class _NotificationTeacherWidgetState extends State<NotificationTeacherWidget> {
  late NotificationTeacherModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationTeacherModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NotificationsRecord>>(
      stream: queryNotificationsRecord(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<NotificationsRecord> notificationTeacherNotificationsRecordList =
            snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            appBar: responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
              desktop: false,
            )
                ? AppBar(
                    backgroundColor: FlutterFlowTheme.of(context).info,
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 120.0,
                            height: 45.0,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 5.0, 0.0),
                                      child: Text(
                                        'FEEBE',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 24.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: 24.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 10.0, 0.0),
                          child: AuthUserStreamWidget(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (valueOrDefault(
                                        currentUserDocument?.userRole, 0) !=
                                    4) {
                                  context.pushNamed(
                                    ProfileViewWidget.routeName,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                } else {
                                  _model.students12 =
                                      await queryStudentsRecordOnce(
                                    queryBuilder: (studentsRecord) =>
                                        studentsRecord.where(
                                      'Parents_list',
                                      arrayContains: currentUserReference,
                                    ),
                                  );

                                  context.pushNamed(
                                    ParentProfileWidget.routeName,
                                    queryParameters: {
                                      'studentref': serializeParam(
                                        _model.students12
                                            ?.map((e) => e.reference)
                                            .toList(),
                                        ParamType.DocumentReference,
                                        isList: true,
                                      ),
                                      'parentlist': serializeParam(
                                        functions.placeUserRefInMiddle(
                                            _model.students12!.firstOrNull!
                                                .parentsDetails
                                                .toList(),
                                            currentUserReference!,
                                            functions.middelindex(_model
                                                .students12!
                                                .firstOrNull!
                                                .parentsList
                                                .length)),
                                        ParamType.DataStruct,
                                        isList: true,
                                      ),
                                      'address': serializeParam(
                                        _model.students12?.firstOrNull
                                            ?.studentAddress,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                }

                                safeSetState(() {});
                              },
                              child: Container(
                                width: 22.8,
                                height: 22.8,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  valueOrDefault<String>(
                                    currentUserPhoto,
                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/2uwe1ectpzno/Avatar_Placeholder.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [],
                    centerTitle: true,
                    elevation: 0.0,
                  )
                : null,
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  child: custom_widgets.BackButtonOverrider(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    onBack: () async {
                      context.goNamed(
                        DashboardWidget.routeName,
                        queryParameters: {
                          'fromlogin': serializeParam(
                            false,
                            ParamType.bool,
                          ),
                        }.withoutNulls,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Notifications',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 20.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 20.0),
                              child: Builder(
                                builder: (context) {
                                  final notifications =
                                      notificationTeacherNotificationsRecordList
                                          .where((e) =>
                                              e.userref.contains(
                                                  currentUserReference) ==
                                              true)
                                          .toList();
                                  if (notifications.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        child: EmptyWidget(),
                                      ),
                                    );
                                  }

                                  return ListView.separated(
                                    padding: EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      0,
                                      20.0,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: notifications.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 10.0),
                                    itemBuilder: (context, notificationsIndex) {
                                      final notificationsItem =
                                          notifications[notificationsIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 5.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              NotificationVIewWidget.routeName,
                                              queryParameters: {
                                                'notiref': serializeParam(
                                                  notificationsItem.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                                'schoolref': serializeParam(
                                                  widget.schoolref,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                ),
                                              },
                                            );

                                            await notificationsItem.reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'ReadUseref':
                                                      FieldValue.arrayUnion([
                                                    currentUserReference
                                                  ]),
                                                },
                                              ),
                                            });
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              decoration: BoxDecoration(
                                                color: notificationsItem
                                                        .readUseref
                                                        .contains(
                                                            currentUserReference)
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .secondary
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .notificationfill,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 20.0,
                                                    color: Color(0x1D000000),
                                                    offset: Offset(
                                                      0.0,
                                                      0.0,
                                                    ),
                                                    spreadRadius: 0.0,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: notificationsItem
                                                          .readUseref
                                                          .contains(
                                                              currentUserReference)
                                                      ? Color(0xFFDDF1F6)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .notificationBorder,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if (notificationsItem
                                                                          .content !=
                                                                      '')
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.46,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Text(
                                                                    notificationsItem
                                                                        .content,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: Text(
                                                                  dateTimeFormat("dd MMM y", notificationsItem.createDate) !=
                                                                              ''
                                                                      ? dateTimeFormat(
                                                                          "dd MMM y",
                                                                          notificationsItem
                                                                              .createDate!)
                                                                      : dateTimeFormat(
                                                                          "dd MMM y",
                                                                          getCurrentTimestamp),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiaryText,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (notificationsItem
                                                                          .tag !=
                                                                      '')
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      () {
                                                                        if (notificationsItem.tag ==
                                                                            'Event') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .event;
                                                                        } else if (notificationsItem.tag ==
                                                                            'Birthday') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .birthdayfill;
                                                                        } else if (notificationsItem.tag ==
                                                                            'Homework') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .homework;
                                                                        } else if (notificationsItem.tag ==
                                                                            'Reminder') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .reminderfill;
                                                                        } else if (notificationsItem.tag ==
                                                                            'Holiday') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .holiday;
                                                                        } else {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .event;
                                                                        }
                                                                      }(),
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .text,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3.59),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        () {
                                                                          if (notificationsItem.tag ==
                                                                              'Homework') {
                                                                            return FlutterFlowTheme.of(context).homeworkborder;
                                                                          } else if (notificationsItem.tag ==
                                                                              'Reminder') {
                                                                            return FlutterFlowTheme.of(context).reminderborder;
                                                                          } else if (notificationsItem.tag ==
                                                                              'General') {
                                                                            return FlutterFlowTheme.of(context).generalBorder;
                                                                          } else if (notificationsItem.tag ==
                                                                              'Event') {
                                                                            return FlutterFlowTheme.of(context).eventborder;
                                                                          } else if (notificationsItem.tag ==
                                                                              'Holiday') {
                                                                            return FlutterFlowTheme.of(context).holidayborder;
                                                                          } else {
                                                                            return FlutterFlowTheme.of(context).birthdayborder;
                                                                          }
                                                                        }(),
                                                                        FlutterFlowTheme.of(context)
                                                                            .text,
                                                                      ),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            5.0,
                                                                            5.0,
                                                                            5.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          [
                                                                        if (notificationsItem.tag ==
                                                                            'General')
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                            width:
                                                                                15.5,
                                                                            height:
                                                                                15.5,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        if (notificationsItem.tag ==
                                                                            'Reminder')
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/3d-alarm.png',
                                                                            width:
                                                                                15.5,
                                                                            height:
                                                                                15.5,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        if (notificationsItem.tag ==
                                                                            'Homework')
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                            width:
                                                                                15.5,
                                                                            height:
                                                                                15.5,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        if (notificationsItem.tag ==
                                                                            'Holiday')
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/fxemoji--confetti-removebg-preview.png',
                                                                            width:
                                                                                15.5,
                                                                            height:
                                                                                15.5,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        if (notificationsItem.tag ==
                                                                            'Birthday')
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/noto--birthday-cake-removebg-preview.png',
                                                                            width:
                                                                                15.5,
                                                                            height:
                                                                                15.5,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        if (notificationsItem.tag ==
                                                                            'Event')
                                                                          Image
                                                                              .asset(
                                                                            'assets/images/typcn--flash-removebg-preview.png',
                                                                            width:
                                                                                15.5,
                                                                            height:
                                                                                15.5,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        Text(
                                                                          notificationsItem
                                                                              .tag,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.nunito(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: () {
                                                                                  if ((notificationsItem.tag == 'General') || (notificationsItem.tag == 'Homework') || (notificationsItem.tag == 'Reminder')) {
                                                                                    return FlutterFlowTheme.of(context).text1;
                                                                                  } else if (notificationsItem.tag == 'Event') {
                                                                                    return Color(0xFFC29800);
                                                                                  } else if (notificationsItem.tag == 'Holiday') {
                                                                                    return Color(0xFF072F78);
                                                                                  } else {
                                                                                    return Color(0xFF4E0B6B);
                                                                                  }
                                                                                }(),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ].divide(SizedBox(width: 5.0)).around(
                                                                              SizedBox(width: 5.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              Builder(
                                                                builder:
                                                                    (context) =>
                                                                        InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    await showAlignedDialog(
                                                                      context:
                                                                          context,
                                                                      isGlobal:
                                                                          false,
                                                                      avoidOverflow:
                                                                          false,
                                                                      targetAnchor: AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0)
                                                                          .resolve(
                                                                              Directionality.of(context)),
                                                                      followerAnchor: AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0)
                                                                          .resolve(
                                                                              Directionality.of(context)),
                                                                      builder:
                                                                          (dialogContext) {
                                                                        return Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              FocusScope.of(dialogContext).unfocus();
                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: MediaQuery.sizeOf(context).height * 0.1,
                                                                              width: MediaQuery.sizeOf(context).width * 0.3,
                                                                              child: DeletenotificationWidget(
                                                                                notiref: notificationsItem.reference,
                                                                                schoolref: widget.schoolref,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiaryText,
                                                                    size: 24.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 5.0)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.85,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Visibility(
                                                        visible: notificationsItem
                                                                    .descri !=
                                                                '',
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Text(
                                                            notificationsItem
                                                                .descri
                                                                .maybeHandleOverflow(
                                                              maxChars: 50,
                                                              replacement: '…',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(SizedBox(
                                                          height: 10.0))
                                                      .around(SizedBox(
                                                          height: 10.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ].addToEnd(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    decoration: BoxDecoration(),
                    child: wrapWithModel(
                      model: _model.navbarteacherModel,
                      updateCallback: () => safeSetState(() {}),
                      child: NavbarteacherWidget(
                        pageno: 2,
                        schoolref: widget.schoolref,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
