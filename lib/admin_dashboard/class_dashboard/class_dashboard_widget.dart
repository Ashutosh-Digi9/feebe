import '/admin_dashboard/edit_delete_school/edit_delete_school_widget.dart';
import '/admin_dashboard/quick_action_for_class/quick_action_for_class_widget.dart';
import '/admin_dashboard/select_class_notice/select_class_notice_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_widget.dart';
import '/components/emptystudent_widget.dart';
import '/confirmationpages/empty_class/empty_class_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/navbar/navbaradmin/navbaradmin_widget.dart';
import '/shimmer_effects/class_dashboard_shimmer/class_dashboard_shimmer_widget.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import '/shimmer_effects/teacher_shimmer/teacher_shimmer_widget.dart';
import '/teacher/teacher_notice_comp/teacher_notice_comp_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'class_dashboard_model.dart';
export 'class_dashboard_model.dart';

class ClassDashboardWidget extends StatefulWidget {
  const ClassDashboardWidget({
    super.key,
    required this.schoolref,
    int? tabindex,
    String? classname,
    int? pageno,
  })  : this.tabindex = tabindex ?? 0,
        this.classname = classname ?? 'All',
        this.pageno = pageno ?? 0;

  final DocumentReference? schoolref;
  final int tabindex;
  final String classname;
  final int pageno;

  static String routeName = 'class_dashboard';
  static String routePath = '/classDashboard';

  @override
  State<ClassDashboardWidget> createState() => _ClassDashboardWidgetState();
}

