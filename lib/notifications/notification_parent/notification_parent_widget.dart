import '/admin_dashboard/deletenotification/deletenotification_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbar_parent/navbar_parent_widget.dart';
import '/shimmer_effects/notifications_shimmer/notifications_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_parent_model.dart';
export 'notification_parent_model.dart';

class NotificationParentWidget extends StatefulWidget {
  const NotificationParentWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  static String routeName = 'notification_parent';
  static String routePath = '/calender_day_view';

  @override
  State<NotificationParentWidget> createState() =>
      _NotificationParentWidgetState();
}

class _NotificationParentWidgetState extends State<NotificationParentWidget> {
  late NotificationParentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationParentModel());
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
            body: NotificationsShimmerWidget(),
          );
        }
        List<NotificationsRecord> notificationParentNotificationsRecordList =
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
                    title: Container(
                      width: 120.0,
                      height: 45.0,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
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
                    ),
                    actions: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
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
                                          transitionType:
                                              PageTransitionType.fade,
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
                                          transitionType:
                                              PageTransitionType.fade,
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
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    centerTitle: true,
                    elevation: 2.0,
                  )
                : null,
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 15.0, 0.0, 0.0),
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
                              0.0, 10.0, 0.0, 20.0),
                          child: Builder(
                            builder: (context) {
                              final notifications =
                                  notificationParentNotificationsRecordList
                                      .where((e) => e.userref
                                          .contains(currentUserReference))
                                      .toList()
                                      .sortedList(
                                          keyOf: (e) => e.createDate!,
                                          desc: true)
                                      .toList();
                              if (notifications.isEmpty) {
                                return Center(
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
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
                                        10.0, 0.0, 10.0, 0.0),
                                    child: StreamBuilder<UsersRecord>(
                                      stream: UsersRecord.getDocument(
                                          notificationsItem.addedby!),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            child: NotificationsShimmerWidget(),
                                          );
                                        }

                                        final containerUsersRecord =
                                            snapshot.data!;

                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
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
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: valueOrDefault<Color>(
                                                  notificationsItem.readUseref
                                                          .contains(
                                                              currentUserReference)
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .secondary
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .notificationfill,
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 20.0,
                                                    color: Color(0x1A000000),
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
                                                  color: valueOrDefault<Color>(
                                                    notificationsItem.readUseref
                                                            .contains(
                                                                currentUserReference)
                                                        ? Color(0xFFDDF1F6)
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .notificationBorder,
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                  ),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(5.0),
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
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.4,
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
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
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
                                                                  dateTimeFormat(
                                                                      "dd MMM y",
                                                                      notificationsItem
                                                                          .createDate!),
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
                                                                          return Color(
                                                                              0xFFFFFCF0);
                                                                        } else if (notificationsItem.tag ==
                                                                            'Holiday') {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .reminderfill;
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
                                                                                BoxFit.fill,
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
                                                                              0.0,
                                                                              1.0)
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
                                                                        .primaryText,
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
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.85,
                                                        decoration:
                                                            BoxDecoration(),
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
                                                                .descri,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
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
                                                                          .w500,
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
                                                      .divide(
                                                          SizedBox(height: 5.0))
                                                      .around(SizedBox(
                                                          height: 5.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ].addToEnd(SizedBox(height: 20.0)),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    decoration: BoxDecoration(),
                    child: wrapWithModel(
                      model: _model.navbarParentModel,
                      updateCallback: () => safeSetState(() {}),
                      child: NavbarParentWidget(
                        pageno: 2,
                        schoolref: widget.schoolref!,
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
