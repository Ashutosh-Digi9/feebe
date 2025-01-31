import '/admin_dashboard/deletenotification/deletenotification_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'notification_admin_model.dart';
export 'notification_admin_model.dart';

class NotificationAdminWidget extends StatefulWidget {
  const NotificationAdminWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  @override
  State<NotificationAdminWidget> createState() =>
      _NotificationAdminWidgetState();
}

class _NotificationAdminWidgetState extends State<NotificationAdminWidget> {
  late NotificationAdminModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationAdminModel());
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
            body: SizedBox(
              width: MediaQuery.sizeOf(context).width * 1.0,
              child: const ClassshimmerWidget(),
            ),
          );
        }
        List<NotificationsRecord> notificationAdminNotificationsRecordList =
            snapshot.data!;

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
                  padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 10.0, 0.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'Profile_view',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
                        );
                      },
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          valueOrDefault<String>(
                            currentUserPhoto,
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
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
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.82,
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 20.0),
                                child: Builder(
                                  builder: (context) {
                                    final notices =
                                        notificationAdminNotificationsRecordList
                                            .where((e) => e.schoolref
                                                .contains(widget.schoolref))
                                            .toList()
                                            .sortedList(
                                                keyOf: (e) => e.createDate!,
                                                desc: true)
                                            .toList();
                                    if (notices.isEmpty) {
                                      return Center(
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          child: const EmptyWidget(),
                                        ),
                                      );
                                    }

                                    return ListView.builder(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        20.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: notices.length,
                                      itemBuilder: (context, noticesIndex) {
                                        final noticesItem =
                                            notices[noticesIndex];
                                        return StreamBuilder<UsersRecord>(
                                          stream: UsersRecord.getDocument(
                                              noticesItem.addedby!),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
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

                                            final columnUsersRecord =
                                                snapshot.data!;

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(10.0, 0.0, 10.0,
                                                          10.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'NotificationVIew',
                                                        queryParameters: {
                                                          'notificationref':
                                                              serializeParam(
                                                            noticesItem
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          kTransitionInfoKey:
                                                              const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .fade,
                                                          ),
                                                        },
                                                      );

                                                      await noticesItem
                                                          .reference
                                                          .update({
                                                        ...createNotificationsRecordData(
                                                          isread: true,
                                                        ),
                                                        ...mapToFirestore(
                                                          {
                                                            'ReadUseref':
                                                                FieldValue
                                                                    .arrayUnion([
                                                              currentUserReference
                                                            ]),
                                                          },
                                                        ),
                                                      });
                                                    },
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 5.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: noticesItem
                                                                  .readUseref
                                                                  .contains(
                                                                      currentUserReference)
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .secondary
                                                              : const Color(
                                                                  0xFFF2F5FF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    const BoxDecoration(),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          60.0,
                                                                      height:
                                                                          60.0,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30.0),
                                                                        child: Image
                                                                            .network(
                                                                          columnUsersRecord
                                                                              .photoUrl,
                                                                          width:
                                                                              200.0,
                                                                          height:
                                                                              200.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Text(
                                                                              '${noticesItem.addedby?.id == currentUserReference?.id ? 'You' : columnUsersRecord.displayName} - ${noticesItem.heading}',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.6,
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              functions.convertToStringclass(noticesItem.towhome.toList()),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional
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
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.4,
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Text(
                                                                        noticesItem
                                                                            .content,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        if (noticesItem.tag !=
                                                                                '')
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.04,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: (noticesItem.tag == 'Notice') || (noticesItem.tag == 'Home work') || (noticesItem.tag == 'Assignment') ? const Color(0x56FF976A) : const Color(0x577DD7FE),
                                                                              borderRadius: BorderRadius.circular(3.59),
                                                                              border: Border.all(
                                                                                color: (noticesItem.tag == 'Notice') || (noticesItem.tag == 'Home work') || (noticesItem.tag == 'Assignment') ? const Color(0xFFFF976A) : const Color(0xFF7DD7FE),
                                                                                width: 2.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  if ((noticesItem.tag == 'Notice') || (noticesItem.tag == 'Reminder') || (noticesItem.tag == 'General'))
                                                                                    Icon(
                                                                                      Icons.push_pin_rounded,
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      size: 20.0,
                                                                                    ),
                                                                                  if ((noticesItem.tag == 'Event') || (noticesItem.tag == 'Birthday') || (noticesItem.tag == 'Holiday'))
                                                                                    Icon(
                                                                                      Icons.bolt_outlined,
                                                                                      color: FlutterFlowTheme.of(context).warning,
                                                                                      size: 20.0,
                                                                                    ),
                                                                                  Text(
                                                                                    noticesItem.tag,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: (noticesItem.tag == 'Notice') || (noticesItem.tag == 'Home work') || (noticesItem.tag == 'Assignment') ? FlutterFlowTheme.of(context).alternate : FlutterFlowTheme.of(context).text1,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ].divide(const SizedBox(width: 5.0)).around(const SizedBox(width: 5.0)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        if (columnUsersRecord.userRole ==
                                                                            2)
                                                                          Builder(
                                                                            builder: (context) =>
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                await showAlignedDialog(
                                                                                  context: context,
                                                                                  isGlobal: false,
                                                                                  avoidOverflow: false,
                                                                                  targetAnchor: const AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                  followerAnchor: const AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                  builder: (dialogContext) {
                                                                                    return Material(
                                                                                      color: Colors.transparent,
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          FocusScope.of(dialogContext).unfocus();
                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                        },
                                                                                        child: SizedBox(
                                                                                          height: MediaQuery.sizeOf(context).height * 0.1,
                                                                                          width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                          child: DeletenotificationWidget(
                                                                                            notiref: noticesItem.reference,
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
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 30.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ].divide(const SizedBox(
                                                                              width: 10.0)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                                child: Text(
                                                                  dateTimeFormat(
                                                                      "dd ,MM, y",
                                                                      noticesItem
                                                                          .createDate!),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiaryText,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.8,
                                                                decoration:
                                                                    const BoxDecoration(),
                                                                child:
                                                                    Visibility(
                                                                  visible: noticesItem
                                                                              .descri !=
                                                                          '',
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      noticesItem
                                                                          .descri
                                                                          .maybeHandleOverflow(
                                                                        maxChars:
                                                                            50,
                                                                        replacement:
                                                                            '…',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Nunito',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                                .divide(const SizedBox(
                                                                    height:
                                                                        10.0))
                                                                .around(const SizedBox(
                                                                    height:
                                                                        10.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ].addToEnd(const SizedBox(height: 20.0)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Color(0x40B7B7B7),
                              offset: Offset(
                                2.0,
                                -5.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                        ),
                        child: wrapWithModel(
                          model: _model.navbaradminModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbaradminWidget(
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
          ),
        );
      },
    );
  }
}