class _ClassDashboardWidgetState extends State<ClassDashboardWidget>
    with TickerProviderStateMixin {
  late ClassDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassDashboardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().studentimage = '';
      FFAppState().eventfiles = [];
      safeSetState(() {});
      _model.date = getCurrentTimestamp;
      _model.pageno = widget.pageno;
      _model.noticename = 'General';
      _model.last = false;
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
                      _model.school!.calendarList.toList(), getCurrentTimestamp)
                  .length !=
              0) {
            await widget.schoolref!.update(createSchoolRecordData(
              popupdate: getCurrentTimestamp,
            ));
          }
        }
      } else {
        if (functions
                .filterEventsAfterTwoDays(
                    _model.school!.calendarList.toList(), getCurrentTimestamp)
                .length !=
            0) {
          await widget.schoolref!.update(createSchoolRecordData(
            popupdate: getCurrentTimestamp,
          ));
        }
      }
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.tabBarController = TabController(
      vsync: this,
      length: 4,
      initialIndex: min(
          valueOrDefault<int>(
            _model.tabindex,
            0,
          ),
          3),
    )
      ..addListener(() => safeSetState(() {}))
      ..addListener(() async {
        if (_model.tabBarController!.indexIsChanging) {
          return;
        }

        if (_model.tabBarCurrentIndex != 1) {
          await actions.hideKeyboard(
            context,
          );
          FFAppState().eventfiles = [];
          safeSetState(() {});
          _model.tabindex = _model.tabBarCurrentIndex;
          _model.pageno = 0;
          safeSetState(() {});
        }
      });

    _model.titleTextController ??= TextEditingController();
    _model.titleFocusNode ??= FocusNode();
    _model.titleFocusNode!.addListener(() => safeSetState(() {}));
    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
    _model.descriptionFocusNode!.addListener(() => safeSetState(() {}));
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

    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.schoolref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
            body: ClassDashboardShimmerWidget(),
          );
        }

        final classDashboardSchoolRecord = snapshot.data!;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
          floatingActionButton: Visibility(
            visible: (_model.tabindex == 2) &&
                (valueOrDefault(currentUserDocument?.userRole, 0) != 1),
            child: Align(
              alignment: AlignmentDirectional(1.0, 0.8),
              child: AuthUserStreamWidget(
                builder: (context) => FloatingActionButton(
                  onPressed: () async {
                    context.pushNamed(
                      AddEventsDetailsWidget.routeName,
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
          body: NestedScrollView(
            floatHeaderSlivers: false,
            headerSliverBuilder: (context, _) => [
              if (responsiveVisibility(
                context: context,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ))
                SliverAppBar(
                  expandedHeight: 120.0,
                  collapsedHeight: 50.0,
                  pinned: true,
                  floating: false,
                  backgroundColor: FlutterFlowTheme.of(context).info,
                  automaticallyImplyLeading: false,
                  actions: [],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<List<SchoolRecord>>(
                                stream: querySchoolRecord(
                                  queryBuilder: (schoolRecord) =>
                                      schoolRecord.where(
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<SchoolRecord> containerSchoolRecordList =
                                      snapshot.data!;

                                  return Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.15,
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (valueOrDefault(
                                                currentUserDocument?.userRole,
                                                0) ==
                                            2)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 5.0, 0.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) =>
                                                  FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30.0,
                                                borderWidth: 1.0,
                                                buttonSize: 60.0,
                                                icon: FaIcon(
                                                  FontAwesomeIcons
                                                      .solidBuilding,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 25.0,
                                                ),
                                                onPressed: () async {
                                                  context.goNamed(
                                                    DashboardWidget.routeName,
                                                    queryParameters: {
                                                      'tabindex':
                                                          serializeParam(
                                                        0,
                                                        ParamType.int,
                                                      ),
                                                      'fromlogin':
                                                          serializeParam(
                                                        false,
                                                        ParamType.bool,
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
                                                },
                                              ),
                                            ),
                                          ),
                                        if (valueOrDefault(
                                                currentUserDocument?.userRole,
                                                0) ==
                                            1)
                                          AuthUserStreamWidget(
                                            builder: (context) =>
                                                FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 60.0,
                                              icon: FaIcon(
                                                FontAwesomeIcons.solidBuilding,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 25.0,
                                              ),
                                              onPressed: () async {
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.userRole,
                                                        0) ==
                                                    1) {
                                                  context.pushNamed(
                                                    ExistingSchoolDetailsSAWidget
                                                        .routeName,
                                                    queryParameters: {
                                                      'schoolrefMain':
                                                          serializeParam(
                                                        classDashboardSchoolRecord
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
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
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      child: Container(
                                        width: 120.0,
                                        height: 45.0,
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                              child: Text(
                                                'FEEBE',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 24.0,
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
                                            Container(
                                              width: 24.0,
                                              height: 24.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 10.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          SearchPageAdminWidget.routeName,
                                          queryParameters: {
                                            'schoolref': serializeParam(
                                              widget.schoolref,
                                              ParamType.DocumentReference,
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
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color: Color(0x2B000000),
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
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
                                                  currentUserDocument?.userRole,
                                                  0) !=
                                              4) {
                                            context.pushNamed(
                                              ProfileViewWidget.routeName,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
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
                                                arrayContains:
                                                    currentUserReference,
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
                                                  functions
                                                      .placeUserRefInMiddle(
                                                          _model
                                                              .students12!
                                                              .firstOrNull!
                                                              .parentsDetails
                                                              .toList(),
                                                          currentUserReference!,
                                                          functions.middelindex(
                                                              _model
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
                                                kTransitionInfoKey:
                                                    TransitionInfo(
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
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                                  classDashboardSchoolRecord
                                                      .schoolDetails
                                                      .schoolImage,
                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                ) !=
                                                ''
                                        ? valueOrDefault<String>(
                                            classDashboardSchoolRecord
                                                .schoolDetails.schoolImage,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                          )
                                        : FFAppState().schoolimage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.7,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.1,
                                    decoration: BoxDecoration(),
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          classDashboardSchoolRecord
                                              .schoolDetails.schoolName,
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
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
                      ],
                    ),
                    centerTitle: true,
                    expandedTitleScale: 1.0,
                  ),
                  toolbarHeight: 20.0,
                  elevation: 0.0,
                )
            ],
            body: Builder(
              builder: (context) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: custom_widgets.BackButtonOverriderforClass(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        pageIndex: _model.tabindex,
                        onBack: () async {
                          if (_model.tabindex == 3) {
                            _model.tabindex = 2;
                            safeSetState(() {});
                            safeSetState(() {
                              _model.tabBarController!.animateTo(
                                max(0, _model.tabBarController!.index - 1),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            });
                          } else if (_model.tabindex == 2) {
                            _model.tabindex = 1;
                            safeSetState(() {});
                            safeSetState(() {
                              _model.tabBarController!.animateTo(
                                max(0, _model.tabBarController!.index - 1),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            });
                          } else if (_model.tabindex == 1) {
                            _model.tabindex = 0;
                            safeSetState(() {});
                            safeSetState(() {
                              _model.tabBarController!.animateTo(
                                max(0, _model.tabBarController!.index - 1),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            });
                          } else {
                            safeSetState(() {
                              _model.tabBarController!.animateTo(
                                max(0, _model.tabBarController!.index - 1),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            });
                          }
                        },
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 0.0),
                          child: StreamBuilder<List<UsersRecord>>(
                            stream: queryUsersRecord(),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  child: ClassDashboardShimmerWidget(),
                                );
                              }
                              List<UsersRecord> containerUsersRecordList =
                                  snapshot.data!;

                              return Container(
                                height: MediaQuery.sizeOf(context).height * 1.0,
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
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                        unselectedLabelStyle: FlutterFlowTheme
                                                .of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                        labelColor:
                                            FlutterFlowTheme.of(context).text1,
                                        unselectedLabelColor:
                                            FlutterFlowTheme.of(context).text1,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        unselectedBackgroundColor:
                                            Color(0xFFF0F0F0),
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        borderWidth: 1.0,
                                        borderRadius: 10.0,
                                        elevation: 0.0,
                                        tabs: [
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
                                            () async {
                                              await actions.hideKeyboard(
                                                context,
                                              );
                                              _model.pageno = 0;
                                              safeSetState(() {});
                                              _model.tabindex = 0;
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.tabBarController!
                                                    .animateTo(
                                                  0,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              });
                                            },
                                            () async {
                                              _model.pageno = 1;
                                              safeSetState(() {});
                                              await actions.hideKeyboard(
                                                context,
                                              );
                                              FFAppState().eventfiles = [];
                                              safeSetState(() {});
                                              _model.tabindex = 1;
                                              safeSetState(() {});
                                            },
                                            () async {
                                              await actions.hideKeyboard(
                                                context,
                                              );
                                              _model.pageno = 2;
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.tabBarController!
                                                    .animateTo(
                                                  2,
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              });
                                            },
                                            () async {
                                              _model.pageno = 3;
                                              safeSetState(() {});
                                              await actions.hideKeyboard(
                                                context,
                                              );
                                              _model.tabindex = 3;
                                              safeSetState(() {});
                                            }
                                          ][i]();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _model.tabBarController,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .newBgcolor,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      5.0, 10.0, 5.0, 30.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if ((dateTimeFormat("yMd", currentUserDocument?.checkin) == dateTimeFormat("yMd", getCurrentTimestamp)) &&
                                                            (dateTimeFormat(
                                                                    "yMd",
                                                                    currentUserDocument
                                                                        ?.checkout) !=
                                                                dateTimeFormat(
                                                                    "yMd",
                                                                    getCurrentTimestamp)) &&
                                                            (valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.userRole,
                                                                    0) ==
                                                                2))
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child:
                                                                  AuthUserStreamWidget(
                                                                builder:
                                                                    (context) =>
                                                                        FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    var confirmDialogResponse =
                                                                        await showDialog<bool>(
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
                                                                      await currentUserReference!
                                                                          .update(
                                                                              createUsersRecordData(
                                                                        checkout:
                                                                            getCurrentTimestamp,
                                                                      ));
                                                                      triggerPushNotification(
                                                                        notificationTitle:
                                                                            'Check In',
                                                                        notificationText:
                                                                            '${currentUserDisplayName}  has checked In ',
                                                                        userRefs: [
                                                                          currentUserReference!
                                                                        ],
                                                                        initialPageName:
                                                                            'Dashboard',
                                                                        parameterData: {},
                                                                      );
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            'Checked Out',
                                                                            style:
                                                                                TextStyle(
                                                                              color: FlutterFlowTheme.of(context).secondary,
                                                                            ),
                                                                          ),
                                                                          duration:
                                                                              Duration(milliseconds: 4000),
                                                                          backgroundColor:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  text:
                                                                      'Check Out',
                                                                  icon: Icon(
                                                                    FFIcons
                                                                        .kcheckout,
                                                                    size: 15.0,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.35,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.04,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    iconColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .text1,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                      font: GoogleFonts
                                                                          .nunito(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .text1,
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                      shadows: [
                                                                        Shadow(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          offset: Offset(
                                                                              2.0,
                                                                              2.0),
                                                                          blurRadius:
                                                                              2.0,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (functions.isWithin300kMeters(
                                                                classDashboardSchoolRecord
                                                                    .latlng!,
                                                                currentUserLocationValue!) ==
                                                            false)
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          10.0,
                                                                          0.0,
                                                                          10.0),
                                                              child: Text(
                                                                'You are not within the school\'s location. Check-in/Check-out is disabled.',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .nunito(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
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
                                                            ),
                                                          ),
                                                        if ((dateTimeFormat(
                                                                    "yMMMd",
                                                                    currentUserDocument
                                                                        ?.checkin) !=
                                                                dateTimeFormat(
                                                                    "yMMMd",
                                                                    getCurrentTimestamp)) &&
                                                            (valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.userRole,
                                                                    0) ==
                                                                2))
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child:
                                                                AuthUserStreamWidget(
                                                              builder: (context) =>
                                                                  FFButtonWidget(
                                                                onPressed: (functions.isWithin300kMeters(
                                                                            classDashboardSchoolRecord.latlng!,
                                                                            currentUserLocationValue!) ==
                                                                        false)
                                                                    ? null
                                                                    : () async {
                                                                        if (currentUserDocument?.checkin !=
                                                                            null) {
                                                                          await currentUserReference!
                                                                              .update(createUsersRecordData(
                                                                            checkin:
                                                                                getCurrentTimestamp,
                                                                          ));
                                                                        } else {
                                                                          await currentUserReference!
                                                                              .update(createUsersRecordData(
                                                                            checkin:
                                                                                getCurrentTimestamp,
                                                                          ));
                                                                        }

                                                                        triggerPushNotification(
                                                                          notificationTitle:
                                                                              'Check In',
                                                                          notificationText:
                                                                              '${currentUserDisplayName}  has checked In ',
                                                                          userRefs: [
                                                                            currentUserReference!
                                                                          ],
                                                                          initialPageName:
                                                                              'Dashboard',
                                                                          parameterData: {},
                                                                        );
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Checked In',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        );
                                                                      },
                                                                text:
                                                                    'Check In',
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.9,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.05,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                  elevation:
                                                                      2.0,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  disabledColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .dIsable,
                                                                  disabledTextColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .text,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    if (classDashboardSchoolRecord
                                                            .listOfTeachers
                                                            .length ==
                                                        0)
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
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
                                                              if (valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.userRole,
                                                                      0) ==
                                                                  1) {
                                                                return;
                                                              }

                                                              context.pushNamed(
                                                                AddTeacherManuallyAdminWidget
                                                                    .routeName,
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
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
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
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      FFAppConstants
                                                                          .addImage,
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
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 5.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (classDashboardSchoolRecord
                                                            .listOfTeachers
                                                            .length !=
                                                        0)
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Builder(
                                                            builder: (context) {
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
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                        child: StreamBuilder<
                                                                            UsersRecord>(
                                                                          stream:
                                                                              UsersRecord.getDocument(teachersItem.userRef!),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Container(
                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                height: MediaQuery.sizeOf(context).height * 0.12,
                                                                                child: TeacherShimmerWidget(),
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
                                                                                if (Navigator.of(context).canPop()) {
                                                                                  context.pop();
                                                                                }
                                                                                context.pushNamed(
                                                                                  TeacherTimelineNewWidget.routeName,
                                                                                  queryParameters: {
                                                                                    'teacherRef': serializeParam(
                                                                                      teachersItem.teachersId,
                                                                                      ParamType.DocumentReference,
                                                                                    ),
                                                                                    'schoolref': serializeParam(
                                                                                      widget.schoolref,
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
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.18,
                                                                                decoration: BoxDecoration(),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: StreamBuilder<TeachersRecord>(
                                                                                          stream: TeachersRecord.getDocument(teachersItem.teachersId!),
                                                                                          builder: (context, snapshot) {
                                                                                            // Customize what your widget looks like when it's loading.
                                                                                            if (!snapshot.hasData) {
                                                                                              return Center(
                                                                                                child: Container(
                                                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                                  height: MediaQuery.sizeOf(context).height * 0.1,
                                                                                                  child: TeacherShimmerWidget(),
                                                                                                ),
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
                                                                                                    () {
                                                                                                      if ((containerUsersRecord.checkout != null) && (dateTimeFormat("yMMMd", containerUsersRecord.checkout) == dateTimeFormat("yMMMd", getCurrentTimestamp))) {
                                                                                                        return FlutterFlowTheme.of(context).tertiary;
                                                                                                      } else if ((containerUsersRecord.checkin != null) && (dateTimeFormat("yMMMd", containerUsersRecord.checkin) == dateTimeFormat("yMMMd", getCurrentTimestamp))) {
                                                                                                        return Color(0xFF4CBAFA);
                                                                                                      } else {
                                                                                                        return FlutterFlowTheme.of(context).tertiary;
                                                                                                      }
                                                                                                    }(),
                                                                                                    FlutterFlowTheme.of(context).tertiary,
                                                                                                  ),
                                                                                                  width: 5.0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Stack(
                                                                                                alignment: AlignmentDirectional(1.0, 1.0),
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
                                                                                                  if ((dateTimeFormat("yMMMd", containerUsersRecord.checkout) != dateTimeFormat("yMMMd", getCurrentTimestamp)) && (containerUsersRecord.checkin != null) && (dateTimeFormat("yMMMd", containerUsersRecord.checkin) == dateTimeFormat("yMMMd", getCurrentTimestamp)))
                                                                                                    Align(
                                                                                                      alignment: AlignmentDirectional(1.0, 1.6),
                                                                                                      child: Container(
                                                                                                        width: 20.0,
                                                                                                        height: 20.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: Color(0xFF4CBAFA),
                                                                                                          shape: BoxShape.circle,
                                                                                                        ),
                                                                                                        child: Icon(
                                                                                                          Icons.check,
                                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                                          size: 15.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            teachersItem.teacherName.maybeHandleOverflow(
                                                                                              maxChars: 6,
                                                                                              replacement: '…',
                                                                                            ),
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
                                                                                      ),
                                                                                    ],
                                                                                  ),
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
                                                      ),
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final schoolsclass =
                                                              classDashboardSchoolRecord
                                                                  .listOfClass
                                                                  .toList();
                                                          if (schoolsclass
                                                              .isEmpty) {
                                                            return Center(
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.2,
                                                                child:
                                                                    EmptyClassWidget(
                                                                  schoolref:
                                                                      classDashboardSchoolRecord
                                                                          .reference,
                                                                ),
                                                              ),
                                                            );
                                                          }

                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                schoolsclass
                                                                    .length,
                                                                (schoolsclassIndex) {
                                                              final schoolsclassItem =
                                                                  schoolsclass[
                                                                      schoolsclassIndex];
                                                              return Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            5.0,
                                                                            12.0),
                                                                child: StreamBuilder<
                                                                    SchoolClassRecord>(
                                                                  stream: SchoolClassRecord
                                                                      .getDocument(
                                                                          schoolsclassItem),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        child:
                                                                            ClassshimmerWidget(),
                                                                      );
                                                                    }

                                                                    final containerSchoolClassRecord =
                                                                        snapshot
                                                                            .data!;

                                                                    return InkWell(
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
                                                                          ClassViewWidget
                                                                              .routeName,
                                                                          queryParameters:
                                                                              {
                                                                            'schoolclassref':
                                                                                serializeParam(
                                                                              containerSchoolClassRecord.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                            'schoolref':
                                                                                serializeParam(
                                                                              classDashboardSchoolRecord.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                            'datePick':
                                                                                serializeParam(
                                                                              getCurrentTimestamp,
                                                                              ParamType.DateTime,
                                                                            ),
                                                                          }.withoutNulls,
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
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
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
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            border:
                                                                                Border.all(
                                                                              color: Color(0xFFF2F2F2),
                                                                              width: 1.0,
                                                                            ),
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
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                        child: Container(
                                                                                          height: MediaQuery.sizeOf(context).height * 0.08,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 10.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                RichText(
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
                                                                                                        text: containerSchoolClassRecord.className,
                                                                                                        style: GoogleFonts.nunito(
                                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontSize: 16.0,
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
                                                                                                        text: containerSchoolClassRecord.studentsList.length.toString(),
                                                                                                        style: GoogleFonts.nunito(
                                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontSize: 16.0,
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
                                                                                    ),
                                                                                    if (valueOrDefault(currentUserDocument?.userRole, 0) != 1)
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                                                                        child: AuthUserStreamWidget(
                                                                                          builder: (context) => FlutterFlowIconButton(
                                                                                            borderRadius: 30.0,
                                                                                            buttonSize: 40.0,
                                                                                            fillColor: Color(0xFFF2981B),
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
                                                                                                    return Padding(
                                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                                      child: Container(
                                                                                                        height: MediaQuery.sizeOf(context).height * 0.32,
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
                                                                                                context.pushNamed(
                                                                                                  CalenderClassWidget.routeName,
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
                                                                                                    'studentpage': serializeParam(
                                                                                                      false,
                                                                                                      ParamType.bool,
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
                                                                                              if (valueOrDefault(currentUserDocument?.userRole, 0) == 1) {
                                                                                                context.pushNamed(
                                                                                                  ClassViewWidget.routeName,
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
                                                                                                  ClassNoticeAdminTeacherWidget.routeName,
                                                                                                  queryParameters: {
                                                                                                    'classref': serializeParam(
                                                                                                      containerSchoolClassRecord.reference,
                                                                                                      ParamType.DocumentReference,
                                                                                                    ),
                                                                                                    'schoolref': serializeParam(
                                                                                                      widget.schoolref,
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
                                                                                                    'assets/images/468327a4975a393d58c5ac8c6ccadf49_(1).png',
                                                                                                    width: MediaQuery.sizeOf(context).width * 0.2,
                                                                                                    height: MediaQuery.sizeOf(context).height * 0.045,
                                                                                                    fit: BoxFit.contain,
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 0.0, 0.0),
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
                                                                                          width: MediaQuery.sizeOf(context).width * 0.24,
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
                                                                                              if (valueOrDefault(currentUserDocument?.userRole, 0) == 1) {
                                                                                                context.pushNamed(
                                                                                                  ClassAttendenceWidget.routeName,
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
                                                                                                    kTransitionInfoKey: TransitionInfo(
                                                                                                      hasTransition: true,
                                                                                                      transitionType: PageTransitionType.fade,
                                                                                                    ),
                                                                                                  },
                                                                                                );
                                                                                              } else {
                                                                                                if (containerSchoolClassRecord.attendance.where((e) => dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)).toList().length != 0) {
                                                                                                  context.pushNamed(
                                                                                                    ClassAttendenceWidget.routeName,
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
                                                                                                      kTransitionInfoKey: TransitionInfo(
                                                                                                        hasTransition: true,
                                                                                                        transitionType: PageTransitionType.fade,
                                                                                                      ),
                                                                                                    },
                                                                                                  );
                                                                                                } else {
                                                                                                  context.pushNamed(
                                                                                                    MarkAttendenceWidget.routeName,
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
                                                                                                      if ((containerSchoolClassRecord.attendance.where((e) => (dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)) && e.checkIn).toList().length != 0) && (containerSchoolClassRecord.attendance.where((e) => (dateTimeFormat("yMMMd", e.date) == dateTimeFormat("yMMMd", getCurrentTimestamp)) && !e.checkIn).toList().length != 0))
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
                                                                                                Text(
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
                                                                                              ],
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
                                                                ),
                                                              );
                                                            }),
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
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    10.0,
                                                                    10.0,
                                                                    30.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              if (Navigator.of(
                                                                      context)
                                                                  .canPop()) {
                                                                context.pop();
                                                              }
                                                              context.pushNamed(
                                                                AddClassAdminWidget
                                                                    .routeName,
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
                                                            text: 'Add Class',
                                                            icon: Icon(
                                                              Icons.add,
                                                              size: 15.0,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.06,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconColor: Color(
                                                                  0xFF1A1C1E),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFF1A1C1E),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                                shadows: [
                                                                  Shadow(
                                                                    color: Color(
                                                                        0x14F4F5FA),
                                                                    offset:
                                                                        Offset(
                                                                            0.0,
                                                                            -3.0),
                                                                    blurRadius:
                                                                        6.0,
                                                                  )
                                                                ],
                                                              ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFFEFF0F6),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5.0))
                                                      .addToEnd(SizedBox(
                                                          height: 30.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 20.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (!functions.isDatePassed(
                                                            _model.date!) &&
                                                        (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.userRole,
                                                                0) !=
                                                            1))
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 0.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
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
                                                                            8.0),
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xFFF2F2F2),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                child: Column(
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
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Text(
                                                                        'New Notice',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
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
                                                                    Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.9,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children:
                                                                              [
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                _model.noticename = 'General';
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
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
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
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                _model.noticename = 'Reminder';
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
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
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
                                                                                        textAlign: TextAlign.start,
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
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                _model.noticename = 'Homework';
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
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Image.asset(
                                                                                        'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                                        width: 15.5,
                                                                                        height: 15.5,
                                                                                        fit: BoxFit.contain,
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
                                                                          ].divide(SizedBox(width: 10.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Form(
                                                                      key: _model
                                                                          .formKey,
                                                                      autovalidateMode:
                                                                          AutovalidateMode
                                                                              .disabled,
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                0.0,
                                                                                10.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.9,
                                                                              child: TextFormField(
                                                                                controller: _model.titleTextController,
                                                                                focusNode: _model.titleFocusNode,
                                                                                onFieldSubmitted: (_) async {
                                                                                  _model.last = true;
                                                                                  safeSetState(() {});
                                                                                },
                                                                                autofocus: false,
                                                                                textCapitalization: TextCapitalization.sentences,
                                                                                obscureText: false,
                                                                                decoration: InputDecoration(
                                                                                  isDense: true,
                                                                                  labelText: 'Title *',
                                                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                        font: GoogleFonts.nunito(
                                                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                        color: (_model.titleFocusNode?.hasFocus ?? false) ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).textfieldText,
                                                                                        fontSize: (_model.titleFocusNode?.hasFocus ?? false) ? 12.0 : 16.0,
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
                                                                                      font: GoogleFonts.nunito(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xDE000000),
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                maxLines: null,
                                                                                maxLength: 60,
                                                                                buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                                                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                validator: _model.titleTextControllerValidator.asValidator(context),
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
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.9,
                                                                              child: TextFormField(
                                                                                controller: _model.descriptionTextController,
                                                                                focusNode: _model.descriptionFocusNode,
                                                                                autofocus: false,
                                                                                textCapitalization: TextCapitalization.sentences,
                                                                                obscureText: false,
                                                                                decoration: InputDecoration(
                                                                                  isDense: true,
                                                                                  labelText: 'Description ',
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
                                                                                      font: GoogleFonts.nunito(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).text2,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                maxLines: 3,
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
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final imagesview =
                                                                                FFAppState().eventfiles.toList();

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
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          FlutterFlowIconButton(
                                                                            borderColor:
                                                                                FlutterFlowTheme.of(context).stroke,
                                                                            borderRadius:
                                                                                10.0,
                                                                            borderWidth:
                                                                                1.0,
                                                                            buttonSize:
                                                                                50.0,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.attach_file,
                                                                              color: FlutterFlowTheme.of(context).tertiaryText,
                                                                              size: 18.0,
                                                                            ),
                                                                            showLoadingIndicator:
                                                                                true,
                                                                            onPressed:
                                                                                () async {
                                                                              safeSetState(() {
                                                                                _model.isDataUploading_uploadData9tz = false;
                                                                                _model.uploadedLocalFiles_uploadData9tz = [];
                                                                                _model.uploadedFileUrls_uploadData9tz = [];
                                                                              });

                                                                              final selectedFiles = await selectFiles(
                                                                                multiFile: true,
                                                                              );
                                                                              if (selectedFiles != null) {
                                                                                safeSetState(() => _model.isDataUploading_uploadData9tz = true);
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
                                                                                  _model.isDataUploading_uploadData9tz = false;
                                                                                }
                                                                                if (selectedUploadedFiles.length == selectedFiles.length && downloadUrls.length == selectedFiles.length) {
                                                                                  safeSetState(() {
                                                                                    _model.uploadedLocalFiles_uploadData9tz = selectedUploadedFiles;
                                                                                    _model.uploadedFileUrls_uploadData9tz = downloadUrls;
                                                                                  });
                                                                                } else {
                                                                                  safeSetState(() {});
                                                                                  return;
                                                                                }
                                                                              }

                                                                              if (_model.uploadedFileUrls_uploadData9tz.length != 0) {
                                                                                if (functions.isValidFileFormatCopy(_model.uploadedFileUrls_uploadData9tz.toList())) {
                                                                                  FFAppState().eventfiles = functions.combineImagePathsCopy(FFAppState().eventfiles.toList(), _model.uploadedFileUrls_uploadData9tz.toList()).toList().cast<String>();
                                                                                  safeSetState(() {});
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        'File uploaded',
                                                                                        style: TextStyle(
                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                        ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 1700),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                    ),
                                                                                  );
                                                                                } else {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        'only pdf , docx , jpeg , png , jpg , mp3, ppt , pptx files are allowed',
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
                                                                            borderColor:
                                                                                FlutterFlowTheme.of(context).stroke,
                                                                            borderRadius:
                                                                                10.0,
                                                                            borderWidth:
                                                                                1.0,
                                                                            buttonSize:
                                                                                50.0,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.photo_camera_outlined,
                                                                              color: FlutterFlowTheme.of(context).tertiaryText,
                                                                              size: 18.0,
                                                                            ),
                                                                            showLoadingIndicator:
                                                                                true,
                                                                            onPressed:
                                                                                () async {
                                                                              safeSetState(() {
                                                                                _model.isDataUploading_uploadDataK0455 = false;
                                                                                _model.uploadedLocalFile_uploadDataK0455 = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                _model.uploadedFileUrl_uploadDataK0455 = '';
                                                                              });

                                                                              final selectedMedia = await selectMedia(
                                                                                imageQuality: 10,
                                                                                multiImage: false,
                                                                              );
                                                                              if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                                safeSetState(() => _model.isDataUploading_uploadDataK0455 = true);
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
                                                                                  _model.isDataUploading_uploadDataK0455 = false;
                                                                                }
                                                                                if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                  safeSetState(() {
                                                                                    _model.uploadedLocalFile_uploadDataK0455 = selectedUploadedFiles.first;
                                                                                    _model.uploadedFileUrl_uploadDataK0455 = downloadUrls.first;
                                                                                  });
                                                                                } else {
                                                                                  safeSetState(() {});
                                                                                  return;
                                                                                }
                                                                              }

                                                                              if (_model.uploadedFileUrl_uploadDataK0455 != '') {
                                                                                FFAppState().addToEventfiles(_model.uploadedFileUrl_uploadDataK0455);
                                                                                safeSetState(() {});
                                                                              }
                                                                            },
                                                                          ),
                                                                          FFButtonWidget(
                                                                            onPressed: (classDashboardSchoolRecord.listOfStudents.length == 0)
                                                                                ? null
                                                                                : () async {
                                                                                    if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) {
                                                                                      return;
                                                                                    }
                                                                                    _model.title = _model.titleTextController.text;
                                                                                    _model.des = _model.descriptionTextController.text;
                                                                                    safeSetState(() {});
                                                                                    if (_model.noticename != '') {
                                                                                      if (FFAppState().eventfiles.length == 0) {
                                                                                        safeSetState(() {
                                                                                          _model.titleTextController?.clear();
                                                                                          _model.descriptionTextController?.clear();
                                                                                        });
                                                                                        await showModalBottomSheet(
                                                                                          isScrollControlled: true,
                                                                                          backgroundColor: Colors.transparent,
                                                                                          isDismissible: false,
                                                                                          enableDrag: false,
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return Padding(
                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                              child: Container(
                                                                                                height: MediaQuery.sizeOf(context).height * 0.75,
                                                                                                child: SelectClassNoticeWidget(
                                                                                                  schoolref: widget.schoolref!,
                                                                                                  eventtitle: _model.title!,
                                                                                                  description: _model.des!,
                                                                                                  datetime: getCurrentTimestamp,
                                                                                                  eventname: _model.noticename,
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ).then((value) => safeSetState(() {}));
                                                                                      } else {
                                                                                        safeSetState(() {
                                                                                          _model.titleTextController?.clear();
                                                                                          _model.descriptionTextController?.clear();
                                                                                        });
                                                                                        await showModalBottomSheet(
                                                                                          isScrollControlled: true,
                                                                                          backgroundColor: Colors.transparent,
                                                                                          isDismissible: false,
                                                                                          enableDrag: false,
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return Padding(
                                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                                              child: Container(
                                                                                                height: MediaQuery.sizeOf(context).height * 0.75,
                                                                                                child: SelectClassNoticeWidget(
                                                                                                  schoolref: widget.schoolref!,
                                                                                                  eventtitle: _model.title!,
                                                                                                  description: _model.des!,
                                                                                                  datetime: getCurrentTimestamp,
                                                                                                  eventname: _model.noticename,
                                                                                                  images: FFAppState().eventfiles,
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
                                                                                          duration: Duration(milliseconds: 4000),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                        ),
                                                                                      );
                                                                                    }
                                                                                  },
                                                                            text:
                                                                                'Post',
                                                                            options:
                                                                                FFButtonOptions(
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
                                                                                    color: Color(0xFF1A1C1E),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderSide: BorderSide(
                                                                                color: valueOrDefault<Color>(
                                                                                  classDashboardSchoolRecord.listOfStudents.length == 0 ? FlutterFlowTheme.of(context).secondary : FlutterFlowTheme.of(context).primary,
                                                                                  FlutterFlowTheme.of(context).primary,
                                                                                ),
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                              disabledColor: FlutterFlowTheme.of(context).dIsable,
                                                                              disabledTextColor: FlutterFlowTheme.of(context).secondary,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]
                                                                      .divide(SizedBox(
                                                                          height:
                                                                              10.0))
                                                                      .around(SizedBox(
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
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  20.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.9,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.05,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFFF3F3F3),
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
                                                                    if (_model
                                                                            .datePicked ==
                                                                        null)
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              20.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'Latest on your notice board',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).text2,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    Container(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                    ),
                                                                    if (_model
                                                                            .datePicked !=
                                                                        null)
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
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
                                                                              _model.date = functions.prevDate(_model.date);
                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.chevron_left,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            dateTimeFormat("d/M/y",
                                                                                _model.date),
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
                                                                              _model.date = functions.nextDate(_model.date);
                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.navigate_next,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 10.0)),
                                                                      ),
                                                                    Container(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          100.0,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                    ),
                                                                    if (_model
                                                                            .datePicked ==
                                                                        null)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                                            final _datePickedDate =
                                                                                await showDatePicker(
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

                                                                            if (_datePickedDate !=
                                                                                null) {
                                                                              safeSetState(() {
                                                                                _model.datePicked = DateTime(
                                                                                  _datePickedDate.year,
                                                                                  _datePickedDate.month,
                                                                                  _datePickedDate.day,
                                                                                );
                                                                              });
                                                                            } else if (_model.datePicked !=
                                                                                null) {
                                                                              safeSetState(() {
                                                                                _model.datePicked = getCurrentTimestamp;
                                                                              });
                                                                            }
                                                                            if (_model.datePicked !=
                                                                                null) {
                                                                              _model.date = _model.datePicked;
                                                                              safeSetState(() {});
                                                                            } else {
                                                                              _model.date = getCurrentTimestamp;
                                                                              safeSetState(() {});
                                                                            }
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            FFIcons.kvector2x,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            size:
                                                                                25.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            if (_model
                                                                    .datePicked ==
                                                                null)
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
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
                                                                        .sortedList(
                                                                            keyOf: (e) =>
                                                                                dateTimeFormat("relative", e.eventDate!),
                                                                            desc: true)
                                                                        .toList()
                                                                        .take(5)
                                                                        .toList();
                                                                    if (notices
                                                                        .isEmpty) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.4,
                                                                          child:
                                                                              EmptyWidget(),
                                                                        ),
                                                                      );
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
                                                                          padding:
                                                                              EdgeInsets.all(10.0),
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
                                                                                NoticeDetailsWidget.routeName,
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
                                                                                borderRadius: BorderRadius.circular(12.0),
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
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                  border: Border.all(
                                                                                    color: Color(0xFFEAFFD9),
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
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
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
                                                                                                  width: MediaQuery.sizeOf(context).width * 0.36,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    noticesItem.eventTitle,
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
                                                                                                  dateTimeFormat("dd MMM y", noticesItem.eventDate!),
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
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                Container(
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: valueOrDefault<Color>(
                                                                                                      () {
                                                                                                        if (noticesItem.eventName == 'Homework') {
                                                                                                          return FlutterFlowTheme.of(context).homework;
                                                                                                        } else if (noticesItem.eventName == 'Reminder') {
                                                                                                          return FlutterFlowTheme.of(context).reminderfill;
                                                                                                        } else {
                                                                                                          return FlutterFlowTheme.of(context).event;
                                                                                                        }
                                                                                                      }(),
                                                                                                      FlutterFlowTheme.of(context).text,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(3.59),
                                                                                                    border: Border.all(
                                                                                                      color: valueOrDefault<Color>(
                                                                                                        () {
                                                                                                          if (noticesItem.eventName == 'Homework') {
                                                                                                            return FlutterFlowTheme.of(context).homeworkborder;
                                                                                                          } else if (noticesItem.eventName == 'Reminder') {
                                                                                                            return FlutterFlowTheme.of(context).reminderborder;
                                                                                                          } else {
                                                                                                            return FlutterFlowTheme.of(context).generalBorder;
                                                                                                          }
                                                                                                        }(),
                                                                                                        FlutterFlowTheme.of(context).text,
                                                                                                      ),
                                                                                                      width: 1.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsets.all(5.0),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        if (noticesItem.eventName == 'General')
                                                                                                          Image.asset(
                                                                                                            'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                        if (noticesItem.eventName == 'Reminder')
                                                                                                          Image.asset(
                                                                                                            'assets/images/3d-alarm.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.contain,
                                                                                                          ),
                                                                                                        if (noticesItem.eventName == 'Homework')
                                                                                                          Image.asset(
                                                                                                            'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                        Text(
                                                                                                          noticesItem.eventName,
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
                                                                                                if (valueOrDefault(currentUserDocument?.userRole, 0) != 1)
                                                                                                  Builder(
                                                                                                    builder: (context) => AuthUserStreamWidget(
                                                                                                      builder: (context) => FlutterFlowIconButton(
                                                                                                        borderRadius: 40.0,
                                                                                                        buttonSize: MediaQuery.sizeOf(context).width * 0.1,
                                                                                                        icon: Icon(
                                                                                                          Icons.more_vert,
                                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                          size: 20.0,
                                                                                                        ),
                                                                                                        onPressed: () async {
                                                                                                          if (noticesItem.eventfiles.length == 0) {
                                                                                                            await showAlignedDialog(
                                                                                                              context: context,
                                                                                                              isGlobal: false,
                                                                                                              avoidOverflow: false,
                                                                                                              targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                              followerAnchor: AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                                              builder: (dialogContext) {
                                                                                                                return Material(
                                                                                                                  color: Colors.transparent,
                                                                                                                  child: Container(
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
                                                                                                                        classref: noticesItem.classref,
                                                                                                                      ),
                                                                                                                      noticebool: true,
                                                                                                                      schoolref: widget.schoolref!,
                                                                                                                      schoolcal: false,
                                                                                                                      classref: noticesItem.classref,
                                                                                                                      eventImages: noticesItem,
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
                                                                                                              targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                              followerAnchor: AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                                              builder: (dialogContext) {
                                                                                                                return Material(
                                                                                                                  color: Colors.transparent,
                                                                                                                  child: Container(
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
                                                                                                                        eventfiles: noticesItem.eventfiles,
                                                                                                                        classref: noticesItem.classref,
                                                                                                                      ),
                                                                                                                      noticebool: true,
                                                                                                                      schoolref: widget.schoolref!,
                                                                                                                      schoolcal: false,
                                                                                                                      classref: noticesItem.classref,
                                                                                                                      eventImages: noticesItem,
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
                                                                                              ].divide(SizedBox(width: 10.0)),
                                                                                            ),
                                                                                          ].divide(SizedBox(width: 5.0)),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          noticesItem.eventDescription,
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length.toString(),
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length.toString(),
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length.toString(),
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length.toString(),
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length.toString(),
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
                                                                                    ].addToEnd(SizedBox(height: 10.0)),
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
                                                            if (_model
                                                                    .datePicked !=
                                                                null)
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
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
                                                                            functions.formatDate(e.eventDate!) ==
                                                                            functions.formatDate(_model
                                                                                .date!))
                                                                        .toList()
                                                                        .sortedList(
                                                                            keyOf: (e) =>
                                                                                e.eventDate!,
                                                                            desc: true)
                                                                        .toList();
                                                                    if (notices
                                                                        .isEmpty) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.4,
                                                                          child:
                                                                              EmptyWidget(),
                                                                        ),
                                                                      );
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
                                                                          padding:
                                                                              EdgeInsets.all(10.0),
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
                                                                                NoticeDetailsWidget.routeName,
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
                                                                                borderRadius: BorderRadius.circular(12.0),
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
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                  border: Border.all(
                                                                                    color: Color(0xFFEAFFD9),
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
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
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
                                                                                                  width: MediaQuery.sizeOf(context).width * 0.36,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    noticesItem.eventTitle,
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
                                                                                                  dateTimeFormat("dd MMM y", noticesItem.eventDate!),
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
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                Container(
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: valueOrDefault<Color>(
                                                                                                      () {
                                                                                                        if (noticesItem.eventName == 'Homework') {
                                                                                                          return FlutterFlowTheme.of(context).homework;
                                                                                                        } else if (noticesItem.eventName == 'Reminder') {
                                                                                                          return FlutterFlowTheme.of(context).reminderfill;
                                                                                                        } else {
                                                                                                          return FlutterFlowTheme.of(context).event;
                                                                                                        }
                                                                                                      }(),
                                                                                                      FlutterFlowTheme.of(context).text,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(3.59),
                                                                                                    border: Border.all(
                                                                                                      color: valueOrDefault<Color>(
                                                                                                        () {
                                                                                                          if (noticesItem.eventName == 'Homework') {
                                                                                                            return FlutterFlowTheme.of(context).homeworkborder;
                                                                                                          } else if (noticesItem.eventName == 'Reminder') {
                                                                                                            return FlutterFlowTheme.of(context).reminderborder;
                                                                                                          } else {
                                                                                                            return FlutterFlowTheme.of(context).generalBorder;
                                                                                                          }
                                                                                                        }(),
                                                                                                        FlutterFlowTheme.of(context).text,
                                                                                                      ),
                                                                                                      width: 1.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsets.all(5.0),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        if (noticesItem.eventName == 'General')
                                                                                                          Image.asset(
                                                                                                            'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                        if (noticesItem.eventName == 'Reminder')
                                                                                                          Image.asset(
                                                                                                            'assets/images/3d-alarm.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.contain,
                                                                                                          ),
                                                                                                        if (noticesItem.eventName == 'Homework')
                                                                                                          Image.asset(
                                                                                                            'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                                                            width: 15.5,
                                                                                                            height: 15.5,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                        Text(
                                                                                                          noticesItem.eventName,
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
                                                                                                if (valueOrDefault(currentUserDocument?.userRole, 0) != 1)
                                                                                                  Builder(
                                                                                                    builder: (context) => AuthUserStreamWidget(
                                                                                                      builder: (context) => FlutterFlowIconButton(
                                                                                                        borderRadius: 40.0,
                                                                                                        buttonSize: MediaQuery.sizeOf(context).width * 0.1,
                                                                                                        icon: Icon(
                                                                                                          Icons.more_vert,
                                                                                                          color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                                          size: 20.0,
                                                                                                        ),
                                                                                                        onPressed: () async {
                                                                                                          if (noticesItem.eventfiles.length == 0) {
                                                                                                            await showAlignedDialog(
                                                                                                              context: context,
                                                                                                              isGlobal: false,
                                                                                                              avoidOverflow: false,
                                                                                                              targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                              followerAnchor: AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                                              builder: (dialogContext) {
                                                                                                                return Material(
                                                                                                                  color: Colors.transparent,
                                                                                                                  child: Container(
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
                                                                                                                        classref: noticesItem.classref,
                                                                                                                      ),
                                                                                                                      noticebool: true,
                                                                                                                      schoolref: widget.schoolref!,
                                                                                                                      schoolcal: false,
                                                                                                                      classref: noticesItem.classref,
                                                                                                                      eventImages: noticesItem,
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
                                                                                                              targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                              followerAnchor: AlignmentDirectional(1.0, -1.0).resolve(Directionality.of(context)),
                                                                                                              builder: (dialogContext) {
                                                                                                                return Material(
                                                                                                                  color: Colors.transparent,
                                                                                                                  child: Container(
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
                                                                                                                        eventfiles: noticesItem.eventfiles,
                                                                                                                        classref: noticesItem.classref,
                                                                                                                      ),
                                                                                                                      noticebool: true,
                                                                                                                      schoolref: widget.schoolref!,
                                                                                                                      schoolcal: false,
                                                                                                                      classref: noticesItem.classref,
                                                                                                                      eventImages: noticesItem,
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
                                                                                              ].divide(SizedBox(width: 10.0)),
                                                                                            ),
                                                                                          ].divide(SizedBox(width: 5.0)),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          noticesItem.eventDescription,
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length.toString(),
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length.toString(),
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length.toString(),
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length.toString(),
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
                                                                                            if (noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length != 0)
                                                                                              badges.Badge(
                                                                                                badgeContent: Text(
                                                                                                  noticesItem.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length.toString(),
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
                                                                                    ].addToEnd(SizedBox(height: 10.0)),
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
                                                      SizedBox(height: 20.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 20.0),
                                              child: RefreshIndicator(
                                                onRefresh: () async {},
                                                child: SingleChildScrollView(
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
                                                            EdgeInsetsDirectional
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
                                                            Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.58,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Text(
                                                                'Tap the filter to view events for a specific class',
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
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          10.0,
                                                                          5.0),
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
                                                                        _model.selectedclass = dropDownSchoolClassRecordList
                                                                            .where((e) =>
                                                                                e.className ==
                                                                                _model.dropDownValue)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.reference;
                                                                        _model.classevents = dropDownSchoolClassRecordList
                                                                            .where((e) =>
                                                                                e.className ==
                                                                                _model.dropDownValue)
                                                                            .toList()
                                                                            .firstOrNull!
                                                                            .calendar
                                                                            .toList()
                                                                            .cast<EventsNoticeStruct>();
                                                                        safeSetState(
                                                                            () {});
                                                                      } else {
                                                                        _model.selectedclass =
                                                                            null;
                                                                        _model.classevents =
                                                                            [];
                                                                        safeSetState(
                                                                            () {});
                                                                      }

                                                                      _model.isClicked =
                                                                          true;
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    width:
                                                                        111.0,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.05,
                                                                    textStyle: FlutterFlowTheme.of(
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
                                                                              FlutterFlowTheme.of(context).text1,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
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
                                                                        .secondaryBackground,
                                                                    elevation:
                                                                        2.0,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    borderWidth:
                                                                        1.0,
                                                                    borderRadius:
                                                                        20.0,
                                                                    margin: EdgeInsetsDirectional
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
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      35.0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
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
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    1.0,
                                                                child: custom_widgets
                                                                    .Timelinewidgetdatatype(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      1.0,
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
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      30.0),
                                                          child: StreamBuilder<
                                                              SchoolClassRecord>(
                                                            stream: SchoolClassRecord
                                                                .getDocument(_model
                                                                    .selectedclass!),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        CircularProgressIndicator(
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

                                                              final containerSchoolClassRecord =
                                                                  snapshot
                                                                      .data!;

                                                              return Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    1.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      1.0,
                                                                  child: custom_widgets
                                                                      .TimelinewidgetdatatypeClassCopy(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        MediaQuery.sizeOf(context).height *
                                                                            1.0,
                                                                    timrlinewidget:
                                                                        containerSchoolClassRecord
                                                                            .calendar,
                                                                    schoolclassref:
                                                                        _model
                                                                            .selectedclass!,
                                                                    classname:
                                                                        _model
                                                                            .dropDownValue!,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                    ].addToEnd(
                                                        SizedBox(height: 30.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.055,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF0F0F0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              await Future
                                                                  .wait([
                                                                Future(
                                                                    () async {
                                                                  await _model
                                                                      .pageViewController
                                                                      ?.animateToPage(
                                                                    0,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  _model.pageno =
                                                                      0;
                                                                  safeSetState(
                                                                      () {});
                                                                }),
                                                              ]);
                                                            },
                                                            text: 'Students',
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.45,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.05,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model.pageno ==
                                                                        0
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground
                                                                    : Color(
                                                                        0xFFF0F0F0),
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  _model.pageno ==
                                                                          0
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground
                                                                      : Color(
                                                                          0xFFF0F0F0),
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            showLoadingIndicator:
                                                                false,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              await Future
                                                                  .wait([
                                                                Future(
                                                                    () async {
                                                                  _model.pageno =
                                                                      1;
                                                                  safeSetState(
                                                                      () {});
                                                                }),
                                                                Future(
                                                                    () async {
                                                                  await _model
                                                                      .pageViewController
                                                                      ?.animateToPage(
                                                                    1,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                                }),
                                                              ]);
                                                            },
                                                            text: 'Teachers',
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.45,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.05,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: _model
                                                                          .pageno ==
                                                                      1
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground
                                                                  : Color(
                                                                      0xFFF0F0F0),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: _model
                                                                            .pageno ==
                                                                        1
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground
                                                                    : Color(
                                                                        0xFFF0F0F0),
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 20.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        1.0,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
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
                                                                initialPage: 0),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        5.0,
                                                                        30.0),
                                                            child:
                                                                SingleChildScrollView(
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
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                    child: Text(
                                                                      'Total Student - ${classDashboardSchoolRecord.studentDataList.where((e) => e.isDraft == false).toList().length.toString()}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Color(0xFF5E6165),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            10.0,
                                                                            5.0,
                                                                            30.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final students = functions
                                                                            .startfromfirststudents(classDashboardSchoolRecord.studentDataList.sortedList(keyOf: (e) => e.studentName, desc: false).toList())
                                                                            .toList();
                                                                        if (students
                                                                            .isEmpty) {
                                                                          return Center(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 1.0,
                                                                              height: MediaQuery.sizeOf(context).height * 0.2,
                                                                              child: EmptystudentWidget(),
                                                                            ),
                                                                          );
                                                                        }

                                                                        return GridView
                                                                            .builder(
                                                                          padding:
                                                                              EdgeInsets.fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            50.0,
                                                                          ),
                                                                          gridDelegate:
                                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                3,
                                                                            crossAxisSpacing:
                                                                                15.0,
                                                                            mainAxisSpacing:
                                                                                18.0,
                                                                            childAspectRatio:
                                                                                0.87,
                                                                          ),
                                                                          primary:
                                                                              false,
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          itemCount:
                                                                              students.length,
                                                                          itemBuilder:
                                                                              (context, studentsIndex) {
                                                                            final studentsItem =
                                                                                students[studentsIndex];
                                                                            return Builder(
                                                                              builder: (context) {
                                                                                if (studentsIndex == 0) {
                                                                                  return Visibility(
                                                                                    visible: valueOrDefault(currentUserDocument?.userRole, 0) != 1,
                                                                                    child: AuthUserStreamWidget(
                                                                                      builder: (context) => InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          context.pushNamed(
                                                                                            AddStudentManuallyWidget.routeName,
                                                                                            queryParameters: {
                                                                                              'schoolref': serializeParam(
                                                                                                widget.schoolref,
                                                                                                ParamType.DocumentReference,
                                                                                              ),
                                                                                            }.withoutNulls,
                                                                                          );
                                                                                        },
                                                                                        child: Material(
                                                                                          color: Colors.transparent,
                                                                                          elevation: 1.0,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(10.0),
                                                                                          ),
                                                                                          child: Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                            height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              boxShadow: [
                                                                                                BoxShadow(
                                                                                                  blurRadius: 2.0,
                                                                                                  color: Color(0x3CE4E5E7),
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
                                                                                                      studentsItem.studentImage != '' ? studentsItem.studentImage : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                                                    ),
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 1.0),
                                                                                                  child: Text(
                                                                                                    'Add Student',
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.nunito(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                          fontSize: 12.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ].divide(SizedBox(height: 10.0)),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                } else {
                                                                                  return InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      if (studentsItem.isDraft == true) {
                                                                                        context.pushNamed(
                                                                                          StudentDraftWidget.routeName,
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
                                                                                        if (studentsItem.classref.length != 0) {
                                                                                          context.pushNamed(
                                                                                            IndistudentmainpagesWidget.routeName,
                                                                                            queryParameters: {
                                                                                              'studentsref': serializeParam(
                                                                                                studentsItem.studentId,
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
                                                                                            extra: <String, dynamic>{
                                                                                              kTransitionInfoKey: TransitionInfo(
                                                                                                hasTransition: true,
                                                                                                transitionType: PageTransitionType.fade,
                                                                                              ),
                                                                                            },
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
                                                                                                classDashboardSchoolRecord.reference,
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
                                                                                    },
                                                                                    child: Stack(
                                                                                      children: [
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          elevation: 1.0,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(10.0),
                                                                                          ),
                                                                                          child: Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                            height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              boxShadow: [
                                                                                                BoxShadow(
                                                                                                  blurRadius: 2.0,
                                                                                                  color: Color(0x40E4E5E7),
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
                                                                                                  child: CachedNetworkImage(
                                                                                                    fadeInDuration: Duration(milliseconds: 500),
                                                                                                    fadeOutDuration: Duration(milliseconds: 500),
                                                                                                    imageUrl: valueOrDefault<String>(
                                                                                                      studentsItem.studentImage,
                                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                                                    ),
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    studentsItem.studentName,
                                                                                                    textAlign: TextAlign.center,
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
                                                                                              ].divide(SizedBox(height: 10.0)),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        if (studentsItem.isDraft)
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(1.0, -1.2),
                                                                                            child: Icon(
                                                                                              Icons.error,
                                                                                              color: Color(0xFFB03E3E),
                                                                                              size: 24.0,
                                                                                            ),
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                }
                                                                              },
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ].addToEnd(
                                                                    SizedBox(
                                                                        height:
                                                                            40.0)),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        5.0,
                                                                        20.0),
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
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            12.0,
                                                                            10.0,
                                                                            10.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            'Total Teachers  - ${classDashboardSchoolRecord.listOfTeachers.length.toString()}',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: Color(0xFF5E6165),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        if (valueOrDefault(currentUserDocument?.userRole,
                                                                                0) !=
                                                                            1)
                                                                          AuthUserStreamWidget(
                                                                            builder: (context) =>
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                FFAppState().eventfiles = [];
                                                                                safeSetState(() {});
                                                                                await showModalBottomSheet(
                                                                                  isScrollControlled: true,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  isDismissible: false,
                                                                                  enableDrag: false,
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return Padding(
                                                                                      padding: MediaQuery.viewInsetsOf(context),
                                                                                      child: Container(
                                                                                        height: MediaQuery.sizeOf(context).height * 0.65,
                                                                                        child: TeacherNoticeCompWidget(
                                                                                          school: classDashboardSchoolRecord.reference,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ).then((value) => safeSetState(() {}));
                                                                              },
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.35,
                                                                                height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 2.0,
                                                                                      color: Color(0x3C000000),
                                                                                      offset: Offset(
                                                                                        0.0,
                                                                                        1.0,
                                                                                      ),
                                                                                      spreadRadius: 0.0,
                                                                                    )
                                                                                  ],
                                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                                  border: Border.all(
                                                                                    color: Color(0xFFEFF0F6),
                                                                                    width: 1.0,
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.add,
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      size: 24.0,
                                                                                    ),
                                                                                    Text(
                                                                                      'Staff Notice',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.nunito(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
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
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final teachersSchool = functions
                                                                              .startfromfirst(classDashboardSchoolRecord.teachersDataList.sortedList(keyOf: (e) => e.teacherName, desc: false).toList())
                                                                              .toList();

                                                                          return GridView
                                                                              .builder(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            gridDelegate:
                                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                                              crossAxisCount: 4,
                                                                              childAspectRatio: 0.7,
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
                                                                              return Builder(
                                                                                builder: (context) {
                                                                                  if (teachersSchoolIndex == 0) {
                                                                                    return Visibility(
                                                                                      visible: valueOrDefault(currentUserDocument?.userRole, 0) != 1,
                                                                                      child: AuthUserStreamWidget(
                                                                                        builder: (context) => InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            context.pushNamed(
                                                                                              AddTeacherManuallyAdminWidget.routeName,
                                                                                              queryParameters: {
                                                                                                'schoolRef': serializeParam(
                                                                                                  widget.schoolref,
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
                                                                                          child: Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                            height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 60.0,
                                                                                                    height: 60.0,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Color(0xFFE4EDFC),
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: ClipRRect(
                                                                                                      borderRadius: BorderRadius.circular(30.0),
                                                                                                      child: Image.network(
                                                                                                        FFAppConstants.addImage,
                                                                                                        width: 200.0,
                                                                                                        height: 200.0,
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                                    child: Text(
                                                                                                      'Add Teacher',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.nunito(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            fontSize: 12.0,
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
                                                                                      ),
                                                                                    );
                                                                                  } else {
                                                                                    return Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                      child: InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          if (Navigator.of(context).canPop()) {
                                                                                            context.pop();
                                                                                          }
                                                                                          context.pushNamed(
                                                                                            TeacherProfileWidget.routeName,
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
                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                          height: MediaQuery.sizeOf(context).height * 1.0,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 60.0,
                                                                                                  height: 60.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    shape: BoxShape.circle,
                                                                                                  ),
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.circular(30.0),
                                                                                                    child: Image.network(
                                                                                                      valueOrDefault<String>(
                                                                                                        teachersSchoolItem.teacherImage != '' ? teachersSchoolItem.teacherImage : FFAppConstants.addImage,
                                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                                                      ),
                                                                                                      width: 200.0,
                                                                                                      height: 200.0,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    teachersSchoolItem.teacherName,
                                                                                                    textAlign: TextAlign.center,
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
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].addToEnd(
                                                                    SizedBox(
                                                                        height:
                                                                            30.0)),
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
                                0.0,
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
