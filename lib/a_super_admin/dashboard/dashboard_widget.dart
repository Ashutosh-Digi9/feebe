import '/admin_dashboard/quick_action_for_class/quick_action_for_class_widget.dart';
import '/admin_dashboard/select_class_notice/select_class_notice_widget.dart';
import '/admin_dashboard/videoplayer/videoplayer_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/delete_copy_widget.dart';
import '/components/empty_widget.dart';
import '/components/emptystudent_widget.dart';
import '/confirmationpages/empty_class_copy/empty_class_copy_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/navbar/nav_bar_s_a/nav_bar_s_a_widget.dart';
import '/navbar/navbar_parent/navbar_parent_widget.dart';
import '/navbar/navbarteacher/navbarteacher_widget.dart';
import '/parent/class_event_view/class_event_view_widget.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import '/shimmer_effects/event_shimmer/event_shimmer_widget.dart';
import '/shimmer_effects/main_dashboard_shimmer/main_dashboard_shimmer_widget.dart';
import '/shimmer_effects/studentshimmer/studentshimmer_widget.dart';
import '/teacher/upcomingevent_teacher/upcomingevent_teacher_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({
    super.key,
    int? tabindex,
    bool? fromlogin,
  })  : this.tabindex = tabindex ?? 0,
        this.fromlogin = fromlogin ?? true;

  final int tabindex;
  final bool fromlogin;

  static String routeName = 'Dashboard';
  static String routePath = '/dashboard';

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {
  late DashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().studentimage = '';
      FFAppState().eventDetails = EventsNoticeStruct();
      FFAppState().eventfiles = [];
      FFAppState().update(() {});
      _model.calendarDate = getCurrentTimestamp;
      _model.datetime = getCurrentTimestamp;
      _model.eventname = 'General';
      safeSetState(() {});
      safeSetState(() {
        _model.descriptionTextController?.clear();
        _model.eventnameTextController?.clear();
      });
      FFAppState().profileimagechanged = false;
      FFAppState().schoolimagechanged = false;
      FFAppState().imageurl = '';
      FFAppState().schoolimage = '';
      safeSetState(() {});
      if (valueOrDefault(currentUserDocument?.userRole, 0) == 2) {
        if (currentUserDocument?.subcriptiondetails == null) {
          context.pushNamed(
            SubscribtioplanWidget.routeName,
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
              ),
            },
          );
        } else if (functions.formatDate(getCurrentTimestamp) >
            functions
                .formatDate(currentUserDocument!.subcriptiondetails.endDate!)) {
          _model.school = await querySchoolRecordOnce(
            queryBuilder: (schoolRecord) => schoolRecord.where(
              'principal_details.principal_id',
              isEqualTo: currentUserReference,
            ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);

          await currentUserReference!.update(createUsersRecordData(
            subscriptionStatus: 1,
          ));

          await _model.school!.reference.update(createSchoolRecordData(
            subscriptionStatus: 1,
          ));

          context.goNamed(SubscriptionendedWidget.routeName);
        } else if (valueOrDefault(currentUserDocument?.subscriptionStatus, 0) !=
            2) {
          context.goNamed(AmountNotPaiddWidget.routeName);
        } else {
          if (widget.fromlogin) {
            _model.numberofSchool = await querySchoolRecordOnce(
              queryBuilder: (schoolRecord) => schoolRecord.where(
                'listOfAdmin',
                arrayContains: currentUserReference,
              ),
            );
            if (_model.numberofSchool?.length == 1) {
              context.pushNamed(
                ClassDashboardWidget.routeName,
                queryParameters: {
                  'schoolref': serializeParam(
                    _model.numberofSchool?.firstOrNull?.reference,
                    ParamType.DocumentReference,
                  ),
                }.withoutNulls,
              );
            }
          }
        }
      } else if (valueOrDefault(currentUserDocument?.userRole, 0) == 3) {
        _model.teacherSchool = await querySchoolRecordOnce(
          queryBuilder: (schoolRecord) => schoolRecord.where(
            'listOfteachersuser',
            arrayContains: currentUserReference,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        if (currentUserDocument?.popupdate != null) {
          if (dateTimeFormat("yMd", getCurrentTimestamp) !=
              dateTimeFormat("yMd", currentUserDocument?.popupdate)) {
            if (functions
                    .filterEventsAfterTwoDays(
                        _model.teacherSchool!.calendarList.toList(),
                        getCurrentTimestamp)
                    .length !=
                0) {
              await showAlignedDialog(
                context: context,
                isGlobal: false,
                avoidOverflow: false,
                targetAnchor: AlignmentDirectional(0.0, -0.5)
                    .resolve(Directionality.of(context)),
                followerAnchor: AlignmentDirectional(0.0, -0.99)
                    .resolve(Directionality.of(context)),
                builder: (dialogContext) {
                  return Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(dialogContext).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
                        height: 100.0,
                        width: 300.0,
                        child: UpcomingeventTeacherWidget(
                          schoolref: _model.teacherSchool!.reference,
                        ),
                      ),
                    ),
                  );
                },
              );

              await currentUserReference!.update(createUsersRecordData(
                popupdate: getCurrentTimestamp,
              ));
            }
          }
        } else {
          if (functions
                  .filterEventsAfterTwoDays(
                      _model.teacherSchool!.calendarList.toList(),
                      getCurrentTimestamp)
                  .length !=
              0) {
            await showAlignedDialog(
              context: context,
              isGlobal: false,
              avoidOverflow: false,
              targetAnchor: AlignmentDirectional(0.0, -0.5)
                  .resolve(Directionality.of(context)),
              followerAnchor: AlignmentDirectional(0.0, -0.99)
                  .resolve(Directionality.of(context)),
              builder: (dialogContext) {
                return Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(dialogContext).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Container(
                      height: 100.0,
                      width: 300.0,
                      child: UpcomingeventTeacherWidget(
                        schoolref: _model.teacherSchool!.reference,
                      ),
                    ),
                  ),
                );
              },
            );

            await currentUserReference!.update(createUsersRecordData(
              popupdate: getCurrentTimestamp,
            ));
          }
        }
      } else if (valueOrDefault(currentUserDocument?.userRole, 0) == 4) {
      } else {
        return;
      }
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.tabbarclassController = TabController(
      vsync: this,
      length: 4,
      initialIndex: min(
          valueOrDefault<int>(
            widget.tabindex != null ? widget.tabindex : 0,
            0,
          ),
          3),
    )
      ..addListener(() => safeSetState(() {}))
      ..addListener(() async {
        if (_model.tabbarclassController!.indexIsChanging) {
          return;
        }

        await actions.hideKeyboard(
          context,
        );
        _model.eventname = 'General';
        _model.lastfield = 0;
        _model.pageno = _model.tabbarclassCurrentIndex;
        safeSetState(() {});
        FFAppState().eventfiles = [];
        safeSetState(() {});
      });

    _model.eventnameTextController ??= TextEditingController();
    _model.eventnameFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
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

    return Builder(
      builder: (context) => StreamBuilder<List<SchoolRecord>>(
        stream: querySchoolRecord(),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).bgColorNewOne,
              body: MainDashboardShimmerWidget(),
            );
          }
          List<SchoolRecord> dashboardSchoolRecordList = snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).bgColorNewOne,
              floatingActionButton: Visibility(
                visible: _model.pageno == 2,
                child: Align(
                  alignment: AlignmentDirectional(1.0, 0.7),
                  child: FloatingActionButton(
                    onPressed: () async {
                      context.pushNamed(
                        AddEventsDetailsWidget.routeName,
                        queryParameters: {
                          'selectedDate': serializeParam(
                            getCurrentTimestamp,
                            ParamType.DateTime,
                          ),
                          'schoolRef': serializeParam(
                            dashboardSchoolRecordList
                                .where((e) => e.listOfteachersuser
                                    .contains(currentUserReference))
                                .toList()
                                .firstOrNull
                                ?.reference,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                      );
                    },
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    elevation: 8.0,
                    child: Icon(
                      Icons.add_rounded,
                      color: FlutterFlowTheme.of(context).info,
                      size: 24.0,
                    ),
                  ),
                ),
              ),
              appBar: responsiveVisibility(
                        context: context,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ) &&
                      ((valueOrDefault(currentUserDocument?.userRole, 0) ==
                              1) ||
                          (valueOrDefault(currentUserDocument?.userRole, 0) ==
                              2) ||
                          (valueOrDefault(currentUserDocument?.userRole, 0) ==
                              3) ||
                          (valueOrDefault(currentUserDocument?.userRole, 0) ==
                              4))
                  ? AppBar(
                      backgroundColor: FlutterFlowTheme.of(context).info,
                      automaticallyImplyLeading: false,
                      title: Container(
                        width: 100.0,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) ==
                                3)
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    TeacherNoticeTeacherWidget.routeName,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.event_note_outlined,
                                  color: Color(0x33000000),
                                  size: 20.0,
                                ),
                              ),
                            if ((valueOrDefault(
                                        currentUserDocument?.userRole, 0) ==
                                    1) ||
                                (valueOrDefault(
                                        currentUserDocument?.userRole, 0) ==
                                    3))
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (valueOrDefault(
                                          currentUserDocument?.userRole, 0) ==
                                      1) {
                                    context.pushNamed(
                                      SearchPageSAWidget.routeName,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                        ),
                                      },
                                    );
                                  } else {
                                    context.pushNamed(
                                      SearchPageAdminWidget.routeName,
                                      queryParameters: {
                                        'schoolref': serializeParam(
                                          dashboardSchoolRecordList
                                              .where((e) => e.listOfteachersuser
                                                  .contains(
                                                      currentUserReference))
                                              .toList()
                                              .firstOrNull
                                              ?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  }
                                },
                                child: Icon(
                                  Icons.search_sharp,
                                  color: Color(0x2B000000),
                                  size: 20.0,
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              child: InkWell(
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
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/2uwe1ectpzno/Avatar_Placeholder.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ],
                      centerTitle: true,
                      elevation: 0.0,
                    )
                  : null,
              body: Builder(
                builder: (context) {
                  if (valueOrDefault(currentUserDocument?.userRole, 0) == 1) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Builder(
                                    builder: (context) => Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 0.0, 5.0),
                                      child: Text(
                                        'Click on your school to view details! ',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 10.0),
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.8,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0F0F0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment(0.0, 0),
                                          child: FlutterFlowButtonTabBar(
                                            useToggleButtonStyle: false,
                                            labelStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleMedium
                                                .override(
                                                  font: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMedium
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                            unselectedLabelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontStyle,
                                                    ),
                                            labelColor:
                                                FlutterFlowTheme.of(context)
                                                    .text1,
                                            unselectedLabelColor:
                                                FlutterFlowTheme.of(context)
                                                    .text1,
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            unselectedBackgroundColor:
                                                Color(0xFFF0F0F0),
                                            borderColor: Color(0xFFD0D0D1),
                                            borderWidth: 1.0,
                                            borderRadius: 8.0,
                                            elevation: 0.0,
                                            tabs: [
                                              Tab(
                                                text: 'New Requests',
                                              ),
                                              Tab(
                                                text: 'Existing schools',
                                              ),
                                            ],
                                            controller: _model.tabBarController,
                                            onTap: (i) async {
                                              [() async {}, () async {}][i]();
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: TabBarView(
                                            controller: _model.tabBarController,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 20.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiary,
                                                  ),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final requestedschools =
                                                          dashboardSchoolRecordList
                                                              .where((e) =>
                                                                  e.schoolStatus ==
                                                                  0)
                                                              .toList();
                                                      if (requestedschools
                                                          .isEmpty) {
                                                        return EmptyWidget();
                                                      }

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                          0,
                                                          0,
                                                          0,
                                                          10.0,
                                                        ),
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            requestedschools
                                                                .length,
                                                        itemBuilder: (context,
                                                            requestedschoolsIndex) {
                                                          final requestedschoolsItem =
                                                              requestedschools[
                                                                  requestedschoolsIndex];
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        8.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                if (Navigator.of(
                                                                        context)
                                                                    .canPop()) {
                                                                  context.pop();
                                                                }
                                                                context
                                                                    .pushNamed(
                                                                  NewSchoolDetailsSAWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'schoolref':
                                                                        serializeParam(
                                                                      requestedschoolsItem
                                                                          .reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    kTransitionInfoKey:
                                                                        TransitionInfo(
                                                                      hasTransition:
                                                                          true,
                                                                      transitionType:
                                                                          PageTransitionType
                                                                              .fade,
                                                                    ),
                                                                  },
                                                                );
                                                              },
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 2.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            41.3,
                                                                        color: Color(
                                                                            0x0B000000),
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
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.85,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 60.0,
                                                                                        height: 60.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          image: DecorationImage(
                                                                                            fit: BoxFit.cover,
                                                                                            image: Image.network(
                                                                                              requestedschoolsItem.schoolDetails.schoolImage,
                                                                                            ).image,
                                                                                          ),
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onLongPress: () async {
                                                                                              await Navigator.push(
                                                                                                context,
                                                                                                PageTransition(
                                                                                                  type: PageTransitionType.fade,
                                                                                                  child: FlutterFlowExpandedImageView(
                                                                                                    image: Image.network(
                                                                                                      valueOrDefault<String>(
                                                                                                        requestedschoolsItem.schoolDetails.schoolImage != '' ? requestedschoolsItem.schoolDetails.schoolImage : FFAppConstants.Schoolimage,
                                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                                      ),
                                                                                                      fit: BoxFit.contain,
                                                                                                    ),
                                                                                                    allowRotation: false,
                                                                                                    tag: valueOrDefault<String>(
                                                                                                      requestedschoolsItem.schoolDetails.schoolImage != '' ? requestedschoolsItem.schoolDetails.schoolImage : FFAppConstants.Schoolimage,
                                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' + '$requestedschoolsIndex',
                                                                                                    ),
                                                                                                    useHeroAnimation: true,
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                            child: Hero(
                                                                                              tag: valueOrDefault<String>(
                                                                                                requestedschoolsItem.schoolDetails.schoolImage != '' ? requestedschoolsItem.schoolDetails.schoolImage : FFAppConstants.Schoolimage,
                                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' + '$requestedschoolsIndex',
                                                                                              ),
                                                                                              transitionOnUserGestures: true,
                                                                                              child: ClipRRect(
                                                                                                borderRadius: BorderRadius.circular(30.0),
                                                                                                child: Image.network(
                                                                                                  valueOrDefault<String>(
                                                                                                    requestedschoolsItem.schoolDetails.schoolImage != '' ? requestedschoolsItem.schoolDetails.schoolImage : FFAppConstants.Schoolimage,
                                                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                                  ),
                                                                                                  width: 200.0,
                                                                                                  height: 200.0,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 5.0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                requestedschoolsItem.schoolDetails.schoolName,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.nunito(
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      fontSize: 16.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Text(
                                                                                              requestedschoolsItem.schoolDetails.city,
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.nunito(
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    fontSize: 16.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Text(
                                                                                            requestedschoolsItem.principalDetails.phoneNumber,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.nunito(
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.normal,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                          Text(
                                                                                            '${requestedschoolsItem.schoolDetails.noOfStudents.toString()} Students',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.nunito(
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.normal,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                          Text(
                                                                                            requestedschoolsItem.principalDetails.emailId,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.nunito(
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.normal,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ].divide(SizedBox(height: 4.0)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0.0, -1.0),
                                                                                    child: Material(
                                                                                      color: Colors.transparent,
                                                                                      elevation: 0.0,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                      ),
                                                                                      child: Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.06,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              blurRadius: 0.0,
                                                                                              color: Color(0x33000000),
                                                                                              offset: Offset(
                                                                                                0.0,
                                                                                                1.0,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          border: Border.all(
                                                                                            color: Color(0xFFE4ECFC),
                                                                                            width: 1.0,
                                                                                          ),
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Text(
                                                                                              valueOrDefault<String>(
                                                                                                formatNumber(
                                                                                                  requestedschoolsItem.schoolDetails.noOfBranches,
                                                                                                  formatType: FormatType.custom,
                                                                                                  format: '00',
                                                                                                  locale: '',
                                                                                                ),
                                                                                                '01',
                                                                                              ),
                                                                                              textAlign: TextAlign.center,
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.nunito(
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                    fontSize: 20.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                            Text(
                                                                                              'Branches',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.nunito(
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                    fontSize: 9.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                                                                              10)
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 8.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  FFButtonWidget(
                                                                                    onPressed: () {
                                                                                      print('Button pressed ...');
                                                                                    },
                                                                                    text: 'Reject',
                                                                                    options: FFButtonOptions(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.35,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.043,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        shadows: [
                                                                                          Shadow(
                                                                                            color: Color(0x99F4F5FA),
                                                                                            offset: Offset(0.0, -3.0),
                                                                                            blurRadius: 6.0,
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      elevation: 0.0,
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                                    ),
                                                                                    showLoadingIndicator: false,
                                                                                  ),
                                                                                  FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(
                                                                                        SubscriptionWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'schoolRef': serializeParam(
                                                                                            requestedschoolsItem.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    text: 'Approve',
                                                                                    options: FFButtonOptions(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.35,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.043,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        shadows: [
                                                                                          Shadow(
                                                                                            color: Color(0x7E253EA7),
                                                                                            offset: Offset(0.0, 1.0),
                                                                                            blurRadius: 2.0,
                                                                                          ),
                                                                                          Shadow(
                                                                                            color: Color(0xFF375DFB),
                                                                                            offset: Offset(0.0, 0.0),
                                                                                            blurRadius: 0.0,
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      elevation: 0.0,
                                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 15.0)).around(SizedBox(width: 15.0)),
                                                                              ),
                                                                            ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Builder(
                                                                                builder: (context) => Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                  child: FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      await showDialog(
                                                                                        context: context,
                                                                                        builder: (dialogContext) {
                                                                                          return Dialog(
                                                                                            elevation: 0,
                                                                                            insetPadding: EdgeInsets.zero,
                                                                                            backgroundColor: Colors.transparent,
                                                                                            alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                            child: GestureDetector(
                                                                                              onTap: () {
                                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                              },
                                                                                              child: Container(
                                                                                                height: MediaQuery.sizeOf(context).height * 0.3,
                                                                                                width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                                child: DeleteCopyWidget(
                                                                                                  schoolref: requestedschoolsItem.reference,
                                                                                                  isBranch: false,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    text: 'Delete',
                                                                                    options: FFButtonOptions(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.4,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.05,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFF1A1C1E),
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        shadows: [
                                                                                          Shadow(
                                                                                            color: Color(0x12F4F5FA),
                                                                                            offset: Offset(0.0, -3.0),
                                                                                            blurRadius: 6.0,
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      elevation: 0.0,
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                child: FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    context.pushNamed(
                                                                                      SubscriptionWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'schoolRef': serializeParam(
                                                                                          requestedschoolsItem.reference,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                      extra: <String, dynamic>{
                                                                                        kTransitionInfoKey: TransitionInfo(
                                                                                          hasTransition: true,
                                                                                          transitionType: PageTransitionType.fade,
                                                                                        ),
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                  text: 'Select Plan ',
                                                                                  options: FFButtonOptions(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.4,
                                                                                    height: MediaQuery.sizeOf(context).height * 0.05,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      font: GoogleFonts.nunito(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      shadows: [
                                                                                        Shadow(
                                                                                          color: Color(0x09253EA7),
                                                                                          offset: Offset(0.0, 1.0),
                                                                                          blurRadius: 2.0,
                                                                                        ),
                                                                                        Shadow(
                                                                                          color: Color(0xFF375DFB),
                                                                                          offset: Offset(0.0, 0.0),
                                                                                          blurRadius: 0.0,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    elevation: 0.0,
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      width: 1.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
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
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 20.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiary,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    primary: false,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            context.pushNamed(
                                                              SearchPageSAWidget
                                                                  .routeName,
                                                              extra: <String,
                                                                  dynamic>{
                                                                kTransitionInfoKey:
                                                                    TransitionInfo(
                                                                  hasTransition:
                                                                      true,
                                                                  transitionType:
                                                                      PageTransitionType
                                                                          .fade,
                                                                ),
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.85,
                                                            height: 50.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .search,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    size: 24.0,
                                                                  ),
                                                                  Text(
                                                                    'Try Searching for \"School\"',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Builder(
                                                          builder: (context) {
                                                            final existingschools = dashboardSchoolRecordList
                                                                .where((e) =>
                                                                    (e.schoolStatus ==
                                                                        2) &&
                                                                    !e
                                                                        .isBranchPresent)
                                                                .toList()
                                                                .sortedList(
                                                                    keyOf: (e) =>
                                                                        e.createdAt!,
                                                                    desc: true)
                                                                .toList();
                                                            if (existingschools
                                                                .isEmpty) {
                                                              return EmptyWidget();
                                                            }

                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                0,
                                                                0,
                                                                0,
                                                                30.0,
                                                              ),
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  existingschools
                                                                      .length,
                                                              itemBuilder: (context,
                                                                  existingschoolsIndex) {
                                                                final existingschoolsItem =
                                                                    existingschools[
                                                                        existingschoolsIndex];
                                                                return Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          8.0,
                                                                          10.0,
                                                                          0.0),
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
                                                                      context
                                                                          .pushNamed(
                                                                        ExistingSchoolDetailsSAWidget
                                                                            .routeName,
                                                                        queryParameters:
                                                                            {
                                                                          'schoolrefMain':
                                                                              serializeParam(
                                                                            existingschoolsItem.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                        extra: <String,
                                                                            dynamic>{
                                                                          kTransitionInfoKey:
                                                                              TransitionInfo(
                                                                            hasTransition:
                                                                                true,
                                                                            transitionType:
                                                                                PageTransitionType.fade,
                                                                          ),
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          2.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 41.3,
                                                                              color: Color(0x08000000),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                1.0,
                                                                              ),
                                                                              spreadRadius: 0.0,
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              5.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.85,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(5.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                                                                                            child: Container(
                                                                                              width: 60.0,
                                                                                              height: 60.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                image: DecorationImage(
                                                                                                  fit: BoxFit.cover,
                                                                                                  image: Image.network(
                                                                                                    existingschoolsItem.schoolDetails.schoolImage,
                                                                                                  ).image,
                                                                                                ),
                                                                                                shape: BoxShape.circle,
                                                                                              ),
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onLongPress: () async {
                                                                                                    await Navigator.push(
                                                                                                      context,
                                                                                                      PageTransition(
                                                                                                        type: PageTransitionType.fade,
                                                                                                        child: FlutterFlowExpandedImageView(
                                                                                                          image: Image.network(
                                                                                                            valueOrDefault<String>(
                                                                                                              valueOrDefault<String>(
                                                                                                                            existingschoolsItem.schoolDetails.schoolImage,
                                                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                                                                          ) !=
                                                                                                                          ''
                                                                                                                  ? existingschoolsItem.schoolDetails.schoolImage
                                                                                                                  : FFAppConstants.Schoolimage,
                                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                                            ),
                                                                                                            fit: BoxFit.contain,
                                                                                                          ),
                                                                                                          allowRotation: false,
                                                                                                          tag: valueOrDefault<String>(
                                                                                                            valueOrDefault<String>(
                                                                                                                          existingschoolsItem.schoolDetails.schoolImage,
                                                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                                                                        ) !=
                                                                                                                        ''
                                                                                                                ? existingschoolsItem.schoolDetails.schoolImage
                                                                                                                : FFAppConstants.Schoolimage,
                                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' + '$existingschoolsIndex',
                                                                                                          ),
                                                                                                          useHeroAnimation: true,
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                  child: Hero(
                                                                                                    tag: valueOrDefault<String>(
                                                                                                      valueOrDefault<String>(
                                                                                                                    existingschoolsItem.schoolDetails.schoolImage,
                                                                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                                                                  ) !=
                                                                                                                  ''
                                                                                                          ? existingschoolsItem.schoolDetails.schoolImage
                                                                                                          : FFAppConstants.Schoolimage,
                                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' + '$existingschoolsIndex',
                                                                                                    ),
                                                                                                    transitionOnUserGestures: true,
                                                                                                    child: ClipRRect(
                                                                                                      borderRadius: BorderRadius.circular(30.0),
                                                                                                      child: Image.network(
                                                                                                        valueOrDefault<String>(
                                                                                                          valueOrDefault<String>(
                                                                                                                        existingschoolsItem.schoolDetails.schoolImage,
                                                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                                                                      ) !=
                                                                                                                      ''
                                                                                                              ? existingschoolsItem.schoolDetails.schoolImage
                                                                                                              : FFAppConstants.Schoolimage,
                                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                                        ),
                                                                                                        width: 200.0,
                                                                                                        height: 200.0,
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 5.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                    child: Text(
                                                                                                      existingschoolsItem.schoolDetails.schoolName,
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.nunito(
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Text(
                                                                                                    existingschoolsItem.schoolDetails.city,
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.nunito(
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          fontSize: 16.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  existingschoolsItem.principalDetails.phoneNumber,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.nunito(
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Text(
                                                                                                  '${existingschoolsItem.listOfStudents.length.toString()} Students',
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.nunito(
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Text(
                                                                                                  existingschoolsItem.principalDetails.emailId,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.nunito(
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ].divide(SizedBox(height: 4.0)),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(0.0, -1.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 10.0, 0.0),
                                                                                            child: Container(
                                                                                              width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                              height: MediaQuery.sizeOf(context).height * 0.06,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                boxShadow: [
                                                                                                  BoxShadow(
                                                                                                    blurRadius: 0.0,
                                                                                                    color: Color(0x33000000),
                                                                                                    offset: Offset(
                                                                                                      0.0,
                                                                                                      1.0,
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                border: Border.all(
                                                                                                  color: Color(0xFFE4ECFC),
                                                                                                  width: 1.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    valueOrDefault<String>(
                                                                                                      formatNumber(
                                                                                                        dashboardSchoolRecordList.where((e) => e.principalDetails.principalId == existingschoolsItem.principalDetails.principalId).toList().length,
                                                                                                        formatType: FormatType.custom,
                                                                                                        format: '00',
                                                                                                        locale: '',
                                                                                                      ),
                                                                                                      '02',
                                                                                                    ),
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.nunito(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                          fontSize: 20.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    'Branches',
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.nunito(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                          fontSize: 9.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 6.0)),
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
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .around(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ].addToEnd(SizedBox(height: 30.0)),
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
                                model: _model.navBarSAModel,
                                updateCallback: () => safeSetState(() {}),
                                child: NavBarSAWidget(
                                  pageno: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                      2) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiary,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 10.0, 5.0, 10.0),
                                      child: Text(
                                        '* To manage any schools,please contact \nthe Superadmin',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 10.0),
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 20.0,
                                                color: Color(0x0A000000),
                                                offset: Offset(
                                                  0.0,
                                                  0.0,
                                                ),
                                                spreadRadius: 0.0,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: Color(0xFFF2F2F2),
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (getCurrentTimestamp >
                                                    currentUserDocument!
                                                        .subcriptiondetails
                                                        .endDate!)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 0.0),
                                                    child: Container(
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.04,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF4CECE),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.error,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            size: 24.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Subscription expired',
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 5.0,
                                                                0.0, 5.0),
                                                    child: Text(
                                                      'Subscription',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .nunito(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiaryText,
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
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 2.0, 5.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        valueOrDefault<String>(
                                                          currentUserDocument
                                                              ?.subcriptiondetails
                                                              .subName,
                                                          'sub name',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      if (currentUserDocument!
                                                              .subcriptiondetails
                                                              .subAmount >
                                                          0.0)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: valueOrDefault<
                                                                      String>(
                                                                    formatNumber(
                                                                      currentUserDocument
                                                                          ?.subcriptiondetails
                                                                          .subAmount,
                                                                      formatType:
                                                                          FormatType
                                                                              .decimal,
                                                                      decimalType:
                                                                          DecimalType
                                                                              .periodDecimal,
                                                                    ),
                                                                    '1',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text: '/',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text: valueOrDefault<
                                                                      String>(
                                                                    currentUserDocument
                                                                        ?.subcriptiondetails
                                                                        .frequency,
                                                                    '2',
                                                                  ),
                                                                  style:
                                                                      GoogleFonts
                                                                          .nunito(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
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
                                                    ],
                                                  ),
                                                ),
                                                if (currentUserDocument!
                                                        .subcriptiondetails
                                                        .subId >
                                                    0)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                5.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Amount paid',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                fontSize: 14.0,
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
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.subscriptionStatus,
                                                                        0) ==
                                                                    2
                                                                ? currentUserDocument
                                                                    ?.subcriptiondetails
                                                                    .subAmount
                                                                    .toString()
                                                                : 'Not paid yet',
                                                            '0',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (currentUserDocument!
                                                        .subcriptiondetails
                                                        .subId >
                                                    0)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                5.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Frequency',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                fontSize: 14.0,
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
                                                        Text(
                                                          'Monthly',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                    .primaryText,
                                                                fontSize: 14.0,
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
                                                      ],
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 5.0, 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Start Date',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                      14.0,
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
                                                      Text(
                                                        dateTimeFormat(
                                                            "dd MMM , y",
                                                            currentUserDocument!
                                                                .subcriptiondetails
                                                                .startDate!),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                      .primaryText,
                                                                  fontSize:
                                                                      14.0,
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
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 5.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'End Date',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                      14.0,
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
                                                      Text(
                                                        dateTimeFormat(
                                                            "dd MMM , y",
                                                            currentUserDocument!
                                                                .subcriptiondetails
                                                                .endDate!),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                      .primaryText,
                                                                  fontSize:
                                                                      14.0,
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
                                                    ],
                                                  ),
                                                ),
                                              ].addToEnd(
                                                  SizedBox(height: 10.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.9,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 20.0,
                                              color: Color(0x0A000000),
                                              offset: Offset(
                                                0.0,
                                                0.0,
                                              ),
                                              spreadRadius: 0.0,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Color(0xFFF2F2F2),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Container(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onLongPress: () async {
                                                          await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  FlutterFlowExpandedImageView(
                                                                image: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    currentUserPhoto !=
                                                                                ''
                                                                        ? currentUserPhoto
                                                                        : FFAppConstants
                                                                            .addImage,
                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                  ),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                allowRotation:
                                                                    false,
                                                                tag:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  currentUserPhoto !=
                                                                              ''
                                                                      ? currentUserPhoto
                                                                      : FFAppConstants
                                                                          .addImage,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                ),
                                                                useHeroAnimation:
                                                                    true,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Hero(
                                                          tag: valueOrDefault<
                                                              String>(
                                                            currentUserPhoto !=
                                                                        ''
                                                                ? currentUserPhoto
                                                                : FFAppConstants
                                                                    .addImage,
                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                          ),
                                                          transitionOnUserGestures:
                                                              true,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40.0),
                                                            child:
                                                                Image.network(
                                                              valueOrDefault<
                                                                  String>(
                                                                currentUserPhoto !=
                                                                            ''
                                                                    ? currentUserPhoto
                                                                    : FFAppConstants
                                                                        .addImage,
                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                              ),
                                                              width: 80.0,
                                                              height: 80.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.5,
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.85,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                              child: Text(
                                                                currentUserDisplayName,
                                                                maxLines: 2,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .nunito(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: Text(
                                                              '+91 ${currentPhoneNumber}',
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
                                                          Text(
                                                            currentUserEmail,
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
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 1.0))
                                                            .around(SizedBox(
                                                                height: 1.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(width: 10.0))
                                                    .around(
                                                        SizedBox(width: 10.0)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 10.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.5,
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Text(
                                                      'Hello, ${currentUserDisplayName}!',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .nunito(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 24.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 5.0),
                                                  child: Text(
                                                    'Click on your school to get started!',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                          ),
                                          if (valueOrDefault(
                                                  currentUserDocument?.userRole,
                                                  0) !=
                                              1)
                                            FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                  AddnoticeAllSchoolsWidget
                                                      .routeName,
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
                                              },
                                              text: 'Branch Notice',
                                              icon: Icon(
                                                Icons.add,
                                                size: 14.0,
                                              ),
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.35,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.04,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                  font: GoogleFonts.nunito(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                  shadows: [
                                                    Shadow(
                                                      color: Color(0xFFF4F5FA),
                                                      offset: Offset(0.0, -3.0),
                                                      blurRadius: 6.0,
                                                    )
                                                  ],
                                                ),
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBorder,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          final schooldetails =
                                              dashboardSchoolRecordList
                                                  .sortedList(
                                                      keyOf: (e) =>
                                                          e.createdAt!,
                                                      desc: false)
                                                  .where((e) => e.listOfAdmin
                                                      .contains(
                                                          currentUserReference))
                                                  .toList();

                                          return SingleChildScrollView(
                                            primary: false,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  schooldetails.length,
                                                  (schooldetailsIndex) {
                                                final schooldetailsItem =
                                                    schooldetails[
                                                        schooldetailsIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 5.0, 10.0),
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
                                                      context.goNamed(
                                                        ClassDashboardWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'schoolref':
                                                              serializeParam(
                                                            schooldetailsItem
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 2.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 20.0,
                                                              color: Color(
                                                                  0x03000000),
                                                              offset: Offset(
                                                                0.0,
                                                                0.0,
                                                              ),
                                                              spreadRadius: 0.0,
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFF2F2F2),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    schooldetailsItem
                                                                            .isBranchPresent
                                                                        ? 'Branch Details'
                                                                        : 'School Details',
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
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        10.0,
                                                                        5.0,
                                                                        10.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
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
                                                                      onLongPress:
                                                                          () async {
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          PageTransition(
                                                                            type:
                                                                                PageTransitionType.fade,
                                                                            child:
                                                                                FlutterFlowExpandedImageView(
                                                                              image: Image.network(
                                                                                valueOrDefault<String>(
                                                                                  schooldetailsItem.schoolDetails.schoolImage != '' ? schooldetailsItem.schoolDetails.schoolImage : FFAppConstants.Schoolimage,
                                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                ),
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                              allowRotation: false,
                                                                              tag: valueOrDefault<String>(
                                                                                schooldetailsItem.schoolDetails.schoolImage != '' ? schooldetailsItem.schoolDetails.schoolImage : FFAppConstants.Schoolimage,
                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' + '$schooldetailsIndex',
                                                                              ),
                                                                              useHeroAnimation: true,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Hero(
                                                                        tag: valueOrDefault<
                                                                            String>(
                                                                          schooldetailsItem.schoolDetails.schoolImage != ''
                                                                              ? schooldetailsItem.schoolDetails.schoolImage
                                                                              : FFAppConstants.Schoolimage,
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' +
                                                                              '$schooldetailsIndex',
                                                                        ),
                                                                        transitionOnUserGestures:
                                                                            true,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              80.0,
                                                                          height:
                                                                              80.0,
                                                                          clipBehavior:
                                                                              Clip.antiAlias,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Image.network(
                                                                            valueOrDefault<String>(
                                                                              schooldetailsItem.schoolDetails.schoolImage != '' ? schooldetailsItem.schoolDetails.schoolImage : FFAppConstants.Schoolimage,
                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          5.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.6,
                                                                              decoration: BoxDecoration(),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                child: Text(
                                                                                  schooldetailsItem.schoolDetails.schoolName,
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.nunito(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    shadows: [
                                                                                      Shadow(
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        offset: Offset(2.0, 2.0),
                                                                                        blurRadius: 2.0,
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Text(
                                                                              'Address -',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.nunito(
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.6,
                                                                              decoration: BoxDecoration(),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Text(
                                                                                  '${schooldetailsItem.schoolDetails.address} ${schooldetailsItem.schoolDetails.city} ${schooldetailsItem.schoolDetails.pincode} ${schooldetailsItem.schoolDetails.state}',
                                                                                  maxLines: 5,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  'No. of students -',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Text(
                                                                                    schooldetailsItem.listOfStudents.length.toString(),
                                                                                    maxLines: 5,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 5.0)),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  'No of employee - ',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Text(
                                                                                    schooldetailsItem.schoolDetails.noOfFaculties.toString(),
                                                                                    maxLines: 5,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 5.0)),
                                                                            ),
                                                                          ),
                                                                          if (!schooldetailsItem
                                                                              .isBranchPresent)
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    'Branch -',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Text(
                                                                                      dashboardSchoolRecordList.where((e) => e.listOfAdmin.contains(currentUserReference)).toList().length.toString(),
                                                                                      maxLines: 5,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 5.0)),
                                                                              ),
                                                                            ),
                                                                        ].divide(SizedBox(height: 4.0)).around(SizedBox(height: 4.0)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                      3) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            child: custom_widgets.BackButtonOverriderforClass(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              pageIndex: _model.tabbarclassCurrentIndex,
                              onBack: () async {
                                if (_model.tabbarclassCurrentIndex == 3) {
                                  safeSetState(() {
                                    _model.tabbarclassController!.animateTo(
                                      max(
                                          0,
                                          _model.tabbarclassController!.index -
                                              1),
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  });
                                } else if (_model.tabbarclassCurrentIndex ==
                                    2) {
                                  safeSetState(() {
                                    _model.tabbarclassController!.animateTo(
                                      max(
                                          0,
                                          _model.tabbarclassController!.index -
                                              1),
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  });
                                } else if (_model.tabbarclassCurrentIndex ==
                                    1) {
                                  safeSetState(() {
                                    _model.tabbarclassController!.animateTo(
                                      max(
                                          0,
                                          _model.tabbarclassController!.index -
                                              1),
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  });
                                } else {
                                  safeSetState(() {
                                    _model.tabbarclassController!.animateTo(
                                      max(
                                          0,
                                          _model.tabbarclassController!.index -
                                              1),
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  });
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: StreamBuilder<List<SchoolRecord>>(
                              stream: querySchoolRecord(
                                queryBuilder: (schoolRecord) =>
                                    schoolRecord.where(
                                  'listOfteachersuser',
                                  arrayContains: currentUserReference,
                                ),
                                singleRecord: true,
                              ),
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
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<SchoolRecord>
                                    adminTeacherSchoolRecordList =
                                    snapshot.data!;
                                final adminTeacherSchoolRecord =
                                    adminTeacherSchoolRecordList.isNotEmpty
                                        ? adminTeacherSchoolRecordList.first
                                        : null;

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StreamBuilder<List<TeachersRecord>>(
                                      stream: queryTeachersRecord(
                                        queryBuilder: (teachersRecord) =>
                                            teachersRecord.where(
                                          'useref',
                                          isEqualTo: currentUserReference,
                                        ),
                                        singleRecord: true,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<TeachersRecord>
                                            bodyTeachersRecordList =
                                            snapshot.data!;
                                        final bodyTeachersRecord =
                                            bodyTeachersRecordList.isNotEmpty
                                                ? bodyTeachersRecordList.first
                                                : null;

                                        return Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              1.0,
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 20.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 10.0),
                                                    child: Container(
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.8,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF0F0F0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: StreamBuilder<
                                                          List<
                                                              SchoolClassRecord>>(
                                                        stream:
                                                            querySchoolClassRecord(
                                                          queryBuilder:
                                                              (schoolClassRecord) =>
                                                                  schoolClassRecord
                                                                      .where(
                                                            'listOfteachersUser',
                                                            arrayContains:
                                                                currentUserReference,
                                                          ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.78,
                                                              child:
                                                                  ClassshimmerWidget(),
                                                            );
                                                          }
                                                          List<SchoolClassRecord>
                                                              tabbarclassSchoolClassRecordList =
                                                              snapshot.data!;

                                                          return Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment(
                                                                        0.0, 0),
                                                                child:
                                                                    FlutterFlowButtonTabBar(
                                                                  useToggleButtonStyle:
                                                                      false,
                                                                  labelStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  unselectedLabelStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  labelColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .text1,
                                                                  unselectedLabelColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .text1,
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                  unselectedBackgroundColor:
                                                                      Color(
                                                                          0xFFF0F0F0),
                                                                  borderColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  borderWidth:
                                                                      1.0,
                                                                  borderRadius:
                                                                      10.0,
                                                                  elevation:
                                                                      0.0,
                                                                  tabs: [
                                                                    Tab(
                                                                      text:
                                                                          'Classes',
                                                                    ),
                                                                    Tab(
                                                                      text:
                                                                          'Notices',
                                                                    ),
                                                                    Tab(
                                                                      text:
                                                                          'Calendar',
                                                                    ),
                                                                    Tab(
                                                                      text:
                                                                          'Students',
                                                                    ),
                                                                  ],
                                                                  controller: _model
                                                                      .tabbarclassController,
                                                                  onTap:
                                                                      (i) async {
                                                                    [
                                                                      () async {
                                                                        await actions
                                                                            .hideKeyboard(
                                                                          context,
                                                                        );
                                                                        safeSetState(
                                                                            () {
                                                                          _model
                                                                              .tabbarclassController!
                                                                              .animateTo(
                                                                            0,
                                                                            duration:
                                                                                Duration(milliseconds: 300),
                                                                            curve:
                                                                                Curves.ease,
                                                                          );
                                                                        });
                                                                      },
                                                                      () async {
                                                                        await actions
                                                                            .hideKeyboard(
                                                                          context,
                                                                        );
                                                                        _model.eventname =
                                                                            'General';
                                                                        _model.lastfield =
                                                                            0;
                                                                        safeSetState(
                                                                            () {});
                                                                        FFAppState().eventfiles =
                                                                            [];
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      () async {
                                                                        await actions
                                                                            .hideKeyboard(
                                                                          context,
                                                                        );
                                                                        safeSetState(
                                                                            () {
                                                                          _model
                                                                              .tabbarclassController!
                                                                              .animateTo(
                                                                            2,
                                                                            duration:
                                                                                Duration(milliseconds: 300),
                                                                            curve:
                                                                                Curves.ease,
                                                                          );
                                                                        });
                                                                      },
                                                                      () async {
                                                                        await actions
                                                                            .hideKeyboard(
                                                                          context,
                                                                        );
                                                                      }
                                                                    ][i]();
                                                                  },
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    TabBarView(
                                                                  controller: _model
                                                                      .tabbarclassController,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          MediaQuery.sizeOf(context).height *
                                                                              0.8,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            20.0),
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.55,
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 10.0),
                                                                                        child: Text(
                                                                                          'Hello, ${currentUserDisplayName}',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.nunito(
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: 20.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) == dateTimeFormat("yMMMd", getCurrentTimestamp)) && (bodyTeachersRecord?.teacherAttendance.where((e) => dateTimeFormat("yMd", e.date) == dateTimeFormat("yMd", getCurrentTimestamp)).toList().length == 0))
                                                                                    Padding(
                                                                                      padding: EdgeInsets.all(10.0),
                                                                                      child: FFButtonWidget(
                                                                                        onPressed: () async {
                                                                                          var confirmDialogResponse = await showDialog<bool>(
                                                                                                context: context,
                                                                                                builder: (alertDialogContext) {
                                                                                                  return AlertDialog(
                                                                                                    title: Text('Check out'),
                                                                                                    content: Text('Are you sure you want to check out?'),
                                                                                                    actions: [
                                                                                                      TextButton(
                                                                                                        onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                        child: Text('Cancel'),
                                                                                                      ),
                                                                                                      TextButton(
                                                                                                        onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                                        child: Text('Confirm'),
                                                                                                      ),
                                                                                                    ],
                                                                                                  );
                                                                                                },
                                                                                              ) ??
                                                                                              false;
                                                                                          if (confirmDialogResponse) {
                                                                                            await bodyTeachersRecord!.reference.update({
                                                                                              ...mapToFirestore(
                                                                                                {
                                                                                                  'teacher_attendance': FieldValue.arrayUnion([
                                                                                                    getTeachersAttendanceFirestoreData(
                                                                                                      createTeachersAttendanceStruct(
                                                                                                        id: functions.generateUniqueId(),
                                                                                                        date: currentUserDocument?.checkin,
                                                                                                        ispresent: true,
                                                                                                        checkInTime: currentUserDocument?.checkin,
                                                                                                        checkOutTime: getCurrentTimestamp,
                                                                                                        clearUnsetFields: false,
                                                                                                      ),
                                                                                                      true,
                                                                                                    )
                                                                                                  ]),
                                                                                                },
                                                                                              ),
                                                                                            });
                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                              SnackBar(
                                                                                                content: Text(
                                                                                                  'Checked out ',
                                                                                                  style: TextStyle(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                                  ),
                                                                                                ),
                                                                                                duration: Duration(milliseconds: 4000),
                                                                                                backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                              ),
                                                                                            );
                                                                                            triggerPushNotification(
                                                                                              notificationTitle: 'Check out',
                                                                                              notificationText: '${currentUserDisplayName}  has checked-out',
                                                                                              userRefs: [
                                                                                                adminTeacherSchoolRecord!.principalDetails.principalId!
                                                                                              ],
                                                                                              initialPageName: 'class_dashboard',
                                                                                              parameterData: {
                                                                                                'schoolref': adminTeacherSchoolRecord.reference,
                                                                                              },
                                                                                            );
                                                                                          }
                                                                                        },
                                                                                        text: 'Check Out',
                                                                                        icon: Icon(
                                                                                          FFIcons.kcheckout,
                                                                                          size: 15.0,
                                                                                        ),
                                                                                        options: FFButtonOptions(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.35,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                          iconColor: FlutterFlowTheme.of(context).text1,
                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).text1,
                                                                                            fontSize: 14.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            shadows: [
                                                                                              Shadow(
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                offset: Offset(2.0, 2.0),
                                                                                                blurRadius: 2.0,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          elevation: 0.0,
                                                                                          borderSide: BorderSide(
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            width: 1.0,
                                                                                          ),
                                                                                          borderRadius: BorderRadius.circular(4.0),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                              if (functions.isWithin300kMeters(adminTeacherSchoolRecord!.latlng!, currentUserLocationValue!) == false)
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 10.0),
                                                                                    child: Text(
                                                                                      'You are not within the school\'s location. Check-in/Check-out is disabled.',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            fontSize: 14.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              if (dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp))
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(10.0),
                                                                                  child: FFButtonWidget(
                                                                                    onPressed: (functions.isWithin300kMeters(adminTeacherSchoolRecord.latlng!, currentUserLocationValue!) == false)
                                                                                        ? null
                                                                                        : () async {
                                                                                            if (currentUserDocument?.checkin != null) {
                                                                                              if (functions.isCheckInOneDayPrior(currentUserDocument!.checkin!, getCurrentTimestamp)) {
                                                                                                if (bodyTeachersRecord?.teacherAttendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", currentUserDocument?.checkin)).toList().length == 0) {
                                                                                                  await currentUserReference!.update(createUsersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ));

                                                                                                  await bodyTeachersRecord!.reference.update({
                                                                                                    ...createTeachersRecordData(
                                                                                                      checkin: getCurrentTimestamp,
                                                                                                    ),
                                                                                                    ...mapToFirestore(
                                                                                                      {
                                                                                                        'teacher_attendance': FieldValue.arrayUnion([
                                                                                                          getTeachersAttendanceFirestoreData(
                                                                                                            updateTeachersAttendanceStruct(
                                                                                                              TeachersAttendanceStruct(
                                                                                                                id: functions.generateUniqueId(),
                                                                                                                date: currentUserDocument?.checkin,
                                                                                                                ispresent: true,
                                                                                                                checkInTime: currentUserDocument?.checkin,
                                                                                                                checkOutTime: FFAppState().checkout,
                                                                                                              ),
                                                                                                              clearUnsetFields: false,
                                                                                                            ),
                                                                                                            true,
                                                                                                          )
                                                                                                        ]),
                                                                                                      },
                                                                                                    ),
                                                                                                  });
                                                                                                } else {
                                                                                                  await currentUserReference!.update(createUsersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ));

                                                                                                  await bodyTeachersRecord!.reference.update(createTeachersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ));
                                                                                                }
                                                                                              } else {
                                                                                                await bodyTeachersRecord!.reference.update({
                                                                                                  ...mapToFirestore(
                                                                                                    {
                                                                                                      'teacher_attendance': getTeachersAttendanceListFirestoreData(
                                                                                                        functions.fillMissingAttendance(bodyTeachersRecord.teacherAttendance.toList(), currentUserDocument!.checkin!, functions.getAdjacentDate(false, getCurrentTimestamp), FFAppState().checkout!),
                                                                                                      ),
                                                                                                    },
                                                                                                  ),
                                                                                                });
                                                                                                if (bodyTeachersRecord.teacherAttendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", currentUserDocument?.checkin)).toList().length == 0) {
                                                                                                  await bodyTeachersRecord.reference.update({
                                                                                                    ...createTeachersRecordData(
                                                                                                      checkin: FFAppState().checkout,
                                                                                                    ),
                                                                                                    ...mapToFirestore(
                                                                                                      {
                                                                                                        'teacher_attendance': FieldValue.arrayUnion([
                                                                                                          getTeachersAttendanceFirestoreData(
                                                                                                            updateTeachersAttendanceStruct(
                                                                                                              TeachersAttendanceStruct(
                                                                                                                id: functions.generateUniqueId(),
                                                                                                                date: currentUserDocument?.checkin,
                                                                                                                ispresent: true,
                                                                                                                checkInTime: currentUserDocument?.checkin,
                                                                                                                checkOutTime: FFAppState().checkout,
                                                                                                              ),
                                                                                                              clearUnsetFields: false,
                                                                                                            ),
                                                                                                            true,
                                                                                                          )
                                                                                                        ]),
                                                                                                      },
                                                                                                    ),
                                                                                                  });

                                                                                                  await currentUserReference!.update(createUsersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ));
                                                                                                } else {
                                                                                                  await bodyTeachersRecord.reference.update(createTeachersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ));

                                                                                                  await currentUserReference!.update(createUsersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ));
                                                                                                }
                                                                                              }

                                                                                              safeSetState(() {});
                                                                                            } else {
                                                                                              if (functions.isDatePassed(adminTeacherSchoolRecord.createdAt!)) {
                                                                                                await currentUserReference!.update(createUsersRecordData(
                                                                                                  checkin: getCurrentTimestamp,
                                                                                                ));

                                                                                                await bodyTeachersRecord!.reference.update({
                                                                                                  ...createTeachersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ),
                                                                                                  ...mapToFirestore(
                                                                                                    {
                                                                                                      'teacher_attendance': getTeachersAttendanceListFirestoreData(
                                                                                                        functions.fillMissingAttendance(bodyTeachersRecord.teacherAttendance.toList(), adminTeacherSchoolRecord.createdAt!, getCurrentTimestamp, FFAppState().checkout!),
                                                                                                      ),
                                                                                                    },
                                                                                                  ),
                                                                                                });
                                                                                              } else {
                                                                                                await currentUserReference!.update(createUsersRecordData(
                                                                                                  checkin: getCurrentTimestamp,
                                                                                                ));

                                                                                                await bodyTeachersRecord!.reference.update(createTeachersRecordData(
                                                                                                  checkin: getCurrentTimestamp,
                                                                                                ));

                                                                                                safeSetState(() {});
                                                                                              }
                                                                                            }

                                                                                            triggerPushNotification(
                                                                                              notificationTitle: 'Check In',
                                                                                              notificationText: '${currentUserDisplayName}  has checked In ',
                                                                                              userRefs: [
                                                                                                adminTeacherSchoolRecord.principalDetails.principalId!
                                                                                              ],
                                                                                              initialPageName: 'class_dashboard',
                                                                                              parameterData: {
                                                                                                'schoolref': adminTeacherSchoolRecord.reference,
                                                                                              },
                                                                                            );
                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                              SnackBar(
                                                                                                content: Text(
                                                                                                  'Checked In',
                                                                                                  style: TextStyle(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                                  ),
                                                                                                ),
                                                                                                duration: Duration(milliseconds: 4000),
                                                                                                backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                    text: 'Check In',
                                                                                    options: FFButtonOptions(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.05,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 2.0,
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      disabledColor: FlutterFlowTheme.of(context).dIsable,
                                                                                      disabledTextColor: FlutterFlowTheme.of(context).text,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                                                                    child: Builder(
                                                                                      builder: (context) {
                                                                                        final tabBarVar = tabbarclassSchoolClassRecordList.sortedList(keyOf: (e) => e.className, desc: false).toList();
                                                                                        if (tabBarVar.isEmpty) {
                                                                                          return Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                            height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                            child: EmptyClassCopyWidget(),
                                                                                          );
                                                                                        }

                                                                                        return ListView.separated(
                                                                                          padding: EdgeInsets.fromLTRB(
                                                                                            0,
                                                                                            0,
                                                                                            0,
                                                                                            30.0,
                                                                                          ),
                                                                                          primary: false,
                                                                                          shrinkWrap: true,
                                                                                          scrollDirection: Axis.vertical,
                                                                                          itemCount: tabBarVar.length,
                                                                                          separatorBuilder: (_, __) => SizedBox(height: 10.0),
                                                                                          itemBuilder: (context, tabBarVarIndex) {
                                                                                            final tabBarVarItem = tabBarVar[tabBarVarIndex];
                                                                                            return Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 10.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp)) || (currentUserDocument?.checkin == null)) {
                                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                                      SnackBar(
                                                                                                        content: Text(
                                                                                                          'Please CheckIn ',
                                                                                                          style: TextStyle(
                                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                                          ),
                                                                                                        ),
                                                                                                        duration: Duration(milliseconds: 4000),
                                                                                                        backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                      ),
                                                                                                    );
                                                                                                  } else {
                                                                                                    context.pushNamed(
                                                                                                      ClassViewWidget.routeName,
                                                                                                      queryParameters: {
                                                                                                        'schoolclassref': serializeParam(
                                                                                                          tabBarVarItem.reference,
                                                                                                          ParamType.DocumentReference,
                                                                                                        ),
                                                                                                        'schoolref': serializeParam(
                                                                                                          adminTeacherSchoolRecord.reference,
                                                                                                          ParamType.DocumentReference,
                                                                                                        ),
                                                                                                        'datePick': serializeParam(
                                                                                                          getCurrentTimestamp,
                                                                                                          ParamType.DateTime,
                                                                                                        ),
                                                                                                      }.withoutNulls,
                                                                                                    );
                                                                                                  }
                                                                                                },
                                                                                                child: Material(
                                                                                                  color: Colors.transparent,
                                                                                                  elevation: 2.0,
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                  ),
                                                                                                  child: Container(
                                                                                                    width: MediaQuery.sizeOf(context).width * 0.75,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 20.0,
                                                                                                          color: Color(0x02000000),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          spreadRadius: 0.0,
                                                                                                        )
                                                                                                      ],
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                      border: Border.all(
                                                                                                        color: Color(0xFFF2F2F2),
                                                                                                        width: 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Align(
                                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                                  child: Container(
                                                                                                                    height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                                                    decoration: BoxDecoration(),
                                                                                                                    child: Padding(
                                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 5.0),
                                                                                                                      child: Column(
                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                        children: [
                                                                                                                          Padding(
                                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                                                            child: RichText(
                                                                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                                                                              text: TextSpan(
                                                                                                                                children: [
                                                                                                                                  TextSpan(
                                                                                                                                    text: 'Class : ',
                                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                          font: GoogleFonts.nunito(
                                                                                                                                            fontWeight: FontWeight.w600,
                                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                          ),
                                                                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                                                          fontSize: 16.0,
                                                                                                                                          letterSpacing: 0.0,
                                                                                                                                          fontWeight: FontWeight.w600,
                                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                        ),
                                                                                                                                  ),
                                                                                                                                  TextSpan(
                                                                                                                                    text: tabBarVarItem.className,
                                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                          font: GoogleFonts.nunito(
                                                                                                                                            fontWeight: FontWeight.w600,
                                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                          ),
                                                                                                                                          fontSize: 16.0,
                                                                                                                                          letterSpacing: 0.0,
                                                                                                                                          fontWeight: FontWeight.w600,
                                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                        ),
                                                                                                                                  )
                                                                                                                                ],
                                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                      font: GoogleFonts.nunito(
                                                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                      ),
                                                                                                                                      letterSpacing: 0.0,
                                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                    ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          RichText(
                                                                                                                            textScaler: MediaQuery.of(context).textScaler,
                                                                                                                            text: TextSpan(
                                                                                                                              children: [
                                                                                                                                TextSpan(
                                                                                                                                  text: 'Students : ',
                                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                        font: GoogleFonts.nunito(
                                                                                                                                          fontWeight: FontWeight.w600,
                                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                        ),
                                                                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                                                        fontSize: 16.0,
                                                                                                                                        letterSpacing: 0.0,
                                                                                                                                        fontWeight: FontWeight.w600,
                                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                      ),
                                                                                                                                ),
                                                                                                                                TextSpan(
                                                                                                                                  text: tabBarVarItem.studentsList.length.toString(),
                                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                        font: GoogleFonts.nunito(
                                                                                                                                          fontWeight: FontWeight.w600,
                                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                        ),
                                                                                                                                        fontSize: 16.0,
                                                                                                                                        letterSpacing: 0.0,
                                                                                                                                        fontWeight: FontWeight.w600,
                                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                      ),
                                                                                                                                )
                                                                                                                              ],
                                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                    font: GoogleFonts.nunito(
                                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                    ),
                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                  ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Padding(
                                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                                                  child: FlutterFlowIconButton(
                                                                                                                    borderColor: Colors.transparent,
                                                                                                                    borderRadius: 30.0,
                                                                                                                    buttonSize: 40.0,
                                                                                                                    fillColor: Color(0xFFF2981B),
                                                                                                                    icon: Icon(
                                                                                                                      Icons.bolt,
                                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                                      size: 24.0,
                                                                                                                    ),
                                                                                                                    onPressed: () async {
                                                                                                                      if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp)) || (currentUserDocument?.checkin == null)) {
                                                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                          SnackBar(
                                                                                                                            content: Text(
                                                                                                                              'Please CheckIn ',
                                                                                                                              style: TextStyle(
                                                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                            duration: Duration(milliseconds: 4000),
                                                                                                                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      } else {
                                                                                                                        await showModalBottomSheet(
                                                                                                                          isScrollControlled: true,
                                                                                                                          backgroundColor: Colors.transparent,
                                                                                                                          enableDrag: false,
                                                                                                                          context: context,
                                                                                                                          builder: (context) {
                                                                                                                            return GestureDetector(
                                                                                                                              onTap: () {
                                                                                                                                FocusScope.of(context).unfocus();
                                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                              },
                                                                                                                              child: Padding(
                                                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                                                child: Container(
                                                                                                                                  height: MediaQuery.sizeOf(context).height * 0.32,
                                                                                                                                  child: QuickActionForClassWidget(
                                                                                                                                    schoolref: adminTeacherSchoolRecord.reference,
                                                                                                                                    classref: tabBarVarItem.reference,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          },
                                                                                                                        ).then((value) => safeSetState(() {}));
                                                                                                                      }
                                                                                                                    },
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                              children: [
                                                                                                                Align(
                                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                  child: Material(
                                                                                                                    color: Colors.transparent,
                                                                                                                    elevation: 2.0,
                                                                                                                    shape: RoundedRectangleBorder(
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                    ),
                                                                                                                    child: Container(
                                                                                                                      width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                                      height: MediaQuery.sizeOf(context).height * 0.09,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                                        boxShadow: [
                                                                                                                          BoxShadow(
                                                                                                                            blurRadius: 4.0,
                                                                                                                            color: Color(0x131D61E7),
                                                                                                                            offset: Offset(
                                                                                                                              0.0,
                                                                                                                              2.0,
                                                                                                                            ),
                                                                                                                            spreadRadius: 0.0,
                                                                                                                          )
                                                                                                                        ],
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        border: Border.all(
                                                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      child: InkWell(
                                                                                                                        splashColor: Colors.transparent,
                                                                                                                        focusColor: Colors.transparent,
                                                                                                                        hoverColor: Colors.transparent,
                                                                                                                        highlightColor: Colors.transparent,
                                                                                                                        onTap: () async {
                                                                                                                          if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp)) || (currentUserDocument?.checkin == null)) {
                                                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                              SnackBar(
                                                                                                                                content: Text(
                                                                                                                                  'Please check In',
                                                                                                                                  style: TextStyle(
                                                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                                duration: Duration(milliseconds: 4000),
                                                                                                                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          } else {
                                                                                                                            context.pushNamed(
                                                                                                                              CalenderClassWidget.routeName,
                                                                                                                              queryParameters: {
                                                                                                                                'schoolclassref': serializeParam(
                                                                                                                                  tabBarVarItem.reference,
                                                                                                                                  ParamType.DocumentReference,
                                                                                                                                ),
                                                                                                                                'schoolref': serializeParam(
                                                                                                                                  adminTeacherSchoolRecord.reference,
                                                                                                                                  ParamType.DocumentReference,
                                                                                                                                ),
                                                                                                                                'mainpage': serializeParam(
                                                                                                                                  true,
                                                                                                                                  ParamType.bool,
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
                                                                                                                        },
                                                                                                                        child: Column(
                                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                          children: [
                                                                                                                            ClipRRect(
                                                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                                                              child: Image.asset(
                                                                                                                                'assets/images/Saly-42_(1).png',
                                                                                                                                width: MediaQuery.sizeOf(context).width * 0.2,
                                                                                                                                height: MediaQuery.sizeOf(context).height * 0.045,
                                                                                                                                fit: BoxFit.contain,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                            Align(
                                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                              child: Text(
                                                                                                                                'Add Event',
                                                                                                                                textAlign: TextAlign.center,
                                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                      font: GoogleFonts.nunito(
                                                                                                                                        fontWeight: FontWeight.w600,
                                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                      ),
                                                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                      fontSize: 12.0,
                                                                                                                                      letterSpacing: 0.0,
                                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                    ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Material(
                                                                                                                  color: Colors.transparent,
                                                                                                                  elevation: 2.0,
                                                                                                                  shape: RoundedRectangleBorder(
                                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                                  ),
                                                                                                                  child: Container(
                                                                                                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                                    height: MediaQuery.sizeOf(context).height * 0.09,
                                                                                                                    decoration: BoxDecoration(
                                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                                      boxShadow: [
                                                                                                                        BoxShadow(
                                                                                                                          blurRadius: 4.0,
                                                                                                                          color: Color(0x131D61E7),
                                                                                                                          offset: Offset(
                                                                                                                            0.0,
                                                                                                                            2.0,
                                                                                                                          ),
                                                                                                                          spreadRadius: 0.0,
                                                                                                                        )
                                                                                                                      ],
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                      border: Border.all(
                                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    child: InkWell(
                                                                                                                      splashColor: Colors.transparent,
                                                                                                                      focusColor: Colors.transparent,
                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                      onTap: () async {
                                                                                                                        if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp)) || (currentUserDocument?.checkin == null)) {
                                                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                            SnackBar(
                                                                                                                              content: Text(
                                                                                                                                'Please check in',
                                                                                                                                style: TextStyle(
                                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              duration: Duration(milliseconds: 4000),
                                                                                                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                            ),
                                                                                                                          );
                                                                                                                        } else {
                                                                                                                          context.pushNamed(
                                                                                                                            ClassNoticeAdminTeacherWidget.routeName,
                                                                                                                            queryParameters: {
                                                                                                                              'classref': serializeParam(
                                                                                                                                tabBarVarItem.reference,
                                                                                                                                ParamType.DocumentReference,
                                                                                                                              ),
                                                                                                                              'schoolref': serializeParam(
                                                                                                                                adminTeacherSchoolRecord.reference,
                                                                                                                                ParamType.DocumentReference,
                                                                                                                              ),
                                                                                                                              'notice': serializeParam(
                                                                                                                                true,
                                                                                                                                ParamType.bool,
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
                                                                                                                      },
                                                                                                                      child: Column(
                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          ClipRRect(
                                                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                                                            child: Image.asset(
                                                                                                                              'assets/images/bell.png',
                                                                                                                              width: MediaQuery.sizeOf(context).width * 0.2,
                                                                                                                              height: MediaQuery.sizeOf(context).height * 0.045,
                                                                                                                              fit: BoxFit.contain,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          Align(
                                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                            child: Text(
                                                                                                                              'Add Notice',
                                                                                                                              textAlign: TextAlign.center,
                                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                    font: GoogleFonts.nunito(
                                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                    ),
                                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                    fontSize: 12.0,
                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                  ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Material(
                                                                                                                  color: Colors.transparent,
                                                                                                                  elevation: 2.0,
                                                                                                                  shape: RoundedRectangleBorder(
                                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                                  ),
                                                                                                                  child: Container(
                                                                                                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                                    height: MediaQuery.sizeOf(context).height * 0.09,
                                                                                                                    decoration: BoxDecoration(
                                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                                      boxShadow: [
                                                                                                                        BoxShadow(
                                                                                                                          blurRadius: 4.0,
                                                                                                                          color: Color(0x131D61E7),
                                                                                                                          offset: Offset(
                                                                                                                            0.0,
                                                                                                                            2.0,
                                                                                                                          ),
                                                                                                                          spreadRadius: 0.0,
                                                                                                                        )
                                                                                                                      ],
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                      border: Border.all(
                                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                                        width: 1.0,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    child: InkWell(
                                                                                                                      splashColor: Colors.transparent,
                                                                                                                      focusColor: Colors.transparent,
                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                      onTap: () async {
                                                                                                                        if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp)) || (currentUserDocument?.checkin == null)) {
                                                                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                            SnackBar(
                                                                                                                              content: Text(
                                                                                                                                'Please Check in',
                                                                                                                                style: TextStyle(
                                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              duration: Duration(milliseconds: 4000),
                                                                                                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                            ),
                                                                                                                          );
                                                                                                                        } else {
                                                                                                                          if (tabBarVarItem.attendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)).toList().length == 0) {
                                                                                                                            context.pushNamed(
                                                                                                                              MarkAttendenceWidget.routeName,
                                                                                                                              queryParameters: {
                                                                                                                                'classRef': serializeParam(
                                                                                                                                  tabBarVarItem.reference,
                                                                                                                                  ParamType.DocumentReference,
                                                                                                                                ),
                                                                                                                                'schoolref': serializeParam(
                                                                                                                                  adminTeacherSchoolRecord.reference,
                                                                                                                                  ParamType.DocumentReference,
                                                                                                                                ),
                                                                                                                              }.withoutNulls,
                                                                                                                              extra: <String, dynamic>{
                                                                                                                                kTransitionInfoKey: TransitionInfo(
                                                                                                                                  hasTransition: true,
                                                                                                                                  transitionType: PageTransitionType.fade,
                                                                                                                                ),
                                                                                                                              },
                                                                                                                            );
                                                                                                                          } else {
                                                                                                                            context.pushNamed(
                                                                                                                              ClassAttendenceWidget.routeName,
                                                                                                                              queryParameters: {
                                                                                                                                'classRef': serializeParam(
                                                                                                                                  tabBarVarItem.reference,
                                                                                                                                  ParamType.DocumentReference,
                                                                                                                                ),
                                                                                                                                'schoolref': serializeParam(
                                                                                                                                  adminTeacherSchoolRecord.reference,
                                                                                                                                  ParamType.DocumentReference,
                                                                                                                                ),
                                                                                                                                'classattendence': serializeParam(
                                                                                                                                  true,
                                                                                                                                  ParamType.bool,
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
                                                                                                                        }
                                                                                                                      },
                                                                                                                      child: Column(
                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          Align(
                                                                                                                            alignment: AlignmentDirectional(1.0, -1.0),
                                                                                                                            child: Stack(
                                                                                                                              alignment: AlignmentDirectional(1.0, -1.0),
                                                                                                                              children: [
                                                                                                                                ClipRRect(
                                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                                  child: Image.asset(
                                                                                                                                    'assets/images/Chart_perspective_matte.png',
                                                                                                                                    width: MediaQuery.sizeOf(context).width * 0.2,
                                                                                                                                    height: MediaQuery.sizeOf(context).height * 0.045,
                                                                                                                                    fit: BoxFit.contain,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                                if ((tabBarVarItem.attendance.where((e) => (dateTimeFormat("yMd", e.date) == dateTimeFormat("yMd", getCurrentTimestamp)) && e.checkIn).toList().length != 0) && (tabBarVarItem.attendance.where((e) => (dateTimeFormat("yMd", e.date) == dateTimeFormat("yMd", getCurrentTimestamp)) && !e.checkIn).toList().length != 0))
                                                                                                                                  Align(
                                                                                                                                    alignment: AlignmentDirectional(1.0, -1.0),
                                                                                                                                    child: Icon(
                                                                                                                                      Icons.check_circle,
                                                                                                                                      color: FlutterFlowTheme.of(context).checkBg,
                                                                                                                                      size: 24.0,
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                              ],
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          Padding(
                                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                                                            child: Text(
                                                                                                                              'Check In/Out',
                                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                    font: GoogleFonts.nunito(
                                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                    ),
                                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                    fontSize: 12.0,
                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                  ),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ].addToEnd(SizedBox(height: 5.0)),
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
                                                                            ].divide(SizedBox(height: 5.0)).addToEnd(SizedBox(height: 30.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            40.0),
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          primary:
                                                                              false,
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              if (!functions.isDatePassed(_model.datetime!))
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(8.0),
                                                                                  child: Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      border: Border.all(
                                                                                        color: Color(0xFFF2F2F2),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(5.0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1.0, -1.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.all(10.0),
                                                                                              child: Text(
                                                                                                'New Notice',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.nunito(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: Color(0xFF222B45),
                                                                                                      fontSize: 16.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    _model.eventname = 'General';
                                                                                                    safeSetState(() {});
                                                                                                    FFAppState().eventname = 'General';
                                                                                                    safeSetState(() {});
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).event,
                                                                                                      borderRadius: BorderRadius.circular(3.59),
                                                                                                      border: Border.all(
                                                                                                        color: FlutterFlowTheme.of(context).generalBorder,
                                                                                                        width: FFAppState().eventname == 'General' ? 3.0 : 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                      child: Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                        children: [
                                                                                                          Image.asset(
                                                                                                            'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'General',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: valueOrDefault<Color>(
                                                                                                                    _model.eventname == 'General' ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).primaryText,
                                                                                                                    FlutterFlowTheme.of(context).text,
                                                                                                                  ),
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ].divide(SizedBox(width: 3.0)).around(SizedBox(width: 3.0)),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    _model.eventname = 'Reminder';
                                                                                                    safeSetState(() {});
                                                                                                    FFAppState().eventname = 'Reminder';
                                                                                                    safeSetState(() {});
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).reminderfill,
                                                                                                      borderRadius: BorderRadius.circular(3.59),
                                                                                                      border: Border.all(
                                                                                                        color: FlutterFlowTheme.of(context).reminderborder,
                                                                                                        width: FFAppState().eventname == 'Reminder' ? 3.0 : 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                      child: Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                        children: [
                                                                                                          Image.asset(
                                                                                                            'assets/images/3d-alarm.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'Reminder',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.nunito(
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              color: valueOrDefault<Color>(
                                                                                                                _model.eventname == 'Reminder' ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).primaryText,
                                                                                                                FlutterFlowTheme.of(context).text,
                                                                                                              ),
                                                                                                              fontSize: 14.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              shadows: [
                                                                                                                Shadow(
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  offset: Offset(2.0, 2.0),
                                                                                                                  blurRadius: 2.0,
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ].divide(SizedBox(width: 3.0)).around(SizedBox(width: 3.0)),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    _model.eventname = 'Homework';
                                                                                                    safeSetState(() {});
                                                                                                    FFAppState().eventname = 'Homework';
                                                                                                    safeSetState(() {});
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).homework,
                                                                                                      borderRadius: BorderRadius.circular(3.59),
                                                                                                      border: Border.all(
                                                                                                        color: FlutterFlowTheme.of(context).homeworkborder,
                                                                                                        width: FFAppState().eventname == 'Homework' ? 3.0 : 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                      child: Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                        children: [
                                                                                                          Image.asset(
                                                                                                            'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'Homework',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ].divide(SizedBox(width: 3.0)).around(SizedBox(width: 3.0)),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ].divide(SizedBox(width: 8.0)),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsets.all(5.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                              children: [
                                                                                                Form(
                                                                                                  key: _model.formKey,
                                                                                                  autovalidateMode: AutovalidateMode.disabled,
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsets.all(5.0),
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                                          child: TextFormField(
                                                                                                            controller: _model.eventnameTextController,
                                                                                                            focusNode: _model.eventnameFocusNode,
                                                                                                            onFieldSubmitted: (_) async {
                                                                                                              _model.lastfield = 1;
                                                                                                              safeSetState(() {});
                                                                                                            },
                                                                                                            autofocus: false,
                                                                                                            textCapitalization: TextCapitalization.sentences,
                                                                                                            obscureText: false,
                                                                                                            decoration: InputDecoration(
                                                                                                              isDense: true,
                                                                                                              labelText: 'Title',
                                                                                                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                    font: GoogleFonts.nunito(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    color: (_model.eventnameFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).textfieldText,
                                                                                                                    fontSize: (_model.eventnameFocusNode?.hasFocus ?? false) ? 12.0 : 16.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                  ),
                                                                                                              hintText: 'Title',
                                                                                                              hintStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                    font: GoogleFonts.nunito(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                    ),
                                                                                                                    color: FlutterFlowTheme.of(context).textfieldText,
                                                                                                                    fontSize: 16.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                  ),
                                                                                                              enabledBorder: OutlineInputBorder(
                                                                                                                borderSide: BorderSide(
                                                                                                                  color: FlutterFlowTheme.of(context).textfieldDisable,
                                                                                                                  width: 1.0,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                              ),
                                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                                borderSide: BorderSide(
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  width: 1.0,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                              ),
                                                                                                              errorBorder: OutlineInputBorder(
                                                                                                                borderSide: BorderSide(
                                                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                                                  width: 1.0,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                              ),
                                                                                                              focusedErrorBorder: OutlineInputBorder(
                                                                                                                borderSide: BorderSide(
                                                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                                                  width: 1.0,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                              ),
                                                                                                              filled: true,
                                                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).text2,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                            maxLines: null,
                                                                                                            maxLength: 25,
                                                                                                            buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                                                                                                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                            validator: _model.eventnameTextControllerValidator.asValidator(context),
                                                                                                            inputFormatters: [
                                                                                                              if (!isAndroid && !isiOS)
                                                                                                                TextInputFormatter.withFunction((oldValue, newValue) {
                                                                                                                  return TextEditingValue(
                                                                                                                    selection: newValue.selection,
                                                                                                                    text: newValue.text.toCapitalization(TextCapitalization.sentences),
                                                                                                                  );
                                                                                                                }),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsets.all(5.0),
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                                          child: TextFormField(
                                                                                                            controller: _model.descriptionTextController,
                                                                                                            focusNode: _model.descriptionFocusNode,
                                                                                                            autofocus: false,
                                                                                                            textCapitalization: TextCapitalization.sentences,
                                                                                                            obscureText: false,
                                                                                                            decoration: InputDecoration(
                                                                                                              isDense: true,
                                                                                                              labelText: 'Description',
                                                                                                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                    font: GoogleFonts.nunito(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    color: (_model.descriptionFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).textfieldText,
                                                                                                                    fontSize: (_model.descriptionFocusNode?.hasFocus ?? false) ? 12.0 : 16.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                  ),
                                                                                                              hintText: 'Description',
                                                                                                              hintStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                    font: GoogleFonts.nunito(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                    ),
                                                                                                                    color: FlutterFlowTheme.of(context).textfieldText,
                                                                                                                    fontSize: 16.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                  ),
                                                                                                              enabledBorder: OutlineInputBorder(
                                                                                                                borderSide: BorderSide(
                                                                                                                  color: FlutterFlowTheme.of(context).textfieldDisable,
                                                                                                                  width: 1.0,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                              ),
                                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                                borderSide: BorderSide(
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  width: 1.0,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                              ),
                                                                                                              errorBorder: OutlineInputBorder(
                                                                                                                borderSide: BorderSide(
                                                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                                                  width: 1.0,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                              ),
                                                                                                              focusedErrorBorder: OutlineInputBorder(
                                                                                                                borderSide: BorderSide(
                                                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                                                  width: 1.0,
                                                                                                                ),
                                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                              ),
                                                                                                              filled: true,
                                                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).text2,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                            maxLines: 4,
                                                                                                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                            validator: _model.descriptionTextControllerValidator.asValidator(context),
                                                                                                            inputFormatters: [
                                                                                                              if (!isAndroid && !isiOS)
                                                                                                                TextInputFormatter.withFunction((oldValue, newValue) {
                                                                                                                  return TextEditingValue(
                                                                                                                    selection: newValue.selection,
                                                                                                                    text: newValue.text.toCapitalization(TextCapitalization.sentences),
                                                                                                                  );
                                                                                                                }),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Builder(
                                                                                                    builder: (context) {
                                                                                                      final imagesview = FFAppState().eventfiles.toList();

                                                                                                      return SingleChildScrollView(
                                                                                                        scrollDirection: Axis.horizontal,
                                                                                                        child: Row(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: List.generate(imagesview.length, (imagesviewIndex) {
                                                                                                            final imagesviewItem = imagesview[imagesviewIndex];
                                                                                                            return Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              children: [
                                                                                                                if (functions.getFileTypeFromUrl(imagesviewItem) == 1)
                                                                                                                  InkWell(
                                                                                                                    splashColor: Colors.transparent,
                                                                                                                    focusColor: Colors.transparent,
                                                                                                                    hoverColor: Colors.transparent,
                                                                                                                    highlightColor: Colors.transparent,
                                                                                                                    onTap: () async {
                                                                                                                      await launchURL(imagesviewItem);
                                                                                                                    },
                                                                                                                    child: ClipRRect(
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                      child: Image.asset(
                                                                                                                        'assets/images/download.png',
                                                                                                                        width: 46.0,
                                                                                                                        height: 41.0,
                                                                                                                        fit: BoxFit.contain,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                if (functions.getFileTypeFromUrl(imagesviewItem) == 2)
                                                                                                                  InkWell(
                                                                                                                    splashColor: Colors.transparent,
                                                                                                                    focusColor: Colors.transparent,
                                                                                                                    hoverColor: Colors.transparent,
                                                                                                                    highlightColor: Colors.transparent,
                                                                                                                    onTap: () async {
                                                                                                                      await launchURL(imagesviewItem);
                                                                                                                    },
                                                                                                                    child: ClipRRect(
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                      child: Image.asset(
                                                                                                                        'assets/images/download_(1).png',
                                                                                                                        width: 46.0,
                                                                                                                        height: 41.0,
                                                                                                                        fit: BoxFit.contain,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                if (functions.getFileTypeFromUrl(imagesviewItem) == 3)
                                                                                                                  InkWell(
                                                                                                                    splashColor: Colors.transparent,
                                                                                                                    focusColor: Colors.transparent,
                                                                                                                    hoverColor: Colors.transparent,
                                                                                                                    highlightColor: Colors.transparent,
                                                                                                                    onTap: () async {
                                                                                                                      await launchURL(imagesviewItem);
                                                                                                                    },
                                                                                                                    child: ClipRRect(
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                      child: Image.asset(
                                                                                                                        'assets/images/download_(2).png',
                                                                                                                        width: 46.0,
                                                                                                                        height: 41.0,
                                                                                                                        fit: BoxFit.contain,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                if (functions.getFileTypeFromUrl(imagesviewItem) == 4)
                                                                                                                  InkWell(
                                                                                                                    splashColor: Colors.transparent,
                                                                                                                    focusColor: Colors.transparent,
                                                                                                                    hoverColor: Colors.transparent,
                                                                                                                    highlightColor: Colors.transparent,
                                                                                                                    onTap: () async {
                                                                                                                      await launchURL(imagesviewItem);
                                                                                                                    },
                                                                                                                    child: ClipRRect(
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                      child: Image.asset(
                                                                                                                        'assets/images/clarity_image-gallery-line.png',
                                                                                                                        width: 46.0,
                                                                                                                        height: 41.0,
                                                                                                                        fit: BoxFit.contain,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                if (functions.getFileTypeFromUrl(imagesviewItem) == 5)
                                                                                                                  InkWell(
                                                                                                                    splashColor: Colors.transparent,
                                                                                                                    focusColor: Colors.transparent,
                                                                                                                    hoverColor: Colors.transparent,
                                                                                                                    highlightColor: Colors.transparent,
                                                                                                                    onTap: () async {
                                                                                                                      await launchURL(imagesviewItem);
                                                                                                                    },
                                                                                                                    child: ClipRRect(
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                      child: Image.asset(
                                                                                                                        'assets/images/download-removebg-preview.png',
                                                                                                                        width: 46.0,
                                                                                                                        height: 41.0,
                                                                                                                        fit: BoxFit.contain,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                              ].divide(SizedBox(width: 5.0)).around(SizedBox(width: 5.0)),
                                                                                                            );
                                                                                                          }),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      FlutterFlowIconButton(
                                                                                                        borderColor: FlutterFlowTheme.of(context).stroke,
                                                                                                        borderRadius: 10.0,
                                                                                                        borderWidth: 1.0,
                                                                                                        buttonSize: 50.0,
                                                                                                        icon: Icon(
                                                                                                          Icons.attach_file,
                                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                          size: 18.0,
                                                                                                        ),
                                                                                                        showLoadingIndicator: true,
                                                                                                        onPressed: () async {
                                                                                                          safeSetState(() {
                                                                                                            _model.isDataUploading_uploadData8ae66 = false;
                                                                                                            _model.uploadedLocalFile_uploadData8ae66 = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                                            _model.uploadedFileUrl_uploadData8ae66 = '';
                                                                                                          });

                                                                                                          final selectedFiles = await selectFiles(
                                                                                                            multiFile: true,
                                                                                                          );
                                                                                                          if (selectedFiles != null) {
                                                                                                            safeSetState(() => _model.isDataUploading_uploadDataWee = true);
                                                                                                            var selectedUploadedFiles = <FFUploadedFile>[];

                                                                                                            var downloadUrls = <String>[];
                                                                                                            try {
                                                                                                              selectedUploadedFiles = selectedFiles
                                                                                                                  .map((m) => FFUploadedFile(
                                                                                                                        name: m.storagePath.split('/').last,
                                                                                                                        bytes: m.bytes,
                                                                                                                      ))
                                                                                                                  .toList();

                                                                                                              downloadUrls = (await Future.wait(
                                                                                                                selectedFiles.map(
                                                                                                                  (f) async => await uploadData(f.storagePath, f.bytes),
                                                                                                                ),
                                                                                                              ))
                                                                                                                  .where((u) => u != null)
                                                                                                                  .map((u) => u!)
                                                                                                                  .toList();
                                                                                                            } finally {
                                                                                                              _model.isDataUploading_uploadDataWee = false;
                                                                                                            }
                                                                                                            if (selectedUploadedFiles.length == selectedFiles.length && downloadUrls.length == selectedFiles.length) {
                                                                                                              safeSetState(() {
                                                                                                                _model.uploadedLocalFiles_uploadDataWee = selectedUploadedFiles;
                                                                                                                _model.uploadedFileUrls_uploadDataWee = downloadUrls;
                                                                                                              });
                                                                                                            } else {
                                                                                                              safeSetState(() {});
                                                                                                              return;
                                                                                                            }
                                                                                                          }

                                                                                                          if (_model.uploadedFileUrls_uploadDataWee.length != 0) {
                                                                                                            if (functions.isValidFileFormatCopy(_model.uploadedFileUrls_uploadDataWee.toList())) {
                                                                                                              FFAppState().eventfiles = functions.combineImagePathsCopy(_model.uploadedFileUrls_uploadDataWee.toList(), FFAppState().eventfiles.toList()).toList().cast<String>();
                                                                                                              safeSetState(() {});
                                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                SnackBar(
                                                                                                                  content: Text(
                                                                                                                    'File uploaded',
                                                                                                                    style: TextStyle(
                                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  duration: Duration(milliseconds: 4000),
                                                                                                                  backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                                ),
                                                                                                              );
                                                                                                            } else {
                                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                SnackBar(
                                                                                                                  content: Text(
                                                                                                                    'only pdf , docx , jpeg , png , jpg , mp3, ppt , pptx files are allowed ',
                                                                                                                    style: TextStyle(
                                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  duration: Duration(milliseconds: 4000),
                                                                                                                  backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                                ),
                                                                                                              );
                                                                                                            }
                                                                                                          }
                                                                                                        },
                                                                                                      ),
                                                                                                      FlutterFlowIconButton(
                                                                                                        borderColor: FlutterFlowTheme.of(context).stroke,
                                                                                                        borderRadius: 8.0,
                                                                                                        borderWidth: 1.0,
                                                                                                        buttonSize: 50.0,
                                                                                                        icon: Icon(
                                                                                                          Icons.photo_camera_outlined,
                                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                          size: 18.0,
                                                                                                        ),
                                                                                                        showLoadingIndicator: true,
                                                                                                        onPressed: () async {
                                                                                                          safeSetState(() {
                                                                                                            _model.isDataUploading_uploadData8ae66 = false;
                                                                                                            _model.uploadedLocalFile_uploadData8ae66 = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                                            _model.uploadedFileUrl_uploadData8ae66 = '';
                                                                                                          });

                                                                                                          final selectedMedia = await selectMedia(
                                                                                                            multiImage: false,
                                                                                                          );
                                                                                                          if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                                                            safeSetState(() => _model.isDataUploading_uploadData8ae66 = true);
                                                                                                            var selectedUploadedFiles = <FFUploadedFile>[];

                                                                                                            var downloadUrls = <String>[];
                                                                                                            try {
                                                                                                              selectedUploadedFiles = selectedMedia
                                                                                                                  .map((m) => FFUploadedFile(
                                                                                                                        name: m.storagePath.split('/').last,
                                                                                                                        bytes: m.bytes,
                                                                                                                        height: m.dimensions?.height,
                                                                                                                        width: m.dimensions?.width,
                                                                                                                        blurHash: m.blurHash,
                                                                                                                      ))
                                                                                                                  .toList();

                                                                                                              downloadUrls = (await Future.wait(
                                                                                                                selectedMedia.map(
                                                                                                                  (m) async => await uploadData(m.storagePath, m.bytes),
                                                                                                                ),
                                                                                                              ))
                                                                                                                  .where((u) => u != null)
                                                                                                                  .map((u) => u!)
                                                                                                                  .toList();
                                                                                                            } finally {
                                                                                                              _model.isDataUploading_uploadData8ae66 = false;
                                                                                                            }
                                                                                                            if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                                              safeSetState(() {
                                                                                                                _model.uploadedLocalFile_uploadData8ae66 = selectedUploadedFiles.first;
                                                                                                                _model.uploadedFileUrl_uploadData8ae66 = downloadUrls.first;
                                                                                                              });
                                                                                                            } else {
                                                                                                              safeSetState(() {});
                                                                                                              return;
                                                                                                            }
                                                                                                          }

                                                                                                          if (_model.uploadedFileUrl_uploadData8ae66 != '') {
                                                                                                            FFAppState().addToEventfiles(_model.uploadedFileUrl_uploadData8ae66);
                                                                                                            safeSetState(() {});
                                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                                              SnackBar(
                                                                                                                content: Text(
                                                                                                                  'File uploaded',
                                                                                                                  style: TextStyle(
                                                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                duration: Duration(milliseconds: 4000),
                                                                                                                backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                              ),
                                                                                                            );
                                                                                                          }
                                                                                                        },
                                                                                                      ),
                                                                                                      FFButtonWidget(
                                                                                                        onPressed: ((adminTeacherSchoolRecord.listOfStudents.length == 0) || (_model.eventnameTextController.text == ''))
                                                                                                            ? null
                                                                                                            : () async {
                                                                                                                if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp)) || (currentUserDocument?.checkin == null)) {
                                                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                    SnackBar(
                                                                                                                      content: Text(
                                                                                                                        'Please CheckIn ',
                                                                                                                        style: TextStyle(
                                                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      duration: Duration(milliseconds: 4000),
                                                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                    ),
                                                                                                                  );
                                                                                                                } else {
                                                                                                                  if (tabbarclassSchoolClassRecordList.where((e) => e.listOfteachersUser.contains(currentUserReference)).toList().length != 0) {
                                                                                                                    if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) {
                                                                                                                      return;
                                                                                                                    }
                                                                                                                    _model.title = _model.eventnameTextController.text;
                                                                                                                    _model.des = _model.descriptionTextController.text;
                                                                                                                    safeSetState(() {});
                                                                                                                    if (_model.eventname != '') {
                                                                                                                      if (FFAppState().eventfiles.length == 0) {
                                                                                                                        safeSetState(() {
                                                                                                                          _model.descriptionTextController?.clear();
                                                                                                                          _model.eventnameTextController?.clear();
                                                                                                                        });
                                                                                                                        _model.lastfield = 0;
                                                                                                                        safeSetState(() {});
                                                                                                                        await showModalBottomSheet(
                                                                                                                          isScrollControlled: true,
                                                                                                                          backgroundColor: Colors.transparent,
                                                                                                                          isDismissible: false,
                                                                                                                          enableDrag: false,
                                                                                                                          context: context,
                                                                                                                          builder: (context) {
                                                                                                                            return GestureDetector(
                                                                                                                              onTap: () {
                                                                                                                                FocusScope.of(context).unfocus();
                                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                              },
                                                                                                                              child: Padding(
                                                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                                                child: Container(
                                                                                                                                  height: MediaQuery.sizeOf(context).height * 0.7,
                                                                                                                                  child: SelectClassNoticeWidget(
                                                                                                                                    schoolref: adminTeacherSchoolRecord.reference,
                                                                                                                                    eventtitle: _model.title!,
                                                                                                                                    description: _model.des!,
                                                                                                                                    datetime: _model.datetime!,
                                                                                                                                    eventname: FFAppState().eventname,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          },
                                                                                                                        ).then((value) => safeSetState(() {}));
                                                                                                                      } else {
                                                                                                                        safeSetState(() {
                                                                                                                          _model.descriptionTextController?.clear();
                                                                                                                          _model.eventnameTextController?.clear();
                                                                                                                        });
                                                                                                                        _model.lastfield = 0;
                                                                                                                        safeSetState(() {});
                                                                                                                        await showModalBottomSheet(
                                                                                                                          isScrollControlled: true,
                                                                                                                          backgroundColor: Colors.transparent,
                                                                                                                          isDismissible: false,
                                                                                                                          enableDrag: false,
                                                                                                                          context: context,
                                                                                                                          builder: (context) {
                                                                                                                            return GestureDetector(
                                                                                                                              onTap: () {
                                                                                                                                FocusScope.of(context).unfocus();
                                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                              },
                                                                                                                              child: Padding(
                                                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                                                child: Container(
                                                                                                                                  height: MediaQuery.sizeOf(context).height * 0.7,
                                                                                                                                  child: SelectClassNoticeWidget(
                                                                                                                                    schoolref: adminTeacherSchoolRecord.reference,
                                                                                                                                    eventtitle: _model.title!,
                                                                                                                                    description: _model.des!,
                                                                                                                                    datetime: _model.datetime!,
                                                                                                                                    images: FFAppState().eventfiles,
                                                                                                                                    eventname: FFAppState().eventname,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          },
                                                                                                                        ).then((value) => safeSetState(() {}));
                                                                                                                      }
                                                                                                                    } else {
                                                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                        SnackBar(
                                                                                                                          content: Text(
                                                                                                                            'Pick the name of event',
                                                                                                                            style: TextStyle(
                                                                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          duration: Duration(milliseconds: 4000),
                                                                                                                          backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                                        ),
                                                                                                                      );
                                                                                                                    }
                                                                                                                  } else {
                                                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                      SnackBar(
                                                                                                                        content: Text(
                                                                                                                          'Notice Addition  To add a notice, you must be assigned to at least one class. Please ensure you are assigned accordingly to proceed.',
                                                                                                                          style: TextStyle(
                                                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        duration: Duration(milliseconds: 4000),
                                                                                                                        backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  }
                                                                                                                }
                                                                                                              },
                                                                                                        text: 'Post',
                                                                                                        options: FFButtonOptions(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.55,
                                                                                                          height: MediaQuery.sizeOf(context).height * 0.055,
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                font: GoogleFonts.nunito(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                ),
                                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                              ),
                                                                                                          elevation: 0.0,
                                                                                                          borderSide: BorderSide(
                                                                                                            color: valueOrDefault<Color>(
                                                                                                              (adminTeacherSchoolRecord.listOfStudents.length == 0) || (_model.eventnameTextController.text == '') ? FlutterFlowTheme.of(context).secondary : FlutterFlowTheme.of(context).primary,
                                                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            ),
                                                                                                          ),
                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                          disabledColor: FlutterFlowTheme.of(context).dIsable,
                                                                                                          disabledTextColor: FlutterFlowTheme.of(context).secondary,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ].divide(SizedBox(height: 10.0)).around(SizedBox(height: 10.0)),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.05,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFF3F3F3),
                                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          if (_model.datePicked == null)
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  'Latest on your notice board',
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.nunito(
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).text2,
                                                                                                        fontSize: 14.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          Container(
                                                                                            width: 50.0,
                                                                                            height: 100.0,
                                                                                            decoration: BoxDecoration(),
                                                                                          ),
                                                                                          if (_model.datePicked != null)
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    _model.datetime = functions.prevDate(_model.datetime);
                                                                                                    safeSetState(() {});
                                                                                                  },
                                                                                                  child: Icon(
                                                                                                    Icons.chevron_left,
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  dateTimeFormat("dd MMM y", _model.datetime),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.nunito(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    _model.datetime = functions.nextDate(_model.datetime);
                                                                                                    safeSetState(() {});
                                                                                                  },
                                                                                                  child: Icon(
                                                                                                    Icons.navigate_next,
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ].divide(SizedBox(width: 10.0)),
                                                                                            ),
                                                                                          if (_model.datePicked == null)
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  final _datePickedDate = await showDatePicker(
                                                                                                    context: context,
                                                                                                    initialDate: getCurrentTimestamp,
                                                                                                    firstDate: DateTime(1900),
                                                                                                    lastDate: getCurrentTimestamp,
                                                                                                    builder: (context, child) {
                                                                                                      return wrapInMaterialDatePickerTheme(
                                                                                                        context,
                                                                                                        child!,
                                                                                                        headerBackgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                                        headerForegroundColor: FlutterFlowTheme.of(context).info,
                                                                                                        headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                                              font: GoogleFonts.nunito(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: 32.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                                            ),
                                                                                                        pickerBackgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                        pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                        selectedDateTimeBackgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                                        selectedDateTimeForegroundColor: FlutterFlowTheme.of(context).info,
                                                                                                        actionButtonForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                        iconSize: 24.0,
                                                                                                      );
                                                                                                    },
                                                                                                  );

                                                                                                  if (_datePickedDate != null) {
                                                                                                    safeSetState(() {
                                                                                                      _model.datePicked = DateTime(
                                                                                                        _datePickedDate.year,
                                                                                                        _datePickedDate.month,
                                                                                                        _datePickedDate.day,
                                                                                                      );
                                                                                                    });
                                                                                                  } else if (_model.datePicked != null) {
                                                                                                    safeSetState(() {
                                                                                                      _model.datePicked = getCurrentTimestamp;
                                                                                                    });
                                                                                                  }
                                                                                                  if (_model.datePicked != null) {
                                                                                                    _model.datetime = _model.datePicked;
                                                                                                    safeSetState(() {});
                                                                                                  } else {
                                                                                                    _model.datetime = getCurrentTimestamp;
                                                                                                    safeSetState(() {});
                                                                                                  }
                                                                                                },
                                                                                                child: Icon(
                                                                                                  FFIcons.kvector2x,
                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  size: 25.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          Container(
                                                                                            width: 50.0,
                                                                                            height: 100.0,
                                                                                            decoration: BoxDecoration(),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  if (_model.datePicked == null)
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                                                                      child: Builder(
                                                                                        builder: (context) {
                                                                                          final notice = (adminTeacherSchoolRecord.listOfNotice.sortedList(keyOf: (e) => e.eventDate!, desc: true).toList() ?? []).take(5).toList();
                                                                                          if (notice.isEmpty) {
                                                                                            return Center(
                                                                                              child: Container(
                                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                height: MediaQuery.sizeOf(context).height * 0.5,
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
                                                                                            itemCount: notice.length,
                                                                                            itemBuilder: (context, noticeIndex) {
                                                                                              final noticeItem = notice[noticeIndex];
                                                                                              return Padding(
                                                                                                padding: EdgeInsets.all(10.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    context.pushNamed(
                                                                                                      NoticeDetailsWidget.routeName,
                                                                                                      queryParameters: {
                                                                                                        'eventDetails': serializeParam(
                                                                                                          noticeItem,
                                                                                                          ParamType.DataStruct,
                                                                                                        ),
                                                                                                      }.withoutNulls,
                                                                                                    );
                                                                                                  },
                                                                                                  child: Material(
                                                                                                    color: Colors.transparent,
                                                                                                    elevation: 2.0,
                                                                                                    shape: RoundedRectangleBorder(
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                    ),
                                                                                                    child: Container(
                                                                                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(
                                                                                                            blurRadius: 20.0,
                                                                                                            color: Color(0x06000000),
                                                                                                            offset: Offset(
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                            ),
                                                                                                            spreadRadius: 0.0,
                                                                                                          )
                                                                                                        ],
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                        border: Border.all(
                                                                                                          color: Color(0xFFF2F2F2),
                                                                                                          width: 1.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                                                                                        child: Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Column(
                                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                    children: [
                                                                                                                      Container(
                                                                                                                        width: MediaQuery.sizeOf(context).width * 0.4,
                                                                                                                        decoration: BoxDecoration(),
                                                                                                                        child: Text(
                                                                                                                          noticeItem.eventTitle,
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
                                                                                                                      Text(
                                                                                                                        dateTimeFormat("dd MMM , y", noticeItem.eventDate!),
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
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                  Container(
                                                                                                                    decoration: BoxDecoration(
                                                                                                                      color: () {
                                                                                                                        if (noticeItem.eventName == 'Homework') {
                                                                                                                          return FlutterFlowTheme.of(context).homework;
                                                                                                                        } else if (noticeItem.eventName == 'Reminder') {
                                                                                                                          return FlutterFlowTheme.of(context).reminderfill;
                                                                                                                        } else {
                                                                                                                          return FlutterFlowTheme.of(context).event;
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                      borderRadius: BorderRadius.circular(3.59),
                                                                                                                      border: Border.all(
                                                                                                                        color: () {
                                                                                                                          if (noticeItem.eventName == 'Homework') {
                                                                                                                            return FlutterFlowTheme.of(context).homeworkborder;
                                                                                                                          } else if (noticeItem.eventName == 'Reminder') {
                                                                                                                            return FlutterFlowTheme.of(context).reminderborder;
                                                                                                                          } else {
                                                                                                                            return FlutterFlowTheme.of(context).generalBorder;
                                                                                                                          }
                                                                                                                        }(),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    child: Padding(
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      child: Row(
                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          if (noticeItem.eventName == 'General')
                                                                                                                            Image.asset(
                                                                                                                              'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                                                                              width: 15.5,
                                                                                                                              height: 15.5,
                                                                                                                              fit: BoxFit.cover,
                                                                                                                            ),
                                                                                                                          if (noticeItem.eventName == 'Reminder')
                                                                                                                            Image.asset(
                                                                                                                              'assets/images/3d-alarm.png',
                                                                                                                              width: 15.5,
                                                                                                                              height: 15.5,
                                                                                                                              fit: BoxFit.cover,
                                                                                                                            ),
                                                                                                                          if (noticeItem.eventName == 'Homework')
                                                                                                                            Image.asset(
                                                                                                                              'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                                                                              width: 15.5,
                                                                                                                              height: 15.5,
                                                                                                                              fit: BoxFit.cover,
                                                                                                                            ),
                                                                                                                          Text(
                                                                                                                            noticeItem.eventName,
                                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                  ),
                                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                                  fontSize: 14.0,
                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                ),
                                                                                                                          ),
                                                                                                                        ].divide(SizedBox(width: 5.0)).around(SizedBox(width: 5.0)),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                                              decoration: BoxDecoration(),
                                                                                                              child: Text(
                                                                                                                noticeItem.eventDescription,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.nunito(
                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                                      fontSize: 16.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.normal,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length.toString(),
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
                                                                                                                          'assets/images/download.png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length.toString(),
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
                                                                                                                      showBadge: true,
                                                                                                                      shape: badges.BadgeShape.circle,
                                                                                                                      badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                      elevation: 0.0,
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      position: badges.BadgePosition.topEnd(),
                                                                                                                      animationType: badges.BadgeAnimationType.scale,
                                                                                                                      toAnimate: true,
                                                                                                                      child: ClipRRect(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        child: Image.asset(
                                                                                                                          'assets/images/download_(1).png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length.toString(),
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
                                                                                                                      showBadge: true,
                                                                                                                      shape: badges.BadgeShape.circle,
                                                                                                                      badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                      elevation: 0.0,
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      position: badges.BadgePosition.topEnd(),
                                                                                                                      animationType: badges.BadgeAnimationType.scale,
                                                                                                                      toAnimate: true,
                                                                                                                      child: ClipRRect(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        child: Image.asset(
                                                                                                                          'assets/images/download_(2).png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length.toString(),
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
                                                                                                                      showBadge: true,
                                                                                                                      shape: badges.BadgeShape.circle,
                                                                                                                      badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                      elevation: 0.0,
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      position: badges.BadgePosition.topEnd(),
                                                                                                                      animationType: badges.BadgeAnimationType.scale,
                                                                                                                      toAnimate: true,
                                                                                                                      child: ClipRRect(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        child: Image.asset(
                                                                                                                          'assets/images/clarity_image-gallery-line.png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length.toString(),
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
                                                                                                                      showBadge: true,
                                                                                                                      shape: badges.BadgeShape.circle,
                                                                                                                      badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                      elevation: 0.0,
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      position: badges.BadgePosition.topEnd(),
                                                                                                                      animationType: badges.BadgeAnimationType.scale,
                                                                                                                      toAnimate: true,
                                                                                                                      child: ClipRRect(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        child: Image.asset(
                                                                                                                          'assets/images/download-removebg-preview.png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                ].divide(SizedBox(width: 18.0)).around(SizedBox(width: 18.0)),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ].addToEnd(SizedBox(height: 20.0)),
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
                                                                                  if (_model.datePicked != null)
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                                                                      child: Builder(
                                                                                        builder: (context) {
                                                                                          final notice = adminTeacherSchoolRecord.listOfNotice.where((e) => dateTimeFormat("yMMMd", e.eventDate) == dateTimeFormat("yMMMd", _model.datetime)).toList().toList() ?? [];
                                                                                          if (notice.isEmpty) {
                                                                                            return Center(
                                                                                              child: Container(
                                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                height: MediaQuery.sizeOf(context).height * 0.5,
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
                                                                                            itemCount: notice.length,
                                                                                            itemBuilder: (context, noticeIndex) {
                                                                                              final noticeItem = notice[noticeIndex];
                                                                                              return Padding(
                                                                                                padding: EdgeInsets.all(10.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    context.pushNamed(
                                                                                                      NoticeDetailsWidget.routeName,
                                                                                                      queryParameters: {
                                                                                                        'eventDetails': serializeParam(
                                                                                                          noticeItem,
                                                                                                          ParamType.DataStruct,
                                                                                                        ),
                                                                                                      }.withoutNulls,
                                                                                                    );
                                                                                                  },
                                                                                                  child: Material(
                                                                                                    color: Colors.transparent,
                                                                                                    elevation: 2.0,
                                                                                                    shape: RoundedRectangleBorder(
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                    ),
                                                                                                    child: Container(
                                                                                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(
                                                                                                            blurRadius: 20.0,
                                                                                                            color: Color(0x06000000),
                                                                                                            offset: Offset(
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                            ),
                                                                                                            spreadRadius: 0.0,
                                                                                                          )
                                                                                                        ],
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                        border: Border.all(
                                                                                                          color: Color(0xFFF2F2F2),
                                                                                                          width: 1.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                                                                                        child: Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Column(
                                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                    children: [
                                                                                                                      Container(
                                                                                                                        width: MediaQuery.sizeOf(context).width * 0.4,
                                                                                                                        decoration: BoxDecoration(),
                                                                                                                        child: Text(
                                                                                                                          noticeItem.eventTitle,
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
                                                                                                                      Text(
                                                                                                                        dateTimeFormat("dd MMM , y", noticeItem.eventDate!),
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
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                  Container(
                                                                                                                    decoration: BoxDecoration(
                                                                                                                      color: () {
                                                                                                                        if (noticeItem.eventName == 'Homework') {
                                                                                                                          return FlutterFlowTheme.of(context).homework;
                                                                                                                        } else if (noticeItem.eventName == 'Reminder') {
                                                                                                                          return FlutterFlowTheme.of(context).reminderfill;
                                                                                                                        } else {
                                                                                                                          return FlutterFlowTheme.of(context).event;
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                      borderRadius: BorderRadius.circular(3.59),
                                                                                                                      border: Border.all(
                                                                                                                        color: () {
                                                                                                                          if (noticeItem.eventName == 'Homework') {
                                                                                                                            return FlutterFlowTheme.of(context).homeworkborder;
                                                                                                                          } else if (noticeItem.eventName == 'Reminder') {
                                                                                                                            return FlutterFlowTheme.of(context).reminderborder;
                                                                                                                          } else {
                                                                                                                            return FlutterFlowTheme.of(context).generalBorder;
                                                                                                                          }
                                                                                                                        }(),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    child: Padding(
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      child: Row(
                                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                        children: [
                                                                                                                          if (noticeItem.eventName == 'General')
                                                                                                                            Image.asset(
                                                                                                                              'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                                                                              width: 15.5,
                                                                                                                              height: 15.5,
                                                                                                                              fit: BoxFit.cover,
                                                                                                                            ),
                                                                                                                          if (noticeItem.eventName == 'Reminder')
                                                                                                                            Image.asset(
                                                                                                                              'assets/images/3d-alarm.png',
                                                                                                                              width: 15.5,
                                                                                                                              height: 15.5,
                                                                                                                              fit: BoxFit.cover,
                                                                                                                            ),
                                                                                                                          if (noticeItem.eventName == 'Homework')
                                                                                                                            Image.asset(
                                                                                                                              'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                                                                              width: 15.5,
                                                                                                                              height: 15.5,
                                                                                                                              fit: BoxFit.cover,
                                                                                                                            ),
                                                                                                                          Text(
                                                                                                                            noticeItem.eventName,
                                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                  ),
                                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                                  fontSize: 14.0,
                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                ),
                                                                                                                          ),
                                                                                                                        ].divide(SizedBox(width: 5.0)).around(SizedBox(width: 5.0)),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                                              decoration: BoxDecoration(),
                                                                                                              child: Text(
                                                                                                                noticeItem.eventDescription,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.nunito(
                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                                      fontSize: 16.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.normal,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length.toString(),
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
                                                                                                                          'assets/images/download.png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length.toString(),
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
                                                                                                                      showBadge: true,
                                                                                                                      shape: badges.BadgeShape.circle,
                                                                                                                      badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                      elevation: 0.0,
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      position: badges.BadgePosition.topEnd(),
                                                                                                                      animationType: badges.BadgeAnimationType.scale,
                                                                                                                      toAnimate: true,
                                                                                                                      child: ClipRRect(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        child: Image.asset(
                                                                                                                          'assets/images/download_(1).png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length.toString(),
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
                                                                                                                      showBadge: true,
                                                                                                                      shape: badges.BadgeShape.circle,
                                                                                                                      badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                      elevation: 0.0,
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      position: badges.BadgePosition.topEnd(),
                                                                                                                      animationType: badges.BadgeAnimationType.scale,
                                                                                                                      toAnimate: true,
                                                                                                                      child: ClipRRect(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        child: Image.asset(
                                                                                                                          'assets/images/download_(2).png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length.toString(),
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
                                                                                                                      showBadge: true,
                                                                                                                      shape: badges.BadgeShape.circle,
                                                                                                                      badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                      elevation: 0.0,
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      position: badges.BadgePosition.topEnd(),
                                                                                                                      animationType: badges.BadgeAnimationType.scale,
                                                                                                                      toAnimate: true,
                                                                                                                      child: ClipRRect(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        child: Image.asset(
                                                                                                                          'assets/images/clarity_image-gallery-line.png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length != 0)
                                                                                                                    badges.Badge(
                                                                                                                      badgeContent: Text(
                                                                                                                        noticeItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length.toString(),
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
                                                                                                                      showBadge: true,
                                                                                                                      shape: badges.BadgeShape.circle,
                                                                                                                      badgeColor: FlutterFlowTheme.of(context).primary,
                                                                                                                      elevation: 0.0,
                                                                                                                      padding: EdgeInsets.all(5.0),
                                                                                                                      position: badges.BadgePosition.topEnd(),
                                                                                                                      animationType: badges.BadgeAnimationType.scale,
                                                                                                                      toAnimate: true,
                                                                                                                      child: ClipRRect(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                        child: Image.asset(
                                                                                                                          'assets/images/download-removebg-preview.png',
                                                                                                                          width: 46.0,
                                                                                                                          height: 41.0,
                                                                                                                          fit: BoxFit.contain,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                ].divide(SizedBox(width: 18.0)).around(SizedBox(width: 18.0)),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ].addToEnd(SizedBox(height: 20.0)),
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
                                                                                ],
                                                                              ),
                                                                            ].addToEnd(SizedBox(height: 40.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          20.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              40.0),
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(10.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.58,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          'Tap the filter to view events for a specific class',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.nunito(
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 10.0, 5.0),
                                                                                        child: FlutterFlowDropDown<String>(
                                                                                          controller: _model.dropDownValueController ??= FormFieldController<String>(
                                                                                            _model.dropDownValue ??= 'All',
                                                                                          ),
                                                                                          options: functions.getClassNames(tabbarclassSchoolClassRecordList.toList(), adminTeacherSchoolRecord.listOfClass.toList()),
                                                                                          onChanged: (val) async {
                                                                                            safeSetState(() => _model.dropDownValue = val);
                                                                                            if (_model.dropDownValue != 'All') {
                                                                                              _model.selectedclass = tabbarclassSchoolClassRecordList.where((e) => e.className == _model.dropDownValue).toList().firstOrNull?.reference;
                                                                                              _model.classevents = tabbarclassSchoolClassRecordList.where((e) => e.className == _model.dropDownValue).toList().firstOrNull!.calendar.toList().cast<EventsNoticeStruct>();
                                                                                              safeSetState(() {});
                                                                                            } else {
                                                                                              _model.selectedclass = null;
                                                                                              _model.classevents = [];
                                                                                              safeSetState(() {});
                                                                                            }
                                                                                          },
                                                                                          width: 111.0,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.05,
                                                                                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.nunito(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).text1,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                          hintText: 'All',
                                                                                          icon: Icon(
                                                                                            Icons.keyboard_arrow_down_rounded,
                                                                                            color: FlutterFlowTheme.of(context).text1,
                                                                                            size: 24.0,
                                                                                          ),
                                                                                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          elevation: 2.0,
                                                                                          borderColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          borderWidth: 0.5,
                                                                                          borderRadius: 20.0,
                                                                                          margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                          hidesUnderline: true,
                                                                                          isOverButton: false,
                                                                                          isSearchable: false,
                                                                                          isMultiSelect: false,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                if (_model.selectedclass == null)
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                      height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                                      ),
                                                                                      child: Visibility(
                                                                                        visible: _model.selectedclass == null,
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                          child: Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                            height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                            child: custom_widgets.Timelinewidgetdatatype(
                                                                                              width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                              height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                              timrlinewidget: adminTeacherSchoolRecord.calendarList,
                                                                                              schoolref: adminTeacherSchoolRecord.reference,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if (_model.selectedclass != null)
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                      height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                                      ),
                                                                                      child: Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                        height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                        child: custom_widgets.TimelinewidgetdatatypeClassCopy(
                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                          height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                          timrlinewidget: _model.classevents,
                                                                                          schoolclassref: _model.selectedclass!,
                                                                                          classname: _model.dropDownValue!,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                              ].addToEnd(SizedBox(height: 30.0)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiary,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            40.0),
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  'Total Student - ${adminTeacherSchoolRecord.studentDataList.where((e) => e.isDraft == false).toList().length.toString()}',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 30.0),
                                                                                child: Builder(
                                                                                  builder: (context) {
                                                                                    final students = adminTeacherSchoolRecord.studentDataList.sortedList(keyOf: (e) => e.studentName, desc: false).toList() ?? [];
                                                                                    if (students.isEmpty) {
                                                                                      return Center(
                                                                                        child: Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                          child: EmptystudentWidget(),
                                                                                        ),
                                                                                      );
                                                                                    }

                                                                                    return GridView.builder(
                                                                                      padding: EdgeInsets.zero,
                                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                        crossAxisCount: 3,
                                                                                        crossAxisSpacing: 10.0,
                                                                                        mainAxisSpacing: 15.0,
                                                                                        childAspectRatio: 0.87,
                                                                                      ),
                                                                                      primary: false,
                                                                                      shrinkWrap: true,
                                                                                      scrollDirection: Axis.vertical,
                                                                                      itemCount: students.length,
                                                                                      itemBuilder: (context, studentsIndex) {
                                                                                        final studentsItem = students[studentsIndex];
                                                                                        return Builder(
                                                                                          builder: (context) {
                                                                                            if (studentsIndex == 0) {
                                                                                              return Visibility(
                                                                                                visible: valueOrDefault(currentUserDocument?.userRole, 0) != 1,
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp)) || (currentUserDocument?.checkin == null)) {
                                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                                        SnackBar(
                                                                                                          content: Text(
                                                                                                            'Please CheckIn ',
                                                                                                            style: TextStyle(
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                            ),
                                                                                                          ),
                                                                                                          duration: Duration(milliseconds: 4000),
                                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                        ),
                                                                                                      );
                                                                                                    } else {
                                                                                                      context.pushNamed(
                                                                                                        AddStudentManuallyWidget.routeName,
                                                                                                        queryParameters: {
                                                                                                          'schoolref': serializeParam(
                                                                                                            adminTeacherSchoolRecord.reference,
                                                                                                            ParamType.DocumentReference,
                                                                                                          ),
                                                                                                        }.withoutNulls,
                                                                                                      );
                                                                                                    }
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                    height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 2.0,
                                                                                                          color: Color(0x3FE4E5E7),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            1.0,
                                                                                                          ),
                                                                                                          spreadRadius: 0.0,
                                                                                                        )
                                                                                                      ],
                                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                                      border: Border.all(
                                                                                                        color: Color(0xFFEDF1F3),
                                                                                                        width: 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                                          height: MediaQuery.sizeOf(context).width * 0.15,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: Color(0xFFE4EDFC),
                                                                                                            shape: BoxShape.circle,
                                                                                                          ),
                                                                                                          child: Stack(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            children: [
                                                                                                              Container(
                                                                                                                width: MediaQuery.sizeOf(context).width * 0.18,
                                                                                                                height: MediaQuery.sizeOf(context).width * 0.18,
                                                                                                                clipBehavior: Clip.antiAlias,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  shape: BoxShape.circle,
                                                                                                                ),
                                                                                                                child: Image.network(
                                                                                                                  FFAppConstants.addImage,
                                                                                                                  fit: BoxFit.cover,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        Text(
                                                                                                          'Add Student',
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.nunito(
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                                fontSize: 12.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ].divide(SizedBox(height: 10.0)),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            } else {
                                                                                              return StreamBuilder<StudentsRecord>(
                                                                                                stream: StudentsRecord.getDocument(studentsItem.studentId!),
                                                                                                builder: (context, snapshot) {
                                                                                                  // Customize what your widget looks like when it's loading.
                                                                                                  if (!snapshot.hasData) {
                                                                                                    return StudentshimmerWidget();
                                                                                                  }

                                                                                                  final stackStudentsRecord = snapshot.data!;

                                                                                                  return InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp)) || (currentUserDocument?.checkin == null)) {
                                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                                          SnackBar(
                                                                                                            content: Text(
                                                                                                              'Please CheckIn ',
                                                                                                              style: TextStyle(
                                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              ),
                                                                                                            ),
                                                                                                            duration: Duration(milliseconds: 4000),
                                                                                                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                          ),
                                                                                                        );
                                                                                                      } else {
                                                                                                        if (stackStudentsRecord.isDraft == true) {
                                                                                                          context.pushNamed(
                                                                                                            StudentDraftWidget.routeName,
                                                                                                            queryParameters: {
                                                                                                              'schoolref': serializeParam(
                                                                                                                adminTeacherSchoolRecord.reference,
                                                                                                                ParamType.DocumentReference,
                                                                                                              ),
                                                                                                              'studentref': serializeParam(
                                                                                                                studentsItem.studentId,
                                                                                                                ParamType.DocumentReference,
                                                                                                              ),
                                                                                                            }.withoutNulls,
                                                                                                          );
                                                                                                        } else {
                                                                                                          if (studentsItem.classref.length != 0) {
                                                                                                            context.pushNamed(
                                                                                                              IndistudentmainpagesWidget.routeName,
                                                                                                              queryParameters: {
                                                                                                                'studentsref': serializeParam(
                                                                                                                  studentsItem.studentId,
                                                                                                                  ParamType.DocumentReference,
                                                                                                                ),
                                                                                                                'schoolref': serializeParam(
                                                                                                                  adminTeacherSchoolRecord.reference,
                                                                                                                  ParamType.DocumentReference,
                                                                                                                ),
                                                                                                              }.withoutNulls,
                                                                                                            );
                                                                                                          } else {
                                                                                                            context.pushNamed(
                                                                                                              NewStudentWidget.routeName,
                                                                                                              queryParameters: {
                                                                                                                'studentsref': serializeParam(
                                                                                                                  studentsItem.studentId,
                                                                                                                  ParamType.DocumentReference,
                                                                                                                ),
                                                                                                                'schoolref': serializeParam(
                                                                                                                  adminTeacherSchoolRecord.reference,
                                                                                                                  ParamType.DocumentReference,
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
                                                                                                        }
                                                                                                      }
                                                                                                    },
                                                                                                    child: Stack(
                                                                                                      alignment: AlignmentDirectional(0.0, -1.0),
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                          height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                            boxShadow: [
                                                                                                              BoxShadow(
                                                                                                                blurRadius: 2.0,
                                                                                                                color: Color(0xFFE4E5E7),
                                                                                                                offset: Offset(
                                                                                                                  0.0,
                                                                                                                  1.0,
                                                                                                                ),
                                                                                                                spreadRadius: 0.0,
                                                                                                              )
                                                                                                            ],
                                                                                                            borderRadius: BorderRadius.circular(10.0),
                                                                                                            border: Border.all(
                                                                                                              color: Color(0xFFEDF1F3),
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              Container(
                                                                                                                width: MediaQuery.sizeOf(context).width * 0.18,
                                                                                                                height: MediaQuery.sizeOf(context).width * 0.18,
                                                                                                                clipBehavior: Clip.antiAlias,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  shape: BoxShape.circle,
                                                                                                                ),
                                                                                                                child: Image.network(
                                                                                                                  valueOrDefault<String>(
                                                                                                                    studentsItem.studentImage,
                                                                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                                                                  ),
                                                                                                                  fit: BoxFit.cover,
                                                                                                                ),
                                                                                                              ),
                                                                                                              Text(
                                                                                                                studentsItem.studentName,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.nunito(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                      fontSize: 14.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ].divide(SizedBox(height: 10.0)),
                                                                                                          ),
                                                                                                        ),
                                                                                                        if (stackStudentsRecord.isDraft)
                                                                                                          Align(
                                                                                                            alignment: AlignmentDirectional(1.0, -1.1),
                                                                                                            child: FaIcon(
                                                                                                              FontAwesomeIcons.exclamationCircle,
                                                                                                              color: Color(0xFFB03E3E),
                                                                                                              size: 20.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ].addToEnd(SizedBox(height: 40.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ].addToEnd(
                                                    SizedBox(height: 30.0)),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
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
                                    color: Color(0x04B7B7B7),
                                    offset: Offset(
                                      2.0,
                                      -5.0,
                                    ),
                                    spreadRadius: 0.0,
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: wrapWithModel(
                                model: _model.navbarteacherModel,
                                updateCallback: () => safeSetState(() {}),
                                child: NavbarteacherWidget(
                                  pageno: 1,
                                  schoolref: dashboardSchoolRecordList
                                      .where((e) => e.listOfteachersuser
                                          .contains(currentUserReference))
                                      .toList()
                                      .firstOrNull
                                      ?.reference,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                      4) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: StreamBuilder<List<StudentsRecord>>(
                                stream: queryStudentsRecord(
                                  queryBuilder: (studentsRecord) =>
                                      studentsRecord.where(
                                    'Parents_list',
                                    arrayContains: currentUserReference,
                                  ),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      child: MainDashboardShimmerWidget(),
                                    );
                                  }
                                  List<StudentsRecord> bodyStudentsRecordList =
                                      snapshot.data!;

                                  return Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .newBgcolor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 20.0),
                                      child: SingleChildScrollView(
                                        primary: false,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Hello, ${currentUserDisplayName}!',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 24.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 10.0),
                                                child: Text(
                                                  'Here’s an overview of ${valueOrDefault<String>(
                                                    bodyStudentsRecordList
                                                                .length ==
                                                            1
                                                        ? bodyStudentsRecordList
                                                            .firstOrNull
                                                            ?.studentName
                                                        : 'your child',
                                                    'Name',
                                                  )}\'s profile!',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.95,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF0F0F0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Visibility(
                                                  visible:
                                                      bodyStudentsRecordList
                                                              .length !=
                                                          1,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final studentNAV =
                                                            bodyStudentsRecordList
                                                                .sortedList(
                                                                    keyOf: (e) =>
                                                                        e.studentName,
                                                                    desc: false)
                                                                .toList();

                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: List.generate(
                                                                studentNAV
                                                                    .length,
                                                                (studentNAVIndex) {
                                                              final studentNAVItem =
                                                                  studentNAV[
                                                                      studentNAVIndex];
                                                              return Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            2.0,
                                                                            0.0),
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
                                                                    _model.pageno =
                                                                        studentNAVIndex;
                                                                    _model.selectedstudentref =
                                                                        studentNAVItem
                                                                            .reference;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .studentPageviewController
                                                                        ?.animateToPage(
                                                                      studentNAVIndex,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              500),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.44,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.05,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: studentNAVIndex ==
                                                                              _model
                                                                                  .pageno
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .secondary
                                                                          : Color(
                                                                              0xFFF0F0F0),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: studentNAVIndex ==
                                                                                _model.pageno
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : Color(0xFFF0F0F0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Text(
                                                                        studentNAVItem
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
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final studentList =
                                                    bodyStudentsRecordList
                                                        .sortedList(
                                                            keyOf: (e) =>
                                                                e.studentName,
                                                            desc: false)
                                                        .toList();

                                                return Container(
                                                  width: double.infinity,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.8,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 40.0),
                                                    child: PageView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      controller: _model
                                                              .studentPageviewController ??=
                                                          PageController(
                                                              initialPage: max(
                                                                  0,
                                                                  min(
                                                                      0,
                                                                      studentList
                                                                              .length -
                                                                          1))),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          studentList.length,
                                                      itemBuilder: (context,
                                                          studentListIndex) {
                                                        final studentListItem =
                                                            studentList[
                                                                studentListIndex];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      40.0),
                                                          child:
                                                              SingleChildScrollView(
                                                            primary: false,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child: Text(
                                                                      'Upcoming Events',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                StreamBuilder<
                                                                    SchoolRecord>(
                                                                  stream: SchoolRecord
                                                                      .getDocument(
                                                                          studentListItem
                                                                              .schoolref!),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.08,
                                                                        child:
                                                                            EventShimmerWidget(),
                                                                      );
                                                                    }

                                                                    final containerSchoolRecord =
                                                                        snapshot
                                                                            .data!;

                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Builder(
                                                                            builder:
                                                                                (context) {
                                                                              final events = containerSchoolRecord.calendarList.where((e) => !functions.isDatePassed(e.eventDate!)).toList().sortedList(keyOf: (e) => e.eventDate!, desc: false).toList();

                                                                              return SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: List.generate(events.length, (eventsIndex) {
                                                                                    final eventsItem = events[eventsIndex];
                                                                                    return Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                await showModalBottomSheet(
                                                                                                  isScrollControlled: true,
                                                                                                  backgroundColor: Colors.transparent,
                                                                                                  enableDrag: false,
                                                                                                  context: context,
                                                                                                  builder: (context) {
                                                                                                    return GestureDetector(
                                                                                                      onTap: () {
                                                                                                        FocusScope.of(context).unfocus();
                                                                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                                                                      },
                                                                                                      child: Padding(
                                                                                                        padding: MediaQuery.viewInsetsOf(context),
                                                                                                        child: Container(
                                                                                                          height: MediaQuery.sizeOf(context).height * 0.6,
                                                                                                          child: ClassEventViewWidget(
                                                                                                            school: dashboardSchoolRecordList.where((e) => e.listOfStudents.contains(studentListItem.reference)).toList().firstOrNull!.reference,
                                                                                                            eventid: eventsItem.eventId,
                                                                                                            evvent: eventsItem,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ).then((value) => safeSetState(() {}));
                                                                                              },
                                                                                              child: Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  color: () {
                                                                                                    if (eventsItem.eventName == 'Event') {
                                                                                                      return FlutterFlowTheme.of(context).event;
                                                                                                    } else if (eventsItem.eventName == 'Birthday') {
                                                                                                      return FlutterFlowTheme.of(context).birthdayfill;
                                                                                                    } else {
                                                                                                      return FlutterFlowTheme.of(context).holiday;
                                                                                                    }
                                                                                                  }(),
                                                                                                  borderRadius: BorderRadius.circular(3.59),
                                                                                                  border: Border.all(
                                                                                                    color: () {
                                                                                                      if (eventsItem.eventName == 'Event') {
                                                                                                        return FlutterFlowTheme.of(context).eventborder;
                                                                                                      } else if (eventsItem.eventName == 'Birthday') {
                                                                                                        return FlutterFlowTheme.of(context).birthdayborder;
                                                                                                      } else {
                                                                                                        return FlutterFlowTheme.of(context).holidayborder;
                                                                                                      }
                                                                                                    }(),
                                                                                                    width: 1.0,
                                                                                                  ),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsets.all(10.0),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      if (eventsItem.eventName == 'Event')
                                                                                                        Image.asset(
                                                                                                          'assets/images/typcn--flash.jpg',
                                                                                                          width: 15.5,
                                                                                                          height: 15.5,
                                                                                                          fit: BoxFit.contain,
                                                                                                        ),
                                                                                                      if (eventsItem.eventName == 'Holiday')
                                                                                                        Image.asset(
                                                                                                          'assets/images/fxemoji--confetti-removebg-preview.png',
                                                                                                          width: 15.5,
                                                                                                          height: 15.5,
                                                                                                          fit: BoxFit.contain,
                                                                                                        ),
                                                                                                      if (eventsItem.eventName == 'Birthday')
                                                                                                        Image.asset(
                                                                                                          'assets/images/noto--birthday-cake-removebg-preview.png',
                                                                                                          width: 15.5,
                                                                                                          height: 15.5,
                                                                                                          fit: BoxFit.contain,
                                                                                                          alignment: Alignment(0.0, -1.0),
                                                                                                        ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                                        child: Text(
                                                                                                          eventsItem.eventTitle.maybeHandleOverflow(
                                                                                                            maxChars: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 10;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 12;
                                                                                                              } else {
                                                                                                                return 12;
                                                                                                              }
                                                                                                            }(),
                                                                                                            replacement: '…',
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.inter(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                color: () {
                                                                                                                  if (eventsItem.eventName == 'Event') {
                                                                                                                    return Color(0xFFC29800);
                                                                                                                  } else if (eventsItem.eventName == 'Holiday') {
                                                                                                                    return Color(0xFF072F78);
                                                                                                                  } else {
                                                                                                                    return Color(0xFF4E0B6B);
                                                                                                                  }
                                                                                                                }(),
                                                                                                                fontSize: 14.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ].divide(SizedBox(width: 5.0)).around(SizedBox(width: 5.0)),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          functions.formatDate(eventsItem.eventDate!) == functions.formatDate(getCurrentTimestamp) ? 'Today' : dateTimeFormat("MMMd", eventsItem.eventDate!),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.nunito(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: functions.formatDate(eventsItem.eventDate!) == functions.formatDate(getCurrentTimestamp) ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).tertiaryText,
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ].divide(SizedBox(height: 5.0)),
                                                                                    );
                                                                                  }).divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          12.0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .stroke,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          10.0,
                                                                          10.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                studentListItem.schoolName,
                                                                                'school name',
                                                                              ),
                                                                              maxLines: 1,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.nunito(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                10.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                  height: MediaQuery.sizeOf(context).height * 0.12,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(16.0),
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                                                    studentListItem.studentImage,
                                                                                                    'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6',
                                                                                                  ),
                                                                                                  fit: BoxFit.contain,
                                                                                                ),
                                                                                                allowRotation: false,
                                                                                                tag: valueOrDefault<String>(
                                                                                                  studentListItem.studentImage,
                                                                                                  'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6' + '$studentListIndex',
                                                                                                ),
                                                                                                useHeroAnimation: true,
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: Hero(
                                                                                          tag: valueOrDefault<String>(
                                                                                            studentListItem.studentImage,
                                                                                            'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6' + '$studentListIndex',
                                                                                          ),
                                                                                          transitionOnUserGestures: true,
                                                                                          child: Container(
                                                                                            width: 75.0,
                                                                                            height: 75.0,
                                                                                            clipBehavior: Clip.antiAlias,
                                                                                            decoration: BoxDecoration(
                                                                                              shape: BoxShape.circle,
                                                                                            ),
                                                                                            child: Image.network(
                                                                                              valueOrDefault<String>(
                                                                                                studentListItem.studentImage,
                                                                                                'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6',
                                                                                              ),
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Text(
                                                                                                studentListItem.studentName,
                                                                                                textAlign: TextAlign.start,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.nunito(
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                                      fontSize: 20.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Text(
                                                                                                'Dob :  ${dateTimeFormat("dd MMM y", studentListItem.dateOfBirth)}',
                                                                                                textAlign: TextAlign.start,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.nunito(
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                      fontSize: 14.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ].divide(SizedBox(height: 8.0)),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  height: MediaQuery.sizeOf(context).height * 0.12,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        FlutterFlowIconButton(
                                                                                          borderColor: Colors.transparent,
                                                                                          borderRadius: 20.0,
                                                                                          buttonSize: MediaQuery.sizeOf(context).width * 0.09,
                                                                                          fillColor: FlutterFlowTheme.of(context).primary,
                                                                                          icon: Icon(
                                                                                            Icons.call,
                                                                                            color: FlutterFlowTheme.of(context).info,
                                                                                            size: 20.0,
                                                                                          ),
                                                                                          onPressed: () async {
                                                                                            _model.school9 = await SchoolRecord.getDocumentOnce(dashboardSchoolRecordList.where((e) => e.listOfStudents.contains(studentListItem.reference)).toList().firstOrNull!.reference);
                                                                                            await launchUrl(Uri(
                                                                                              scheme: 'tel',
                                                                                              path: _model.school9!.principalDetails.phoneNumber,
                                                                                            ));

                                                                                            safeSetState(() {});
                                                                                          },
                                                                                        ),
                                                                                        Text(
                                                                                          'School',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.nunito(
                                                                                                  fontWeight: FontWeight.normal,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                fontSize: 10.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 10.0)),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (studentListItem
                                                                        .timeline
                                                                        .where((e) =>
                                                                            dateTimeFormat("yMd", e.date) ==
                                                                            dateTimeFormat("yMd",
                                                                                _model.calendarDate))
                                                                        .toList()
                                                                        .length !=
                                                                    0)
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
                                                                      if (studentListItem
                                                                              .timeline
                                                                              .where((e) => functions.formatDate(e.date!) == functions.formatDate(_model.calendarDate!))
                                                                              .toList()
                                                                              .length !=
                                                                          0) {
                                                                        context
                                                                            .pushNamed(
                                                                          TimelinedetailsWidget
                                                                              .routeName,
                                                                          queryParameters:
                                                                              {
                                                                            'studentRef':
                                                                                serializeParam(
                                                                              studentListItem.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                            'schoolref':
                                                                                serializeParam(
                                                                              dashboardSchoolRecordList.where((e) => e.listOfStudents.contains(studentListItem.reference)).toList().firstOrNull?.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                            'date':
                                                                                serializeParam(
                                                                              _model.calendarDate,
                                                                              ParamType.DateTime,
                                                                            ),
                                                                          }.withoutNulls,
                                                                          extra: <String,
                                                                              dynamic>{
                                                                            kTransitionInfoKey:
                                                                                TransitionInfo(
                                                                              hasTransition: true,
                                                                              transitionType: PageTransitionType.fade,
                                                                            ),
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          2.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.9,
                                                                        height:
                                                                            140.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 20.0,
                                                                              color: Color(0x04000000),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              spreadRadius: 0.0,
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children:
                                                                              [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  functions.formatDate(_model.calendarDate!) == functions.formatDate(getCurrentTimestamp) ? 'Today \'s Timeline' : '${dateTimeFormat("dd MMM , y", _model.calendarDate)}\'s Timeline',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        fontSize: 20.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              decoration: BoxDecoration(),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                child: Builder(
                                                                                  builder: (context) {
                                                                                    final timeslines = studentListItem.timeline.where((e) => dateTimeFormat("yMd", e.date) == dateTimeFormat("yMd", _model.calendarDate)).toList().sortedList(keyOf: (e) => dateTimeFormat("yMd", e.date!), desc: false).toList().take(4).toList();
                                                                                    if (timeslines.isEmpty) {
                                                                                      return Center(
                                                                                        child: EmptyWidget(),
                                                                                      );
                                                                                    }

                                                                                    return Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: List.generate(timeslines.length, (timeslinesIndex) {
                                                                                        final timeslinesItem = timeslines[timeslinesIndex];
                                                                                        return Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                                child: ClipRRect(
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                  child: Image.network(
                                                                                                    () {
                                                                                                      if (timeslinesItem.activityId == 0) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Ffork_and_knife_with_plate.png?alt=media&token=d3c0ab7c-f43b-4a3b-b615-02135d701b23';
                                                                                                      } else if (timeslinesItem.activityId == 1) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FBitmap.png?alt=media&token=932b22f6-a33b-4cb2-a8f8-a3d176899f44';
                                                                                                      } else if (timeslinesItem.activityId == 2) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fcamera.png?alt=media&token=4349afe9-7085-47ec-9527-857f6ce94378';
                                                                                                      } else if (timeslinesItem.activityId == 3) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FAppreciation.png?alt=media&token=d7cd93a2-eaed-4068-8271-5c3c69805c34';
                                                                                                      } else if (timeslinesItem.activityId == 4) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fpotty_(2).png?alt=media&token=ebf034f3-760d-405e-b9db-1a8407d2ec02';
                                                                                                      } else if (timeslinesItem.activityId == 0) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Ffork_and_knife_with_plate.png?alt=media&token=d3c0ab7c-f43b-4a3b-b615-02135d701b23';
                                                                                                      } else if (timeslinesItem.activityId == 1) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FBitmap.png?alt=media&token=932b22f6-a33b-4cb2-a8f8-a3d176899f44';
                                                                                                      } else if (timeslinesItem.activityId == 2) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fcamera.png?alt=media&token=4349afe9-7085-47ec-9527-857f6ce94378';
                                                                                                      } else if (timeslinesItem.activityId == 3) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FAppreciation.png?alt=media&token=d7cd93a2-eaed-4068-8271-5c3c69805c34';
                                                                                                      } else if (timeslinesItem.activityId == 4) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fpotty_(2).png?alt=media&token=ebf034f3-760d-405e-b9db-1a8407d2ec02';
                                                                                                      } else if (timeslinesItem.activityId == 0) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Ffork_and_knife_with_plate.png?alt=media&token=d3c0ab7c-f43b-4a3b-b615-02135d701b23';
                                                                                                      } else if (timeslinesItem.activityId == 1) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FBitmap.png?alt=media&token=932b22f6-a33b-4cb2-a8f8-a3d176899f44';
                                                                                                      } else if (timeslinesItem.activityId == 2) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fcamera.png?alt=media&token=4349afe9-7085-47ec-9527-857f6ce94378';
                                                                                                      } else if (timeslinesItem.activityId == 3) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FAppreciation.png?alt=media&token=d7cd93a2-eaed-4068-8271-5c3c69805c34';
                                                                                                      } else if (timeslinesItem.activityId == 4) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fpotty_(2).png?alt=media&token=ebf034f3-760d-405e-b9db-1a8407d2ec02';
                                                                                                      } else if (timeslinesItem.activityId == 0) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Ffork_and_knife_with_plate.png?alt=media&token=d3c0ab7c-f43b-4a3b-b615-02135d701b23';
                                                                                                      } else if (timeslinesItem.activityId == 1) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FBitmap.png?alt=media&token=932b22f6-a33b-4cb2-a8f8-a3d176899f44';
                                                                                                      } else if (timeslinesItem.activityId == 2) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fcamera.png?alt=media&token=4349afe9-7085-47ec-9527-857f6ce94378';
                                                                                                      } else if (timeslinesItem.activityId == 3) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FAppreciation.png?alt=media&token=d7cd93a2-eaed-4068-8271-5c3c69805c34';
                                                                                                      } else if (timeslinesItem.activityId == 4) {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fpotty_(2).png?alt=media&token=ebf034f3-760d-405e-b9db-1a8407d2ec02';
                                                                                                      } else {
                                                                                                        return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FIncident.png?alt=media&token=f2401cf9-a754-4a0c-8f2f-ad0423ebe926';
                                                                                                      }
                                                                                                    }(),
                                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                                    height: MediaQuery.sizeOf(context).height * 0.06,
                                                                                                    fit: BoxFit.contain,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                dateTimeFormat("jm", timeslinesItem.date!),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.nunito(
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                      fontSize: 10.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      }).divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ].addToEnd(SizedBox(height: 10.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final classes =
                                                                        studentListItem
                                                                            .classref
                                                                            .toList();

                                                                    return ListView
                                                                        .builder(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      primary:
                                                                          false,
                                                                      shrinkWrap:
                                                                          true,
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      itemCount:
                                                                          classes
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              classesIndex) {
                                                                        final classesItem =
                                                                            classes[classesIndex];
                                                                        return Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                16.0,
                                                                                5.0,
                                                                                0.0),
                                                                            child:
                                                                                StreamBuilder<SchoolClassRecord>(
                                                                              stream: SchoolClassRecord.getDocument(classesItem),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 50.0,
                                                                                      height: 50.0,
                                                                                      child: CircularProgressIndicator(
                                                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                                                          FlutterFlowTheme.of(context).primary,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }

                                                                                final classesSchoolClassRecord = snapshot.data!;

                                                                                return Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                  height: 160.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                    boxShadow: [
                                                                                      BoxShadow(
                                                                                        blurRadius: 20.0,
                                                                                        color: Color(0x08000000),
                                                                                        offset: Offset(
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        spreadRadius: 0.0,
                                                                                      )
                                                                                    ],
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(10.0),
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                              child: Text(
                                                                                                'Class: ${classesSchoolClassRecord.className}',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.nunito(
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                                      fontSize: 18.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Material(
                                                                                                  color: Colors.transparent,
                                                                                                  elevation: 2.0,
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                  ),
                                                                                                  child: Container(
                                                                                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                    height: MediaQuery.sizeOf(context).height * 0.09,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 4.0,
                                                                                                          color: Color(0x491D61E7),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                    ),
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        context.pushNamed(
                                                                                                          AttendenceParentWidget.routeName,
                                                                                                          queryParameters: {
                                                                                                            'classref': serializeParam(
                                                                                                              classesSchoolClassRecord.reference,
                                                                                                              ParamType.DocumentReference,
                                                                                                            ),
                                                                                                            'studentref': serializeParam(
                                                                                                              studentListItem.reference,
                                                                                                              ParamType.DocumentReference,
                                                                                                            ),
                                                                                                          }.withoutNulls,
                                                                                                          extra: <String, dynamic>{
                                                                                                            kTransitionInfoKey: TransitionInfo(
                                                                                                              hasTransition: true,
                                                                                                              transitionType: PageTransitionType.fade,
                                                                                                            ),
                                                                                                          },
                                                                                                        );
                                                                                                      },
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                        children: [
                                                                                                          StreamBuilder<SchoolClassRecord>(
                                                                                                            stream: SchoolClassRecord.getDocument(classesItem),
                                                                                                            builder: (context, snapshot) {
                                                                                                              // Customize what your widget looks like when it's loading.
                                                                                                              if (!snapshot.hasData) {
                                                                                                                return Center(
                                                                                                                  child: SizedBox(
                                                                                                                    width: 50.0,
                                                                                                                    height: 50.0,
                                                                                                                    child: CircularProgressIndicator(
                                                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                                        FlutterFlowTheme.of(context).primary,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                );
                                                                                                              }

                                                                                                              final textSchoolClassRecord = snapshot.data!;

                                                                                                              return Text(
                                                                                                                '${functions.calculateAttendancePercentageCopy(textSchoolClassRecord.attendance.toList(), studentListItem.reference).toString()} %',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.nunito(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                      fontSize: 24.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              );
                                                                                                            },
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'Check In/Out',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  fontSize: 12.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Material(
                                                                                                  color: Colors.transparent,
                                                                                                  elevation: 2.0,
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                  ),
                                                                                                  child: Container(
                                                                                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                    height: MediaQuery.sizeOf(context).height * 0.09,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 4.0,
                                                                                                          color: Color(0x491D61E7),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                    ),
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        context.pushNamed(
                                                                                                          CalenderParentWidget.routeName,
                                                                                                          queryParameters: {
                                                                                                            'classref': serializeParam(
                                                                                                              classesSchoolClassRecord.reference,
                                                                                                              ParamType.DocumentReference,
                                                                                                            ),
                                                                                                          }.withoutNulls,
                                                                                                        );
                                                                                                      },
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                        children: [
                                                                                                          ClipRRect(
                                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                                            child: Image.asset(
                                                                                                              'assets/images/Saly-42.png',
                                                                                                              width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                                              height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                                              fit: BoxFit.contain,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'Calender',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  fontSize: 12.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Material(
                                                                                                  color: Colors.transparent,
                                                                                                  elevation: 2.0,
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                  ),
                                                                                                  child: Container(
                                                                                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                    height: MediaQuery.sizeOf(context).height * 0.09,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          blurRadius: 4.0,
                                                                                                          color: Color(0x491D61E7),
                                                                                                          offset: Offset(
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                    ),
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        context.pushNamed(
                                                                                                          NotificationParentWidget.routeName,
                                                                                                          queryParameters: {
                                                                                                            'schoolref': serializeParam(
                                                                                                              studentListItem.schoolref,
                                                                                                              ParamType.DocumentReference,
                                                                                                            ),
                                                                                                          }.withoutNulls,
                                                                                                        );
                                                                                                      },
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                        children: [
                                                                                                          ClipRRect(
                                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                                            child: Image.network(
                                                                                                              FFAppConstants.bellIcon,
                                                                                                              width: 30.0,
                                                                                                              height: 30.0,
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'Notification',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.nunito(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  fontSize: 12.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(height: 10.0)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                                if (studentListItem
                                                                        .gallery
                                                                        .length !=
                                                                    0)
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            12.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          2.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  '${studentListItem.studentName}\'s Gallery',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                height: 100.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                ),
                                                                                child: Builder(
                                                                                  builder: (context) {
                                                                                    final gallleryItems = studentListItem.gallery.sortedList(keyOf: (e) => e.date!, desc: false).toList().take(4).toList();

                                                                                    return GridView.builder(
                                                                                      padding: EdgeInsets.zero,
                                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                        crossAxisCount: 4,
                                                                                        crossAxisSpacing: 10.0,
                                                                                        mainAxisSpacing: 10.0,
                                                                                        childAspectRatio: 1.0,
                                                                                      ),
                                                                                      scrollDirection: Axis.vertical,
                                                                                      itemCount: gallleryItems.length,
                                                                                      itemBuilder: (context, gallleryItemsIndex) {
                                                                                        final gallleryItemsItem = gallleryItems[gallleryItemsIndex];
                                                                                        return Builder(
                                                                                          builder: (context) {
                                                                                            if (gallleryItemsItem.images != '') {
                                                                                              return InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  context.pushNamed(
                                                                                                    IndiviImageViewWidget.routeName,
                                                                                                    queryParameters: {
                                                                                                      'student': serializeParam(
                                                                                                        studentListItem.reference,
                                                                                                        ParamType.DocumentReference,
                                                                                                      ),
                                                                                                      'imagepath': serializeParam(
                                                                                                        gallleryItemsItem.images,
                                                                                                        ParamType.String,
                                                                                                      ),
                                                                                                      'gallery': serializeParam(
                                                                                                        gallleryItemsItem,
                                                                                                        ParamType.DataStruct,
                                                                                                      ),
                                                                                                    }.withoutNulls,
                                                                                                  );
                                                                                                },
                                                                                                onLongPress: () async {
                                                                                                  await Navigator.push(
                                                                                                    context,
                                                                                                    PageTransition(
                                                                                                      type: PageTransitionType.fade,
                                                                                                      child: FlutterFlowExpandedImageView(
                                                                                                        image: Image.network(
                                                                                                          gallleryItemsItem.images,
                                                                                                          fit: BoxFit.contain,
                                                                                                        ),
                                                                                                        allowRotation: false,
                                                                                                        tag: gallleryItemsItem.images,
                                                                                                        useHeroAnimation: true,
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                                child: Hero(
                                                                                                  tag: gallleryItemsItem.images,
                                                                                                  transitionOnUserGestures: true,
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    child: Image.network(
                                                                                                      gallleryItemsItem.images,
                                                                                                      width: 65.0,
                                                                                                      height: 71.0,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            } else {
                                                                                              return Stack(
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                children: [
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Builder(
                                                                                                      builder: (context) => InkWell(
                                                                                                        splashColor: Colors.transparent,
                                                                                                        focusColor: Colors.transparent,
                                                                                                        hoverColor: Colors.transparent,
                                                                                                        highlightColor: Colors.transparent,
                                                                                                        onTap: () async {
                                                                                                          await showDialog(
                                                                                                            context: context,
                                                                                                            builder: (dialogContext) {
                                                                                                              return Dialog(
                                                                                                                elevation: 0,
                                                                                                                insetPadding: EdgeInsets.zero,
                                                                                                                backgroundColor: Colors.transparent,
                                                                                                                alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                                child: GestureDetector(
                                                                                                                  onTap: () {
                                                                                                                    FocusScope.of(dialogContext).unfocus();
                                                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                  },
                                                                                                                  child: Container(
                                                                                                                    height: MediaQuery.sizeOf(context).height * 0.8,
                                                                                                                    width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                                                    child: VideoplayerWidget(
                                                                                                                      studentref: studentListItem.reference,
                                                                                                                      gallery: gallleryItemsItem,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          );
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          width: 65.0,
                                                                                                          height: 71.0,
                                                                                                          child: custom_widgets.SquareVideoPlayer(
                                                                                                            width: 65.0,
                                                                                                            height: 71.0,
                                                                                                            videoUrl: gallleryItemsItem.video,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: Icon(
                                                                                                      Icons.play_circle,
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      size: 24.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    context.pushNamed(
                                                                                      StudentGalleryWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'student': serializeParam(
                                                                                          studentListItem.reference,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  },
                                                                                  child: Text(
                                                                                    'View \nAll',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.nunito(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                          fontSize: 16.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 5.0)).around(SizedBox(height: 5.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ].addToEnd(
                                                                  SizedBox(
                                                                      height:
                                                                          40.0)),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ].addToEnd(SizedBox(height: 20.0)),
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
                                    color: Color(0x05B7B7B7),
                                    offset: Offset(
                                      2.0,
                                      -5.0,
                                    ),
                                    spreadRadius: 0.0,
                                  )
                                ],
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: StreamBuilder<List<StudentsRecord>>(
                                  stream: queryStudentsRecord(
                                    queryBuilder: (studentsRecord) =>
                                        studentsRecord.where(
                                      'Parents_list',
                                      arrayContains: currentUserReference,
                                    ),
                                    singleRecord: true,
                                  ),
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
                                    List<StudentsRecord>
                                        navbarParentStudentsRecordList =
                                        snapshot.data!;
                                    final navbarParentStudentsRecord =
                                        navbarParentStudentsRecordList
                                                .isNotEmpty
                                            ? navbarParentStudentsRecordList
                                                .first
                                            : null;

                                    return wrapWithModel(
                                      model: _model.navbarParentModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: NavbarParentWidget(
                                        pageno: 1,
                                        schoolref: navbarParentStudentsRecord!
                                            .schoolref!,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'Your Session has been expired',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 25.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              LoginWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                ),
                              },
                            );
                          },
                          text: 'Log In',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 21.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
