import '/admin_dashboard/deletenotification/deletenotification_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_admin_model.dart';
export 'notification_admin_model.dart';

class NotificationAdminWidget extends StatefulWidget {
  const NotificationAdminWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  static String routeName = 'Notification_admin';
  static String routePath = '/notificationAdmin';

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
            body: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              child: ClassshimmerWidget(),
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
                    elevation: 0.0,
                  )
                : null,
            body: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    child: custom_widgets.BackButtonOverrider(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      onBack: () async {
                        context.goNamed(
                          ClassDashboardWidget.routeName,
                          queryParameters: {
                            'schoolref': serializeParam(
                              widget.schoolref,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, -1.0),
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
                          Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 20.0),
                              child: Builder(
                                builder: (context) {
                                  final notices =
                                      notificationAdminNotificationsRecordList
                                          .where((e) =>
                                              e.userref.contains(
                                                  currentUserReference) ==
                                              true)
                                          .toList()
                                          .sortedList(
                                              keyOf: (e) => e.createDate!,
                                              desc: false)
                                          .toList();
                                  if (notices.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        child: EmptyWidget(),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    padding: EdgeInsets.fromLTRB(
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
                                      final noticesItem = notices[noticesIndex];
                                      return StreamBuilder<UsersRecord>(
                                        stream: UsersRecord.getDocument(
                                            noticesItem.addedby!),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              child: ClassshimmerWidget(),
                                            );
                                          }

                                          final columnUsersRecord =
                                              snapshot.data!;

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 10.0),
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
                                                      NotificationVIewWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'notiref':
                                                            serializeParam(
                                                          noticesItem.reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                        'schoolref':
                                                            serializeParam(
                                                          widget.schoolref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );

                                                    await noticesItem.reference
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
                                                          'readschoolref':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            widget.schoolref
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 2.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: noticesItem
                                                                    .readschoolref
                                                                    .contains(
                                                                        widget
                                                                            .schoolref) &&
                                                                (noticesItem
                                                                        .readschoolref
                                                                        .contains(widget
                                                                            .schoolref) ==
                                                                    true)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .notificationfill,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 20.0,
                                                            color: Color(
                                                                0x1B000000),
                                                            offset: Offset(
                                                              0.0,
                                                              2.0,
                                                            ),
                                                            spreadRadius: 0.0,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        border: Border.all(
                                                          color: noticesItem
                                                                      .readschoolref
                                                                      .contains(
                                                                          widget
                                                                              .schoolref) &&
                                                                  (columnUsersRecord
                                                                          .listofSchool
                                                                          .contains(widget
                                                                              .schoolref) ==
                                                                      true)
                                                              ? Color(
                                                                  0xFFDDF1F6)
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .notificationBorder,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            38.0,
                                                                        height:
                                                                            38.0,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            columnUsersRecord.photoUrl,
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: RichText(
                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                text: TextSpan(
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: '${noticesItem.addedby?.id == currentUserReference?.id ? 'You' : columnUsersRecord.displayName} - ',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: Color(0xFF151E28),
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: noticesItem.heading,
                                                                                      style: TextStyle(
                                                                                        color: Color(0xFF151E28),
                                                                                        fontSize: 14.0,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFF151E28),
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            if (noticesItem.towhome.length !=
                                                                                0)
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                decoration: BoxDecoration(),
                                                                                child: Text(
                                                                                  noticesItem.towhome.isNotEmpty ? '${functions.convertToStringclass(noticesItem.towhome.toList())}' : 'Everyone',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  if (valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.userRole,
                                                                          0) !=
                                                                      1)
                                                                    Builder(
                                                                      builder:
                                                                          (context) =>
                                                                              Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                        child:
                                                                            AuthUserStreamWidget(
                                                                          builder: (context) =>
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
                                                                              await showAlignedDialog(
                                                                                context: context,
                                                                                isGlobal: false,
                                                                                avoidOverflow: false,
                                                                                targetAnchor: AlignmentDirectional(0.0, 1.0).resolve(Directionality.of(context)),
                                                                                followerAnchor: AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                builder: (dialogContext) {
                                                                                  return Material(
                                                                                    color: Colors.transparent,
                                                                                    child: GestureDetector(
                                                                                      onTap: () {
                                                                                        FocusScope.of(dialogContext).unfocus();
                                                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                                                      },
                                                                                      child: Container(
                                                                                        height: MediaQuery.sizeOf(context).height * 0.08,
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
                                                                            child:
                                                                                Icon(
                                                                              Icons.more_vert,
                                                                              color: FlutterFlowTheme.of(context).tertiaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
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
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.48,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        if (noticesItem.content !=
                                                                                '')
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.46,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              noticesItem.content,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.nunito(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              10.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            dateTimeFormat("dd MMM y",
                                                                                noticesItem.createDate!),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      if (noticesItem.tag !=
                                                                              '')
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                valueOrDefault<Color>(
                                                                              () {
                                                                                if (noticesItem.tag == 'Event') {
                                                                                  return FlutterFlowTheme.of(context).event;
                                                                                } else if (noticesItem.tag == 'Birthday') {
                                                                                  return FlutterFlowTheme.of(context).birthdayfill;
                                                                                } else if (noticesItem.tag == 'Homework') {
                                                                                  return FlutterFlowTheme.of(context).homework;
                                                                                } else if (noticesItem.tag == 'Reminder') {
                                                                                  return FlutterFlowTheme.of(context).reminderfill;
                                                                                } else if (noticesItem.tag == 'Holiday') {
                                                                                  return FlutterFlowTheme.of(context).holiday;
                                                                                } else {
                                                                                  return FlutterFlowTheme.of(context).event;
                                                                                }
                                                                              }(),
                                                                              FlutterFlowTheme.of(context).text,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(3.59),
                                                                            border:
                                                                                Border.all(
                                                                              color: valueOrDefault<Color>(
                                                                                () {
                                                                                  if (noticesItem.tag == 'Homework') {
                                                                                    return FlutterFlowTheme.of(context).homeworkborder;
                                                                                  } else if (noticesItem.tag == 'Reminder') {
                                                                                    return FlutterFlowTheme.of(context).reminderborder;
                                                                                  } else if (noticesItem.tag == 'General') {
                                                                                    return FlutterFlowTheme.of(context).generalBorder;
                                                                                  } else if (noticesItem.tag == 'Event') {
                                                                                    return FlutterFlowTheme.of(context).eventborder;
                                                                                  } else if (noticesItem.tag == 'Holiday') {
                                                                                    return FlutterFlowTheme.of(context).holidayborder;
                                                                                  } else {
                                                                                    return FlutterFlowTheme.of(context).birthdayborder;
                                                                                  }
                                                                                }(),
                                                                                FlutterFlowTheme.of(context).text,
                                                                              ),
                                                                              width: 1.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                if (noticesItem.tag == 'General')
                                                                                  Image.asset(
                                                                                    'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                                    width: 15.5,
                                                                                    height: 15.5,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                if (noticesItem.tag == 'Reminder')
                                                                                  Image.asset(
                                                                                    'assets/images/3d-alarm.png',
                                                                                    width: 15.5,
                                                                                    height: 15.5,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                if (noticesItem.tag == 'Homework')
                                                                                  Image.asset(
                                                                                    'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                                    width: 15.5,
                                                                                    height: 15.5,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                if (noticesItem.tag == 'Holiday')
                                                                                  Image.asset(
                                                                                    'assets/images/fxemoji--confetti-removebg-preview.png',
                                                                                    width: 15.5,
                                                                                    height: 15.5,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                if (noticesItem.tag == 'Birthday')
                                                                                  Image.asset(
                                                                                    'assets/images/noto--birthday-cake-removebg-preview.png',
                                                                                    width: 15.5,
                                                                                    height: 15.5,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                if (noticesItem.tag == 'Event')
                                                                                  Image.asset(
                                                                                    'assets/images/typcn--flash-removebg-preview.png',
                                                                                    width: 15.5,
                                                                                    height: 15.5,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                Text(
                                                                                  valueOrDefault<String>(
                                                                                    noticesItem.tag,
                                                                                    'Homework',
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: () {
                                                                                          if ((noticesItem.tag == 'General') || (noticesItem.tag == 'Homework') || (noticesItem.tag == 'Reminder')) {
                                                                                            return FlutterFlowTheme.of(context).text1;
                                                                                          } else if (noticesItem.tag == 'Event') {
                                                                                            return Color(0xFFC29800);
                                                                                          } else if (noticesItem.tag == 'Holiday') {
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
                                                                              ].divide(SizedBox(width: 5.0)).around(SizedBox(width: 5.0)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            8.0)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.8,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Visibility(
                                                                visible: noticesItem
                                                                            .descri !=
                                                                        '',
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
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
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiaryText,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
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
                        ].addToEnd(SizedBox(height: 20.0)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      decoration: BoxDecoration(
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
        );
      },
    );
  }
}
