import '/admin_dashboard/deletenotification/deletenotification_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbar_parent/navbar_parent_widget.dart';
import '/shimmer_effects/notifications_shimmer/notifications_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'notification_parent_model.dart';
export 'notification_parent_model.dart';

class NotificationParentWidget extends StatefulWidget {
  const NotificationParentWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

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
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).bgColor1,
              size: 28.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Notifications',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Nunito',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
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
                          stream: queryNotificationsRecord(),
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
                                            .where((e) => e.userref
                                                .contains(currentUserReference))
                                            .toList()
                                            .sortedList(
                                                keyOf: (e) => e.createDate!,
                                                desc: true)
                                            .toList();
                                    if (notifications.isEmpty) {
                                      return Center(
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          child: const EmptyWidget(),
                                        ),
                                      );
                                    }

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
                                              context.pushNamed(
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
                                                    BorderRadius.circular(16.0),
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
                                                          16.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      StreamBuilder<
                                                          UsersRecord>(
                                                        stream: UsersRecord
                                                            .getDocument(
                                                                notificationsItem
                                                                    .addedby!),
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

                                                          final containerUsersRecord =
                                                              snapshot.data!;

                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.15,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.15,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      containerUsersRecord
                                                                          .photoUrl,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                        child:
                                                                            Text(
                                                                          '${containerUsersRecord.displayName}- ${notificationsItem.heading}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.65,
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            functions.convertToStringclass(notificationsItem.towhome.toList()),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
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
                                                                  0.4,
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
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
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
                                                                    height: MediaQuery.sizeOf(context)
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
                                                                          BorderRadius.circular(
                                                                              3.59),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: (notificationsItem.tag == 'Notice') ||
                                                                                (notificationsItem.tag == 'Home work') ||
                                                                                (notificationsItem.tag == 'Assignment')
                                                                            ? const Color(0xFFFF976A)
                                                                            : const Color(0xFF7DD7FE),
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          if ((notificationsItem.tag == 'Notice') ||
                                                                              (notificationsItem.tag == 'Home work') ||
                                                                              (notificationsItem.tag == 'Assignment'))
                                                                            Icon(
                                                                              Icons.push_pin_rounded,
                                                                              color: FlutterFlowTheme.of(context).error,
                                                                              size: 20.0,
                                                                            ),
                                                                          if ((notificationsItem.tag == 'Event') ||
                                                                              (notificationsItem.tag == 'Birthday') ||
                                                                              (notificationsItem.tag == 'Holiday'))
                                                                            Icon(
                                                                              Icons.bolt_outlined,
                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                              size: 20.0,
                                                                            ),
                                                                          Text(
                                                                            notificationsItem.tag,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  color: (notificationsItem.tag == 'Notice') || (notificationsItem.tag == 'Home work') || (notificationsItem.tag == 'Assignment') ? FlutterFlowTheme.of(context).alternate : FlutterFlowTheme.of(context).text1,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ].divide(const SizedBox(width: 5.0)).around(const SizedBox(width: 5.0)),
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
                                                                      await showAlignedDialog(
                                                                        context:
                                                                            context,
                                                                        isGlobal:
                                                                            false,
                                                                        avoidOverflow:
                                                                            false,
                                                                        targetAnchor:
                                                                            const AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                        followerAnchor:
                                                                            const AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: SizedBox(
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
                                                                      size:
                                                                          30.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(const SizedBox(
                                                                  width: 5.0)),
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
                                                              "dd, MM, y",
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
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.85,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Visibility(
                                                          visible: notificationsItem
                                                                      .descri !=
                                                                  '',
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
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
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiaryText,
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
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
                    ].addToEnd(const SizedBox(height: 20.0)),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Container(
                  decoration: const BoxDecoration(),
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
      ),
    );
  }
}
