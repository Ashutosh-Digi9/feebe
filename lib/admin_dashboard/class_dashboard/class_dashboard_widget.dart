import '/admin_dashboard/edit_delete_school/edit_delete_school_widget.dart';
import '/admin_dashboard/select_class_notice/select_class_notice_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/empty_class_widget.dart';
import '/components/empty_widget.dart';
import '/components/emptystudent_widget.dart';
import '/components/quick_action_for_class_widget.dart';
import '/components/upcomingevent_teacher_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import '/shimmer_effects/class_dashboard_shimmer/class_dashboard_shimmer_widget.dart';
import '/teacher/teacher_notice_comp/teacher_notice_comp_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'class_dashboard_model.dart';
export 'class_dashboard_model.dart';

class ClassDashboardWidget extends StatefulWidget {
  const ClassDashboardWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  @override
  State<ClassDashboardWidget> createState() => _ClassDashboardWidgetState();
}

class _ClassDashboardWidgetState extends State<ClassDashboardWidget>
    with TickerProviderStateMixin {
  late ClassDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassDashboardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.date = getCurrentTimestamp;
      safeSetState(() {});
      _model.school = await SchoolRecord.getDocumentOnce(widget.schoolref!);
      if (_model.school?.popupdate != null) {
        if (dateTimeFormat("yMd", _model.school?.popupdate) !=
            dateTimeFormat("yMd", getCurrentTimestamp)) {
          if (_model.school?.listOfNotice
                  .where((e) => !functions.isDatePassed(e.eventDate!))
                  .toList().isNotEmpty) {
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
                      schoolref: widget.schoolref!,
                    ),
                  ),
                );
              },
            );

            await widget.schoolref!.update(createSchoolRecordData(
              popupdate: getCurrentTimestamp,
            ));
          }
        }
      } else {
        if (_model.school?.listOfNotice
                .where((e) => !functions.isDatePassed(e.eventDate!))
                .toList().isNotEmpty) {
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
                    schoolref: widget.schoolref!,
                  ),
                ),
              );
            },
          );

          await widget.schoolref!.update(createSchoolRecordData(
            popupdate: getCurrentTimestamp,
          ));
        }
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.titleTextController ??= TextEditingController();
    _model.titleFocusNode ??= FocusNode();

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
    return Builder(
      builder: (context) => StreamBuilder<SchoolRecord>(
        stream: SchoolRecord.getDocument(widget.schoolref!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).tertiary,
              body: const ClassDashboardShimmerWidget(),
            );
          }

          final classDashboardSchoolRecord = snapshot.data!;

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
                    Icons.dashboard_sharp,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 25.0,
                  ),
                  onPressed: () async {
                    context.goNamed('Dashboard');
                  },
                ),
                title: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/eebe_(500_x_200_px).png',
                    width: 100.0,
                    height: 50.0,
                    fit: BoxFit.contain,
                  ),
                ),
                actions: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          'SearchPage_admin',
                          queryParameters: {
                            'schoolref': serializeParam(
                              widget.schoolref,
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
                      child: Icon(
                        Icons.search,
                        color: FlutterFlowTheme.of(context).alternate,
                        size: 30.0,
                      ),
                    ),
                  ),
                  AuthUserStreamWidget(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('EditProfile_SA');
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.15,
                        height: MediaQuery.sizeOf(context).width * 0.15,
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
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/error_image.png',
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
                      SingleChildScrollView(
                        primary: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 5.0, 0.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.15,
                                      height: MediaQuery.sizeOf(context).width *
                                          0.15,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          classDashboardSchoolRecord
                                              .schoolDetails.schoolImage,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/feebe-n1t92v/assets/euqc6305sfyt/%F0%9F%94%A5_Ellipse_38.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.7,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.1,
                                        decoration: const BoxDecoration(),
                                        child: Align(
                                          alignment:
                                              const AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              classDashboardSchoolRecord
                                                  .schoolDetails.schoolName,
                                              textAlign: TextAlign.start,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Nunito',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    fontSize: 20.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.8,
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 0.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: const Alignment(0.0, 0),
                                      child: FlutterFlowButtonTabBar(
                                        useToggleButtonStyle: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              letterSpacing: 0.0,
                                            ),
                                        unselectedLabelStyle:
                                            FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  letterSpacing: 0.0,
                                                ),
                                        labelColor:
                                            FlutterFlowTheme.of(context).text1,
                                        unselectedLabelColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                        unselectedBackgroundColor:
                                            const Color(0xFFF0F0F0),
                                        borderColor: const Color(0xFFF0F0F0),
                                        borderWidth: 2.0,
                                        borderRadius: 12.0,
                                        elevation: 0.0,
                                        buttonMargin:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                8.0, 0.0, 8.0, 0.0),
                                        tabs: const [
                                          Tab(
                                            text: 'Classes',
                                          ),
                                          Tab(
                                            text: 'Notices',
                                          ),
                                          Tab(
                                            text: 'Calendar',
                                          ),
                                          Tab(
                                            text: 'Academy',
                                          ),
                                        ],
                                        controller: _model.tabBarController,
                                        onTap: (i) async {
                                          [
                                            () async {},
                                            () async {},
                                            () async {},
                                            () async {}
                                          ][i]();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _model.tabBarController,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.95,
                                              decoration: const BoxDecoration(),
                                              child: SingleChildScrollView(
                                                primary: false,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    if (classDashboardSchoolRecord
                                                            .listOfTeachers.isEmpty)
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: InkWell(
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
                                                              'add_Teacher_manually_Admin',
                                                              queryParameters: {
                                                                'schoolRef':
                                                                    serializeParam(
                                                                  widget
                                                                      .schoolref,
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
                                                                      PageTransitionType
                                                                          .fade,
                                                                ),
                                                              },
                                                            );
                                                          },
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Color(
                                                                      0xFFEADFFF),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.12,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.12,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Add_profile_pic_(2).png',
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'No Teacher Yet',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontSize:
                                                                          13.0,
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
                                                      ),
                                                    if (classDashboardSchoolRecord
                                                            .listOfTeachers.isNotEmpty)
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final teachers =
                                                                classDashboardSchoolRecord
                                                                    .teachersDataList
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
                                                                        .start,
                                                                children: List.generate(
                                                                    teachers
                                                                        .length,
                                                                    (teachersIndex) {
                                                                  final teachersItem =
                                                                      teachers[
                                                                          teachersIndex];
                                                                  return Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child: StreamBuilder<
                                                                          UsersRecord>(
                                                                        stream:
                                                                            UsersRecord.getDocument(teachersItem.userRef!),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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

                                                                          final containerUsersRecord =
                                                                              snapshot.data!;

                                                                          return Container(
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                    child: StreamBuilder<TeachersRecord>(
                                                                                      stream: TeachersRecord.getDocument(teachersItem.teachersId!),
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

                                                                                        final containerTeachersRecord = snapshot.data!;

                                                                                        return Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                          height: MediaQuery.sizeOf(context).width * 0.15,
                                                                                          decoration: BoxDecoration(
                                                                                            color: const Color(0xFFEADFFF),
                                                                                            shape: BoxShape.circle,
                                                                                            border: Border.all(
                                                                                              color: ((containerUsersRecord.checkin != null) && (dateTimeFormat("yMMMd", containerUsersRecord.checkin) == dateTimeFormat("yMMMd", getCurrentTimestamp))) && (containerTeachersRecord.teacherAttendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)).toList().isEmpty) ? FlutterFlowTheme.of(context).checkBg : FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              width: 2.0,
                                                                                            ),
                                                                                          ),
                                                                                          child: Stack(
                                                                                            alignment: const AlignmentDirectional(1.0, 1.0),
                                                                                            children: [
                                                                                              Container(
                                                                                                width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                                height: MediaQuery.sizeOf(context).width * 0.15,
                                                                                                clipBehavior: Clip.antiAlias,
                                                                                                decoration: const BoxDecoration(
                                                                                                  shape: BoxShape.circle,
                                                                                                ),
                                                                                                child: Image.network(
                                                                                                  teachersItem.teacherImage,
                                                                                                  fit: BoxFit.contain,
                                                                                                ),
                                                                                              ),
                                                                                              if ((containerUsersRecord.checkin != null) && (dateTimeFormat("yMMMd", containerUsersRecord.checkin) == dateTimeFormat("yMMMd", getCurrentTimestamp)))
                                                                                                Icon(
                                                                                                  Icons.check_circle,
                                                                                                  color: FlutterFlowTheme.of(context).checkBg,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                    child: Text(
                                                                                      teachersItem.teacherName,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            fontSize: 15.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  10.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          context.pushNamed(
                                                            'AddClassAdmin',
                                                            queryParameters: {
                                                              'schoolref':
                                                                  serializeParam(
                                                                widget
                                                                    .schoolref,
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
                                                                    PageTransitionType
                                                                        .fade,
                                                              ),
                                                            },
                                                          );
                                                        },
                                                        text: 'Add Class',
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.06,
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                          elevation: 3.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            width: 0.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
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
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      20.0),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final schoolsclass =
                                                                  classDashboardSchoolRecord
                                                                      .listOfClass
                                                                      .toList();
                                                              if (schoolsclass
                                                                  .isEmpty) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        MediaQuery.sizeOf(context).height *
                                                                            0.2,
                                                                    child:
                                                                        const EmptyClassWidget(),
                                                                  ),
                                                                );
                                                              }

                                                              return ListView
                                                                  .builder(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  20.0,
                                                                ),
                                                                primary: false,
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    schoolsclass
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        schoolsclassIndex) {
                                                                  final schoolsclassItem =
                                                                      schoolsclass[
                                                                          schoolsclassIndex];
                                                                  return Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            10.0),
                                                                    child: StreamBuilder<
                                                                        SchoolClassRecord>(
                                                                      stream: SchoolClassRecord
                                                                          .getDocument(
                                                                              schoolsclassItem),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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

                                                                        final containerSchoolClassRecord =
                                                                            snapshot.data!;

                                                                        return InkWell(
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
                                                                            context.pushNamed(
                                                                              'Class_view',
                                                                              queryParameters: {
                                                                                'schoolclassref': serializeParam(
                                                                                  containerSchoolClassRecord.reference,
                                                                                  ParamType.DocumentReference,
                                                                                ),
                                                                                'schoolref': serializeParam(
                                                                                  widget.schoolref,
                                                                                  ParamType.DocumentReference,
                                                                                ),
                                                                              }.withoutNulls,
                                                                            );
                                                                          },
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                5.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.7,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    blurRadius: 4.0,
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                    offset: const Offset(
                                                                                      2.0,
                                                                                      2.0,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                          child: Container(
                                                                                            height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                            decoration: const BoxDecoration(),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Class :  ${containerSchoolClassRecord.className}',
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Nunito',
                                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                          fontSize: 16.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    'Students :  ${containerSchoolClassRecord.studentsList.length.toString()}',
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
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                        child: FlutterFlowIconButton(
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
                                                                                                      schoolref: widget.schoolref!,
                                                                                                      classref: schoolsclassItem,
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
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                      children: [
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            if (containerSchoolClassRecord.attendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)).toList().isNotEmpty) {
                                                                                              context.goNamed(
                                                                                                'mark_attendence',
                                                                                                queryParameters: {
                                                                                                  'classRef': serializeParam(
                                                                                                    schoolsclassItem,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                  'schoolref': serializeParam(
                                                                                                    widget.schoolref,
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
                                                                                              context.pushNamed(
                                                                                                'class_attendence',
                                                                                                queryParameters: {
                                                                                                  'classRef': serializeParam(
                                                                                                    containerSchoolClassRecord.reference,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                  'schoolref': serializeParam(
                                                                                                    classDashboardSchoolRecord.reference,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
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
                                                                                                    if (containerSchoolClassRecord.attendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)).toList().isNotEmpty)
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
                                                                                              Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  'Attendance',
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
                                                                                        Align(
                                                                                          alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              context.pushNamed(
                                                                                                'calender_class',
                                                                                                queryParameters: {
                                                                                                  'schoolclassref': serializeParam(
                                                                                                    containerSchoolClassRecord.reference,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                  'schoolref': serializeParam(
                                                                                                    classDashboardSchoolRecord.reference,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                              );
                                                                                            },
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
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
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                                                                                                    child: Text(
                                                                                                      'Class\nCalendar',
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
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            context.goNamed(
                                                                                              'ClassNotice_Admin_Teacher',
                                                                                              queryParameters: {
                                                                                                'classref': serializeParam(
                                                                                                  containerSchoolClassRecord.reference,
                                                                                                  ParamType.DocumentReference,
                                                                                                ),
                                                                                                'schoolref': serializeParam(
                                                                                                  widget.schoolref,
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
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    'Class Notice \nboard',
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
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
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
                                                      ),
                                                    ),
                                                  ].divide(
                                                      const SizedBox(height: 5.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 20.0),
                                            child: SingleChildScrollView(
                                              primary: false,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                            _model.date = functions
                                                                .prevDate(_model
                                                                    .date);
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .chevron_left_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 28.0,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Text(
                                                              dateTimeFormat(
                                                                  "yMMMd",
                                                                  _model.date),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
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
                                                            _model.date = functions
                                                                .nextDate(_model
                                                                    .date);
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .navigate_next_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 28.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (!functions.isDatePassed(
                                                      _model.date!))
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(10.0),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 1.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
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
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    10.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'New Notice',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Nunito',
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.9,
                                                                  decoration:
                                                                      const BoxDecoration(),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children:
                                                                            [
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
                                                                              _model.noticename = 'Notice';
                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                border: Border.all(
                                                                                  color: valueOrDefault<Color>(
                                                                                    _model.noticename == 'Notice' ? const Color(0xFFC29800) : FlutterFlowTheme.of(context).text,
                                                                                    FlutterFlowTheme.of(context).text,
                                                                                  ),
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
                                                                                      color: FlutterFlowTheme.of(context).warning,
                                                                                      size: 20.0,
                                                                                    ),
                                                                                    Text(
                                                                                      'Notice',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: valueOrDefault<Color>(
                                                                                              _model.noticename == 'Notice' ? const Color(0xFFC29800) : FlutterFlowTheme.of(context).text,
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
                                                                              _model.noticename = 'Holiday';
                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                border: Border.all(
                                                                                  color: valueOrDefault<Color>(
                                                                                    _model.noticename == 'Holiday' ? const Color(0xFFC29800) : FlutterFlowTheme.of(context).text,
                                                                                    FlutterFlowTheme.of(context).text,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.celebration_sharp,
                                                                                      color: FlutterFlowTheme.of(context).warning,
                                                                                      size: 20.0,
                                                                                    ),
                                                                                    Text(
                                                                                      'Holiday',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: valueOrDefault<Color>(
                                                                                              _model.noticename == 'Holiday' ? const Color(0xFFC29800) : FlutterFlowTheme.of(context).text,
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
                                                                              _model.noticename = 'Home work';
                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                border: Border.all(
                                                                                  color: valueOrDefault<Color>(
                                                                                    _model.noticename == 'Home work' ? const Color(0xFFC29800) : FlutterFlowTheme.of(context).text,
                                                                                    FlutterFlowTheme.of(context).text,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.home_work_outlined,
                                                                                      color: FlutterFlowTheme.of(context).warning,
                                                                                      size: 20.0,
                                                                                    ),
                                                                                    Text(
                                                                                      'Home work',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: valueOrDefault<Color>(
                                                                                              _model.noticename == 'Home work' ? const Color(0xFFC29800) : FlutterFlowTheme.of(context).text,
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
                                                                              _model.noticename = 'Assignment';
                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                border: Border.all(
                                                                                  color: valueOrDefault<Color>(
                                                                                    _model.noticename == 'Assignment' ? const Color(0xFFC29800) : FlutterFlowTheme.of(context).text,
                                                                                    FlutterFlowTheme.of(context).text,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.assignment,
                                                                                      color: FlutterFlowTheme.of(context).warning,
                                                                                      size: 20.0,
                                                                                    ),
                                                                                    Text(
                                                                                      'Assignment',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: valueOrDefault<Color>(
                                                                                              _model.noticename == 'Assignment' ? const Color(0xFFC29800) : FlutterFlowTheme.of(context).text,
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
                                                                ),
                                                                Form(
                                                                  key: _model
                                                                      .formKey,
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .disabled,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.9,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                _model.titleTextController,
                                                                            focusNode:
                                                                                _model.titleFocusNode,
                                                                            autofocus:
                                                                                false,
                                                                            textCapitalization:
                                                                                TextCapitalization.sentences,
                                                                            obscureText:
                                                                                false,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              isDense: true,
                                                                              labelText: 'Title',
                                                                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    color: valueOrDefault<Color>(
                                                                                      (_model.titleFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                                                                                      FlutterFlowTheme.of(context).alternate,
                                                                                    ),
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
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                            maxLines:
                                                                                2,
                                                                            maxLength:
                                                                                25,
                                                                            buildCounter: (context, {required currentLength, required isFocused, maxLength}) =>
                                                                                null,
                                                                            cursorColor:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            validator:
                                                                                _model.titleTextControllerValidator.asValidator(context),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.9,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                _model.descriptionTextController,
                                                                            focusNode:
                                                                                _model.descriptionFocusNode,
                                                                            autofocus:
                                                                                false,
                                                                            textCapitalization:
                                                                                TextCapitalization.sentences,
                                                                            obscureText:
                                                                                false,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              isDense: true,
                                                                              labelText: 'Description',
                                                                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    color: valueOrDefault<Color>(
                                                                                      (_model.descriptionFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                                                                                      FlutterFlowTheme.of(context).alternate,
                                                                                    ),
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
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                            maxLines:
                                                                                4,
                                                                            cursorColor:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            validator:
                                                                                _model.descriptionTextControllerValidator.asValidator(context),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      const BoxDecoration(),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      final imagesview = _model
                                                                          .uploadedFileUrls
                                                                          .toList();

                                                                      return GridView
                                                                          .builder(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        gridDelegate:
                                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              5,
                                                                          crossAxisSpacing:
                                                                              10.0,
                                                                          mainAxisSpacing:
                                                                              10.0,
                                                                          childAspectRatio:
                                                                              1.0,
                                                                        ),
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        itemCount:
                                                                            imagesview.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                imagesviewIndex) {
                                                                          final imagesviewItem =
                                                                              imagesview[imagesviewIndex];
                                                                          return ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.network(
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
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    FlutterFlowIconButton(
                                                                      borderColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .alternate,
                                                                      borderRadius:
                                                                          8.0,
                                                                      borderWidth:
                                                                          0.2,
                                                                      buttonSize:
                                                                          40.0,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .attach_file,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        final selectedMedia =
                                                                            await selectMedia(
                                                                          mediaSource:
                                                                              MediaSource.photoGallery,
                                                                          multiImage:
                                                                              true,
                                                                        );
                                                                        if (selectedMedia !=
                                                                                null &&
                                                                            selectedMedia.every((m) =>
                                                                                validateFileFormat(m.storagePath, context))) {
                                                                          safeSetState(() =>
                                                                              _model.isDataUploading = true);
                                                                          var selectedUploadedFiles =
                                                                              <FFUploadedFile>[];

                                                                          var downloadUrls =
                                                                              <String>[];
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
                                                                            _model.isDataUploading =
                                                                                false;
                                                                          }
                                                                          if (selectedUploadedFiles.length == selectedMedia.length &&
                                                                              downloadUrls.length == selectedMedia.length) {
                                                                            safeSetState(() {
                                                                              _model.uploadedLocalFiles = selectedUploadedFiles;
                                                                              _model.uploadedFileUrls = downloadUrls;
                                                                            });
                                                                            showUploadMessage(context,
                                                                                'Success!');
                                                                          } else {
                                                                            safeSetState(() {});
                                                                            showUploadMessage(context,
                                                                                'Failed to upload data');
                                                                            return;
                                                                          }
                                                                        }

                                                                        _model.images = _model
                                                                            .uploadedFileUrls
                                                                            .toList()
                                                                            .cast<String>();
                                                                        safeSetState(
                                                                            () {});
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'File uploaded',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                const Duration(milliseconds: 1700),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                    FFButtonWidget(
                                                                      onPressed: (classDashboardSchoolRecord.listOfStudents.isEmpty)
                                                                          ? null
                                                                          : () async {
                                                                              if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) {
                                                                                return;
                                                                              }
                                                                              if (_model.noticename != null && _model.noticename != '') {
                                                                                if (_model.uploadedFileUrls.isEmpty) {
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
                                                                                              schoolref: widget.schoolref!,
                                                                                              eventtitle: _model.titleTextController.text,
                                                                                              description: _model.descriptionTextController.text,
                                                                                              datetime: _model.date!,
                                                                                              eventname: _model.noticename!,
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
                                                                                              schoolref: widget.schoolref!,
                                                                                              eventtitle: _model.titleTextController.text,
                                                                                              description: _model.descriptionTextController.text,
                                                                                              datetime: _model.date!,
                                                                                              images: _model.uploadedFileUrls,
                                                                                              eventname: _model.noticename!,
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
                                                                                      'Please pick notice name ',
                                                                                      style: TextStyle(
                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                      ),
                                                                                    ),
                                                                                    duration: const Duration(milliseconds: 4000),
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                );
                                                                              }
                                                                            },
                                                                      text:
                                                                          'Create notice',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.5,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.05,
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        disabledColor:
                                                                            FlutterFlowTheme.of(context).dIsable,
                                                                        disabledTextColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    ),
                                                                  ],
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 20.0),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    20.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final notices = classDashboardSchoolRecord
                                                                .listOfNotice
                                                                .where((e) =>
                                                                    dateTimeFormat(
                                                                        "yMMMd",
                                                                        e
                                                                            .eventDate) ==
                                                                    dateTimeFormat(
                                                                        "yMMMd",
                                                                        _model
                                                                            .date))
                                                                .toList();
                                                            if (notices
                                                                .isEmpty) {
                                                              return SizedBox(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.4,
                                                                child:
                                                                    const EmptyWidget(),
                                                              );
                                                            }

                                                            return ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount: notices
                                                                  .length,
                                                              itemBuilder: (context,
                                                                  noticesIndex) {
                                                                final noticesItem =
                                                                    notices[
                                                                        noticesIndex];
                                                                return Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
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
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                      border: Border.all(
                                                                                        color: FlutterFlowTheme.of(context).success,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: [
                                                                                          if (noticesItem.eventName == 'Notice')
                                                                                            Icon(
                                                                                              Icons.push_pin,
                                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                                              size: 20.0,
                                                                                            ),
                                                                                          if (noticesItem.eventName == 'Holiday')
                                                                                            Icon(
                                                                                              Icons.celebration_sharp,
                                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                                              size: 20.0,
                                                                                            ),
                                                                                          if (noticesItem.eventName == 'Home work')
                                                                                            Icon(
                                                                                              Icons.home_work_outlined,
                                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                                              size: 20.0,
                                                                                            ),
                                                                                          if (noticesItem.eventName == 'Assignment')
                                                                                            Icon(
                                                                                              Icons.assignment,
                                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                                              size: 20.0,
                                                                                            ),
                                                                                          Text(
                                                                                            noticesItem.eventName,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  fontSize: 14.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                          ),
                                                                                        ].divide(const SizedBox(width: 10.0)).around(const SizedBox(width: 10.0)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  if (!functions.isDatePassed(noticesItem.eventDate!) && (dateTimeFormat("yMd", noticesItem.eventDate) != dateTimeFormat("yMd", getCurrentTimestamp)))
                                                                                    Builder(
                                                                                      builder: (context) => FlutterFlowIconButton(
                                                                                        borderColor: const Color(0xFFCDCDCD),
                                                                                        borderRadius: 40.0,
                                                                                        buttonSize: MediaQuery.sizeOf(context).width * 0.1,
                                                                                        icon: Icon(
                                                                                          Icons.more_vert,
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          size: 20.0,
                                                                                        ),
                                                                                        onPressed: () async {
                                                                                          if (noticesItem.eventImages.isEmpty) {
                                                                                            await showAlignedDialog(
                                                                                              context: context,
                                                                                              isGlobal: false,
                                                                                              avoidOverflow: false,
                                                                                              targetAnchor: const AlignmentDirectional(1.0, 0.0).resolve(Directionality.of(context)),
                                                                                              followerAnchor: const AlignmentDirectional(1.0, 0.0).resolve(Directionality.of(context)),
                                                                                              builder: (dialogContext) {
                                                                                                return Material(
                                                                                                  color: Colors.transparent,
                                                                                                  child: GestureDetector(
                                                                                                    onTap: () {
                                                                                                      FocusScope.of(dialogContext).unfocus();
                                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                                    },
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.sizeOf(context).height * 0.12,
                                                                                                      width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                                      child: EditDeleteSchoolWidget(
                                                                                                        eventid: noticesItem.eventId,
                                                                                                        event: EventsNoticeStruct(
                                                                                                          eventId: noticesItem.eventId,
                                                                                                          eventTitle: noticesItem.eventTitle,
                                                                                                          eventDescription: noticesItem.eventDescription,
                                                                                                          eventDate: noticesItem.eventDate,
                                                                                                          eventName: noticesItem.eventName,
                                                                                                        ),
                                                                                                        noticebool: true,
                                                                                                        schoolref: widget.schoolref!,
                                                                                                        schoolcal: false,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          } else {
                                                                                            await showAlignedDialog(
                                                                                              context: context,
                                                                                              isGlobal: false,
                                                                                              avoidOverflow: false,
                                                                                              targetAnchor: const AlignmentDirectional(1.0, 0.0).resolve(Directionality.of(context)),
                                                                                              followerAnchor: const AlignmentDirectional(1.0, 0.0).resolve(Directionality.of(context)),
                                                                                              builder: (dialogContext) {
                                                                                                return Material(
                                                                                                  color: Colors.transparent,
                                                                                                  child: GestureDetector(
                                                                                                    onTap: () {
                                                                                                      FocusScope.of(dialogContext).unfocus();
                                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                                    },
                                                                                                    child: SizedBox(
                                                                                                      height: MediaQuery.sizeOf(context).height * 0.12,
                                                                                                      width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                                      child: EditDeleteSchoolWidget(
                                                                                                        eventid: noticesItem.eventId,
                                                                                                        event: EventsNoticeStruct(
                                                                                                          eventId: noticesItem.eventId,
                                                                                                          eventTitle: noticesItem.eventTitle,
                                                                                                          eventDescription: noticesItem.eventDescription,
                                                                                                          eventDate: noticesItem.eventDate,
                                                                                                          eventImages: noticesItem.eventImages,
                                                                                                          eventName: noticesItem.eventName,
                                                                                                        ),
                                                                                                        noticebool: true,
                                                                                                        schoolref: widget.schoolref!,
                                                                                                        schoolcal: false,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                ].divide(const SizedBox(width: 10.0)),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                                                                                  child: Text(
                                                                                    dateTimeFormat("yMMMd", noticesItem.eventDate!),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                    child: Text(
                                                                                      noticesItem.eventTitle,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                            fontSize: 14.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              noticesItem.eventDescription,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  final images1 = noticesItem.eventImages.toList();

                                                                                  return Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: List.generate(images1.length, (images1Index) {
                                                                                      final images1Item = images1[images1Index];
                                                                                      return Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
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
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ].addToEnd(const SizedBox(height: 10.0)),
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
                                                ].addToEnd(
                                                    const SizedBox(height: 20.0)),
                                              ),
                                            ),
                                          ),
                                          RefreshIndicator(
                                            onRefresh: () async {},
                                            child: SingleChildScrollView(
                                              primary: false,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                              child: Text(
                                                                'Select a date to add an event.',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
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
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                        ),
                                                      ),
                                                      child: SizedBox(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.65,
                                                        child: custom_widgets
                                                            .Timelinewidgetdatatype(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.65,
                                                          timrlinewidget:
                                                              classDashboardSchoolRecord
                                                                  .calendarList,
                                                          schoolref: widget
                                                              .schoolref!,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 10.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.pageno = 0;
                                                          safeSetState(() {});
                                                          await _model
                                                              .pageViewController
                                                              ?.animateToPage(
                                                            0,
                                                            duration: const Duration(
                                                                milliseconds:
                                                                    500),
                                                            curve: Curves.ease,
                                                          );
                                                        },
                                                        text: 'Teachers',
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.04,
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: _model
                                                                      .pageno ==
                                                                  0
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryBackground
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: _model.pageno ==
                                                                            0
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .secondaryText
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        showLoadingIndicator:
                                                            false,
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.pageno = 1;
                                                          safeSetState(() {});
                                                          await _model
                                                              .pageViewController
                                                              ?.animateToPage(
                                                            1,
                                                            duration: const Duration(
                                                                milliseconds:
                                                                    500),
                                                            curve: Curves.ease,
                                                          );
                                                        },
                                                        text: 'Students',
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.04,
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: _model
                                                                      .pageno ==
                                                                  1
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primary
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: _model.pageno ==
                                                                            1
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .secondaryText
                                                                        : FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        showLoadingIndicator:
                                                            false,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 500.0,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    40.0),
                                                        child: PageView(
                                                          controller: _model
                                                                  .pageViewController ??=
                                                              PageController(
                                                                  initialPage:
                                                                      0),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                              child:
                                                                  SingleChildScrollView(
                                                                primary: false,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () async {
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
                                                                                      height: MediaQuery.sizeOf(context).height * 0.8,
                                                                                      child: TeacherNoticeCompWidget(
                                                                                        school: classDashboardSchoolRecord.reference,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ).then((value) =>
                                                                                safeSetState(() {}));
                                                                          },
                                                                          text:
                                                                              'Add Notice',
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.add,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                40.0,
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                16.0,
                                                                                0.0,
                                                                                16.0,
                                                                                0.0),
                                                                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                            elevation:
                                                                                5.0,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                          'add_Teacher_manually_Admin',
                                                                          queryParameters:
                                                                              {
                                                                            'schoolRef':
                                                                                serializeParam(
                                                                              widget.schoolref,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                          }.withoutNulls,
                                                                          extra: <String,
                                                                              dynamic>{
                                                                            kTransitionInfoKey:
                                                                                const TransitionInfo(
                                                                              hasTransition: true,
                                                                              transitionType: PageTransitionType.fade,
                                                                            ),
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.3,
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              5.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.15,
                                                                                height: MediaQuery.sizeOf(context).width * 0.15,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Color(0xFFEADFFF),
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
                                                                                          'assets/images/Avatar_Placeholder.png',
                                                                                          fit: BoxFit.contain,
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
                                                                                  'Add Teacher',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Inter',
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ].divide(const SizedBox(height: 5.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          20.0),
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final teachersSchool = classDashboardSchoolRecord
                                                                              .teachersDataList
                                                                              .toList();

                                                                          return GridView
                                                                              .builder(
                                                                            padding:
                                                                                const EdgeInsets.fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              20.0,
                                                                            ),
                                                                            gridDelegate:
                                                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                                              crossAxisCount: 3,
                                                                              crossAxisSpacing: 20.0,
                                                                              mainAxisSpacing: 10.0,
                                                                              childAspectRatio: 1.0,
                                                                            ),
                                                                            primary:
                                                                                false,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            itemCount:
                                                                                teachersSchool.length,
                                                                            itemBuilder:
                                                                                (context, teachersSchoolIndex) {
                                                                              final teachersSchoolItem = teachersSchool[teachersSchoolIndex];
                                                                              return Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    context.pushNamed(
                                                                                      'Teacher_profile',
                                                                                      queryParameters: {
                                                                                        'teacherRef': serializeParam(
                                                                                          teachersSchoolItem.teachersId,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                        'schoolref': serializeParam(
                                                                                          widget.schoolref,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: const BoxDecoration(),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                          height: MediaQuery.sizeOf(context).width * 0.25,
                                                                                          clipBehavior: Clip.antiAlias,
                                                                                          decoration: const BoxDecoration(
                                                                                            shape: BoxShape.circle,
                                                                                          ),
                                                                                          child: Image.network(
                                                                                            teachersSchoolItem.teacherImage,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            teachersSchoolItem.teacherName,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w500,
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
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ].addToEnd(
                                                                      const SizedBox(
                                                                          height:
                                                                              20.0)),
                                                                ),
                                                              ),
                                                            ),
                                                            Stack(
                                                              children: [
                                                                SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.5,
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Total Student - ${classDashboardSchoolRecord.listOfStudents.length.toString()}',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(10.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 20.0,
                                                                                        height: 20.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                          shape: BoxShape.circle,
                                                                                          border: Border.all(
                                                                                            color: FlutterFlowTheme.of(context).text1,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'No Border: This is a new student who has \nnot been added to any class yet.',
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Nunito',
                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(10.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 20.0,
                                                                                        height: 20.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).checkBg,
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Green Border: This student already exists\nin one or more classes.',
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Nunito',
                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                              fontSize: 14.0,
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Container(
                                                                              height: MediaQuery.sizeOf(context).height * 0.4,
                                                                              decoration: const BoxDecoration(),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(10.0),
                                                                                child: Builder(
                                                                                  builder: (context) {
                                                                                    final students = classDashboardSchoolRecord.studentDataList.toList();
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
                                                                                      padding: EdgeInsets.zero,
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
                                                                                        return InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            if (studentsItem.classref.isNotEmpty) {
                                                                                              context.pushNamed(
                                                                                                'IndiStudentAdmin',
                                                                                                queryParameters: {
                                                                                                  'studentsref': serializeParam(
                                                                                                    studentsItem.studentId,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                  'schoolref': serializeParam(
                                                                                                    classDashboardSchoolRecord.reference,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                  'classref': serializeParam(
                                                                                                    studentsItem.classref,
                                                                                                    ParamType.DocumentReference,
                                                                                                    isList: true,
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
                                                                                                    classDashboardSchoolRecord.reference,
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
                                                                                          },
                                                                                          child: Stack(
                                                                                            children: [
                                                                                              Material(
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
                                                                                                        studentsItem.classref.isNotEmpty ? FlutterFlowTheme.of(context).checkBg : FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                        FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      ),
                                                                                                      width: 3.0,
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
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child:
                                                                        FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        context
                                                                            .pushNamed(
                                                                          'add_student_manually',
                                                                          queryParameters:
                                                                              {
                                                                            'schoolref':
                                                                                serializeParam(
                                                                              widget.schoolref,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      },
                                                                      text:
                                                                          'Register New Student',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.8,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.05,
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              color: Colors.white,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 1.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      16.0),
                                                          child: smooth_page_indicator
                                                              .SmoothPageIndicator(
                                                            controller: _model
                                                                    .pageViewController ??=
                                                                PageController(
                                                                    initialPage:
                                                                        0),
                                                            count: 2,
                                                            axisDirection:
                                                                Axis.horizontal,
                                                            onDotClicked:
                                                                (i) async {
                                                              await _model
                                                                  .pageViewController!
                                                                  .animateToPage(
                                                                i,
                                                                duration: const Duration(
                                                                    milliseconds:
                                                                        500),
                                                                curve:
                                                                    Curves.ease,
                                                              );
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            effect:
                                                                smooth_page_indicator
                                                                    .SlideEffect(
                                                              spacing: 8.0,
                                                              radius: 8.0,
                                                              dotWidth: 8.0,
                                                              dotHeight: 8.0,
                                                              dotColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .accent1,
                                                              activeDotColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              paintStyle:
                                                                  PaintingStyle
                                                                      .fill,
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
                                        ],
                                      ),
                                    ),
                                  ],
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
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          decoration: const BoxDecoration(),
                          child: wrapWithModel(
                            model: _model.navbaradminModel,
                            updateCallback: () => safeSetState(() {}),
                            child: NavbaradminWidget(
                              pageno: 1,
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
      ),
    );
  }
}
