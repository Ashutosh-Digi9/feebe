import '/admin_dashboard/deletenotification/deletenotification_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/shimmer_effects/existingschoolshimmer/existingschoolshimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_v_iew_model.dart';
export 'notification_v_iew_model.dart';

class NotificationVIewWidget extends StatefulWidget {
  const NotificationVIewWidget({
    super.key,
    this.notiref,
    this.schoolref,
    this.index,
  });

  final DocumentReference? notiref;
  final DocumentReference? schoolref;
  final int? index;

  static String routeName = 'NotificationVIew';
  static String routePath = '/notificationVIew';

  @override
  State<NotificationVIewWidget> createState() => _NotificationVIewWidgetState();
}

class _NotificationVIewWidgetState extends State<NotificationVIewWidget> {
  late NotificationVIewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationVIewModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.date = getCurrentTimestamp;
      safeSetState(() {});
      _model.notifications =
          await NotificationsRecord.getDocumentOnce(widget.notiref!);

      await _model.notifications!.reference
          .update(createNotificationsRecordData(
        isread: true,
        notification: createNotificationStruct(
          notificationTitle:
              _model.notifications?.notification.notificationTitle,
          descriptions: _model.notifications?.notification.descriptions,
          timeStamp: _model.notifications?.notification.timeStamp,
          isRead: true,
          eventDate: _model.notifications?.notification.eventDate,
          fieldValues: {
            'notification_files':
                _model.notifications?.notification.notificationFiles,
          },
          clearUnsetFields: false,
        ),
      ));
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NotificationsRecord>(
      stream: NotificationsRecord.getDocument(widget.notiref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: ExistingschoolshimmerWidget(),
          );
        }

