import '/admin_dashboard/select_class_notice/select_class_notice_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/delete_copy_widget.dart';
import '/components/empty_widget.dart';
import '/components/emptystudent_widget.dart';
import '/components/quick_action_for_class_widget.dart';
import '/components/upcomingevent_teacher_widget.dart';
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
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({
    super.key,
    int? tabindex,
  }) : tabindex = tabindex ?? 0;

  final int tabindex;

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
      FFAppState().eventnoticeimage = [];
      FFAppState().update(() {});
      _model.calendarDate = getCurrentTimestamp;
      _model.datetime = getCurrentTimestamp;
      safeSetState(() {});
      FFAppState().profileimagechanged = false;
      FFAppState().schoolimagechanged = false;
      FFAppState().imageurl =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
      FFAppState().schoolimage =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
      safeSetState(() {});
      if (valueOrDefault(currentUserDocument?.userRole, 0) == 2) {
        if (currentUserDocument?.subcriptiondetails == null) {
          context.pushNamed(
            'subscribtioplan',
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
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

          context.goNamed('subscriptionended');
        } else if (valueOrDefault(currentUserDocument?.subscriptionStatus, 0) !=
            2) {
          context.goNamed('amount_not_paidd');
        } else {
          _model.numberofSchool = await querySchoolRecordOnce(
            queryBuilder: (schoolRecord) => schoolRecord.where(
              'principal_details.principal_id',
              isEqualTo: currentUserReference,
            ),
          );
          if (_model.numberofSchool?.length == 1) {
            context.pushNamed(
              'class_dashboard',
              queryParameters: {
                'schoolref': serializeParam(
                  _model.numberofSchool?.firstOrNull?.reference,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );
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
                        getCurrentTimestamp).isNotEmpty) {
              await showAlignedDialog(
                context: context,
                isGlobal: false,
                avoidOverflow: false,
                targetAnchor: const AlignmentDirectional(0.0, -0.8)
                    .resolve(Directionality.of(context)),
                followerAnchor: const AlignmentDirectional(0.0, -0.8)
                    .resolve(Directionality.of(context)),
                builder: (dialogContext) {
                  return Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(dialogContext).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: UpcomingeventTeacherWidget(
                        schoolref: _model.teacherSchool!.reference,
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
                      getCurrentTimestamp).isNotEmpty) {
            await showAlignedDialog(
              context: context,
              isGlobal: false,
              avoidOverflow: false,
              targetAnchor: const AlignmentDirectional(0.0, -0.8)
                  .resolve(Directionality.of(context)),
              followerAnchor: const AlignmentDirectional(0.0, -0.8)
                  .resolve(Directionality.of(context)),
              builder: (dialogContext) {
                return Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(dialogContext).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: UpcomingeventTeacherWidget(
                      schoolref: _model.teacherSchool!.reference,
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
        _model.studentsP = await queryStudentsRecordOnce(
          queryBuilder: (studentsRecord) => studentsRecord.where(
            'Parents_list',
            arrayContains: currentUserReference,
          ),
        );
        FFAppState().loopmin = 0;
        safeSetState(() {});
        while (FFAppState().loopmin <
            valueOrDefault<int>(
              _model.studentsP?.length,
              0,
            )) {
          if (currentUserDocument?.popupdate != null) {
            if (getCurrentTimestamp != currentUserDocument?.popupdate) {
              if (functions
                      .filterEventsAfterTwoDays(
                          _model.teacherSchool!.calendarList.toList(),
                          getCurrentTimestamp).isNotEmpty) {
                await showAlignedDialog(
                  context: context,
                  isGlobal: false,
                  avoidOverflow: false,
                  targetAnchor: const AlignmentDirectional(0.0, -0.8)
                      .resolve(Directionality.of(context)),
                  followerAnchor: const AlignmentDirectional(0.0, -0.8)
                      .resolve(Directionality.of(context)),
                  builder: (dialogContext) {
                    return Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(dialogContext).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: UpcomingeventTeacherWidget(
                          schoolref: _model.studentsP!
                              .elementAtOrNull(FFAppState().loopmin)!
                              .schoolref!,
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
                        getCurrentTimestamp).isNotEmpty) {
              await showAlignedDialog(
                context: context,
                isGlobal: false,
                avoidOverflow: false,
                targetAnchor: const AlignmentDirectional(0.0, -0.8)
                    .resolve(Directionality.of(context)),
                followerAnchor: const AlignmentDirectional(0.0, -0.8)
                    .resolve(Directionality.of(context)),
                builder: (dialogContext) {
                  return Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(dialogContext).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: UpcomingeventTeacherWidget(
                        schoolref: _model.studentsP!
                            .elementAtOrNull(FFAppState().loopmin)!
                            .schoolref!,
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

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _model.studentsP!
                    .elementAtOrNull(FFAppState().loopmin)!
                    .schoolref!
                    .id,
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: const Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
          FFAppState().loopmin = FFAppState().loopmin + 1;
          safeSetState(() {});
        }
      } else {
        return;
      }
    });

    getCurrentUserLocation(defaultLocation: const LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.tabBarController1 = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.tabBarController2 = TabController(
      vsync: this,
      length: 4,
      initialIndex: min(
          valueOrDefault<int>(
            widget.tabindex,
            0,
          ),
          3),
    )..addListener(() => safeSetState(() {}));
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
              body: const MainDashboardShimmerWidget(),
            );
          }
          List<SchoolRecord> dashboardSchoolRecordList = snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).bgColorNewOne,
                floatingActionButton: Visibility(
                  visible: _model.tabBarCurrentIndex2 == 2,
                  child: Align(
                    alignment: const AlignmentDirectional(1.0, 0.7),
                    child: FloatingActionButton(
                      onPressed: () async {
                        context.pushNamed(
                          'add_events_details',
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
                      backgroundColor: const Color(0xFFF2981B),
                      elevation: 8.0,
                      child: Icon(
                        Icons.add_rounded,
                        color: FlutterFlowTheme.of(context).info,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
                appBar:
                    (valueOrDefault(currentUserDocument?.userRole, 0) == 1) ||
                            (valueOrDefault(currentUserDocument?.userRole, 0) ==
                                2) ||
                            (valueOrDefault(currentUserDocument?.userRole, 0) ==
                                3) ||
                            (valueOrDefault(currentUserDocument?.userRole, 0) ==
                                4)
                        ? AppBar(
                            backgroundColor: FlutterFlowTheme.of(context).info,
                            automaticallyImplyLeading: false,
                            title: Image.asset(
                              'assets/images/eebe_(500_x_200_px).png',
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                            actions: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (valueOrDefault(
                                          currentUserDocument?.userRole, 0) ==
                                      1)
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'SearchPage_SA',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                            ),
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.search_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        size: 24.0,
                                      ),
                                    ),
                                  if (valueOrDefault(
                                          currentUserDocument?.userRole, 0) ==
                                      6)
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'Teacher_noticeTeacher',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                            ),
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.event_note_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 5.0, 0.0),
                                    child: InkWell(
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
                                              transitionType:
                                                  PageTransitionType.fade,
                                            ),
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.network(
                                              valueOrDefault<String>(
                                                currentUserPhoto,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                              ),
                                            ).image,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(const SizedBox(width: 10.0)),
                              ),
                            ],
                            centerTitle: true,
                            elevation: 0.0,
                          )
                        : null,
                body: SafeArea(
                  top: true,
                  child: Builder(
                    builder: (context) {
                      if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                          1) {
                        return SizedBox(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Builder(
                                        builder: (context) => Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            'Click on your school to view details! ',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.8,
                                        decoration: const BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 8.0, 0.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: const Alignment(0.0, 0),
                                                child: FlutterFlowButtonTabBar(
                                                  useToggleButtonStyle: true,
                                                  labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                  unselectedLabelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                      const Color(0xFFF0F0F0),
                                                  borderColor:
                                                      const Color(0xFFF0F0F0),
                                                  unselectedBorderColor:
                                                      const Color(0xFFF0F0F0),
                                                  borderWidth: 3.0,
                                                  borderRadius: 12.0,
                                                  elevation: 0.0,
                                                  buttonMargin:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(8.0, 0.0,
                                                              8.0, 0.0),
                                                  padding: const EdgeInsets.all(5.0),
                                                  tabs: const [
                                                    Tab(
                                                      text: 'New Requests',
                                                    ),
                                                    Tab(
                                                      text: 'Existing schools',
                                                    ),
                                                  ],
                                                  controller:
                                                      _model.tabBarController1,
                                                  onTap: (i) async {
                                                    [
                                                      () async {},
                                                      () async {}
                                                    ][i]();
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: TabBarView(
                                                  controller:
                                                      _model.tabBarController1,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  20.0),
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
                                                            return const EmptyWidget();
                                                          }

                                                          return ListView
                                                              .builder(
                                                            padding: const EdgeInsets
                                                                .fromLTRB(
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
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        8.0,
                                                                        10.0,
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
                                                                    context
                                                                        .pushNamed(
                                                                      'NewSchoolDetails_SA',
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
                                                                            const TransitionInfo(
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
                                                                        5.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                4.0,
                                                                            color:
                                                                                Color(0x33000000),
                                                                            offset:
                                                                                Offset(
                                                                              0.0,
                                                                              2.0,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                                                width: MediaQuery.sizeOf(context).width * 0.85,
                                                                                decoration: const BoxDecoration(),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
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
                                                                                              alignment: const AlignmentDirectional(0.0, 0.0),
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
                                                                                                            requestedschoolsItem.schoolDetails.schoolImage,
                                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png',
                                                                                                          ),
                                                                                                          fit: BoxFit.contain,
                                                                                                        ),
                                                                                                        allowRotation: false,
                                                                                                        tag: valueOrDefault<String>(
                                                                                                          requestedschoolsItem.schoolDetails.schoolImage,
                                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png' '$requestedschoolsIndex',
                                                                                                        ),
                                                                                                        useHeroAnimation: true,
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                                child: Hero(
                                                                                                  tag: valueOrDefault<String>(
                                                                                                    requestedschoolsItem.schoolDetails.schoolImage,
                                                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png' '$requestedschoolsIndex',
                                                                                                  ),
                                                                                                  transitionOnUserGestures: true,
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(30.0),
                                                                                                    child: Image.network(
                                                                                                      valueOrDefault<String>(
                                                                                                        requestedschoolsItem.schoolDetails.schoolImage,
                                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png',
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
                                                                                        decoration: const BoxDecoration(),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 5.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    requestedschoolsItem.schoolDetails.schoolName,
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Nunito',
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          fontSize: 18.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Text(
                                                                                                  requestedschoolsItem.schoolDetails.city,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Nunito',
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        fontSize: 18.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                '${requestedschoolsItem.schoolDetails.noOfFaculties.toString()} employee',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                requestedschoolsItem.principalDetails.phoneNumber,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ].divide(const SizedBox(height: 4.0)),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(0.0, -1.0),
                                                                                        child: Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.06,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            boxShadow: const [
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
                                                                                              color: const Color(0x1D61E71F),
                                                                                              width: 1.0,
                                                                                            ),
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                valueOrDefault<String>(
                                                                                                  dashboardSchoolRecordList.where((e) => e.principalDetails.principalId == requestedschoolsItem.principalDetails.principalId).toList().length.toString(),
                                                                                                  '02',
                                                                                                ),
                                                                                                textAlign: TextAlign.center,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      fontSize: 20.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                'Branches',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      fontSize: 9.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              if (valueOrDefault(currentUserDocument?.userRole, 0) == 10)
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 8.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      FFButtonWidget(
                                                                                        onPressed: () async {
                                                                                          context.goNamed(
                                                                                            'SchoolRejected',
                                                                                            extra: <String, dynamic>{
                                                                                              kTransitionInfoKey: const TransitionInfo(
                                                                                                hasTransition: true,
                                                                                                transitionType: PageTransitionType.fade,
                                                                                              ),
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                        text: 'Reject',
                                                                                        options: FFButtonOptions(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.35,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.043,
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            shadows: [
                                                                                              const Shadow(
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
                                                                                            'subscription',
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
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            shadows: [
                                                                                              const Shadow(
                                                                                                color: Color(0x7E253EA7),
                                                                                                offset: Offset(0.0, 1.0),
                                                                                                blurRadius: 2.0,
                                                                                              ),
                                                                                              const Shadow(
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
                                                                                    ].divide(const SizedBox(width: 15.0)).around(const SizedBox(width: 15.0)),
                                                                                  ),
                                                                                ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Builder(
                                                                                    builder: (context) => Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                      child: FFButtonWidget(
                                                                                        onPressed: () async {
                                                                                          await showDialog(
                                                                                            context: context,
                                                                                            builder: (dialogContext) {
                                                                                              return Dialog(
                                                                                                elevation: 0,
                                                                                                insetPadding: EdgeInsets.zero,
                                                                                                backgroundColor: Colors.transparent,
                                                                                                alignment: const AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                child: GestureDetector(
                                                                                                  onTap: () {
                                                                                                    FocusScope.of(dialogContext).unfocus();
                                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                                  },
                                                                                                  child: SizedBox(
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
                                                                                          width: MediaQuery.sizeOf(context).width * 0.38,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            shadows: [
                                                                                              const Shadow(
                                                                                                color: Color(0x99F4F5FA),
                                                                                                offset: Offset(0.0, -3.0),
                                                                                                blurRadius: 6.0,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          elevation: 0.0,
                                                                                          borderSide: const BorderSide(
                                                                                            color: Color(0xFFEFF0F6),
                                                                                            width: 1.0,
                                                                                          ),
                                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 5.0),
                                                                                    child: FFButtonWidget(
                                                                                      onPressed: () async {
                                                                                        context.pushNamed(
                                                                                          'subscription',
                                                                                          queryParameters: {
                                                                                            'schoolRef': serializeParam(
                                                                                              requestedschoolsItem.reference,
                                                                                              ParamType.DocumentReference,
                                                                                            ),
                                                                                          }.withoutNulls,
                                                                                        );
                                                                                      },
                                                                                      text: 'Select Plan ',
                                                                                      options: FFButtonOptions(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.38,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          shadows: [
                                                                                            const Shadow(
                                                                                              color: Color(0x7E253EA7),
                                                                                              offset: Offset(0.0, 1.0),
                                                                                              blurRadius: 2.0,
                                                                                            ),
                                                                                            const Shadow(
                                                                                              color: Color(0xFF375DFB),
                                                                                              offset: Offset(0.0, 0.0),
                                                                                              blurRadius: 0.0,
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                        elevation: 3.0,
                                                                                        borderRadius: BorderRadius.circular(10.0),
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final existingschools =
                                                              dashboardSchoolRecordList
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
                                                            return const EmptyWidget();
                                                          }

                                                          return ListView
                                                              .builder(
                                                            padding: const EdgeInsets
                                                                .fromLTRB(
                                                              0,
                                                              0,
                                                              0,
                                                              20.0,
                                                            ),
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
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        8.0,
                                                                        10.0,
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
                                                                    context
                                                                        .pushNamed(
                                                                      'ExistingSchoolDetails_SA',
                                                                      queryParameters:
                                                                          {
                                                                        'schoolrefMain':
                                                                            serializeParam(
                                                                          existingschoolsItem
                                                                              .reference,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <String,
                                                                          dynamic>{
                                                                        kTransitionInfoKey:
                                                                            const TransitionInfo(
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
                                                                        5.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                4.0,
                                                                            color:
                                                                                Color(0x33000000),
                                                                            offset:
                                                                                Offset(
                                                                              0.0,
                                                                              2.0,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                                                width: MediaQuery.sizeOf(context).width * 0.85,
                                                                                decoration: const BoxDecoration(),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
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
                                                                                              alignment: const AlignmentDirectional(0.0, 0.0),
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
                                                                                                            existingschoolsItem.schoolDetails.schoolImage,
                                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png',
                                                                                                          ),
                                                                                                          fit: BoxFit.contain,
                                                                                                        ),
                                                                                                        allowRotation: false,
                                                                                                        tag: valueOrDefault<String>(
                                                                                                          existingschoolsItem.schoolDetails.schoolImage,
                                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png' '$existingschoolsIndex',
                                                                                                        ),
                                                                                                        useHeroAnimation: true,
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                                child: Hero(
                                                                                                  tag: valueOrDefault<String>(
                                                                                                    existingschoolsItem.schoolDetails.schoolImage,
                                                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png' '$existingschoolsIndex',
                                                                                                  ),
                                                                                                  transitionOnUserGestures: true,
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(30.0),
                                                                                                    child: Image.network(
                                                                                                      valueOrDefault<String>(
                                                                                                        existingschoolsItem.schoolDetails.schoolImage,
                                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png',
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
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        decoration: const BoxDecoration(),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 5.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    existingschoolsItem.schoolDetails.schoolName,
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Nunito',
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          fontSize: 18.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.bold,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Text(
                                                                                                  existingschoolsItem.schoolDetails.city,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Nunito',
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        fontSize: 18.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                '${existingschoolsItem.schoolDetails.noOfFaculties.toString()} employee',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                '${existingschoolsItem.listOfStudents.length.toString()} - students',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                existingschoolsItem.principalDetails.phoneNumber,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ].divide(const SizedBox(height: 4.0)),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(0.0, -1.0),
                                                                                        child: Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.06,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            boxShadow: const [
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
                                                                                              color: const Color(0x1D61E71F),
                                                                                              width: 1.0,
                                                                                            ),
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                valueOrDefault<String>(
                                                                                                  dashboardSchoolRecordList.where((e) => e.principalDetails.principalId == existingschoolsItem.principalDetails.principalId).toList().length.toString(),
                                                                                                  '02',
                                                                                                ),
                                                                                                textAlign: TextAlign.center,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      fontSize: 20.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                              Text(
                                                                                                'Branches',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      fontSize: 9.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(const SizedBox(width: 6.0)),
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
                                                    ),
                                                  ],
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
                              Align(
                                alignment: const AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
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
                                    model: _model.navBarSAModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: const NavBarSAWidget(
                                      pageno: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (valueOrDefault(
                              currentUserDocument?.userRole, 0) ==
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: SingleChildScrollView(
                                    primary: false,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 10.0, 5.0, 10.0),
                                          child: Text(
                                            '* To manage any schools, please contact the Superadmin.',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 5.0, 10.0),
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (getCurrentTimestamp >
                                                        currentUserDocument!
                                                            .subcriptiondetails
                                                            .endDate!)
                                                      Container(
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.04,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              const Color(0xFFF4CCCC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
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
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'Subscription expired',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    5.0,
                                                                    0.0,
                                                                    5.0),
                                                        child: Text(
                                                          'Subscription',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  2.0,
                                                                  5.0,
                                                                  5.0),
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
                                                            valueOrDefault<
                                                                String>(
                                                              currentUserDocument
                                                                  ?.subcriptiondetails
                                                                  .subName,
                                                              'sub name',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          if (currentUserDocument!
                                                                  .subcriptiondetails
                                                                  .subAmount >
                                                              0.0)
                                                            Text(
                                                              '${currentUserDocument?.subcriptiondetails.subAmount.toString()}/${currentUserDocument?.subcriptiondetails.frequency}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
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
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    5.0,
                                                                    5.0),
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
                                                                    fontFamily:
                                                                        'Nunito',
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
                                                                    fontFamily:
                                                                        'Nunito',
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
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  5.0,
                                                                  5.0),
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
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                          Text(
                                                            dateTimeFormat(
                                                                "dd MMM , y",
                                                                currentUserDocument!
                                                                    .subcriptiondetails
                                                                    .startDate!),
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
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
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
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                          Text(
                                                            dateTimeFormat(
                                                                "dd MMM , y",
                                                                currentUserDocument!
                                                                    .subcriptiondetails
                                                                    .endDate!),
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
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].addToEnd(
                                                      const SizedBox(height: 10.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (valueOrDefault(
                                                    currentUserDocument
                                                        ?.userRole,
                                                    0) !=
                                                1)
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 5.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    context.pushNamed(
                                                      'addnoticeAllSchools',
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            const TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .fade,
                                                        ),
                                                      },
                                                    );
                                                  },
                                                  text: 'Add Notice',
                                                  options: FFButtonOptions(
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.05,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    elevation: 0.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            'Hello, $currentUserDisplayName',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            'Click on your school to get started!',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final schooldetails =
                                                dashboardSchoolRecordList
                                                    .sortedList(
                                                        keyOf: (e) =>
                                                            e.createdAt!,
                                                        desc: false)
                                                    .where((e) =>
                                                        e.principalDetails
                                                            .principalId ==
                                                        currentUserReference)
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
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 10.0),
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
                                                        if (Navigator.of(
                                                                context)
                                                            .canPop()) {
                                                          context.pop();
                                                        }
                                                        context.pushNamed(
                                                          'class_dashboard',
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
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'School details',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Nunito',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          10.0,
                                                                          0.0,
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
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              60.0,
                                                                          height:
                                                                              60.0,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onLongPress:
                                                                                () async {
                                                                              await Navigator.push(
                                                                                context,
                                                                                PageTransition(
                                                                                  type: PageTransitionType.fade,
                                                                                  child: FlutterFlowExpandedImageView(
                                                                                    image: Image.network(
                                                                                      valueOrDefault<String>(
                                                                                        schooldetailsItem.schoolDetails.schoolImage,
                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                      ),
                                                                                      fit: BoxFit.contain,
                                                                                    ),
                                                                                    allowRotation: false,
                                                                                    tag: valueOrDefault<String>(
                                                                                      schooldetailsItem.schoolDetails.schoolImage,
                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' '$schooldetailsIndex',
                                                                                    ),
                                                                                    useHeroAnimation: true,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Hero(
                                                                              tag: valueOrDefault<String>(
                                                                                schooldetailsItem.schoolDetails.schoolImage,
                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' '$schooldetailsIndex',
                                                                              ),
                                                                              transitionOnUserGestures: true,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(30.0),
                                                                                child: Image.network(
                                                                                  valueOrDefault<String>(
                                                                                    schooldetailsItem.schoolDetails.schoolImage,
                                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                  ),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                                              alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                decoration: const BoxDecoration(),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                  child: Text(
                                                                                    schooldetailsItem.schoolDetails.schoolName,
                                                                                    maxLines: 2,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          fontSize: 16.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                              child: Text(
                                                                                'Address -',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Nunito',
                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                decoration: const BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Text(
                                                                                    '${schooldetailsItem.schoolDetails.address} ${schooldetailsItem.schoolDetails.city} ${schooldetailsItem.schoolDetails.pincode} ${schooldetailsItem.schoolDetails.state}',
                                                                                    maxLines: 5,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    'No. of students -',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                    child: Text(
                                                                                      schooldetailsItem.listOfStudents.length.toString(),
                                                                                      maxLines: 5,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(const SizedBox(width: 5.0)),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    'No of employee - ',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                    child: Text(
                                                                                      schooldetailsItem.schoolDetails.noOfFaculties.toString(),
                                                                                      maxLines: 5,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(const SizedBox(width: 5.0)),
                                                                              ),
                                                                            ),
                                                                          ].divide(const SizedBox(height: 4.0)).around(const SizedBox(height: 4.0)),
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (valueOrDefault(
                              currentUserDocument?.userRole, 0) ==
                          3) {
                        return SizedBox(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: Stack(
                            children: [
                              StreamBuilder<List<SchoolRecord>>(
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
                                            FlutterFlowTheme.of(context)
                                                .primary,
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 20.0),
                                        child:
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
                                            List<TeachersRecord>
                                                bodyTeachersRecordList =
                                                snapshot.data!;
                                            final bodyTeachersRecord =
                                                bodyTeachersRecordList
                                                        .isNotEmpty
                                                    ? bodyTeachersRecordList
                                                        .first
                                                    : null;

                                            return Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              decoration: const BoxDecoration(),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 20.0),
                                                child: SingleChildScrollView(
                                                  primary: false,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    10.0,
                                                                    10.0,
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.15,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.15,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  adminTeacherSchoolRecord
                                                                      ?.schoolDetails
                                                                      .schoolImage,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      adminTeacherSchoolRecord
                                                                          ?.schoolDetails
                                                                          .schoolName,
                                                                      'school name',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          fontSize:
                                                                              20.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Container(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.8,
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        10.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: StreamBuilder<
                                                                List<
                                                                    SchoolClassRecord>>(
                                                              stream:
                                                                  querySchoolClassRecord(
                                                                queryBuilder:
                                                                    (schoolClassRecord) =>
                                                                        schoolClassRecord
                                                                            .where(
                                                                  'teachers_list',
                                                                  arrayContains:
                                                                      bodyTeachersRecord
                                                                          ?.reference,
                                                                ),
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return SizedBox(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.78,
                                                                    child:
                                                                        const ClassshimmerWidget(),
                                                                  );
                                                                }
                                                                List<SchoolClassRecord>
                                                                    tabBarSchoolClassRecordList =
                                                                    snapshot
                                                                        .data!;

                                                                return Column(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          const Alignment(
                                                                              0.0,
                                                                              0),
                                                                      child:
                                                                          FlutterFlowButtonTabBar(
                                                                        useToggleButtonStyle:
                                                                            true,
                                                                        labelStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                        unselectedLabelStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                        labelColor:
                                                                            FlutterFlowTheme.of(context).text1,
                                                                        unselectedLabelColor:
                                                                            FlutterFlowTheme.of(context).text1,
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).secondaryBackground,
                                                                        unselectedBackgroundColor:
                                                                            const Color(0xFFF0F0F0),
                                                                        unselectedBorderColor:
                                                                            const Color(0xFFDDD4D4),
                                                                        borderWidth:
                                                                            0.5,
                                                                        borderRadius:
                                                                            10.0,
                                                                        elevation:
                                                                            0.0,
                                                                        buttonMargin: const EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                        tabs: const [
                                                                          Tab(
                                                                            text:
                                                                                'Classes',
                                                                          ),
                                                                          Tab(
                                                                            text:
                                                                                'Notice',
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
                                                                        controller:
                                                                            _model.tabBarController2,
                                                                        onTap:
                                                                            (i) async {
                                                                          [
                                                                            () async {},
                                                                            () async {
                                                                              safeSetState(() {
                                                                                _model.eventnameTextController?.clear();
                                                                                _model.descriptionTextController?.clear();
                                                                              });
                                                                              _model.eventname = null;
                                                                              safeSetState(() {});
                                                                              FFAppState().eventnoticeimage = [];
                                                                              safeSetState(() {});
                                                                            },
                                                                            () async {},
                                                                            () async {}
                                                                          ][i]();
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          TabBarView(
                                                                        controller:
                                                                            _model.tabBarController2,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                20.0),
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              primary: false,
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 10.0),
                                                                                          child: Text(
                                                                                            'Hello, $currentUserDisplayName',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  fontSize: 20.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      if ((dateTimeFormat("yMMMd", currentUserDocument?.checkin) == dateTimeFormat("yMMMd", getCurrentTimestamp)) && (bodyTeachersRecord?.teacherAttendance.where((e) => dateTimeFormat("yMd", e.date) == dateTimeFormat("yMd", getCurrentTimestamp)).toList().isEmpty))
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(10.0),
                                                                                          child: FFButtonWidget(
                                                                                            onPressed: (functions.isWithin300kMeters(adminTeacherSchoolRecord!.latlng!, currentUserLocationValue!) == false)
                                                                                                ? null
                                                                                                : () async {
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
                                                                                                        duration: const Duration(milliseconds: 4000),
                                                                                                        backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                      ),
                                                                                                    );
                                                                                                    triggerPushNotification(
                                                                                                      notificationTitle: 'Check out',
                                                                                                      notificationText: '$currentUserDisplayName  has checked-out',
                                                                                                      userRefs: [
                                                                                                        adminTeacherSchoolRecord.principalDetails.principalId!
                                                                                                      ],
                                                                                                      initialPageName: 'class_dashboard',
                                                                                                      parameterData: {
                                                                                                        'schoolref': adminTeacherSchoolRecord.reference,
                                                                                                      },
                                                                                                    );

                                                                                                    var notificationsRecordReference = NotificationsRecord.collection.doc();
                                                                                                    await notificationsRecordReference.set({
                                                                                                      ...createNotificationsRecordData(
                                                                                                        content: '$currentUserDisplayName has checked out',
                                                                                                        createDate: getCurrentTimestamp,
                                                                                                        notification: updateNotificationStruct(
                                                                                                          NotificationStruct(
                                                                                                            notificationTitle: 'Check out',
                                                                                                            descriptions: '$currentUserDisplayName has checked out',
                                                                                                            timeStamp: getCurrentTimestamp,
                                                                                                            isRead: false,
                                                                                                          ),
                                                                                                          clearUnsetFields: false,
                                                                                                          create: true,
                                                                                                        ),
                                                                                                        isread: false,
                                                                                                        addedby: currentUserReference,
                                                                                                        heading: 'Check out',
                                                                                                      ),
                                                                                                      ...mapToFirestore(
                                                                                                        {
                                                                                                          'schoolref': [
                                                                                                            adminTeacherSchoolRecord.reference
                                                                                                          ],
                                                                                                          'towhome': tabBarSchoolClassRecordList.map((e) => e.className).toList(),
                                                                                                        },
                                                                                                      ),
                                                                                                    });
                                                                                                    _model.dfff = NotificationsRecord.getDocumentFromData({
                                                                                                      ...createNotificationsRecordData(
                                                                                                        content: '$currentUserDisplayName has checked out',
                                                                                                        createDate: getCurrentTimestamp,
                                                                                                        notification: updateNotificationStruct(
                                                                                                          NotificationStruct(
                                                                                                            notificationTitle: 'Check out',
                                                                                                            descriptions: '$currentUserDisplayName has checked out',
                                                                                                            timeStamp: getCurrentTimestamp,
                                                                                                            isRead: false,
                                                                                                          ),
                                                                                                          clearUnsetFields: false,
                                                                                                          create: true,
                                                                                                        ),
                                                                                                        isread: false,
                                                                                                        addedby: currentUserReference,
                                                                                                        heading: 'Check out',
                                                                                                      ),
                                                                                                      ...mapToFirestore(
                                                                                                        {
                                                                                                          'schoolref': [
                                                                                                            adminTeacherSchoolRecord.reference
                                                                                                          ],
                                                                                                          'towhome': tabBarSchoolClassRecordList.map((e) => e.className).toList(),
                                                                                                        },
                                                                                                      ),
                                                                                                    }, notificationsRecordReference);

                                                                                                    safeSetState(() {});
                                                                                                  },
                                                                                            text: 'Check Out',
                                                                                            icon: Icon(
                                                                                              Icons.logout,
                                                                                              color: FlutterFlowTheme.of(context).text1,
                                                                                              size: 15.0,
                                                                                            ),
                                                                                            options: FFButtonOptions(
                                                                                              width: MediaQuery.sizeOf(context).width * 0.35,
                                                                                              height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                    fontFamily: 'Nunito',
                                                                                                    color: FlutterFlowTheme.of(context).text1,
                                                                                                    fontSize: 16.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                              elevation: 2.0,
                                                                                              borderSide: BorderSide(
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                              ),
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                              disabledColor: FlutterFlowTheme.of(context).dIsable,
                                                                                              disabledTextColor: FlutterFlowTheme.of(context).text,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                  if (functions.isWithin300kMeters(adminTeacherSchoolRecord!.latlng!, currentUserLocationValue!) == false)
                                                                                    Align(
                                                                                      alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 10.0),
                                                                                        child: Text(
                                                                                          'You are not within the school\'s location. Check-in/Check-out is disabled.',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Nunito',
                                                                                                fontSize: 14.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  if (dateTimeFormat("yMMMd", currentUserDocument?.checkin) != dateTimeFormat("yMMMd", getCurrentTimestamp))
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(10.0),
                                                                                      child: FFButtonWidget(
                                                                                        onPressed: (functions.isWithin300kMeters(adminTeacherSchoolRecord.latlng!, currentUserLocationValue!) == false)
                                                                                            ? null
                                                                                            : () async {
                                                                                                if (currentUserDocument?.checkin != null) {
                                                                                                  if (bodyTeachersRecord?.teacherAttendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", currentUserDocument?.checkin)).toList().isEmpty) {
                                                                                                    await bodyTeachersRecord!.reference.update({
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
                                                                                                    await currentUserReference!.update(createUsersRecordData(
                                                                                                      checkin: getCurrentTimestamp,
                                                                                                    ));

                                                                                                    await bodyTeachersRecord!.reference.update(createTeachersRecordData(
                                                                                                      checkin: getCurrentTimestamp,
                                                                                                    ));
                                                                                                  }

                                                                                                  safeSetState(() {});
                                                                                                } else {
                                                                                                  await currentUserReference!.update(createUsersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ));

                                                                                                  await bodyTeachersRecord!.reference.update(createTeachersRecordData(
                                                                                                    checkin: getCurrentTimestamp,
                                                                                                  ));

                                                                                                  safeSetState(() {});
                                                                                                }

                                                                                                triggerPushNotification(
                                                                                                  notificationTitle: 'Check In',
                                                                                                  notificationText: '$currentUserDisplayName  has checked In ',
                                                                                                  userRefs: [
                                                                                                    adminTeacherSchoolRecord.principalDetails.principalId!
                                                                                                  ],
                                                                                                  initialPageName: 'class_dashboard',
                                                                                                  parameterData: {
                                                                                                    'schoolref': adminTeacherSchoolRecord.reference,
                                                                                                  },
                                                                                                );

                                                                                                var notificationsRecordReference = NotificationsRecord.collection.doc();
                                                                                                await notificationsRecordReference.set({
                                                                                                  ...createNotificationsRecordData(
                                                                                                    content: '$currentUserDisplayName has checked in',
                                                                                                    notification: updateNotificationStruct(
                                                                                                      NotificationStruct(
                                                                                                        notificationTitle: 'Check In',
                                                                                                        descriptions: '$currentUserDisplayName has checked In',
                                                                                                        timeStamp: getCurrentTimestamp,
                                                                                                        isRead: false,
                                                                                                      ),
                                                                                                      clearUnsetFields: false,
                                                                                                      create: true,
                                                                                                    ),
                                                                                                    createDate: getCurrentTimestamp,
                                                                                                    isread: false,
                                                                                                    addedby: currentUserReference,
                                                                                                    heading: 'Check in',
                                                                                                  ),
                                                                                                  ...mapToFirestore(
                                                                                                    {
                                                                                                      'schoolref': [
                                                                                                        adminTeacherSchoolRecord.reference
                                                                                                      ],
                                                                                                      'towhome': tabBarSchoolClassRecordList.map((e) => e.className).toList(),
                                                                                                    },
                                                                                                  ),
                                                                                                });
                                                                                                _model.sc = NotificationsRecord.getDocumentFromData({
                                                                                                  ...createNotificationsRecordData(
                                                                                                    content: '$currentUserDisplayName has checked in',
                                                                                                    notification: updateNotificationStruct(
                                                                                                      NotificationStruct(
                                                                                                        notificationTitle: 'Check In',
                                                                                                        descriptions: '$currentUserDisplayName has checked In',
                                                                                                        timeStamp: getCurrentTimestamp,
                                                                                                        isRead: false,
                                                                                                      ),
                                                                                                      clearUnsetFields: false,
                                                                                                      create: true,
                                                                                                    ),
                                                                                                    createDate: getCurrentTimestamp,
                                                                                                    isread: false,
                                                                                                    addedby: currentUserReference,
                                                                                                    heading: 'Check in',
                                                                                                  ),
                                                                                                  ...mapToFirestore(
                                                                                                    {
                                                                                                      'schoolref': [
                                                                                                        adminTeacherSchoolRecord.reference
                                                                                                      ],
                                                                                                      'towhome': tabBarSchoolClassRecordList.map((e) => e.className).toList(),
                                                                                                    },
                                                                                                  ),
                                                                                                }, notificationsRecordReference);
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  SnackBar(
                                                                                                    content: Text(
                                                                                                      'Checked In',
                                                                                                      style: TextStyle(
                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                      ),
                                                                                                    ),
                                                                                                    duration: const Duration(milliseconds: 4000),
                                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                  ),
                                                                                                );

                                                                                                safeSetState(() {});
                                                                                              },
                                                                                        text: 'Check In',
                                                                                        options: FFButtonOptions(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.05,
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                fontFamily: 'Nunito',
                                                                                                color: Colors.white,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                          elevation: 2.0,
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          disabledColor: FlutterFlowTheme.of(context).dIsable,
                                                                                          disabledTextColor: FlutterFlowTheme.of(context).text,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                                                                    child: Container(
                                                                                      decoration: const BoxDecoration(),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                                                                        child: Builder(
                                                                                          builder: (context) {
                                                                                            final tabBarVar = tabBarSchoolClassRecordList.toList();

                                                                                            return ListView.builder(
                                                                                              padding: const EdgeInsets.fromLTRB(
                                                                                                0,
                                                                                                0,
                                                                                                0,
                                                                                                30.0,
                                                                                              ),
                                                                                              primary: false,
                                                                                              shrinkWrap: true,
                                                                                              scrollDirection: Axis.vertical,
                                                                                              itemCount: tabBarVar.length,
                                                                                              itemBuilder: (context, tabBarVarIndex) {
                                                                                                final tabBarVarItem = tabBarVar[tabBarVarIndex];
                                                                                                return Padding(
                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
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
                                                                                                            duration: const Duration(milliseconds: 4000),
                                                                                                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                          ),
                                                                                                        );
                                                                                                      } else {
                                                                                                        if (Navigator.of(context).canPop()) {
                                                                                                          context.pop();
                                                                                                        }
                                                                                                        context.pushNamed(
                                                                                                          'Class_view',
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
                                                                                                      elevation: 5.0,
                                                                                                      shape: RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(16.0),
                                                                                                      ),
                                                                                                      child: Container(
                                                                                                        width: MediaQuery.sizeOf(context).width * 0.75,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                          borderRadius: BorderRadius.circular(16.0),
                                                                                                        ),
                                                                                                        child: Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Align(
                                                                                                              alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                                children: [
                                                                                                                  Align(
                                                                                                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                                                    child: Container(
                                                                                                                      height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                                                      decoration: const BoxDecoration(),
                                                                                                                      child: Padding(
                                                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 5.0),
                                                                                                                        child: Column(
                                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                          children: [
                                                                                                                            Text(
                                                                                                                              'Class: ${tabBarVarItem.className}',
                                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                    fontFamily: 'Nunito',
                                                                                                                                    color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                                                    fontSize: 16.0,
                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                                  ),
                                                                                                                            ),
                                                                                                                            Text(
                                                                                                                              'Students: ${tabBarVarItem.studentsList.length.toString()}',
                                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                    fontFamily: 'Nunito',
                                                                                                                                    color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                                                    fontSize: 16.0,
                                                                                                                                    letterSpacing: 0.0,
                                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                                  ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Padding(
                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                                                    child: FlutterFlowIconButton(
                                                                                                                      borderColor: Colors.transparent,
                                                                                                                      borderRadius: 30.0,
                                                                                                                      buttonSize: 40.0,
                                                                                                                      fillColor: const Color(0xFFF2981B),
                                                                                                                      icon: Icon(
                                                                                                                        Icons.bolt,
                                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                                        size: 24.0,
                                                                                                                      ),
                                                                                                                      onPressed: () async {
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
                                                                                                                                child: QuickActionForClassWidget(
                                                                                                                                  schoolref: adminTeacherSchoolRecord.reference,
                                                                                                                                  classref: tabBarVarItem.reference,
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          },
                                                                                                                        ).then((value) => safeSetState(() {}));
                                                                                                                      },
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                children: [
                                                                                                                  Align(
                                                                                                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Material(
                                                                                                                      color: Colors.transparent,
                                                                                                                      elevation: 2.0,
                                                                                                                      shape: RoundedRectangleBorder(
                                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                                      ),
                                                                                                                      child: Container(
                                                                                                                        height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                                                          boxShadow: const [
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
                                                                                                                        child: Padding(
                                                                                                                          padding: const EdgeInsets.all(5.0),
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
                                                                                                                                    duration: const Duration(milliseconds: 4000),
                                                                                                                                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                                  ),
                                                                                                                                );
                                                                                                                              } else {
                                                                                                                                context.pushNamed(
                                                                                                                                  'calender_class',
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
                                                                                                                                    kTransitionInfoKey: const TransitionInfo(
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
                                                                                                                                    height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                                                                    fit: BoxFit.contain,
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                                Align(
                                                                                                                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                                                  child: Text(
                                                                                                                                    'Class calendar',
                                                                                                                                    textAlign: TextAlign.center,
                                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                          fontFamily: 'Nunito',
                                                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                          fontSize: 14.0,
                                                                                                                                          letterSpacing: 0.0,
                                                                                                                                          fontWeight: FontWeight.normal,
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
                                                                                                                  Material(
                                                                                                                    color: Colors.transparent,
                                                                                                                    elevation: 2.0,
                                                                                                                    shape: RoundedRectangleBorder(
                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                    ),
                                                                                                                    child: Container(
                                                                                                                      height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                                        boxShadow: const [
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
                                                                                                                      child: Padding(
                                                                                                                        padding: const EdgeInsets.all(5.0),
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
                                                                                                                                  duration: const Duration(milliseconds: 4000),
                                                                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                                ),
                                                                                                                              );
                                                                                                                            } else {
                                                                                                                              context.goNamed(
                                                                                                                                'ClassNotice_Admin_Teacher',
                                                                                                                                queryParameters: {
                                                                                                                                  'classref': serializeParam(
                                                                                                                                    tabBarVarItem.reference,
                                                                                                                                    ParamType.DocumentReference,
                                                                                                                                  ),
                                                                                                                                  'schoolref': serializeParam(
                                                                                                                                    adminTeacherSchoolRecord.reference,
                                                                                                                                    ParamType.DocumentReference,
                                                                                                                                  ),
                                                                                                                                  'date': serializeParam(
                                                                                                                                    getCurrentTimestamp,
                                                                                                                                    ParamType.DateTime,
                                                                                                                                  ),
                                                                                                                                }.withoutNulls,
                                                                                                                                extra: <String, dynamic>{
                                                                                                                                  kTransitionInfoKey: const TransitionInfo(
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
                                                                                                                                  height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                                                                  fit: BoxFit.contain,
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Align(
                                                                                                                                alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                                                child: Text(
                                                                                                                                  'Add Notice',
                                                                                                                                  textAlign: TextAlign.center,
                                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                        fontFamily: 'Nunito',
                                                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                        fontSize: 14.0,
                                                                                                                                        letterSpacing: 0.0,
                                                                                                                                        fontWeight: FontWeight.normal,
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
                                                                                                                      height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                                        boxShadow: const [
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
                                                                                                                      child: Padding(
                                                                                                                        padding: const EdgeInsets.all(5.0),
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
                                                                                                                                  duration: const Duration(milliseconds: 4000),
                                                                                                                                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                                ),
                                                                                                                              );
                                                                                                                            } else {
                                                                                                                              if (tabBarVarItem.attendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)).toList().isEmpty) {
                                                                                                                                context.pushNamed(
                                                                                                                                  'mark_attendence',
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
                                                                                                                                    kTransitionInfoKey: const TransitionInfo(
                                                                                                                                      hasTransition: true,
                                                                                                                                      transitionType: PageTransitionType.fade,
                                                                                                                                    ),
                                                                                                                                  },
                                                                                                                                );
                                                                                                                              } else {
                                                                                                                                context.goNamed(
                                                                                                                                  'class_attendence',
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
                                                                                                                                    kTransitionInfoKey: const TransitionInfo(
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
                                                                                                                                alignment: const AlignmentDirectional(1.0, -1.0),
                                                                                                                                child: Stack(
                                                                                                                                  alignment: const AlignmentDirectional(1.0, -1.0),
                                                                                                                                  children: [
                                                                                                                                    ClipRRect(
                                                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                                                      child: Image.asset(
                                                                                                                                        'assets/images/Chart_perspective_matte.png',
                                                                                                                                        width: MediaQuery.sizeOf(context).width * 0.2,
                                                                                                                                        height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                                                                        fit: BoxFit.contain,
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                    if (tabBarVarItem.attendance.where((e) => dateTimeFormat("yMd", e.date) == dateTimeFormat("yMd", getCurrentTimestamp)).toList().isNotEmpty)
                                                                                                                                      Align(
                                                                                                                                        alignment: const AlignmentDirectional(1.0, -1.0),
                                                                                                                                        child: Icon(
                                                                                                                                          Icons.check_circle,
                                                                                                                                          color: FlutterFlowTheme.of(context).checkBg,
                                                                                                                                          size: 24.0,
                                                                                                                                        ),
                                                                                                                                      ),
                                                                                                                                  ],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Text(
                                                                                                                                'Attendance',
                                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                      fontFamily: 'Nunito',
                                                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                                      fontSize: 14.0,
                                                                                                                                      letterSpacing: 0.0,
                                                                                                                                      fontWeight: FontWeight.normal,
                                                                                                                                    ),
                                                                                                                              ),
                                                                                                                            ],
                                                                                                                          ),
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
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            final datePickedDate = await showDatePicker(
                                                                                              context: context,
                                                                                              initialDate: getCurrentTimestamp,
                                                                                              firstDate: DateTime(1900),
                                                                                              lastDate: DateTime(2050),
                                                                                              builder: (context, child) {
                                                                                                return wrapInMaterialDatePickerTheme(
                                                                                                  context,
                                                                                                  child!,
                                                                                                  headerBackgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                                  headerForegroundColor: FlutterFlowTheme.of(context).info,
                                                                                                  headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                                        fontFamily: 'Nunito',
                                                                                                        fontSize: 32.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
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

                                                                                            if (datePickedDate != null) {
                                                                                              safeSetState(() {
                                                                                                _model.datePicked = DateTime(
                                                                                                  datePickedDate.year,
                                                                                                  datePickedDate.month,
                                                                                                  datePickedDate.day,
                                                                                                );
                                                                                              });
                                                                                            }
                                                                                            _model.datetime = _model.datePicked;
                                                                                            safeSetState(() {});
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.date_range_outlined,
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            size: 28.0,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                          child: Text(
                                                                                            dateTimeFormat("dd MMM , y", _model.datetime),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  fontSize: 16.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  if (!functions.isDatePassed(_model.datetime!))
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(10.0),
                                                                                      child: Material(
                                                                                        color: Colors.transparent,
                                                                                        elevation: 1.0,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                                        ),
                                                                                        child: Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            borderRadius: BorderRadius.circular(10.0),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: const AlignmentDirectional(-1.0, -1.0),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(10.0),
                                                                                                    child: Text(
                                                                                                      'New Notice',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'Nunito',
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                                                                                  child: SingleChildScrollView(
                                                                                                    scrollDirection: Axis.horizontal,
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                      children: [
                                                                                                        InkWell(
                                                                                                          splashColor: Colors.transparent,
                                                                                                          focusColor: Colors.transparent,
                                                                                                          hoverColor: Colors.transparent,
                                                                                                          highlightColor: Colors.transparent,
                                                                                                          onTap: () async {
                                                                                                            _model.eventname = 'Notice';
                                                                                                            safeSetState(() {});
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            width: MediaQuery.sizeOf(context).width * 0.26,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: valueOrDefault<Color>(
                                                                                                                _model.eventname == 'Notice' ? const Color(0xFFFFFCF0) : const Color(0xFFF5F2F2),
                                                                                                                const Color(0xFFF5F2F2),
                                                                                                              ),
                                                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                                                              border: Border.all(
                                                                                                                color: valueOrDefault<Color>(
                                                                                                                  _model.eventname == 'Notice' ? const Color(0xFFB0FF6A) : FlutterFlowTheme.of(context).text,
                                                                                                                  FlutterFlowTheme.of(context).text,
                                                                                                                ),
                                                                                                                width: 1.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                children: [
                                                                                                                  Icon(
                                                                                                                    Icons.push_pin,
                                                                                                                    color: valueOrDefault<Color>(
                                                                                                                      _model.eventname == 'Notice' ? FlutterFlowTheme.of(context).checkBg : FlutterFlowTheme.of(context).warning,
                                                                                                                      FlutterFlowTheme.of(context).warning,
                                                                                                                    ),
                                                                                                                    size: 20.0,
                                                                                                                  ),
                                                                                                                  Text(
                                                                                                                    'Notice',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          fontFamily: 'Nunito',
                                                                                                                          color: valueOrDefault<Color>(
                                                                                                                            _model.eventname == 'Notice' ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).alternate,
                                                                                                                            FlutterFlowTheme.of(context).text,
                                                                                                                          ),
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ].divide(const SizedBox(width: 10.0)).around(const SizedBox(width: 10.0)),
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
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            width: MediaQuery.sizeOf(context).width * 0.26,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: valueOrDefault<Color>(
                                                                                                                _model.eventname == 'Reminder' ? const Color(0xC3FBF0FF) : const Color(0xFFF5F2F2),
                                                                                                                const Color(0xFFF5F2F2),
                                                                                                              ),
                                                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                                                              border: Border.all(
                                                                                                                color: valueOrDefault<Color>(
                                                                                                                  _model.eventname == 'Reminder' ? const Color(0xFFADA6EB) : FlutterFlowTheme.of(context).text,
                                                                                                                  FlutterFlowTheme.of(context).text,
                                                                                                                ),
                                                                                                                width: 1.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                children: [
                                                                                                                  Icon(
                                                                                                                    Icons.alarm,
                                                                                                                    color: valueOrDefault<Color>(
                                                                                                                      _model.eventname == 'Reminder' ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).warning,
                                                                                                                      FlutterFlowTheme.of(context).warning,
                                                                                                                    ),
                                                                                                                    size: 20.0,
                                                                                                                  ),
                                                                                                                  Text(
                                                                                                                    'Reminder',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          fontFamily: 'Nunito',
                                                                                                                          color: valueOrDefault<Color>(
                                                                                                                            _model.eventname == 'Reminder' ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).alternate,
                                                                                                                            FlutterFlowTheme.of(context).text,
                                                                                                                          ),
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ].divide(const SizedBox(width: 10.0)).around(const SizedBox(width: 10.0)),
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
                                                                                                            _model.eventname = 'General';
                                                                                                            safeSetState(() {});
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            width: MediaQuery.sizeOf(context).width * 0.26,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: valueOrDefault<Color>(
                                                                                                                _model.eventname == 'General' ? const Color(0xFFFFFCF0) : const Color(0xFFF5F2F2),
                                                                                                                const Color(0xFFF5F2F2),
                                                                                                              ),
                                                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                                                              border: Border.all(
                                                                                                                color: valueOrDefault<Color>(
                                                                                                                  _model.eventname == 'General' ? const Color(0xFFFF976A) : FlutterFlowTheme.of(context).text,
                                                                                                                  FlutterFlowTheme.of(context).text,
                                                                                                                ),
                                                                                                                width: 1.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                children: [
                                                                                                                  Icon(
                                                                                                                    Icons.mode_comment,
                                                                                                                    color: valueOrDefault<Color>(
                                                                                                                      _model.eventname == 'General' ? FlutterFlowTheme.of(context).warning : FlutterFlowTheme.of(context).warning,
                                                                                                                      FlutterFlowTheme.of(context).warning,
                                                                                                                    ),
                                                                                                                    size: 20.0,
                                                                                                                  ),
                                                                                                                  Text(
                                                                                                                    'General',
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          fontFamily: 'Nunito',
                                                                                                                          color: valueOrDefault<Color>(
                                                                                                                            _model.eventname == 'General' ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).alternate,
                                                                                                                            FlutterFlowTheme.of(context).text,
                                                                                                                          ),
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ].divide(const SizedBox(width: 10.0)).around(const SizedBox(width: 10.0)),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ].divide(const SizedBox(width: 10.0)),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.all(10.0),
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
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                                                                                                              child: SizedBox(
                                                                                                                width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                                                child: TextFormField(
                                                                                                                  controller: _model.eventnameTextController,
                                                                                                                  focusNode: _model.eventnameFocusNode,
                                                                                                                  autofocus: false,
                                                                                                                  textCapitalization: TextCapitalization.sentences,
                                                                                                                  obscureText: false,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    isDense: true,
                                                                                                                    labelText: 'Title',
                                                                                                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                          fontFamily: 'Nunito',
                                                                                                                          color: (_model.eventnameFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                    hintText: 'Title',
                                                                                                                    hintStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                          fontFamily: 'Nunito',
                                                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FontWeight.normal,
                                                                                                                        ),
                                                                                                                    enabledBorder: OutlineInputBorder(
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: FlutterFlowTheme.of(context).dIsable,
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
                                                                                                                        fontFamily: 'Nunito',
                                                                                                                        letterSpacing: 0.0,
                                                                                                                      ),
                                                                                                                  maxLines: null,
                                                                                                                  maxLength: 25,
                                                                                                                  buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                                                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                                  validator: _model.eventnameTextControllerValidator.asValidator(context),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                                              child: SizedBox(
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
                                                                                                                          fontFamily: 'Nunito',
                                                                                                                          color: (_model.descriptionFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                    hintText: 'Description',
                                                                                                                    hintStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                          fontFamily: 'Nunito',
                                                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                                                          fontSize: 12.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FontWeight.normal,
                                                                                                                        ),
                                                                                                                    enabledBorder: OutlineInputBorder(
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: FlutterFlowTheme.of(context).dIsable,
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
                                                                                                                        fontFamily: 'Nunito',
                                                                                                                        letterSpacing: 0.0,
                                                                                                                      ),
                                                                                                                  maxLines: 4,
                                                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                                  validator: _model.descriptionTextControllerValidator.asValidator(context),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Container(
                                                                                                        decoration: const BoxDecoration(),
                                                                                                        child: Builder(
                                                                                                          builder: (context) {
                                                                                                            final imagesview = FFAppState().eventnoticeimage.toList();

                                                                                                            return GridView.builder(
                                                                                                              padding: EdgeInsets.zero,
                                                                                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                                                                crossAxisCount: 5,
                                                                                                                crossAxisSpacing: 10.0,
                                                                                                                mainAxisSpacing: 10.0,
                                                                                                                childAspectRatio: 1.0,
                                                                                                              ),
                                                                                                              primary: false,
                                                                                                              shrinkWrap: true,
                                                                                                              scrollDirection: Axis.vertical,
                                                                                                              itemCount: imagesview.length,
                                                                                                              itemBuilder: (context, imagesviewIndex) {
                                                                                                                final imagesviewItem = imagesview[imagesviewIndex];
                                                                                                                return ClipRRect(
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                  child: Image.network(
                                                                                                                    imagesviewItem,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                );
                                                                                                              },
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                        children: [
                                                                                                          FlutterFlowIconButton(
                                                                                                            borderColor: const Color(0xFFEDF1F3),
                                                                                                            borderRadius: 8.0,
                                                                                                            buttonSize: 40.0,
                                                                                                            icon: Icon(
                                                                                                              Icons.attach_file,
                                                                                                              color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                              size: 24.0,
                                                                                                            ),
                                                                                                            showLoadingIndicator: true,
                                                                                                            onPressed: () async {
                                                                                                              final selectedMedia = await selectMedia(
                                                                                                                mediaSource: MediaSource.photoGallery,
                                                                                                                multiImage: true,
                                                                                                              );
                                                                                                              if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                                                                safeSetState(() => _model.isDataUploading1 = true);
                                                                                                                var selectedUploadedFiles = <FFUploadedFile>[];

                                                                                                                var downloadUrls = <String>[];
                                                                                                                try {
                                                                                                                  showUploadMessage(
                                                                                                                    context,
                                                                                                                    'Uploading file...',
                                                                                                                    showLoading: true,
                                                                                                                  );
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
                                                                                                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                                                  _model.isDataUploading1 = false;
                                                                                                                }
                                                                                                                if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                                                  safeSetState(() {
                                                                                                                    _model.uploadedLocalFiles1 = selectedUploadedFiles;
                                                                                                                    _model.uploadedFileUrls1 = downloadUrls;
                                                                                                                  });
                                                                                                                  showUploadMessage(context, 'Success!');
                                                                                                                } else {
                                                                                                                  safeSetState(() {});
                                                                                                                  showUploadMessage(context, 'Failed to upload data');
                                                                                                                  return;
                                                                                                                }
                                                                                                              }

                                                                                                              FFAppState().addToEventnoticeimage(_model.uploadedFileUrls1.firstOrNull!);
                                                                                                              safeSetState(() {});
                                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                SnackBar(
                                                                                                                  content: Text(
                                                                                                                    'File uploaded',
                                                                                                                    style: TextStyle(
                                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  duration: const Duration(milliseconds: 4000),
                                                                                                                  backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          ),
                                                                                                          FlutterFlowIconButton(
                                                                                                            borderColor: const Color(0xFFEDF1F3),
                                                                                                            borderRadius: 8.0,
                                                                                                            buttonSize: 40.0,
                                                                                                            icon: Icon(
                                                                                                              Icons.photo_camera_outlined,
                                                                                                              color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                              size: 24.0,
                                                                                                            ),
                                                                                                            showLoadingIndicator: true,
                                                                                                            onPressed: () async {
                                                                                                              final selectedMedia = await selectMedia(
                                                                                                                multiImage: false,
                                                                                                              );
                                                                                                              if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                                                                safeSetState(() => _model.isDataUploading2 = true);
                                                                                                                var selectedUploadedFiles = <FFUploadedFile>[];

                                                                                                                var downloadUrls = <String>[];
                                                                                                                try {
                                                                                                                  showUploadMessage(
                                                                                                                    context,
                                                                                                                    'Uploading file...',
                                                                                                                    showLoading: true,
                                                                                                                  );
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
                                                                                                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                                                  _model.isDataUploading2 = false;
                                                                                                                }
                                                                                                                if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                                                  safeSetState(() {
                                                                                                                    _model.uploadedLocalFile2 = selectedUploadedFiles.first;
                                                                                                                    _model.uploadedFileUrl2 = downloadUrls.first;
                                                                                                                  });
                                                                                                                  showUploadMessage(context, 'Success!');
                                                                                                                } else {
                                                                                                                  safeSetState(() {});
                                                                                                                  showUploadMessage(context, 'Failed to upload data');
                                                                                                                  return;
                                                                                                                }
                                                                                                              }

                                                                                                              FFAppState().addToEventnoticeimage(_model.uploadedFileUrl2);
                                                                                                              safeSetState(() {});
                                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                SnackBar(
                                                                                                                  content: Text(
                                                                                                                    'File uploaded',
                                                                                                                    style: TextStyle(
                                                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  duration: const Duration(milliseconds: 4000),
                                                                                                                  backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          ),
                                                                                                          FFButtonWidget(
                                                                                                            onPressed: (adminTeacherSchoolRecord.listOfStudents.isEmpty)
                                                                                                                ? null
                                                                                                                : () async {
                                                                                                                    if (tabBarSchoolClassRecordList.where((e) => e.listOfteachersUser.contains(currentUserReference)).toList().isNotEmpty) {
                                                                                                                      if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) {
                                                                                                                        return;
                                                                                                                      }
                                                                                                                      if (_model.eventname != null && _model.eventname != '') {
                                                                                                                        if (FFAppState().eventnoticeimage.isEmpty) {
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
                                                                                                                                  child: SizedBox(
                                                                                                                                    height: MediaQuery.sizeOf(context).height * 0.7,
                                                                                                                                    child: SelectClassNoticeWidget(
                                                                                                                                      schoolref: adminTeacherSchoolRecord.reference,
                                                                                                                                      eventtitle: _model.eventnameTextController.text,
                                                                                                                                      description: _model.descriptionTextController.text,
                                                                                                                                      datetime: _model.datetime!,
                                                                                                                                      eventname: _model.eventname!,
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              );
                                                                                                                            },
                                                                                                                          ).then((value) => safeSetState(() {}));
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
                                                                                                                                  child: SizedBox(
                                                                                                                                    height: MediaQuery.sizeOf(context).height * 0.7,
                                                                                                                                    child: SelectClassNoticeWidget(
                                                                                                                                      schoolref: adminTeacherSchoolRecord.reference,
                                                                                                                                      eventtitle: _model.eventnameTextController.text,
                                                                                                                                      description: _model.descriptionTextController.text,
                                                                                                                                      datetime: _model.datetime!,
                                                                                                                                      images: FFAppState().eventnoticeimage,
                                                                                                                                      eventname: _model.eventname!,
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
                                                                                                                            duration: const Duration(milliseconds: 4000),
                                                                                                                            backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      }
                                                                                                                    } else {
                                                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                        SnackBar(
                                                                                                                          content: Text(
                                                                                                                            '**Notice Addition**   To add a notice, you must be assigned to at least one class. Please ensure you are assigned accordingly to proceed.',
                                                                                                                            style: TextStyle(
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          duration: const Duration(milliseconds: 4000),
                                                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                                                        ),
                                                                                                                      );
                                                                                                                    }
                                                                                                                  },
                                                                                                            text: 'Create notice',
                                                                                                            options: FFButtonOptions(
                                                                                                              width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                                              height: MediaQuery.sizeOf(context).height * 0.05,
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                    fontFamily: 'Nunito',
                                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                  ),
                                                                                                              elevation: 0.0,
                                                                                                              borderSide: BorderSide(
                                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                              ),
                                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                                              disabledColor: FlutterFlowTheme.of(context).dIsable,
                                                                                                              disabledTextColor: FlutterFlowTheme.of(context).primaryText,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ].divide(const SizedBox(height: 10.0)).around(const SizedBox(height: 10.0)),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                                                                    child: Builder(
                                                                                      builder: (context) {
                                                                                        final notice = adminTeacherSchoolRecord.listOfNotice.where((e) => dateTimeFormat("yMMMd", e.eventDate) == dateTimeFormat("yMMMd", _model.datetime)).toList().toList() ?? [];

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
                                                                                          itemCount: notice.length,
                                                                                          itemBuilder: (context, noticeIndex) {
                                                                                            final noticeItem = notice[noticeIndex];
                                                                                            return Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
                                                                                              child: Material(
                                                                                                color: Colors.transparent,
                                                                                                elevation: 5.0,
                                                                                                shape: RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.circular(16.0),
                                                                                                ),
                                                                                                child: Container(
                                                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                                    borderRadius: BorderRadius.circular(16.0),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                                          child: Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: [
                                                                                                              Container(
                                                                                                                width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                ),
                                                                                                                child: Text(
                                                                                                                  noticeItem.eventTitle,
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        fontFamily: 'Nunito',
                                                                                                                        fontSize: 16.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: () {
                                                                                                                    if (noticeItem.eventName == 'Notice') {
                                                                                                                      return const Color(0xFFFFFCF0);
                                                                                                                    } else if (noticeItem.eventName == 'Reminder') {
                                                                                                                      return const Color(0xC3FBF0FF);
                                                                                                                    } else {
                                                                                                                      return const Color(0xFFFFFCF0);
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                                                  border: Border.all(
                                                                                                                    color: () {
                                                                                                                      if (noticeItem.eventName == 'Notice') {
                                                                                                                        return const Color(0xFFB0FF6A);
                                                                                                                      } else if (noticeItem.eventName == 'Reminder') {
                                                                                                                        return const Color(0xFFADA6EB);
                                                                                                                      } else {
                                                                                                                        return const Color(0xFFFF976A);
                                                                                                                      }
                                                                                                                    }(),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                child: Padding(
                                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                                                  child: Row(
                                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                    children: [
                                                                                                                      if (noticeItem.eventName == 'Notice')
                                                                                                                        Icon(
                                                                                                                          Icons.push_pin,
                                                                                                                          color: FlutterFlowTheme.of(context).checkBg,
                                                                                                                          size: 20.0,
                                                                                                                        ),
                                                                                                                      if (noticeItem.eventName == 'Reminder')
                                                                                                                        Icon(
                                                                                                                          Icons.alarm,
                                                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                                                          size: 20.0,
                                                                                                                        ),
                                                                                                                      if (noticeItem.eventName == 'General')
                                                                                                                        Icon(
                                                                                                                          Icons.mode_comment,
                                                                                                                          color: FlutterFlowTheme.of(context).warning,
                                                                                                                          size: 20.0,
                                                                                                                        ),
                                                                                                                      Text(
                                                                                                                        noticeItem.eventName,
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              fontFamily: 'Nunito',
                                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                              fontSize: 16.0,
                                                                                                                              letterSpacing: 0.0,
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                            ),
                                                                                                                      ),
                                                                                                                    ].divide(const SizedBox(width: 10.0)).around(const SizedBox(width: 10.0)),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                                          child: Text(
                                                                                                            dateTimeFormat("dd MMM , y", noticeItem.eventDate!),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: 'Nunito',
                                                                                                                  color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                                          decoration: const BoxDecoration(),
                                                                                                          child: Text(
                                                                                                            noticeItem.eventDescription,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  fontFamily: 'Nunito',
                                                                                                                  color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                                          child: Builder(
                                                                                                            builder: (context) {
                                                                                                              final images1 = noticeItem.eventImages.toList();

                                                                                                              return SingleChildScrollView(
                                                                                                                scrollDirection: Axis.horizontal,
                                                                                                                child: Row(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  children: List.generate(images1.length, (images1Index) {
                                                                                                                    final images1Item = images1[images1Index];
                                                                                                                    return Padding(
                                                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 10.0, 0.0),
                                                                                                                      child: Container(
                                                                                                                        width: 50.0,
                                                                                                                        height: 50.0,
                                                                                                                        decoration: const BoxDecoration(),
                                                                                                                        child: InkWell(
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
                                                                                                                                    images1Item,
                                                                                                                                    fit: BoxFit.contain,
                                                                                                                                  ),
                                                                                                                                  allowRotation: false,
                                                                                                                                  tag: images1Item,
                                                                                                                                  useHeroAnimation: true,
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            );
                                                                                                                          },
                                                                                                                          child: Hero(
                                                                                                                            tag: images1Item,
                                                                                                                            transitionOnUserGestures: true,
                                                                                                                            child: ClipRRect(
                                                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                                                              child: Image.network(
                                                                                                                                images1Item,
                                                                                                                                width: 50.0,
                                                                                                                                height: 50.0,
                                                                                                                                fit: BoxFit.cover,
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
                                                                                                      ].addToEnd(const SizedBox(height: 20.0)),
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
                                                                                ].addToEnd(const SizedBox(height: 10.0)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                20.0),
                                                                            child:
                                                                                Container(
                                                                              height: MediaQuery.sizeOf(context).height * 0.8,
                                                                              decoration: const BoxDecoration(),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(10.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Select a date to add an event.',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Nunito',
                                                                                                color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 10.0, 5.0),
                                                                                          child: FlutterFlowDropDown<String>(
                                                                                            controller: _model.dropDownValueController ??= FormFieldController<String>(
                                                                                              _model.dropDownValue ??= 'All',
                                                                                            ),
                                                                                            options: functions.getClassNames(tabBarSchoolClassRecordList.toList(), adminTeacherSchoolRecord.listOfClass.toList()),
                                                                                            onChanged: (val) async {
                                                                                              safeSetState(() => _model.dropDownValue = val);
                                                                                              if (_model.dropDownValue != 'All') {
                                                                                                _model.class1 = await SchoolClassRecord.getDocumentOnce(tabBarSchoolClassRecordList.where((e) => e.className == _model.dropDownValue).toList().firstOrNull!.reference);
                                                                                                _model.selectedclass = _model.class1?.reference;
                                                                                                _model.classevents = _model.class1!.calendar.toList().cast<EventsNoticeStruct>();
                                                                                                safeSetState(() {});

                                                                                                safeSetState(() {});
                                                                                              } else {
                                                                                                _model.selectedclass = null;
                                                                                                _model.classevents = [];
                                                                                                safeSetState(() {});

                                                                                                safeSetState(() {});
                                                                                              }

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                            height: MediaQuery.sizeOf(context).height * 0.05,
                                                                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  color: FlutterFlowTheme.of(context).text1,
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                            hintText: 'All',
                                                                                            icon: Icon(
                                                                                              Icons.keyboard_arrow_down_rounded,
                                                                                              color: FlutterFlowTheme.of(context).text1,
                                                                                              size: 24.0,
                                                                                            ),
                                                                                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            elevation: 2.0,
                                                                                            borderColor: FlutterFlowTheme.of(context).dIsable,
                                                                                            borderWidth: 2.0,
                                                                                            borderRadius: 10.0,
                                                                                            margin: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                            hidesUnderline: true,
                                                                                            isOverButton: false,
                                                                                            isSearchable: false,
                                                                                            isMultiSelect: false,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      if (_model.selectedclass == null)
                                                                                        Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                          decoration: const BoxDecoration(),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                            child: SizedBox(
                                                                                              width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                              height: MediaQuery.sizeOf(context).height * 0.57,
                                                                                              child: custom_widgets.Timelinewidgetdatatype(
                                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                height: MediaQuery.sizeOf(context).height * 0.57,
                                                                                                timrlinewidget: adminTeacherSchoolRecord.calendarList,
                                                                                                schoolref: adminTeacherSchoolRecord.reference,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      if (_model.selectedclass != null)
                                                                                        Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                          decoration: const BoxDecoration(),
                                                                                          child: SizedBox(
                                                                                            width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                            height: MediaQuery.sizeOf(context).height * 0.57,
                                                                                            child: custom_widgets.TimelinewidgetdatatypeClassCopy(
                                                                                              width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                              height: MediaQuery.sizeOf(context).height * 0.57,
                                                                                              timrlinewidget: _model.classevents,
                                                                                              schoolclassref: _model.selectedclass!,
                                                                                              classname: _model.dropDownValue!,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: Text(
                                                                                    'Total Student - ${FFAppState().selectedstudents.length.toString()}',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                if (valueOrDefault(currentUserDocument?.userRole, 0) != 1)
                                                                                  InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      context.pushNamed(
                                                                                        'add_student_manually',
                                                                                        queryParameters: {
                                                                                          'schoolref': serializeParam(
                                                                                            adminTeacherSchoolRecord.reference,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    child: Material(
                                                                                      color: Colors.transparent,
                                                                                      elevation: 3.0,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                      ),
                                                                                      child: Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.28,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.14,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                                height: MediaQuery.sizeOf(context).width * 0.15,
                                                                                                decoration: const BoxDecoration(
                                                                                                  color: Color(0xFFE4EDFC),
                                                                                                  shape: BoxShape.circle,
                                                                                                ),
                                                                                                child: Stack(
                                                                                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                  children: [
                                                                                                    Align(
                                                                                                      alignment: const AlignmentDirectional(0.0, -1.0),
                                                                                                      child: Container(
                                                                                                        width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                                        height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                                        clipBehavior: Clip.antiAlias,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.circle,
                                                                                                        ),
                                                                                                        child: Image.asset(
                                                                                                          'assets/images/Generic_avatar.png',
                                                                                                          fit: BoxFit.cover,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Align(
                                                                                                      alignment: const AlignmentDirectional(1.0, 1.0),
                                                                                                      child: Icon(
                                                                                                        Icons.add_circle_outline,
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        size: 20.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: const AlignmentDirectional(0.0, 1.0),
                                                                                                child: Text(
                                                                                                  'Add Student',
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Nunito',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(const SizedBox(height: 8.0)),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                                                                                  child: Container(
                                                                                    height: MediaQuery.sizeOf(context).height * 0.42,
                                                                                    decoration: const BoxDecoration(),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                      child: Builder(
                                                                                        builder: (context) {
                                                                                          final students = adminTeacherSchoolRecord.studentDataList.sortedList(keyOf: (e) => e.studentName, desc: false).toList() ?? [];
                                                                                          if (students.isEmpty) {
                                                                                            return Center(
                                                                                              child: SizedBox(
                                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                height: MediaQuery.sizeOf(context).height * 0.2,
                                                                                                child: const EmptystudentWidget(),
                                                                                              ),
                                                                                            );
                                                                                          }

                                                                                          return GridView.builder(
                                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                              0,
                                                                                              0,
                                                                                              0,
                                                                                              20.0,
                                                                                            ),
                                                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                                              crossAxisCount: 3,
                                                                                              crossAxisSpacing: 5.0,
                                                                                              mainAxisSpacing: 10.0,
                                                                                              childAspectRatio: 0.9,
                                                                                            ),
                                                                                            primary: false,
                                                                                            shrinkWrap: true,
                                                                                            scrollDirection: Axis.vertical,
                                                                                            itemCount: students.length,
                                                                                            itemBuilder: (context, studentsIndex) {
                                                                                              final studentsItem = students[studentsIndex];
                                                                                              return Container(
                                                                                                decoration: const BoxDecoration(),
                                                                                                child: StreamBuilder<StudentsRecord>(
                                                                                                  stream: StudentsRecord.getDocument(studentsItem.studentId!),
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

                                                                                                    final stackStudentsRecord = snapshot.data!;

                                                                                                    return InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        if (stackStudentsRecord.isDraft == true) {
                                                                                                          context.pushNamed(
                                                                                                            'student_draft',
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
                                                                                                          if (studentsItem.classref.isNotEmpty) {
                                                                                                            context.pushNamed(
                                                                                                              'indistudentmainpages',
                                                                                                              queryParameters: {
                                                                                                                'studentsref': serializeParam(
                                                                                                                  studentsItem.studentId,
                                                                                                                  ParamType.DocumentReference,
                                                                                                                ),
                                                                                                                'classref': serializeParam(
                                                                                                                  studentsItem.classref,
                                                                                                                  ParamType.DocumentReference,
                                                                                                                  isList: true,
                                                                                                                ),
                                                                                                                'schoolref': serializeParam(
                                                                                                                  adminTeacherSchoolRecord.reference,
                                                                                                                  ParamType.DocumentReference,
                                                                                                                ),
                                                                                                              }.withoutNulls,
                                                                                                            );
                                                                                                          } else {
                                                                                                            context.goNamed(
                                                                                                              'New_student',
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
                                                                                                                kTransitionInfoKey: const TransitionInfo(
                                                                                                                  hasTransition: true,
                                                                                                                  transitionType: PageTransitionType.fade,
                                                                                                                ),
                                                                                                              },
                                                                                                            );
                                                                                                          }
                                                                                                        }
                                                                                                      },
                                                                                                      child: Stack(
                                                                                                        children: [
                                                                                                          Padding(
                                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 9.0, 0.0, 0.0),
                                                                                                            child: Material(
                                                                                                              color: Colors.transparent,
                                                                                                              elevation: 3.0,
                                                                                                              shape: RoundedRectangleBorder(
                                                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                                                              ),
                                                                                                              child: Container(
                                                                                                                width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                                                  border: Border.all(
                                                                                                                    color: valueOrDefault<Color>(
                                                                                                                      studentsItem.classref.isNotEmpty ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                      FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                child: Column(
                                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                  children: [
                                                                                                                    Container(
                                                                                                                      width: MediaQuery.sizeOf(context).width * 0.18,
                                                                                                                      height: MediaQuery.sizeOf(context).width * 0.18,
                                                                                                                      clipBehavior: Clip.antiAlias,
                                                                                                                      decoration: const BoxDecoration(
                                                                                                                        shape: BoxShape.circle,
                                                                                                                      ),
                                                                                                                      child: Image.network(
                                                                                                                        valueOrDefault<String>(
                                                                                                                          studentsItem.studentImage,
                                                                                                                          'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6',
                                                                                                                        ),
                                                                                                                        fit: BoxFit.cover,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    Padding(
                                                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                                                      child: Container(
                                                                                                                        width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                                                                        ),
                                                                                                                        child: Align(
                                                                                                                          alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                                          child: Text(
                                                                                                                            studentsItem.studentName,
                                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                  fontFamily: 'Nunito',
                                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                                  fontSize: 14.0,
                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                                ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          if (studentsItem.isDraft)
                                                                                                            const Align(
                                                                                                              alignment: AlignmentDirectional(1.0, -1.0),
                                                                                                              child: Icon(
                                                                                                                Icons.error,
                                                                                                                color: Color(0xFFB03E3E),
                                                                                                                size: 30.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                        ],
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
                                                                                  ),
                                                                                ),
                                                                              ].addToEnd(const SizedBox(height: 20.0)),
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
                                                      ),
                                                    ].addToEnd(
                                                        const SizedBox(height: 30.0)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
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
                      } else if (valueOrDefault(
                              currentUserDocument?.userRole, 0) ==
                          4) {
                        return SizedBox(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: Stack(
                            children: [
                              StreamBuilder<List<StudentsRecord>>(
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
                                    return SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      child: const MainDashboardShimmerWidget(),
                                    );
                                  }
                                  List<StudentsRecord> bodyStudentsRecordList =
                                      snapshot.data!;

                                  return Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5.0, 10.0, 5.0, 0.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Hello, $currentUserDisplayName',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Visibility(
                                                  visible:
                                                      bodyStudentsRecordList
                                                              .length !=
                                                          1,
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
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: List.generate(
                                                              studentNAV.length,
                                                              (studentNAVIndex) {
                                                            final studentNAVItem =
                                                                studentNAV[
                                                                    studentNAVIndex];
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          2.0,
                                                                          0.0,
                                                                          2.0,
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
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.4,
                                                                  height: 55.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: studentNAVIndex ==
                                                                            _model
                                                                                .pageno
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .secondary
                                                                        : const Color(
                                                                            0xFFF0F0F0),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: studentNAVIndex ==
                                                                              _model
                                                                                  .pageno
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primary
                                                                          : const Color(
                                                                              0xFFF0F0F0),
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      studentNAVItem
                                                                          .studentName,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Nunito',
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
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
                                            Builder(
                                              builder: (context) {
                                                final studentList =
                                                    bodyStudentsRecordList
                                                        .sortedList(
                                                            keyOf: (e) =>
                                                                e.studentName,
                                                            desc: false)
                                                        .toList();

                                                return SizedBox(
                                                  width: double.infinity,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.9,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
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
                                                        return SingleChildScrollView(
                                                          primary: false,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          10.0,
                                                                          0.0,
                                                                          10.0),
                                                                  child: Text(
                                                                    'Here’s an overview of ${studentListItem.studentName}’s profile!',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                                  child: Text(
                                                                    'Upcoming Events',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                child: StreamBuilder<
                                                                    List<
                                                                        SchoolClassRecord>>(
                                                                  stream:
                                                                      querySchoolClassRecord(),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return SizedBox(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.08,
                                                                        child:
                                                                            const EventShimmerWidget(),
                                                                      );
                                                                    }
                                                                    List<SchoolClassRecord>
                                                                        containerSchoolClassRecordList =
                                                                        snapshot
                                                                            .data!;

                                                                    return Container(
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              10.0),
                                                                          child:
                                                                              Builder(
                                                                            builder:
                                                                                (context) {
                                                                              final events = dashboardSchoolRecordList.where((e) => e.reference == studentListItem.schoolref).toList().firstOrNull?.calendarList.sortedList(keyOf: (e) => e.eventDate!, desc: true).toList() ?? [];

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
                                                                                          alignment: const AlignmentDirectional(-1.0, 0.0),
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
                                                                                                      child: SizedBox(
                                                                                                        height: MediaQuery.sizeOf(context).height * 0.6,
                                                                                                        child: ClassEventViewWidget(
                                                                                                          school: dashboardSchoolRecordList.where((e) => e.listOfStudents.contains(studentListItem.reference)).toList().firstOrNull!.reference,
                                                                                                          eventid: eventsItem.eventId,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              ).then((value) => safeSetState(() {}));
                                                                                            },
                                                                                            child: Container(
                                                                                              width: MediaQuery.sizeOf(context).width * 0.35,
                                                                                              decoration: BoxDecoration(
                                                                                                color: () {
                                                                                                  if (eventsItem.eventName == 'Event') {
                                                                                                    return const Color(0xFFFFFCF0);
                                                                                                  } else if (eventsItem.eventName == 'Birthday') {
                                                                                                    return const Color(0xFFF0F0FF);
                                                                                                  } else {
                                                                                                    return const Color(0xFFFBFCFF);
                                                                                                  }
                                                                                                }(),
                                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                                border: Border.all(
                                                                                                  color: () {
                                                                                                    if (eventsItem.eventName == 'Event') {
                                                                                                      return const Color(0xFFF8BA0B);
                                                                                                    } else if (eventsItem.eventName == 'Birthday') {
                                                                                                      return const Color(0xFF635AAC);
                                                                                                    } else {
                                                                                                      return const Color(0xFF7DD7FE);
                                                                                                    }
                                                                                                  }(),
                                                                                                  width: 2.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(6.0, 8.0, 0.0, 8.0),
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                  children: [
                                                                                                    if (eventsItem.eventName == 'Event')
                                                                                                      const Icon(
                                                                                                        Icons.bolt_sharp,
                                                                                                        color: Color(0xFFF8BA0B),
                                                                                                        size: 24.0,
                                                                                                      ),
                                                                                                    if (eventsItem.eventName == 'Birthday')
                                                                                                      const Icon(
                                                                                                        Icons.cake_outlined,
                                                                                                        color: Color(0xFFB0A7FD),
                                                                                                        size: 24.0,
                                                                                                      ),
                                                                                                    if (eventsItem.eventName == 'Holiday')
                                                                                                      const Icon(
                                                                                                        Icons.celebration_sharp,
                                                                                                        color: Color(0xFF072F78),
                                                                                                        size: 24.0,
                                                                                                      ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 5.0, 0.0),
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
                                                                                                              fontFamily: 'Nunito',
                                                                                                              color: valueOrDefault<Color>(
                                                                                                                () {
                                                                                                                  if (eventsItem.eventName == 'Event') {
                                                                                                                    return const Color(0xFFC29800);
                                                                                                                  } else if (eventsItem.eventName == 'Birthday') {
                                                                                                                    return const Color(0xFF0FA9EE);
                                                                                                                  } else {
                                                                                                                    return const Color(0xFF635AAC);
                                                                                                                  }
                                                                                                                }(),
                                                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          functions.formatDate(eventsItem.eventDate!) == functions.formatDate(getCurrentTimestamp) ? 'Today' : dateTimeFormat("MMMd", eventsItem.eventDate!),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Nunito',
                                                                                                color: functions.formatDate(eventsItem.eventDate!) == functions.formatDate(getCurrentTimestamp) ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).primaryText,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  }).divide(const SizedBox(width: 10.0)).around(const SizedBox(width: 10.0)),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10.0),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          5.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
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
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              10.0,
                                                                              10.0,
                                                                              0.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  studentListItem.schoolName,
                                                                                  maxLines: 1,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Nunito',
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        fontSize: 14.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
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
                                                                                        Align(
                                                                                          alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                          child: Container(
                                                                                            width: 65.0,
                                                                                            height: 65.0,
                                                                                            decoration: const BoxDecoration(
                                                                                              shape: BoxShape.circle,
                                                                                            ),
                                                                                            child: InkWell(
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
                                                                                                        'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6' '$studentListIndex',
                                                                                                      ),
                                                                                                      useHeroAnimation: true,
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                              child: Hero(
                                                                                                tag: valueOrDefault<String>(
                                                                                                  studentListItem.studentImage,
                                                                                                  'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fdownload%20(12).jpeg?alt=media&token=e70fe0d9-9de4-4497-8a79-191670d623c6' '$studentListIndex',
                                                                                                ),
                                                                                                transitionOnUserGestures: true,
                                                                                                child: ClipRRect(
                                                                                                  borderRadius: BorderRadius.circular(30.0),
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
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 5.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Text(
                                                                                                  studentListItem.studentName,
                                                                                                  textAlign: TextAlign.start,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Nunito',
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 16.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Text(
                                                                                                  'Dob :  ${dateTimeFormat("yMMMd", studentListItem.dateOfBirth)}',
                                                                                                  textAlign: TextAlign.start,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Nunito',
                                                                                                        color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                        fontSize: 14.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(const SizedBox(height: 8.0)),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
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
                                                                                              fontFamily: 'Nunito',
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ].divide(const SizedBox(width: 10.0)),
                                                                              ),
                                                                            ],
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
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        10.0,
                                                                        10.0,
                                                                        10.0),
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
                                                                    if (studentListItem
                                                                            .timeline
                                                                            .where((e) =>
                                                                                functions.formatDate(e.date!) ==
                                                                                functions.formatDate(_model.calendarDate!))
                                                                            .toList().isNotEmpty) {
                                                                      context
                                                                          .pushNamed(
                                                                        'timelinedetails',
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
                                                                              const TransitionInfo(
                                                                            hasTransition:
                                                                                true,
                                                                            transitionType:
                                                                                PageTransitionType.fade,
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
                                                                        5.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                const AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                functions.formatDate(_model.calendarDate!) == functions.formatDate(getCurrentTimestamp) ? 'Today \'s Timeline' : '${dateTimeFormat("dd MMM , y", _model.calendarDate)}\'s Timeline',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Nunito',
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      fontSize: 18.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 15.0),
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  final timeslines = studentListItem.timeline.where((e) => dateTimeFormat("yMd", e.date) == dateTimeFormat("yMd", _model.calendarDate)).toList().unique((e) => e.activityId).toList().take(4).toList();
                                                                                  if (timeslines.isEmpty) {
                                                                                    return const Center(
                                                                                      child: EmptyWidget(),
                                                                                    );
                                                                                  }

                                                                                  return Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: List.generate(timeslines.length, (timeslinesIndex) {
                                                                                      final timeslinesItem = timeslines[timeslinesIndex];
                                                                                      return Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                              height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                              clipBehavior: Clip.antiAlias,
                                                                                              decoration: const BoxDecoration(
                                                                                                shape: BoxShape.circle,
                                                                                              ),
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
                                                                                                  } else {
                                                                                                    return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FIncident.png?alt=media&token=f2401cf9-a754-4a0c-8f2f-ad0423ebe926';
                                                                                                  }
                                                                                                }(),
                                                                                                fit: BoxFit.cover,
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              dateTimeFormat("jm", timeslinesItem.date!),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Nunito',
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    }),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
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
                                                                  if (classes
                                                                      .isEmpty) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.3,
                                                                        child:
                                                                            const EmptyWidget(),
                                                                      ),
                                                                    );
                                                                  }

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
                                                                          classes[
                                                                              classesIndex];
                                                                      return Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                5.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 1.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(10.0),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(10.0),
                                                                                child: StreamBuilder<SchoolClassRecord>(
                                                                                  stream: SchoolClassRecord.getDocument(classesItem),
                                                                                  builder: (context, snapshot) {
                                                                                    // Customize what your widget looks like when it's loading.
                                                                                    if (!snapshot.hasData) {
                                                                                      return SizedBox(
                                                                                        width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                        child: const ClassshimmerWidget(),
                                                                                      );
                                                                                    }

                                                                                    final containerSchoolClassRecord = snapshot.data!;

                                                                                    return Container(
                                                                                      decoration: const BoxDecoration(),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Align(
                                                                                              alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                                child: Text(
                                                                                                  containerSchoolClassRecord.className,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Nunito',
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 18.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                                    child: Material(
                                                                                                      color: Colors.transparent,
                                                                                                      elevation: 2.0,
                                                                                                      shape: RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                      ),
                                                                                                      child: Container(
                                                                                                        width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                        height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                                          boxShadow: const [
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
                                                                                                        child: Padding(
                                                                                                          padding: const EdgeInsets.all(5.0),
                                                                                                          child: InkWell(
                                                                                                            splashColor: Colors.transparent,
                                                                                                            focusColor: Colors.transparent,
                                                                                                            hoverColor: Colors.transparent,
                                                                                                            highlightColor: Colors.transparent,
                                                                                                            onTap: () async {
                                                                                                              context.pushNamed(
                                                                                                                'attendence_parent',
                                                                                                                queryParameters: {
                                                                                                                  'classref': serializeParam(
                                                                                                                    containerSchoolClassRecord.reference,
                                                                                                                    ParamType.DocumentReference,
                                                                                                                  ),
                                                                                                                  'studentref': serializeParam(
                                                                                                                    studentListItem.reference,
                                                                                                                    ParamType.DocumentReference,
                                                                                                                  ),
                                                                                                                }.withoutNulls,
                                                                                                                extra: <String, dynamic>{
                                                                                                                  kTransitionInfoKey: const TransitionInfo(
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
                                                                                                                      '${functions.calculateAttendancePercentage(textSchoolClassRecord.attendance.toList(), studentListItem.reference).toString()} %',
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            fontFamily: 'Nunito',
                                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                            fontSize: 24.0,
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                          ),
                                                                                                                    );
                                                                                                                  },
                                                                                                                ),
                                                                                                                Text(
                                                                                                                  'Attendance',
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        fontFamily: 'Nunito',
                                                                                                                        letterSpacing: 0.0,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                                    child: Material(
                                                                                                      color: Colors.transparent,
                                                                                                      elevation: 2.0,
                                                                                                      shape: RoundedRectangleBorder(
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                      ),
                                                                                                      child: Container(
                                                                                                        width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                        height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                                          boxShadow: const [
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
                                                                                                        child: Padding(
                                                                                                          padding: const EdgeInsets.all(5.0),
                                                                                                          child: InkWell(
                                                                                                            splashColor: Colors.transparent,
                                                                                                            focusColor: Colors.transparent,
                                                                                                            hoverColor: Colors.transparent,
                                                                                                            highlightColor: Colors.transparent,
                                                                                                            onTap: () async {
                                                                                                              context.pushNamed(
                                                                                                                'Calender_parent',
                                                                                                                queryParameters: {
                                                                                                                  'classref': serializeParam(
                                                                                                                    containerSchoolClassRecord.reference,
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
                                                                                                                        fontFamily: 'Nunito',
                                                                                                                        letterSpacing: 0.0,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
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
                                                                                                      height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                                        boxShadow: const [
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
                                                                                                      child: Padding(
                                                                                                        padding: const EdgeInsets.all(5.0),
                                                                                                        child: InkWell(
                                                                                                          splashColor: Colors.transparent,
                                                                                                          focusColor: Colors.transparent,
                                                                                                          hoverColor: Colors.transparent,
                                                                                                          highlightColor: Colors.transparent,
                                                                                                          onTap: () async {
                                                                                                            context.pushNamed(
                                                                                                              'notice_parent',
                                                                                                              queryParameters: {
                                                                                                                'clasref': serializeParam(
                                                                                                                  containerSchoolClassRecord.reference,
                                                                                                                  ParamType.DocumentReference,
                                                                                                                ),
                                                                                                                'studentref': serializeParam(
                                                                                                                  studentListItem.reference,
                                                                                                                  ParamType.DocumentReference,
                                                                                                                ),
                                                                                                              }.withoutNulls,
                                                                                                              extra: <String, dynamic>{
                                                                                                                kTransitionInfoKey: const TransitionInfo(
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
                                                                                                              Icon(
                                                                                                                Icons.notifications_rounded,
                                                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                                                size: 34.0,
                                                                                                              ),
                                                                                                              Text(
                                                                                                                'Notice',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      fontFamily: 'Nunito',
                                                                                                                      letterSpacing: 0.0,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
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
                                                                                    );
                                                                                  },
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
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      5.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
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
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              6.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            '${studentListItem.studentName}\'s Gallery',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.65,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                child: Builder(
                                                                                  builder: (context) {
                                                                                    final images = studentListItem.imageslist.toList().take(3).toList();
                                                                                    if (images.isEmpty) {
                                                                                      return Center(
                                                                                        child: SizedBox(
                                                                                          height: MediaQuery.sizeOf(context).height * 0.3,
                                                                                          child: const EmptyWidget(),
                                                                                        ),
                                                                                      );
                                                                                    }

                                                                                    return Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: List.generate(images.length, (imagesIndex) {
                                                                                        final imagesItem = images[imagesIndex];
                                                                                        return Padding(
                                                                                          padding: const EdgeInsets.all(5.0),
                                                                                          child: Container(
                                                                                            width: 80.0,
                                                                                            height: 100.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                                            ),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                context.pushNamed(
                                                                                                  'indivi_image_view',
                                                                                                  queryParameters: {
                                                                                                    'student': serializeParam(
                                                                                                      studentListItem.reference,
                                                                                                      ParamType.DocumentReference,
                                                                                                    ),
                                                                                                    'index': serializeParam(
                                                                                                      imagesIndex,
                                                                                                      ParamType.int,
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
                                                                                                        imagesItem,
                                                                                                        fit: BoxFit.contain,
                                                                                                      ),
                                                                                                      allowRotation: false,
                                                                                                      tag: imagesItem,
                                                                                                      useHeroAnimation: true,
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                              child: Hero(
                                                                                                tag: imagesItem,
                                                                                                transitionOnUserGestures: true,
                                                                                                child: ClipRRect(
                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                  child: Image.network(
                                                                                                    imagesItem,
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      }),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    'Student_gallery',
                                                                                    queryParameters: {
                                                                                      'student': serializeParam(
                                                                                        studentListItem.reference,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  width: 80.0,
                                                                                  height: 100.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                    border: Border.all(
                                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                                    ),
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                    child: Text(
                                                                                      'View \nAll',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(const SizedBox(height: 5.0)).around(
                                                                              const SizedBox(height: 5.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].addToEnd(const SizedBox(
                                                                height: 30.0)),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
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
                                  child: Align(
                                    alignment: const AlignmentDirectional(0.0, 1.0),
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: NavbarParentWidget(
                                            pageno: 1,
                                            schoolref:
                                                navbarParentStudentsRecord!
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Lottie.asset(
                                'assets/jsons/Animation_-_1731063439059.json',
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                height: MediaQuery.sizeOf(context).height * 0.6,
                                fit: BoxFit.contain,
                                animate: true,
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Your Session has been expired',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 25.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(
                                  'Login',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                    ),
                                  },
                                );
                              },
                              text: 'Log In',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 21.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
