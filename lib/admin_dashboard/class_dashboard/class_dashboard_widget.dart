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
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import '/shimmer_effects/addclasss_shimmer/addclasss_shimmer_widget.dart';
import '/shimmer_effects/class_dashboard_shimmer/class_dashboard_shimmer_widget.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import '/shimmer_effects/teacher_shimmer/teacher_shimmer_widget.dart';
import '/teacher/teacher_notice_comp/teacher_notice_comp_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'class_dashboard_model.dart';
export 'class_dashboard_model.dart';

class ClassDashboardWidget extends StatefulWidget {
  const ClassDashboardWidget({
    super.key,
    required this.schoolref,
    int? tabindex,
    String? classname,
  })  : tabindex = tabindex ?? 0,
        classname = classname ?? 'All';

  final DocumentReference? schoolref;
  final int tabindex;
  final String classname;

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
      FFAppState().studentimage = '';
      FFAppState().eventnoticeimage = [];
      safeSetState(() {});
      _model.date = getCurrentTimestamp;
      _model.pageno = 0;
      safeSetState(() {});
      safeSetState(() {
        _model.titleTextController?.clear();
        _model.descriptionTextController?.clear();
      });
      _model.school = await SchoolRecord.getDocumentOnce(widget.schoolref!);
      if (_model.school?.popupdate != null) {
        if (dateTimeFormat("yMd", _model.school?.popupdate) !=
            dateTimeFormat("yMd", getCurrentTimestamp)) {
          if (functions
                  .filterEventsAfterTwoDays(
                      _model.school!.calendarList.toList(), getCurrentTimestamp).isNotEmpty) {
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
        if (functions
                .filterEventsAfterTwoDays(
                    _model.school!.calendarList.toList(), getCurrentTimestamp).isNotEmpty) {
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
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => StreamBuilder<SchoolRecord>(
        stream: SchoolRecord.getDocument(widget.schoolref!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
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
              backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
              floatingActionButton: Visibility(
                visible: (_model.tabBarCurrentIndex == 2) &&
                    (valueOrDefault(currentUserDocument?.userRole, 0) != 1),
                child: Align(
                  alignment: const AlignmentDirectional(1.0, 0.8),
                  child: AuthUserStreamWidget(
                    builder: (context) => FloatingActionButton(
                      onPressed: () async {
                        context.pushNamed(
                          'add_events_details',
                          queryParameters: {
                            'selectedDate': serializeParam(
                              getCurrentTimestamp,
                              ParamType.DateTime,
                            ),
                            'schoolRef': serializeParam(
                              widget.schoolref,
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
              ),
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).info,
                automaticallyImplyLeading: false,
                leading: StreamBuilder<List<SchoolRecord>>(
                  stream: querySchoolRecord(
                    queryBuilder: (schoolRecord) => schoolRecord.where(
                      'principal_details.principal_id',
                      isEqualTo: classDashboardSchoolRecord
                          .principalDetails.principalId,
                    ),
                  ),
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
                    List<SchoolRecord> containerSchoolRecordList =
                        snapshot.data!;

                    return Container(
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if ((valueOrDefault(
                                      currentUserDocument?.userRole, 0) ==
                                  2) &&
                              (containerSchoolRecordList.length != 1))
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 5.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 60.0,
                                  icon: Icon(
                                    Icons.dashboard_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 25.0,
                                  ),
                                  onPressed: () async {
                                    context.goNamed(
                                      'Dashboard',
                                      queryParameters: {
                                        'tabindex': serializeParam(
                                          0,
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: const TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                        ),
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          if (valueOrDefault(
                                  currentUserDocument?.userRole, 0) ==
                              1)
                            AuthUserStreamWidget(
                              builder: (context) => FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30.0,
                                borderWidth: 1.0,
                                buttonSize: 60.0,
                                icon: Icon(
                                  Icons.dashboard_sharp,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 25.0,
                                ),
                                onPressed: () async {
                                  if (valueOrDefault(
                                          currentUserDocument?.userRole, 0) ==
                                      1) {
                                    context.pushNamed(
                                      'ExistingSchoolDetails_SA',
                                      queryParameters: {
                                        'schoolrefMain': serializeParam(
                                          classDashboardSchoolRecord.reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                    );
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
                        context.goNamed(
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
                                  10.0, 5.0, 10.0, 0.0),
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
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
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
                                                    fontWeight: FontWeight.bold,
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
                            StreamBuilder<List<UsersRecord>>(
                              stream: queryUsersRecord(),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    child: const ClassDashboardShimmerWidget(),
                                  );
                                }
                                List<UsersRecord> containerUsersRecordList =
                                    snapshot.data!;

                                return Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.8,
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
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            unselectedLabelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
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
                                                const Color(0xFFF0F0F0),
                                            unselectedBorderColor:
                                                const Color(0xFFDDD4D4),
                                            borderWidth: 0.5,
                                            borderRadius: 10.0,
                                            elevation: 0.0,
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
                                                text: 'School',
                                              ),
                                            ],
                                            controller: _model.tabBarController,
                                            onTap: (i) async {
                                              [
                                                () async {},
                                                () async {
                                                  safeSetState(() {
                                                    _model
                                                        .descriptionTextController
                                                        ?.clear();
                                                    _model.titleTextController
                                                        ?.clear();
                                                  });
                                                  FFAppState()
                                                      .eventnoticeimage = [];
                                                  safeSetState(() {});
                                                },
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
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
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
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                if (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.userRole,
                                                                        0) ==
                                                                    1) {
                                                                  return;
                                                                }

                                                                context
                                                                    .pushNamed(
                                                                  'add_Teacher_manually_Admin',
                                                                  queryParameters:
                                                                      {
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
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.12,
                                                                      height: MediaQuery.sizeOf(context)
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
                                                                        'assets/images/Generic_avatar.png',
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
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          fontSize:
                                                                              13.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
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
                                                              builder:
                                                                  (context) {
                                                                final teachers = functions
                                                                    .sortTeachersByCheckInDate(
                                                                        classDashboardSchoolRecord
                                                                            .teachersDataList
                                                                            .toList(),
                                                                        containerUsersRecordList
                                                                            .where((e) =>
                                                                                e.userRole ==
                                                                                3)
                                                                            .toList(),
                                                                        getCurrentTimestamp)
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
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              5.0,
                                                                              0.0),
                                                                          child:
                                                                              StreamBuilder<UsersRecord>(
                                                                            stream:
                                                                                UsersRecord.getDocument(teachersItem.userRef!),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              // Customize what your widget looks like when it's loading.
                                                                              if (!snapshot.hasData) {
                                                                                return SizedBox(
                                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                  height: MediaQuery.sizeOf(context).height * 0.12,
                                                                                  child: const TeacherShimmerWidget(),
                                                                                );
                                                                              }

                                                                              final containerUsersRecord = snapshot.data!;

                                                                              return Container(
                                                                                decoration: const BoxDecoration(),
                                                                                child: Padding(
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
                                                                                              return SizedBox(
                                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                height: MediaQuery.sizeOf(context).height * 0.1,
                                                                                                child: const TeacherShimmerWidget(),
                                                                                              );
                                                                                            }

                                                                                            final containerTeachersRecord = snapshot.data!;

                                                                                            return Container(
                                                                                              width: 60.0,
                                                                                              height: 60.0,
                                                                                              decoration: BoxDecoration(
                                                                                                shape: BoxShape.circle,
                                                                                                border: Border.all(
                                                                                                  color: valueOrDefault<Color>(
                                                                                                    ((containerUsersRecord.checkin != null) && (dateTimeFormat("yMMMd", containerUsersRecord.checkin) == dateTimeFormat("yMMMd", getCurrentTimestamp))) && (containerTeachersRecord.teacherAttendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)).toList().isEmpty) ? const Color(0xFF4CBAFA) : FlutterFlowTheme.of(context).tertiary,
                                                                                                    FlutterFlowTheme.of(context).tertiary,
                                                                                                  ),
                                                                                                  width: 4.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Stack(
                                                                                                alignment: const AlignmentDirectional(1.0, 1.0),
                                                                                                children: [
                                                                                                  ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(30.0),
                                                                                                    child: Image.network(
                                                                                                      teachersItem.teacherImage,
                                                                                                      width: 200.0,
                                                                                                      height: 200.0,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                  if ((containerUsersRecord.checkin != null) && (dateTimeFormat("yMMMd", containerUsersRecord.checkin) == dateTimeFormat("yMMMd", getCurrentTimestamp)))
                                                                                                    const Align(
                                                                                                      alignment: AlignmentDirectional(1.0, 1.0),
                                                                                                      child: Icon(
                                                                                                        Icons.check_circle,
                                                                                                        color: Color(0xFF4CBAFA),
                                                                                                        size: 28.0,
                                                                                                      ),
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
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
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
                                                        if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.userRole,
                                                                0) !=
                                                            1)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        10.0),
                                                            child:
                                                                AuthUserStreamWidget(
                                                              builder: (context) =>
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  context
                                                                      .pushNamed(
                                                                    'AddClassAdmin',
                                                                    queryParameters:
                                                                        {
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
                                                                            PageTransitionType.fade,
                                                                      ),
                                                                    },
                                                                  );
                                                                },
                                                                text:
                                                                    'Add Class',
                                                                icon: const Icon(
                                                                  Icons.add,
                                                                  size: 15.0,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.06,
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                  borderSide:
                                                                      const BorderSide(
                                                                    color: Color(
                                                                        0xFFEFF0F6),
                                                                    width: 0.5,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
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
                                                                      20.0),
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
                                                                          30.0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  final schoolsclass =
                                                                      classDashboardSchoolRecord
                                                                          .listOfClass
                                                                          .toList();
                                                                  if (schoolsclass
                                                                      .isEmpty) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
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
                                                                      30.0,
                                                                    ),
                                                                    primary:
                                                                        false,
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
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            10.0),
                                                                        child: StreamBuilder<
                                                                            SchoolClassRecord>(
                                                                          stream:
                                                                              SchoolClassRecord.getDocument(schoolsclassItem),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return SizedBox(
                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                child: const ClassshimmerWidget(),
                                                                              );
                                                                            }

                                                                            final containerSchoolClassRecord =
                                                                                snapshot.data!;

                                                                            return InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                context.pushNamed(
                                                                                  'Class_view',
                                                                                  queryParameters: {
                                                                                    'schoolclassref': serializeParam(
                                                                                      containerSchoolClassRecord.reference,
                                                                                      ParamType.DocumentReference,
                                                                                    ),
                                                                                    'schoolref': serializeParam(
                                                                                      classDashboardSchoolRecord.reference,
                                                                                      ParamType.DocumentReference,
                                                                                    ),
                                                                                    'datePick': serializeParam(
                                                                                      getCurrentTimestamp,
                                                                                      ParamType.DateTime,
                                                                                    ),
                                                                                  }.withoutNulls,
                                                                                );
                                                                              },
                                                                              child: Material(
                                                                                color: Colors.transparent,
                                                                                elevation: 5.0,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(16.0),
                                                                                ),
                                                                                child: Container(
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
                                                                                          if (valueOrDefault(currentUserDocument?.userRole, 0) != 1)
                                                                                            Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                              child: AuthUserStreamWidget(
                                                                                                builder: (context) => FlutterFlowIconButton(
                                                                                                  borderRadius: 30.0,
                                                                                                  buttonSize: 40.0,
                                                                                                  fillColor: const Color(0xFFF2981B),
                                                                                                  icon: Icon(
                                                                                                    Icons.bolt,
                                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                  onPressed: () async {
                                                                                                    if (valueOrDefault(currentUserDocument?.userRole, 0) != 1) {
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
                                                                                                    }
                                                                                                  },
                                                                                                ),
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
                                                                                                        spreadRadius: 0.0,
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
                                                                                                            'mainpage': serializeParam(
                                                                                                              true,
                                                                                                              ParamType.bool,
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
                                                                                                                'Add Event',
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
                                                                                                        ].addToEnd(const SizedBox(height: 1.0)),
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
                                                                                                      if (valueOrDefault(currentUserDocument?.userRole, 0) == 1) {
                                                                                                        context.pushNamed(
                                                                                                          'Class_view',
                                                                                                          queryParameters: {
                                                                                                            'schoolclassref': serializeParam(
                                                                                                              containerSchoolClassRecord.reference,
                                                                                                              ParamType.DocumentReference,
                                                                                                            ),
                                                                                                            'schoolref': serializeParam(
                                                                                                              classDashboardSchoolRecord.reference,
                                                                                                              ParamType.DocumentReference,
                                                                                                            ),
                                                                                                            'datePick': serializeParam(
                                                                                                              getCurrentTimestamp,
                                                                                                              ParamType.DateTime,
                                                                                                            ),
                                                                                                          }.withoutNulls,
                                                                                                        );
                                                                                                      } else {
                                                                                                        context.pushNamed(
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
                                                                                                      children: [
                                                                                                        ClipRRect(
                                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                                          child: Image.asset(
                                                                                                            'assets/images/468327a4975a393d58c5ac8c6ccadf49_(1).png',
                                                                                                            width: MediaQuery.sizeOf(context).width * 0.2,
                                                                                                            height: MediaQuery.sizeOf(context).height * 0.039,
                                                                                                            fit: BoxFit.contain,
                                                                                                          ),
                                                                                                        ),
                                                                                                        Align(
                                                                                                          alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                          child: Padding(
                                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
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
                                                                                                      if (valueOrDefault(currentUserDocument?.userRole, 0) == 1) {
                                                                                                        if (Navigator.of(context).canPop()) {
                                                                                                          context.pop();
                                                                                                        }
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
                                                                                                      } else {
                                                                                                        if (containerSchoolClassRecord.attendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)).toList().isNotEmpty) {
                                                                                                          if (Navigator.of(context).canPop()) {
                                                                                                            context.pop();
                                                                                                          }
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
                                                                                                        } else {
                                                                                                          if (Navigator.of(context).canPop()) {
                                                                                                            context.pop();
                                                                                                          }
                                                                                                          context.pushNamed(
                                                                                                            'mark_attendence',
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
                                                      ].divide(const SizedBox(
                                                          height: 5.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 20.0),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (!functions
                                                              .isDatePassed(
                                                                  _model
                                                                      .date!) &&
                                                          (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.userRole,
                                                                  0) !=
                                                              1))
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  10.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder:
                                                                (context) =>
                                                                    Material(
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
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
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
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
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
                                                                      Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.9,
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              10.0,
                                                                              10.0,
                                                                              0.0),
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            scrollDirection:
                                                                                Axis.horizontal,
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    _model.noticename = 'General';
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                    decoration: BoxDecoration(
                                                                                      color: _model.noticename == 'General' ? const Color(0xFFFFFCF0) : const Color(0xFFFFFCF0),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      border: Border.all(
                                                                                        color: valueOrDefault<Color>(
                                                                                          _model.noticename == 'General' ? const Color(0xFFFF976A) : const Color(0xFFFF976A),
                                                                                          FlutterFlowTheme.of(context).text,
                                                                                        ),
                                                                                        width: _model.noticename == 'General' ? 2.0 : 1.0,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.mode_comment,
                                                                                            color: valueOrDefault<Color>(
                                                                                              _model.noticename == 'General' ? FlutterFlowTheme.of(context).warning : FlutterFlowTheme.of(context).warning,
                                                                                              FlutterFlowTheme.of(context).warning,
                                                                                            ),
                                                                                            size: 20.0,
                                                                                          ),
                                                                                          Text(
                                                                                            'General',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  color: valueOrDefault<Color>(
                                                                                                    _model.noticename == 'General' ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).primaryText,
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
                                                                                    _model.noticename = 'Reminder';
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                    decoration: BoxDecoration(
                                                                                      color: _model.noticename == 'Reminder' ? const Color(0xC3FBF0FF) : const Color(0xC3FBF0FF),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      border: Border.all(
                                                                                        color: valueOrDefault<Color>(
                                                                                          _model.noticename == 'Reminder' ? const Color(0xFFADA6EB) : const Color(0xFFADA6EB),
                                                                                          FlutterFlowTheme.of(context).text,
                                                                                        ),
                                                                                        width: _model.noticename == 'Reminder' ? 2.0 : 1.0,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.alarm_sharp,
                                                                                            color: valueOrDefault<Color>(
                                                                                              _model.noticename == 'Reminder' ? FlutterFlowTheme.of(context).error : FlutterFlowTheme.of(context).error,
                                                                                              FlutterFlowTheme.of(context).warning,
                                                                                            ),
                                                                                            size: 20.0,
                                                                                          ),
                                                                                          Text(
                                                                                            'Reminder',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  color: valueOrDefault<Color>(
                                                                                                    _model.noticename == 'Reminder' ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).primaryText,
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
                                                                                    _model.noticename = 'Notice';
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                    decoration: BoxDecoration(
                                                                                      color: _model.noticename == 'Notice' ? const Color(0xFFFFFCF0) : const Color(0xFFFFFCF0),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      border: Border.all(
                                                                                        color: valueOrDefault<Color>(
                                                                                          _model.noticename == 'Notice' ? const Color(0xFFB0FF6A) : const Color(0xFFB0FF6A),
                                                                                          FlutterFlowTheme.of(context).text,
                                                                                        ),
                                                                                        width: _model.noticename == 'Notice' ? 2.0 : 1.0,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.push_pin,
                                                                                            color: valueOrDefault<Color>(
                                                                                              _model.noticename == 'Notice' ? FlutterFlowTheme.of(context).checkBg : FlutterFlowTheme.of(context).checkBg,
                                                                                              FlutterFlowTheme.of(context).warning,
                                                                                            ),
                                                                                            size: 20.0,
                                                                                          ),
                                                                                          Text(
                                                                                            'Notice',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'Nunito',
                                                                                                  color: valueOrDefault<Color>(
                                                                                                    _model.noticename == 'Notice' ? FlutterFlowTheme.of(context).primaryText : FlutterFlowTheme.of(context).primaryText,
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
                                                                            AutovalidateMode.disabled,
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 10.0),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                child: TextFormField(
                                                                                  controller: _model.titleTextController,
                                                                                  focusNode: _model.titleFocusNode,
                                                                                  autofocus: false,
                                                                                  textCapitalization: TextCapitalization.sentences,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    labelText: 'Title',
                                                                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: (_model.titleFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).textfieldText,
                                                                                          fontSize: 12.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                    hintText: 'Title',
                                                                                    hintStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: FlutterFlowTheme.of(context).textfieldText,
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
                                                                                  maxLines: null,
                                                                                  maxLength: 25,
                                                                                  buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.titleTextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
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
                                                                                          color: (_model.descriptionFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).textfieldText,
                                                                                          fontSize: 12.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                    hintText: 'Description',
                                                                                    hintStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          fontFamily: 'Nunito',
                                                                                          color: FlutterFlowTheme.of(context).textfieldText,
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
                                                                                  maxLines: 3,
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.descriptionTextControllerValidator.asValidator(context),
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
                                                                            final imagesview =
                                                                                FFAppState().eventnoticeimage.toList();

                                                                            return GridView.builder(
                                                                              padding: EdgeInsets.zero,
                                                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                                crossAxisCount: 5,
                                                                                crossAxisSpacing: 10.0,
                                                                                mainAxisSpacing: 10.0,
                                                                                childAspectRatio: 1.0,
                                                                              ),
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
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          FlutterFlowIconButton(
                                                                            borderColor:
                                                                                const Color(0xFFEDF1F3),
                                                                            borderRadius:
                                                                                8.0,
                                                                            buttonSize:
                                                                                40.0,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.attach_file,
                                                                              color: FlutterFlowTheme.of(context).tertiaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              safeSetState(() {
                                                                                _model.isDataUploading1 = false;
                                                                                _model.uploadedLocalFiles1 = [];
                                                                                _model.uploadedFileUrls1 = [];
                                                                              });

                                                                              final selectedMedia = await selectMedia(
                                                                                imageQuality: 10,
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

                                                                              if (_model.uploadedFileUrls1.isNotEmpty) {
                                                                                FFAppState().eventnoticeimage = functions.combineImagePaths(FFAppState().eventnoticeimage.toList(), _model.uploadedFileUrls1.toList()).toList().cast<String>();
                                                                                safeSetState(() {});
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text(
                                                                                      'File uploaded',
                                                                                      style: TextStyle(
                                                                                        color: FlutterFlowTheme.of(context).secondary,
                                                                                      ),
                                                                                    ),
                                                                                    duration: const Duration(milliseconds: 1700),
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  ),
                                                                                );
                                                                              }
                                                                            },
                                                                          ),
                                                                          FlutterFlowIconButton(
                                                                            borderColor:
                                                                                const Color(0xFFEDF1F3),
                                                                            borderRadius:
                                                                                8.0,
                                                                            buttonSize:
                                                                                40.0,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.photo_camera_outlined,
                                                                              color: FlutterFlowTheme.of(context).tertiaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              safeSetState(() {
                                                                                _model.isDataUploading2 = false;
                                                                                _model.uploadedLocalFile2 = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                _model.uploadedFileUrl2 = '';
                                                                              });

                                                                              final selectedMedia = await selectMedia(
                                                                                imageQuality: 10,
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

                                                                              if (_model.uploadedFileUrl2 != '') {
                                                                                FFAppState().addToEventnoticeimage(_model.uploadedFileUrl2);
                                                                                safeSetState(() {});
                                                                              }
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
                                                                                                  height: MediaQuery.sizeOf(context).height * 0.75,
                                                                                                  child: SelectClassNoticeWidget(
                                                                                                    schoolref: widget.schoolref!,
                                                                                                    eventtitle: _model.titleTextController.text,
                                                                                                    description: _model.descriptionTextController.text,
                                                                                                    datetime: getCurrentTimestamp,
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
                                                                                                  height: MediaQuery.sizeOf(context).height * 0.75,
                                                                                                  child: SelectClassNoticeWidget(
                                                                                                    schoolref: widget.schoolref!,
                                                                                                    eventtitle: _model.titleTextController.text,
                                                                                                    description: _model.descriptionTextController.text,
                                                                                                    datetime: getCurrentTimestamp,
                                                                                                    eventname: _model.noticename!,
                                                                                                    images: FFAppState().eventnoticeimage,
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
                                                                              width: MediaQuery.sizeOf(context).width * 0.5,
                                                                              height: MediaQuery.sizeOf(context).height * 0.05,
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              disabledColor: FlutterFlowTheme.of(context).dIsable,
                                                                              disabledTextColor: FlutterFlowTheme.of(context).primaryText,
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
                                                        ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    20.0),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.9,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.06,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFF3F3F3),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          'Latest Notice',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: 18.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
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
                                                                        onTap:
                                                                            () async {
                                                                          final datePickedDate =
                                                                              await showDatePicker(
                                                                            context:
                                                                                context,
                                                                            initialDate:
                                                                                getCurrentTimestamp,
                                                                            firstDate:
                                                                                DateTime(1900),
                                                                            lastDate:
                                                                                getCurrentTimestamp,
                                                                            builder:
                                                                                (context, child) {
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

                                                                          if (datePickedDate !=
                                                                              null) {
                                                                            safeSetState(() {
                                                                              _model.datePicked = DateTime(
                                                                                datePickedDate.year,
                                                                                datePickedDate.month,
                                                                                datePickedDate.day,
                                                                              );
                                                                            });
                                                                          }
                                                                          _model.date =
                                                                              _model.datePicked;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .date_range_outlined,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          size:
                                                                              28.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        10.0,
                                                                        0.0,
                                                                        20.0),
                                                                child: Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final notices = classDashboardSchoolRecord
                                                                        .listOfNotice
                                                                        .where((e) =>
                                                                            dateTimeFormat("yMMMd", e.eventDate) ==
                                                                            dateTimeFormat(
                                                                                "yMMMd",
                                                                                _model
                                                                                    .date))
                                                                        .toList()
                                                                        .sortedList(
                                                                            keyOf: (e) =>
                                                                                dateTimeFormat("relative", e.eventDate!),
                                                                            desc: true)
                                                                        .toList();
                                                                    if (notices
                                                                        .isEmpty) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.4,
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
                                                                          notices
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              noticesIndex) {
                                                                        final noticesItem =
                                                                            notices[noticesIndex];
                                                                        return Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              10.0,
                                                                              10.0),
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
                                                                            onTap:
                                                                                () async {
                                                                              context.pushNamed(
                                                                                'Notice_details',
                                                                                queryParameters: {
                                                                                  'eventDetails': serializeParam(
                                                                                    noticesItem,
                                                                                    ParamType.DataStruct,
                                                                                  ),
                                                                                }.withoutNulls,
                                                                              );
                                                                            },
                                                                            child:
                                                                                Material(
                                                                              color: Colors.transparent,
                                                                              elevation: 2.0,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                              ),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  borderRadius: BorderRadius.circular(16.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    width: 1.0,
                                                                                  ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
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
                                                                                                noticesItem.eventTitle,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'Nunito',
                                                                                                      fontSize: 16.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: MediaQuery.sizeOf(context).width * 0.35,
                                                                                                  height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: valueOrDefault<Color>(
                                                                                                      () {
                                                                                                        if (noticesItem.eventName == 'Notice') {
                                                                                                          return const Color(0xFFFFFCF0);
                                                                                                        } else if (noticesItem.eventName == 'Reminder') {
                                                                                                          return const Color(0xC3FBF0FF);
                                                                                                        } else {
                                                                                                          return const Color(0xFFFFFCF0);
                                                                                                        }
                                                                                                      }(),
                                                                                                      FlutterFlowTheme.of(context).text,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                    border: Border.all(
                                                                                                      color: valueOrDefault<Color>(
                                                                                                        () {
                                                                                                          if (noticesItem.eventName == 'Notice') {
                                                                                                            return const Color(0xFFB0FF6A);
                                                                                                          } else if (noticesItem.eventName == 'Reminder') {
                                                                                                            return const Color(0xFFADA6EB);
                                                                                                          } else {
                                                                                                            return const Color(0xFFFF976A);
                                                                                                          }
                                                                                                        }(),
                                                                                                        FlutterFlowTheme.of(context).text,
                                                                                                      ),
                                                                                                      width: 1.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      if (noticesItem.eventName == 'Notice')
                                                                                                        const Icon(
                                                                                                          Icons.push_pin,
                                                                                                          color: Color(0xFF99D63C),
                                                                                                          size: 20.0,
                                                                                                        ),
                                                                                                      if (noticesItem.eventName == 'Reminder')
                                                                                                        Icon(
                                                                                                          Icons.alarm,
                                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                                          size: 20.0,
                                                                                                        ),
                                                                                                      if (noticesItem.eventName == 'General')
                                                                                                        Icon(
                                                                                                          Icons.mode_comment,
                                                                                                          color: FlutterFlowTheme.of(context).warning,
                                                                                                          size: 20.0,
                                                                                                        ),
                                                                                                      Text(
                                                                                                        noticesItem.eventName,
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: 'Inter',
                                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                                              fontSize: 16.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ].divide(const SizedBox(width: 5.0)).around(const SizedBox(width: 5.0)),
                                                                                                  ),
                                                                                                ),
                                                                                                if (valueOrDefault(currentUserDocument?.userRole, 0) != 1)
                                                                                                  Builder(
                                                                                                    builder: (context) => AuthUserStreamWidget(
                                                                                                      builder: (context) => FlutterFlowIconButton(
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
                                                                                                  ),
                                                                                              ].divide(const SizedBox(width: 10.0)),
                                                                                            ),
                                                                                          ].divide(const SizedBox(width: 5.0)),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          dateTimeFormat("dd MMM , y", noticesItem.eventDate!),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Nunito',
                                                                                                color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                fontSize: 14.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ),
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
                                                                                    ].addToEnd(const SizedBox(height: 10.0)),
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
                                                    mainAxisSize:
                                                        MainAxisSize.max,
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
                                                                    5.0),
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
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                  child: Text(
                                                                    'Select a Class to add \nan event.',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiaryText,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          10.0,
                                                                          5.0),
                                                              child: StreamBuilder<
                                                                  List<
                                                                      SchoolClassRecord>>(
                                                                stream:
                                                                    querySchoolClassRecord()
                                                                      ..listen(
                                                                          (snapshot) {
                                                                        List<SchoolClassRecord>
                                                                            dropDownSchoolClassRecordList =
                                                                            snapshot;
                                                                        if (_model.dropDownPreviousSnapshot !=
                                                                                null &&
                                                                            !const ListEquality(SchoolClassRecordDocumentEquality()).equals(dropDownSchoolClassRecordList,
                                                                                _model.dropDownPreviousSnapshot)) {
                                                                          () async {
                                                                            safeSetState(() {});

                                                                            safeSetState(() {});
                                                                          }();
                                                                        }
                                                                        _model.dropDownPreviousSnapshot =
                                                                            snapshot;
                                                                      }),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(
                                                                            FlutterFlowTheme.of(context).primary,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<SchoolClassRecord>
                                                                      dropDownSchoolClassRecordList =
                                                                      snapshot
                                                                          .data!;

                                                                  return FlutterFlowDropDown<
                                                                      String>(
                                                                    controller: _model
                                                                            .dropDownValueController ??=
                                                                        FormFieldController<
                                                                            String>(
                                                                      _model.dropDownValue ??=
                                                                          widget
                                                                              .classname,
                                                                    ),
                                                                    options: functions.getClassNames(
                                                                        dropDownSchoolClassRecordList
                                                                            .toList(),
                                                                        classDashboardSchoolRecord
                                                                            .listOfClass
                                                                            .toList()),
                                                                    onChanged:
                                                                        (val) async {
                                                                      safeSetState(() =>
                                                                          _model.dropDownValue =
                                                                              val);
                                                                      if (_model
                                                                              .dropDownValue !=
                                                                          'All') {
                                                                        _model.class45 = await SchoolClassRecord.getDocumentOnce(dropDownSchoolClassRecordList
                                                                            .where((e) =>
                                                                                e.className ==
                                                                                _model.dropDownValue)
                                                                            .toList()
                                                                            .firstOrNull!
                                                                            .reference);
                                                                        _model.selectedclass = _model
                                                                            .class45
                                                                            ?.reference;
                                                                        _model.classevents = _model
                                                                            .class45!
                                                                            .calendar
                                                                            .toList()
                                                                            .cast<EventsNoticeStruct>();
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      } else {
                                                                        _model.selectedclass =
                                                                            null;
                                                                        _model.classevents =
                                                                            [];
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      }

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.35,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.05,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).text1,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    hintText:
                                                                        'All',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .text1,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    elevation:
                                                                        2.0,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .dIsable,
                                                                    borderWidth:
                                                                        2.0,
                                                                    borderRadius:
                                                                        10.0,
                                                                    margin: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12.0,
                                                                            0.0,
                                                                            12.0,
                                                                            0.0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isOverButton:
                                                                        false,
                                                                    isSearchable:
                                                                        false,
                                                                    isMultiSelect:
                                                                        false,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      if (_model
                                                              .selectedclass ==
                                                          null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
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
                                                                          12.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                              child: SizedBox(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.57,
                                                                child: custom_widgets
                                                                    .Timelinewidgetdatatype(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.57,
                                                                  timrlinewidget:
                                                                      classDashboardSchoolRecord
                                                                          .calendarList,
                                                                  schoolref: widget
                                                                      .schoolref!,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (_model
                                                              .selectedclass !=
                                                          null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
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
                                                                          12.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                              ),
                                                            ),
                                                            child: SizedBox(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.57,
                                                              child: custom_widgets
                                                                  .TimelinewidgetdatatypeClassCopy(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.57,
                                                                timrlinewidget:
                                                                    _model
                                                                        .classevents,
                                                                schoolclassref:
                                                                    _model
                                                                        .selectedclass!,
                                                                classname: _model
                                                                    .dropDownValue!,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ].addToEnd(
                                                        const SizedBox(height: 20.0)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 20.0),
                                                child: Container(
                                                  width: 100.0,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          1.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(
                                                            10.0),
                                                        child: Container(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.05,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xFFF0F0F0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                            2.0),
                                                                child:
                                                                    FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.pageno =
                                                                        0;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .pageViewController
                                                                        ?.animateToPage(
                                                                      0,
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                  },
                                                                  text:
                                                                      'Teachers',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.4,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.05,
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      _model.pageno == 0
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .secondaryBackground
                                                                          : const Color(
                                                                              0xFFF0F0F0),
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        _model.pageno ==
                                                                                0
                                                                            ? FlutterFlowTheme.of(context).primaryBackground
                                                                            : const Color(0xFFF0F0F0),
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  showLoadingIndicator:
                                                                      false,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                            2.0),
                                                                child:
                                                                    FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.pageno =
                                                                        1;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .pageViewController
                                                                        ?.animateToPage(
                                                                      1,
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              500),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                  },
                                                                  text:
                                                                      'Students',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.4,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.05,
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: _model.pageno ==
                                                                            1
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .secondaryBackground
                                                                        : const Color(
                                                                            0xFFF0F0F0),
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: _model.pageno == 1
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryBackground
                                                                          : const Color(
                                                                              0xFFF0F0F0),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  showLoadingIndicator:
                                                                      false,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                1.0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      40.0),
                                                          child: PageView(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            controller: _model
                                                                    .pageViewController ??=
                                                                PageController(
                                                                    initialPage: max(
                                                                        0,
                                                                        min(
                                                                            valueOrDefault<int>(
                                                                              _model.pageno,
                                                                              0,
                                                                            ),
                                                                            1))),
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
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      if (valueOrDefault(
                                                                              currentUserDocument?.userRole,
                                                                              0) !=
                                                                          1)
                                                                        Align(
                                                                          alignment: const AlignmentDirectional(
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
                                                                                AuthUserStreamWidget(
                                                                              builder: (context) => FFButtonWidget(
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
                                                                                          child: SizedBox(
                                                                                            height: MediaQuery.sizeOf(context).height * 0.8,
                                                                                            child: TeacherNoticeCompWidget(
                                                                                              school: classDashboardSchoolRecord.reference,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ).then((value) => safeSetState(() {}));
                                                                                },
                                                                                text: 'Staff Notice',
                                                                                icon: Icon(
                                                                                  Icons.add,
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  size: 15.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  height: 40.0,
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        fontFamily: 'Nunito',
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                  elevation: 5.0,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      if (valueOrDefault(
                                                                              currentUserDocument?.userRole,
                                                                              0) !=
                                                                          1)
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
                                                                              context.pushNamed(
                                                                                'add_Teacher_manually_Admin',
                                                                                queryParameters: {
                                                                                  'schoolRef': serializeParam(
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
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.3,
                                                                              decoration: const BoxDecoration(),
                                                                              child: Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                                                        'Add Teacher',
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'Nunito',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(const SizedBox(height: 5.0)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      Container(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.44,
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              10.0,
                                                                              0.0,
                                                                              15.0),
                                                                          child:
                                                                              Builder(
                                                                            builder:
                                                                                (context) {
                                                                              final teachersSchool = classDashboardSchoolRecord.teachersDataList.sortedList(keyOf: (e) => e.teacherName, desc: false).toList();

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
                                                                                  childAspectRatio: 0.8,
                                                                                ),
                                                                                primary: false,
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.vertical,
                                                                                itemCount: teachersSchool.length,
                                                                                itemBuilder: (context, teachersSchoolIndex) {
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
                                                                                              width: 60.0,
                                                                                              height: 60.0,
                                                                                              decoration: const BoxDecoration(
                                                                                                shape: BoxShape.circle,
                                                                                              ),
                                                                                              child: ClipRRect(
                                                                                                borderRadius: BorderRadius.circular(30.0),
                                                                                                child: Image.network(
                                                                                                  teachersSchoolItem.teacherImage,
                                                                                                  width: 200.0,
                                                                                                  height: 200.0,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
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
                                                                      ),
                                                                    ].addToEnd(const SizedBox(
                                                                        height:
                                                                            20.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SingleChildScrollView(
                                                                primary: false,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                          Text(
                                                                        'Total Student - ${classDashboardSchoolRecord.listOfStudents.length.toString()}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    if (valueOrDefault(
                                                                            currentUserDocument?.userRole,
                                                                            0) !=
                                                                        1)
                                                                      AuthUserStreamWidget(
                                                                        builder:
                                                                            (context) =>
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
                                                                            context.pushNamed(
                                                                              'add_student_manually',
                                                                              queryParameters: {
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
                                                                                3.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                Container(
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
                                                                      ),
                                                                    Container(
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.44,
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            15.0),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final students =
                                                                                classDashboardSchoolRecord.studentDataList.sortedList(keyOf: (e) => e.studentName, desc: false).toList();
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
                                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                crossAxisCount: valueOrDefault<int>(
                                                                                  classDashboardSchoolRecord.studentDataList.firstOrNull == students.firstOrNull ? 3 : 3,
                                                                                  3,
                                                                                ),
                                                                                crossAxisSpacing: 5.0,
                                                                                mainAxisSpacing: 10.0,
                                                                                childAspectRatio: 1.0,
                                                                              ),
                                                                              primary: false,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              itemCount: students.length,
                                                                              itemBuilder: (context, studentsIndex) {
                                                                                final studentsItem = students[studentsIndex];
                                                                                return StreamBuilder<StudentsRecord>(
                                                                                  stream: StudentsRecord.getDocument(studentsItem.studentId!),
                                                                                  builder: (context, snapshot) {
                                                                                    // Customize what your widget looks like when it's loading.
                                                                                    if (!snapshot.hasData) {
                                                                                      return const AddclasssShimmerWidget();
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
                                                                                                classDashboardSchoolRecord.reference,
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
                                                                                          } else {
                                                                                            context.pushNamed(
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
                                                                                              width: MediaQuery.sizeOf(context).width * 0.28,
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
                                                                                          if (stackStudentsRecord.isDraft)
                                                                                            const Align(
                                                                                              alignment: AlignmentDirectional(0.8, -1.0),
                                                                                              child: Icon(
                                                                                                Icons.error,
                                                                                                color: Color(0xFFB03E3E),
                                                                                                size: 24.0,
                                                                                              ),
                                                                                            ),
                                                                                        ],
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
                                                                  ].addToEnd(
                                                                      const SizedBox(
                                                                          height:
                                                                              40.0)),
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
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
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