        final notificationVIewNotificationsRecord = snapshot.data!;

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
                    leading: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).bgColor1,
                        size: 26.0,
                      ),
                      onPressed: () async {
                        context.pop();
                      },
                    ),
                    title: Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Text(
                        'Notification',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    actions: [
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 20.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showAlignedDialog(
                                context: context,
                                isGlobal: false,
                                avoidOverflow: false,
                                targetAnchor: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                followerAnchor: AlignmentDirectional(1.0, -1.0)
                                    .resolve(Directionality.of(context)),
                                builder: (dialogContext) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(dialogContext).unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.1,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.35,
                                        child: DeletenotificationWidget(
                                          notiref:
                                              notificationVIewNotificationsRecord
                                                  .reference,
                                          schoolref: widget.schoolref,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: FlutterFlowTheme.of(context).tertiaryText,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                    centerTitle: false,
                    elevation: 0.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (valueOrDefault(
                                      currentUserDocument?.userRole, 0) ==
                                  2)
                                AuthUserStreamWidget(
                                  builder: (context) =>
                                      StreamBuilder<UsersRecord>(
                                    stream: UsersRecord.getDocument(
                                        notificationVIewNotificationsRecord
                                            .addedby!),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                      final containerUsersRecord =
                                          snapshot.data!;

                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 38.0,
                                              height: 38.0,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  containerUsersRecord.photoUrl,
                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: RichText(
                                                      textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                '${notificationVIewNotificationsRecord.addedby?.id == currentUserReference?.id ? 'You' : containerUsersRecord.displayName}- ',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                notificationVIewNotificationsRecord
                                                                    .heading,
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiaryText,
                                                              fontSize: 14.0,
                                                            ),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 5.0, 0.0, 10.0),
                                                  child: Text(
                                                    'on ${dateTimeFormat("dd MMM y", notificationVIewNotificationsRecord.notification.timeStamp)}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              if ((notificationVIewNotificationsRecord
                                          .addedby !=
                                      null) ||
                                  (notificationVIewNotificationsRecord
                                          .quickactionstudentref.length ==
                                      0))
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 10.0, 20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.45,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    notificationVIewNotificationsRecord
                                                        .notification
                                                        .notificationTitle,
                                                    'Title',
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              if (notificationVIewNotificationsRecord
                                                          .tag !=
                                                      '')
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          valueOrDefault<Color>(
                                                        () {
                                                          if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Event') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .event;
                                                          } else if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Birthday') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .birthdayfill;
                                                          } else if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Homework') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .homework;
                                                          } else if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Reminder') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .reminderfill;
                                                          } else if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Holiday') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .holiday;
                                                          } else {
                                                            return FlutterFlowTheme
                                                                    .of(context)
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
                                                      border: Border.all(
                                                        color: valueOrDefault<
                                                            Color>(
                                                          () {
                                                            if (notificationVIewNotificationsRecord
                                                                    .tag ==
                                                                'Homework') {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .homeworkborder;
                                                            } else if (notificationVIewNotificationsRecord
                                                                    .tag ==
                                                                'Reminder') {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .reminderborder;
                                                            } else if (notificationVIewNotificationsRecord
                                                                    .tag ==
                                                                'General') {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .generalBorder;
                                                            } else if (notificationVIewNotificationsRecord
                                                                    .tag ==
                                                                'Event') {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .eventborder;
                                                            } else if (notificationVIewNotificationsRecord
                                                                    .tag ==
                                                                'Holiday') {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .holidayborder;
                                                            } else {
                                                              return FlutterFlowTheme
                                                                      .of(context)
                                                                  .birthdayborder;
                                                            }
                                                          }(),
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .text,
                                                        ),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  5.0,
                                                                  5.0,
                                                                  5.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'General')
                                                            Image.asset(
                                                              'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                              width: 15.5,
                                                              height: 15.5,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Reminder')
                                                            Image.asset(
                                                              'assets/images/3d-alarm.png',
                                                              width: 15.5,
                                                              height: 15.5,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Homework')
                                                            Image.asset(
                                                              'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                              width: 15.5,
                                                              height: 15.5,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Holiday')
                                                            Image.asset(
                                                              'assets/images/fxemoji--confetti-removebg-preview.png',
                                                              width: 15.5,
                                                              height: 15.5,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Birthday')
                                                            Image.asset(
                                                              'assets/images/noto--birthday-cake-removebg-preview.png',
                                                              width: 15.5,
                                                              height: 15.5,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          if (notificationVIewNotificationsRecord
                                                                  .tag ==
                                                              'Event')
                                                            Image.asset(
                                                              'assets/images/typcn--flash-removebg-preview.png',
                                                              width: 15.5,
                                                              height: 15.5,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          Text(
                                                            notificationVIewNotificationsRecord
                                                                .tag,
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
                                                                  color: () {
                                                                    if ((notificationVIewNotificationsRecord.tag == 'General') ||
                                                                        (notificationVIewNotificationsRecord.tag ==
                                                                            'Homework') ||
                                                                        (notificationVIewNotificationsRecord.tag ==
                                                                            'Reminder')) {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .text1;
                                                                    } else if (notificationVIewNotificationsRecord
                                                                            .tag ==
                                                                        'Event') {
                                                                      return Color(
                                                                          0xFFC29800);
                                                                    } else if (notificationVIewNotificationsRecord
                                                                            .tag ==
                                                                        'Holiday') {
                                                                      return Color(
                                                                          0xFF072F78);
                                                                    } else {
                                                                      return Color(
                                                                          0xFF4E0B6B);
                                                                    }
                                                                  }(),
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
                                                        ]
                                                            .divide(SizedBox(
                                                                width: 5.0))
                                                            .around(SizedBox(
                                                                width: 5.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          if (notificationVIewNotificationsRecord
                                                  .notification.eventDate !=
                                              null)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Text(
                                                'Date : ${dateTimeFormat("EEEE, d MMMM yyyy | h:mm a", notificationVIewNotificationsRecord.notification.eventDate)}',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (notificationVIewNotificationsRecord
                                                              .notification
                                                              .descriptions !=
                                                          '')
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, -1.0),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            notificationVIewNotificationsRecord
                                                                .notification
                                                                .descriptions,
                                                            'des',
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  if ((notificationVIewNotificationsRecord
                                                              .hasIsquick() ==
                                                          null) ||
                                                      !notificationVIewNotificationsRecord
                                                          .isquick)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            if (notificationVIewNotificationsRecord
                                                                    .notification
                                                                    .notificationFiles
                                                                    .where((e) =>
                                                                        functions
                                                                            .getFileTypeFromUrl(e) ==
                                                                        1)
                                                                    .toList()
                                                                    .length !=
                                                                0)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      if (notificationVIewNotificationsRecord
                                                                              .notification
                                                                              .notificationFiles
                                                                              .where((e) => functions.getFileTypeFromUrl(e) == 1)
                                                                              .toList()
                                                                              .length ==
                                                                          1) {
                                                                        await launchURL(notificationVIewNotificationsRecord
                                                                            .notification
                                                                            .notificationFiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                1)
                                                                            .toList()
                                                                            .firstOrNull!);
                                                                      } else {
                                                                        _model.viewppt =
                                                                            false;
                                                                        _model.viewpdf =
                                                                            true;
                                                                        _model.viewdoc =
                                                                            false;
                                                                        _model.viewmp3 =
                                                                            false;
                                                                        _model.viewimage =
                                                                            false;
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            20.0),
                                                                        child:
                                                                            Stack(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.asset(
                                                                                'assets/images/text_line_pdf.png',
                                                                                width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                height: MediaQuery.sizeOf(context).height * 0.28,
                                                                                fit: BoxFit.none,
                                                                              ),
                                                                            ),
                                                                            if (notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length >
                                                                                1)
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 15.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    _model.viewppt = false;
                                                                                    _model.viewpdf = true;
                                                                                    _model.viewdoc = false;
                                                                                    _model.viewmp3 = false;
                                                                                    _model.viewimage = false;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: badges.Badge(
                                                                                    badgeContent: Text(
                                                                                      notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length.toString(),
                                                                                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 20.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    showBadge: true,
                                                                                    shape: badges.BadgeShape.circle,
                                                                                    badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                    elevation: 5.0,
                                                                                    padding: EdgeInsets.all(5.0),
                                                                                    position: badges.BadgePosition.topEnd(),
                                                                                    animationType: badges.BadgeAnimationType.scale,
                                                                                    toAnimate: true,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model.viewpdf)
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final imagesview = notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .where((e) =>
                                                                          functions
                                                                              .getFileTypeFromUrl(e) ==
                                                                          1)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        imagesview
                                                                            .length,
                                                                    separatorBuilder: (_,
                                                                            __) =>
                                                                        SizedBox(
                                                                            height:
                                                                                10.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                            imagesviewIndex) {
                                                                      final imagesviewItem =
                                                                          imagesview[
                                                                              imagesviewIndex];
                                                                      return Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                10.0,
                                                                                10.0),
                                                                            child:
                                                                                badges.Badge(
                                                                              badgeContent: Text(
                                                                                functions.plusIndex(imagesviewIndex).toString(),
                                                                                style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      font: GoogleFonts.nunito(
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              showBadge: true,
                                                                              shape: badges.BadgeShape.circle,
                                                                              badgeColor: FlutterFlowTheme.of(context).primary,
                                                                              elevation: 5.0,
                                                                              padding: EdgeInsets.all(5.0),
                                                                              position: badges.BadgePosition.topEnd(),
                                                                              animationType: badges.BadgeAnimationType.scale,
                                                                              toAnimate: true,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                child: Image.asset(
                                                                                  'assets/images/text_line_pdf.png',
                                                                                  width: 46.0,
                                                                                  height: 41.0,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              await launchURL(imagesviewItem);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                  child: Icon(
                                                                                    Icons.remove_red_eye,
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    size: 20.0,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Text(
                                                                                    'View File',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            if (notificationVIewNotificationsRecord
                                                                    .notification
                                                                    .notificationFiles
                                                                    .where((e) =>
                                                                        functions
                                                                            .getFileTypeFromUrl(e) ==
                                                                        2)
                                                                    .toList()
                                                                    .length !=
                                                                0)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      if (notificationVIewNotificationsRecord
                                                                              .notification
                                                                              .notificationFiles
                                                                              .where((e) => functions.getFileTypeFromUrl(e) == 2)
                                                                              .toList()
                                                                              .length ==
                                                                          1) {
                                                                        await launchURL(notificationVIewNotificationsRecord
                                                                            .notification
                                                                            .notificationFiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                2)
                                                                            .toList()
                                                                            .firstOrNull!);
                                                                      } else {
                                                                        _model.viewppt =
                                                                            false;
                                                                        _model.viewpdf =
                                                                            false;
                                                                        _model.viewdoc =
                                                                            true;
                                                                        _model.viewmp3 =
                                                                            false;
                                                                        _model.viewimage =
                                                                            false;
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            20.0),
                                                                        child:
                                                                            Stack(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.asset(
                                                                                'assets/images/text_line_doc.png',
                                                                                width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                height: MediaQuery.sizeOf(context).height * 0.28,
                                                                                fit: BoxFit.none,
                                                                              ),
                                                                            ),
                                                                            if (notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length >
                                                                                1)
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 15.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    _model.viewppt = false;
                                                                                    _model.viewpdf = false;
                                                                                    _model.viewdoc = true;
                                                                                    _model.viewmp3 = false;
                                                                                    _model.viewimage = false;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: badges.Badge(
                                                                                    badgeContent: Text(
                                                                                      notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length.toString(),
                                                                                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 20.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    showBadge: true,
                                                                                    shape: badges.BadgeShape.circle,
                                                                                    badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                    elevation: 5.0,
                                                                                    padding: EdgeInsets.all(5.0),
                                                                                    position: badges.BadgePosition.topEnd(),
                                                                                    animationType: badges.BadgeAnimationType.scale,
                                                                                    toAnimate: true,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model.viewdoc)
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final imagesview = notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .where((e) =>
                                                                          functions
                                                                              .getFileTypeFromUrl(e) ==
                                                                          2)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        imagesview
                                                                            .length,
                                                                    separatorBuilder: (_,
                                                                            __) =>
                                                                        SizedBox(
                                                                            height:
                                                                                10.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                            imagesviewIndex) {
                                                                      final imagesviewItem =
                                                                          imagesview[
                                                                              imagesviewIndex];
                                                                      return Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          badges
                                                                              .Badge(
                                                                            badgeContent:
                                                                                Text(
                                                                              functions.plusIndex(imagesviewIndex).toString(),
                                                                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    font: GoogleFonts.nunito(
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            showBadge:
                                                                                true,
                                                                            shape:
                                                                                badges.BadgeShape.circle,
                                                                            badgeColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            elevation:
                                                                                0.0,
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            position:
                                                                                badges.BadgePosition.topEnd(),
                                                                            animationType:
                                                                                badges.BadgeAnimationType.scale,
                                                                            toAnimate:
                                                                                true,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.asset(
                                                                                'assets/images/text_line_doc.png',
                                                                                width: 46.0,
                                                                                height: 41.0,
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              await launchURL(imagesviewItem);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                  child: Icon(
                                                                                    Icons.remove_red_eye,
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    size: 20.0,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Text(
                                                                                    'View File',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            if (notificationVIewNotificationsRecord
                                                                    .notification
                                                                    .notificationFiles
                                                                    .where((e) =>
                                                                        functions
                                                                            .getFileTypeFromUrl(e) ==
                                                                        2)
                                                                    .toList()
                                                                    .length !=
                                                                0)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      if (notificationVIewNotificationsRecord
                                                                              .notification
                                                                              .notificationFiles
                                                                              .where((e) => functions.getFileTypeFromUrl(e) == 3)
                                                                              .toList()
                                                                              .length ==
                                                                          1) {
                                                                        await launchURL(notificationVIewNotificationsRecord
                                                                            .notification
                                                                            .notificationFiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                3)
                                                                            .toList()
                                                                            .firstOrNull!);
                                                                      } else {
                                                                        _model.viewppt =
                                                                            false;
                                                                        _model.viewpdf =
                                                                            false;
                                                                        _model.viewdoc =
                                                                            false;
                                                                        _model.viewmp3 =
                                                                            true;
                                                                        _model.viewimage =
                                                                            false;
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            20.0),
                                                                        child:
                                                                            Stack(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.asset(
                                                                                'assets/images/text_line_mp3.png',
                                                                                width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                height: MediaQuery.sizeOf(context).height * 0.28,
                                                                                fit: BoxFit.none,
                                                                              ),
                                                                            ),
                                                                            if (notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length >
                                                                                1)
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 15.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    _model.viewppt = false;
                                                                                    _model.viewpdf = false;
                                                                                    _model.viewdoc = false;
                                                                                    _model.viewmp3 = true;
                                                                                    _model.viewimage = false;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: badges.Badge(
                                                                                    badgeContent: Text(
                                                                                      notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length.toString(),
                                                                                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 20.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    showBadge: true,
                                                                                    shape: badges.BadgeShape.circle,
                                                                                    badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                    elevation: 5.0,
                                                                                    padding: EdgeInsets.all(5.0),
                                                                                    position: badges.BadgePosition.topEnd(),
                                                                                    animationType: badges.BadgeAnimationType.scale,
                                                                                    toAnimate: true,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model.viewmp3)
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final imagesview = notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .where((e) =>
                                                                          functions
                                                                              .getFileTypeFromUrl(e) ==
                                                                          3)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        imagesview
                                                                            .length,
                                                                    separatorBuilder: (_,
                                                                            __) =>
                                                                        SizedBox(
                                                                            height:
                                                                                10.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                            imagesviewIndex) {
                                                                      final imagesviewItem =
                                                                          imagesview[
                                                                              imagesviewIndex];
                                                                      return Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          badges
                                                                              .Badge(
                                                                            badgeContent:
                                                                                Text(
                                                                              functions.plusIndex(imagesviewIndex).toString(),
                                                                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    font: GoogleFonts.nunito(
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            showBadge:
                                                                                true,
                                                                            shape:
                                                                                badges.BadgeShape.circle,
                                                                            badgeColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            elevation:
                                                                                0.0,
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            position:
                                                                                badges.BadgePosition.topEnd(),
                                                                            animationType:
                                                                                badges.BadgeAnimationType.scale,
                                                                            toAnimate:
                                                                                true,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.asset(
                                                                                'assets/images/text_line_mp3.png',
                                                                                width: 46.0,
                                                                                height: 41.0,
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              await launchURL(imagesviewItem);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                  child: Icon(
                                                                                    Icons.remove_red_eye,
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    size: 20.0,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Text(
                                                                                    'View File',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            if (notificationVIewNotificationsRecord
                                                                    .notification
                                                                    .notificationFiles
                                                                    .where((e) =>
                                                                        functions
                                                                            .getFileTypeFromUrl(e) ==
                                                                        4)
                                                                    .toList()
                                                                    .length !=
                                                                0)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      if (notificationVIewNotificationsRecord
                                                                              .notification
                                                                              .notificationFiles
                                                                              .where((e) => functions.getFileTypeFromUrl(e) == 4)
                                                                              .toList()
                                                                              .length ==
                                                                          1) {
                                                                        await launchURL(notificationVIewNotificationsRecord
                                                                            .notification
                                                                            .notificationFiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                4)
                                                                            .toList()
                                                                            .firstOrNull!);
                                                                      } else {
                                                                        _model.viewppt =
                                                                            false;
                                                                        _model.viewpdf =
                                                                            false;
                                                                        _model.viewdoc =
                                                                            false;
                                                                        _model.viewmp3 =
                                                                            false;
                                                                        _model.viewimage =
                                                                            true;
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            20.0),
                                                                        child:
                                                                            Stack(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          children: [
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                await Navigator.push(
                                                                                  context,
                                                                                  PageTransition(
                                                                                    type: PageTransitionType.fade,
                                                                                    child: FlutterFlowExpandedImageView(
                                                                                      image: Image.network(
                                                                                        valueOrDefault<String>(
                                                                                          functions.converttoimagepath(notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().firstOrNull!),
                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                                                        ),
                                                                                        fit: BoxFit.contain,
                                                                                      ),
                                                                                      allowRotation: false,
                                                                                      tag: valueOrDefault<String>(
                                                                                        functions.converttoimagepath(notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().firstOrNull!),
                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                                                      ),
                                                                                      useHeroAnimation: true,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Hero(
                                                                                tag: valueOrDefault<String>(
                                                                                  functions.converttoimagepath(notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().firstOrNull!),
                                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                                                ),
                                                                                transitionOnUserGestures: true,
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    valueOrDefault<String>(
                                                                                      functions.converttoimagepath(notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().firstOrNull!),
                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                                                    ),
                                                                                    width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                    height: MediaQuery.sizeOf(context).height * 0.28,
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            if (notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length >
                                                                                1)
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 15.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    _model.viewppt = false;
                                                                                    _model.viewpdf = false;
                                                                                    _model.viewdoc = false;
                                                                                    _model.viewmp3 = false;
                                                                                    _model.viewimage = true;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: badges.Badge(
                                                                                    badgeContent: Text(
                                                                                      notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length.toString(),
                                                                                      style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 20.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    showBadge: true,
                                                                                    shape: badges.BadgeShape.circle,
                                                                                    badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                    elevation: 5.0,
                                                                                    padding: EdgeInsets.all(5.0),
                                                                                    position: badges.BadgePosition.topEnd(),
                                                                                    animationType: badges.BadgeAnimationType.scale,
                                                                                    toAnimate: true,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model
                                                                .viewimage)
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final imagesview = notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .where((e) =>
                                                                          functions
                                                                              .getFileTypeFromUrl(e) ==
                                                                          4)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        imagesview
                                                                            .length,
                                                                    separatorBuilder: (_,
                                                                            __) =>
                                                                        SizedBox(
                                                                            height:
                                                                                10.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                            imagesviewIndex) {
                                                                      final imagesviewItem =
                                                                          imagesview[
                                                                              imagesviewIndex];
                                                                      return Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child: badges
                                                                            .Badge(
                                                                          badgeContent:
                                                                              Text(
                                                                            functions.serialnumber(imagesviewIndex).toString(),
                                                                            style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          showBadge:
                                                                              true,
                                                                          shape: badges
                                                                              .BadgeShape
                                                                              .circle,
                                                                          badgeColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          elevation:
                                                                              0.0,
                                                                          padding:
                                                                              EdgeInsets.all(5.0),
                                                                          position:
                                                                              badges.BadgePosition.topStart(),
                                                                          animationType: badges
                                                                              .BadgeAnimationType
                                                                              .scale,
                                                                          toAnimate:
                                                                              true,
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, -1.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                await Navigator.push(
                                                                                  context,
                                                                                  PageTransition(
                                                                                    type: PageTransitionType.fade,
                                                                                    child: FlutterFlowExpandedImageView(
                                                                                      image: Image.network(
                                                                                        functions.converttoimagepath(imagesviewItem),
                                                                                        fit: BoxFit.contain,
                                                                                      ),
                                                                                      allowRotation: false,
                                                                                      tag: functions.converttoimagepath(imagesviewItem),
                                                                                      useHeroAnimation: true,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Hero(
                                                                                tag: functions.converttoimagepath(imagesviewItem),
                                                                                transitionOnUserGestures: true,
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    functions.converttoimagepath(imagesviewItem),
                                                                                    width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                    height: MediaQuery.sizeOf(context).height * 0.28,
                                                                                    fit: BoxFit.contain,
                                                                                  ),
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
                                                            if (notificationVIewNotificationsRecord
                                                                    .notification
                                                                    .notificationFiles
                                                                    .where((e) =>
                                                                        functions
                                                                            .getFileTypeFromUrl(e) ==
                                                                        5)
                                                                    .toList()
                                                                    .length !=
                                                                0)
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            12.0),
                                                                child: InkWell(
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
                                                                    if (notificationVIewNotificationsRecord
                                                                            .notification
                                                                            .notificationFiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                5)
                                                                            .toList()
                                                                            .length ==
                                                                        0) {
                                                                      await launchURL(notificationVIewNotificationsRecord
                                                                          .notification
                                                                          .notificationFiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              5)
                                                                          .toList()
                                                                          .firstOrNull!);
                                                                    } else {
                                                                      _model.viewppt =
                                                                          true;
                                                                      _model.viewpdf =
                                                                          false;
                                                                      _model.viewdoc =
                                                                          false;
                                                                      _model.viewmp3 =
                                                                          false;
                                                                      _model.viewimage =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.8,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.28,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          20.0),
                                                                      child:
                                                                          Stack(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            1.0),
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.asset(
                                                                                'assets/images/text_line_ppt.png',
                                                                                width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                height: MediaQuery.sizeOf(context).height * 0.28,
                                                                                fit: BoxFit.none,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          if (notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length >
                                                                              0)
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 15.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  _model.viewppt = true;
                                                                                  _model.viewpdf = false;
                                                                                  _model.viewdoc = false;
                                                                                  _model.viewmp3 = false;
                                                                                  _model.viewimage = false;
                                                                                  safeSetState(() {});
                                                                                },
                                                                                child: badges.Badge(
                                                                                  badgeContent: Text(
                                                                                    notificationVIewNotificationsRecord.notification.notificationFiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length.toString(),
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          fontSize: 20.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                  showBadge: true,
                                                                                  shape: badges.BadgeShape.circle,
                                                                                  badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                  elevation: 5.0,
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  position: badges.BadgePosition.topEnd(),
                                                                                  animationType: badges.BadgeAnimationType.scale,
                                                                                  toAnimate: true,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model.viewppt)
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final imagesview = notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .where((e) =>
                                                                          functions
                                                                              .getFileTypeFromUrl(e) ==
                                                                          5)
                                                                      .toList();

                                                                  return ListView
                                                                      .separated(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        imagesview
                                                                            .length,
                                                                    separatorBuilder: (_,
                                                                            __) =>
                                                                        SizedBox(
                                                                            height:
                                                                                10.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                            imagesviewIndex) {
                                                                      final imagesviewItem =
                                                                          imagesview[
                                                                              imagesviewIndex];
                                                                      return Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          badges
                                                                              .Badge(
                                                                            badgeContent:
                                                                                Text(
                                                                              functions.plusIndex(imagesviewIndex).toString(),
                                                                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    font: GoogleFonts.nunito(
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            showBadge:
                                                                                true,
                                                                            shape:
                                                                                badges.BadgeShape.circle,
                                                                            badgeColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            elevation:
                                                                                0.0,
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            position:
                                                                                badges.BadgePosition.topEnd(),
                                                                            animationType:
                                                                                badges.BadgeAnimationType.scale,
                                                                            toAnimate:
                                                                                true,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.asset(
                                                                                'assets/images/text_line_ppt.png',
                                                                                width: 46.0,
                                                                                height: 41.0,
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              await launchURL(imagesviewItem);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                  child: Icon(
                                                                                    Icons.remove_red_eye,
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    size: 20.0,
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                  child: Text(
                                                                                    'View File',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  if ((notificationVIewNotificationsRecord
                                                              .isquick !=
                                                          null) &&
                                                      notificationVIewNotificationsRecord
                                                          .isquick)
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.8,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if ((notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .length !=
                                                                  0) &&
                                                              !functions.isVideoFile(
                                                                  notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .firstOrNull!))
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.network(
                                                                functions.converttoimagepath(notificationVIewNotificationsRecord
                                                                    .notification
                                                                    .notificationFiles
                                                                    .firstOrNull!),
                                                                width: 311.0,
                                                                height: 249.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          if ((notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .length !=
                                                                  0) &&
                                                              functions.isVideoFile(
                                                                  notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .firstOrNull!))
                                                            FlutterFlowVideoPlayer(
                                                              path: functions.converttovideo(
                                                                  notificationVIewNotificationsRecord
                                                                      .notification
                                                                      .notificationFiles
                                                                      .firstOrNull!),
                                                              videoType:
                                                                  VideoType
                                                                      .network,
                                                              autoPlay: false,
                                                              looping: true,
                                                              showControls:
                                                                  true,
                                                              allowFullScreen:
                                                                  true,
                                                              allowPlaybackSpeedMenu:
                                                                  false,
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]
                                            .divide(SizedBox(height: 10.0))
                                            .around(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((notificationVIewNotificationsRecord
                                          .quickactionstudentref.length !=
                                      0) &&
                                  (valueOrDefault(
                                          currentUserDocument?.userRole, 0) !=
                                      4))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (notificationVIewNotificationsRecord
                                                    .towhome.length !=
                                                0)
                                              Builder(
                                                builder: (context) {
                                                  final names =
                                                      notificationVIewNotificationsRecord
                                                          .towhome
                                                          .toList();

                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                        names.length,
                                                        (namesIndex) {
                                                      final namesItem =
                                                          names[namesIndex];
                                                      return Text(
                                                        '${namesItem}, ',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .nunito(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 18.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                      );
                                                    }),
                                                  );
                                                },
                                              ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 5.0, 5.0, 0.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final students =
                                                        notificationVIewNotificationsRecord
                                                            .quickactionstudentref
                                                            .toList();

                                                    return GridView.builder(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 10.0,
                                                        mainAxisSpacing: 10.0,
                                                        childAspectRatio: 0.9,
                                                      ),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          students.length,
                                                      itemBuilder: (context,
                                                          studentsIndex) {
                                                        final studentsItem =
                                                            students[
                                                                studentsIndex];
                                                        return StreamBuilder<
                                                            StudentsRecord>(
                                                          stream: StudentsRecord
                                                              .getDocument(
                                                                  studentsItem),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                            Color>(
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }

                                                            final containerStudentsRecord =
                                                                snapshot.data!;

                                                            return Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 1.0,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .lightblue,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          2.0,
                                                                      color: Color(
                                                                          0x40E4E5E7),
                                                                      offset:
                                                                          Offset(
                                                                        0.0,
                                                                        1.0,
                                                                      ),
                                                                      spreadRadius:
                                                                          0.0,
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xFFEDF1F3),
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.14,
                                                                        height: MediaQuery.sizeOf(context).width *
                                                                            0.14,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          containerStudentsRecord
                                                                              .studentImage,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        containerStudentsRecord
                                                                            .studentName,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]
                                              .divide(SizedBox(height: 10.0))
                                              .around(SizedBox(height: 10.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ]
                                .divide(SizedBox(height: 5.0))
                                .around(SizedBox(height: 5.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
