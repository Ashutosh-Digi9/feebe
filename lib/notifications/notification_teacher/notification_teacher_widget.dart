import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbarteacher/navbarteacher_widget.dart';
import '/shimmer_effects/notifications_shimmer/notifications_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'notification_teacher_model.dart';
export 'notification_teacher_model.dart';

class NotificationTeacherWidget extends StatefulWidget {
  const NotificationTeacherWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).tertiary,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).info,
          automaticallyImplyLeading: false,
          title: Text(
            'Notifications',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Nunito',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: AuthUserStreamWidget(
                builder: (context) => InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.goNamed(
                      'EditProfile_SA',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );
                  },
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      valueOrDefault<String>(
                        currentUserPhoto,
                        'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fflat-style-woman-avatar_90220-2876.jpg?alt=media&token=2c9154f7-595d-40d6-87fd-c0be9eb08d5a',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: StreamBuilder<List<NotificationsRecord>>(
                          stream: queryNotificationsRecord(
                            queryBuilder: (notificationsRecord) =>
                                notificationsRecord.where(
                              'userref',
                              arrayContains: currentUserReference,
                            ),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return const NotificationsShimmerWidget();
                            }
                            List<NotificationsRecord>
                                containerNotificationsRecordList =
                                snapshot.data!;

                            return Container(
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 20.0),
                                child: Builder(
                                  builder: (context) {
                                    final notifications =
                                        containerNotificationsRecordList
                                            .sortedList(
                                                keyOf: (e) => e.createDate!,
                                                desc: true)
                                            .toList();

                                    return ListView.separated(
                                      padding: const EdgeInsets.fromLTRB(
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
                                          const SizedBox(height: 10.0),
                                      itemBuilder:
                                          (context, notificationsIndex) {
                                        final notificationsItem =
                                            notifications[notificationsIndex];
                                        return Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 5.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.goNamed(
                                                'NotificationVIew',
                                                queryParameters: {
                                                  'notificationref':
                                                      serializeParam(
                                                    notificationsItem.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      const TransitionInfo(
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
                                              elevation: 5.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
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
                                                      : const Color(0xFFF2F5FF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
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
                                                            Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.5,
                                                              decoration:
                                                                  const BoxDecoration(),
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
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          18.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                            ),
                                                            if (notificationsItem
                                                                        .tag !=
                                                                    '')
                                                              Container(
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.04,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: (notificationsItem.tag == 'Notice') ||
                                                                          (notificationsItem.tag ==
                                                                              'Home work') ||
                                                                          (notificationsItem.tag ==
                                                                              'Assignment')
                                                                      ? const Color(
                                                                          0x56FF976A)
                                                                      : const Color(
                                                                          0x577DD7FE),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.59),
                                                                  border: Border
                                                                      .all(
                                                                    color: (notificationsItem.tag == 'Notice') ||
                                                                            (notificationsItem.tag ==
                                                                                'Home work') ||
                                                                            (notificationsItem.tag ==
                                                                                'Assignment')
                                                                        ? const Color(
                                                                            0xFFFF976A)
                                                                        : const Color(
                                                                            0xFF7DD7FE),
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      if ((notificationsItem.tag == 'Notice') ||
                                                                          (notificationsItem.tag ==
                                                                              'Home work') ||
                                                                          (notificationsItem.tag ==
                                                                              'Assignment'))
                                                                        Icon(
                                                                          Icons
                                                                              .push_pin_rounded,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          size:
                                                                              20.0,
                                                                        ),
                                                                      if ((notificationsItem.tag == 'Event') ||
                                                                          (notificationsItem.tag ==
                                                                              'Birthday') ||
                                                                          (notificationsItem.tag ==
                                                                              'Holiday'))
                                                                        Icon(
                                                                          Icons
                                                                              .bolt_outlined,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).warning,
                                                                          size:
                                                                              20.0,
                                                                        ),
                                                                      Text(
                                                                        notificationsItem
                                                                            .tag,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              color: (notificationsItem.tag == 'Notice') || (notificationsItem.tag == 'Home work') || (notificationsItem.tag == 'Assignment') ? FlutterFlowTheme.of(context).alternate : FlutterFlowTheme.of(context).text1,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ]
                                                                        .divide(const SizedBox(
                                                                            width:
                                                                                5.0))
                                                                        .around(const SizedBox(
                                                                            width:
                                                                                5.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                              "relative",
                                                              notificationsItem
                                                                  .createDate!),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: Text(
                                                          notificationsItem
                                                              .notification
                                                              .descriptions,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                    ]
                                                        .divide(const SizedBox(
                                                            height: 10.0))
                                                        .around(const SizedBox(
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
                            );
                          },
                        ),
                      ),
                    ].addToEnd(const SizedBox(height: 10.0)),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Container(
                  decoration: const BoxDecoration(),
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
      ),
    );
  }
}
