import '/admin_dashboard/add_student_bottomsheet/add_student_bottomsheet_widget.dart';
import '/admin_dashboard/search_student_admin/search_student_admin_widget.dart';
import '/admin_dashboard/search_teacher_admin/search_teacher_admin_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/emptystudent_widget.dart';
import '/components/no_teacher_widget.dart';
import '/confirmationpages/classcreated/classcreated_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/addclasss_shimmer/addclasss_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'add_class_admin_model.dart';
export 'add_class_admin_model.dart';

class AddClassAdminWidget extends StatefulWidget {
  const AddClassAdminWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  @override
  State<AddClassAdminWidget> createState() => _AddClassAdminWidgetState();
}

class _AddClassAdminWidgetState extends State<AddClassAdminWidget> {
  late AddClassAdminModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddClassAdminModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().selectedstudents = [];
      FFAppState().SelectedTeachers = [];
      FFAppState().AddStudentClass = [];
      FFAppState().AddTeachersClass = [];
      FFAppState().studentimage = '';
      safeSetState(() {});
    });

    _model.classNameTextController ??=
        TextEditingController(text: FFAppState().classname);
    _model.classNameFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.schoolref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const AddclasssShimmerWidget(),
          );
        }

        final addClassAdminSchoolRecord = snapshot.data!;

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
                  context.pushNamed(
                    'class_dashboard',
                    queryParameters: {
                      'schoolref': serializeParam(
                        widget.schoolref,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );

                  FFAppState().classname = '';
                  safeSetState(() {});
                },
              ),
              title: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().AddStudentClass = [];
                  FFAppState().selectedstudents = [];
                  safeSetState(() {});
                },
                child: Text(
                  'Add class',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiary,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _model.pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.8,
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.099,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.099,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      '01',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Teacher',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 100.0,
                                              height: 10.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryText,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.099,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.099,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiaryText,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      '02',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Student',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Container(
                                                width: 100.0,
                                                height: 10.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.099,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.099,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiaryText,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      '03',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Save',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Form(
                                        key: _model.formKey,
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                child: TextFormField(
                                                  controller: _model
                                                      .classNameTextController,
                                                  focusNode:
                                                      _model.classNameFocusNode,
                                                  autofocus: false,
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelText: 'Class name',
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Nunito',
                                                              color: (_model.classNameFocusNode
                                                                          ?.hasFocus ??
                                                                      false)
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary
                                                                  : const Color(
                                                                      0xFF747373),
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                            ),
                                                    hintText: 'Class Name',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .textfieldText,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .classNameTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Text(
                                                  'Select Teachers for this Class',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 10.0),
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
                                                    FFAppState().classname = _model
                                                        .classNameTextController
                                                        .text;
                                                    safeSetState(() {});
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (context) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: Padding(
                                                            padding: MediaQuery
                                                                .viewInsetsOf(
                                                                    context),
                                                            child: SizedBox(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.75,
                                                              child:
                                                                  SearchTeacherAdminWidget(
                                                                editclass:
                                                                    false,
                                                                school:
                                                                    addClassAdminSchoolRecord
                                                                        .reference,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 1.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.06,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .textfieldText,
                                                          width: 1.0,
                                                        ),
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
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Search Teacher',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: const Color(
                                                                        0xFF747373),
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
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
                                                            child: Icon(
                                                              Icons
                                                                  .search_sharp,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              size: 28.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    'add_Teacher_manually_Admin',
                                                    queryParameters: {
                                                      'schoolRef':
                                                          serializeParam(
                                                        widget.schoolref,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
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
                                                child: Container(
                                                  decoration: const BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.15,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.15,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Color(
                                                                0xFFEADFFF),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/Add_profile_pic_(5).png',
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Add Teacher',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ].divide(const SizedBox(
                                                          height: 5.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (addClassAdminSchoolRecord
                                                      .listOfTeachers.isNotEmpty)
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -1.0, -1.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(),
                                                    child: Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              -1.0, 0.0),
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
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  'Selected - ${FFAppState().AddTeachersClass.length.toString()}',
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
                                                              if (addClassAdminSchoolRecord
                                                                      .listOfTeachers.isNotEmpty)
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1.0,
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
                                                                      if (addClassAdminSchoolRecord
                                                                              .teachersDataList.isEmpty) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Please add teachers.',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                const Duration(milliseconds: 750),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        if (_model
                                                                            .selectAllTeachers) {
                                                                          FFAppState().SelectedTeachers =
                                                                              [];
                                                                          FFAppState().AddTeachersClass =
                                                                              [];
                                                                          safeSetState(
                                                                              () {});
                                                                          _model.selectAllTeachers =
                                                                              false;
                                                                          safeSetState(
                                                                              () {});
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'All Teachers Removed',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                ),
                                                                              ),
                                                                              duration: const Duration(milliseconds: 750),
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          FFAppState().SelectedTeachers = addClassAdminSchoolRecord
                                                                              .listOfTeachers
                                                                              .toList()
                                                                              .cast<DocumentReference>();
                                                                          FFAppState().AddTeachersClass = addClassAdminSchoolRecord
                                                                              .teachersDataList
                                                                              .toList()
                                                                              .cast<TeacherListStruct>();
                                                                          safeSetState(
                                                                              () {});
                                                                          _model.selectAllTeachers =
                                                                              true;
                                                                          safeSetState(
                                                                              () {});
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'All Teachers Seleted',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                ),
                                                                              ),
                                                                              duration: const Duration(milliseconds: 750),
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                            ),
                                                                          );
                                                                        }

                                                                        if (addClassAdminSchoolRecord.teachersDataList.isEmpty) {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text(
                                                                                'Please add teachers.',
                                                                                style: TextStyle(
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              ),
                                                                              duration: const Duration(milliseconds: 1900),
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                            ),
                                                                          );
                                                                        }
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.2,
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          _model.selectAllTeachers
                                                                              ? 'De-select all'
                                                                              : 'Select all',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Nunito',
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                          Container(
                                                            decoration:
                                                                const BoxDecoration(),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                final teachers = addClassAdminSchoolRecord
                                                                    .teachersDataList
                                                                    .sortedList(
                                                                        keyOf: (e) => e
                                                                            .teacherName,
                                                                        desc:
                                                                            false)
                                                                    .toList();
                                                                if (teachers
                                                                    .isEmpty) {
                                                                  return NoTeacherWidget(
                                                                    schoolRef:
                                                                        addClassAdminSchoolRecord
                                                                            .reference,
                                                                  );
                                                                }

                                                                return GridView
                                                                    .builder(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  gridDelegate:
                                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        4,
                                                                    crossAxisSpacing:
                                                                        5.0,
                                                                    mainAxisSpacing:
                                                                        5.0,
                                                                    childAspectRatio:
                                                                        0.8,
                                                                  ),
                                                                  primary:
                                                                      false,
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount:
                                                                      teachers
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          teachersIndex) {
                                                                    final teachersItem =
                                                                        teachers[
                                                                            teachersIndex];
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
                                                                        if (!FFAppState()
                                                                            .SelectedTeachers
                                                                            .contains(teachersItem.teachersId)) {
                                                                          FFAppState()
                                                                              .addToSelectedTeachers(teachersItem.teachersId!);
                                                                          FFAppState()
                                                                              .addToAddTeachersClass(TeacherListStruct(
                                                                            teacherName:
                                                                                teachersItem.teacherName,
                                                                            phoneNumber:
                                                                                teachersItem.phoneNumber,
                                                                            emailId:
                                                                                teachersItem.emailId,
                                                                            teacherImage:
                                                                                teachersItem.teacherImage,
                                                                            teachersId:
                                                                                teachersItem.teachersId,
                                                                            userRef:
                                                                                teachersItem.userRef,
                                                                          ));
                                                                          FFAppState()
                                                                              .update(() {});
                                                                        } else {
                                                                          FFAppState()
                                                                              .removeFromSelectedTeachers(teachersItem.teachersId!);
                                                                          FFAppState()
                                                                              .removeFromAddTeachersClass(TeacherListStruct(
                                                                            teacherName:
                                                                                teachersItem.teacherName,
                                                                            phoneNumber:
                                                                                teachersItem.phoneNumber,
                                                                            emailId:
                                                                                teachersItem.emailId,
                                                                            teacherImage:
                                                                                teachersItem.teacherImage,
                                                                            teachersId:
                                                                                teachersItem.teachersId,
                                                                            userRef:
                                                                                teachersItem.userRef,
                                                                          ));
                                                                          FFAppState()
                                                                              .update(() {});
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Stack(
                                                                              alignment: const AlignmentDirectional(1.0, 1.0),
                                                                              children: [
                                                                                Align(
                                                                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                  child: Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.16,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.16,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Container(
                                                                                      width: 200.0,
                                                                                      height: 200.0,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: const BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        teachersItem.teacherImage,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                if (FFAppState().SelectedTeachers.contains(teachersItem.teachersId))
                                                                                  Align(
                                                                                    alignment: const AlignmentDirectional(0.8, 0.0),
                                                                                    child: Icon(
                                                                                      Icons.check_circle_sharp,
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      size: 25.0,
                                                                                    ),
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                            Text(
                                                                              teachersItem.teacherName,
                                                                              textAlign: TextAlign.start,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ].divide(const SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ]
                                                .divide(const SizedBox(height: 10.0))
                                                .addToEnd(
                                                    const SizedBox(height: 10.0)),
                                          ),
                                        ),
                                      ),
                                    ].addToEnd(const SizedBox(height: 10.0)),
                                  ),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 8.0, 5.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.099,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.099,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.check_circle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                size: 24.0,
                                              ),
                                            ),
                                            Text(
                                              'Teacher',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        LinearPercentIndicator(
                                          percent: 1.0,
                                          width: 90.0,
                                          lineHeight: 12.0,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent4,
                                          barRadius: const Radius.circular(8.0),
                                          padding: EdgeInsets.zero,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.099,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.099,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  '02',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Student',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            width: 90.0,
                                            height: 10.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: LinearPercentIndicator(
                                              percent: 0.0,
                                              width: 90.0,
                                              lineHeight: 12.0,
                                              animation: true,
                                              animateFromLastPercent: true,
                                              progressColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent4,
                                              barRadius: const Radius.circular(8.0),
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.099,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.099,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  '03',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Save',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.12,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .lightblue,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  2.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: FFAppState()
                                                                  .AddTeachersClass
                                                                  .length
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .snackbar,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' Teachers Selected',
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Nunito',
                                                              ),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final teachersref = FFAppState()
                                                              .AddTeachersClass
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.teacherName,
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
                                                                      .spaceEvenly,
                                                              children: List.generate(
                                                                  teachersref
                                                                      .length,
                                                                  (teachersrefIndex) {
                                                                final teachersrefItem =
                                                                    teachersref[
                                                                        teachersrefIndex];
                                                                return Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.1,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).width * 0.1,
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Image.network(
                                                                              teachersrefItem.teacherImage,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            teachersrefItem.teacherName,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          ),
                                                                        ],
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
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 10.0, 0.0, 10.0),
                                                child: Text(
                                                  'Select students for this class',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 0.0, 15.0, 10.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child: SizedBox(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.75,
                                                            child:
                                                                SearchStudentAdminWidget(
                                                              school: widget
                                                                  .schoolref!,
                                                              editclass: false,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                },
                                                child: Material(
                                                  color: Colors.transparent,
                                                  elevation: 1.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.06,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .textfieldText,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Search Student',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: const Color(
                                                                        0xFF747373),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Icon(
                                                              Icons
                                                                  .search_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              size: 30.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              decoration: const BoxDecoration(),
                                              child: SingleChildScrollView(
                                                primary: false,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  2.0),
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
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          SizedBox(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.8,
                                                                        child:
                                                                            AddStudentBottomsheetWidget(
                                                                          schoolref:
                                                                              addClassAdminSchoolRecord.reference,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));

                                                              FFAppState()
                                                                      .imageurl =
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
                                                              FFAppState()
                                                                      .profileimagechanged =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Column(
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
                                                                          2.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/Add_profile_pic_(5).png',
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.18,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.08,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Register\nnew student',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if (addClassAdminSchoolRecord
                                                            .studentDataList
                                                            .where((e) =>
                                                                e.isDraft ==
                                                                false)
                                                            .toList().isNotEmpty)
                                                      Padding(
                                                        padding: const EdgeInsets.all(
                                                            10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Selected - ${FFAppState().selectedstudents.length.toString()}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                            if (addClassAdminSchoolRecord
                                                                    .listOfStudents.isNotEmpty)
                                                              InkWell(
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
                                                                  if (_model
                                                                      .selectAllStudents) {
                                                                    FFAppState()
                                                                        .selectedstudents = [];
                                                                    FFAppState()
                                                                        .AddStudentClass = [];
                                                                    safeSetState(
                                                                        () {});
                                                                    _model.selectAllStudents =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'All Students are removed',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            const Duration(milliseconds: 650),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    FFAppState().selectedstudents = addClassAdminSchoolRecord
                                                                        .studentDataList
                                                                        .where((e) =>
                                                                            e.isDraft ==
                                                                            false)
                                                                        .toList()
                                                                        .map((e) => e
                                                                            .studentId)
                                                                        .withoutNulls
                                                                        .toList()
                                                                        .cast<
                                                                            DocumentReference>();
                                                                    FFAppState().AddStudentClass = addClassAdminSchoolRecord
                                                                        .studentDataList
                                                                        .where((e) =>
                                                                            e.isDraft ==
                                                                            false)
                                                                        .toList()
                                                                        .cast<
                                                                            StudentListStruct>();
                                                                    safeSetState(
                                                                        () {});
                                                                    _model.selectAllStudents =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'All Students are selected',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        ),
                                                                        duration:
                                                                            const Duration(milliseconds: 900),
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).primaryText,
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.2,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      _model.selectAllStudents
                                                                          ? 'Deselect all'
                                                                          : 'Select all',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Nunito',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(
                                                            10.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final students = addClassAdminSchoolRecord
                                                                .studentDataList
                                                                .sortedList(
                                                                    keyOf: (e) => e
                                                                        .studentName,
                                                                    desc: false)
                                                                .where((e) =>
                                                                    e.isDraft ==
                                                                    false)
                                                                .toList();
                                                            if (students
                                                                .isEmpty) {
                                                              return Center(
                                                                child:
                                                                    SizedBox(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.2,
                                                                  child:
                                                                      const EmptystudentWidget(),
                                                                ),
                                                              );
                                                            }

                                                            return GridView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              gridDelegate:
                                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                crossAxisSpacing:
                                                                    5.0,
                                                                mainAxisSpacing:
                                                                    5.0,
                                                                childAspectRatio:
                                                                    1.0,
                                                              ),
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  students
                                                                      .length,
                                                              itemBuilder: (context,
                                                                  studentsIndex) {
                                                                final studentsItem =
                                                                    students[
                                                                        studentsIndex];
                                                                return Stack(
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
                                                                      onTap:
                                                                          () async {
                                                                        if (!FFAppState()
                                                                            .selectedstudents
                                                                            .contains(studentsItem.studentId)) {
                                                                          FFAppState()
                                                                              .addToAddStudentClass(StudentListStruct(
                                                                            studentName:
                                                                                studentsItem.studentName,
                                                                            studentId:
                                                                                studentsItem.studentId,
                                                                            studentImage:
                                                                                studentsItem.studentImage,
                                                                            parentList:
                                                                                studentsItem.parentList,
                                                                            isAddedinClass:
                                                                                true,
                                                                          ));
                                                                          FFAppState()
                                                                              .addToSelectedstudents(studentsItem.studentId!);
                                                                          FFAppState()
                                                                              .update(() {});
                                                                        } else {
                                                                          FFAppState()
                                                                              .removeFromAddStudentClass(StudentListStruct(
                                                                            studentName:
                                                                                studentsItem.studentName,
                                                                            studentId:
                                                                                studentsItem.studentId,
                                                                            studentImage:
                                                                                studentsItem.studentImage,
                                                                            parentList:
                                                                                studentsItem.parentList,
                                                                            isAddedinClass:
                                                                                true,
                                                                          ));
                                                                          FFAppState()
                                                                              .removeFromSelectedstudents(studentsItem.studentId!);
                                                                          FFAppState()
                                                                              .update(() {});
                                                                        }
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        elevation:
                                                                            3.0,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.3,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color: FFAppState().selectedstudents.contains(studentsItem.studentId)
                                                                                ? const Color(0xFFA8C0F4)
                                                                                : FlutterFlowTheme.of(context).secondary,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                            border:
                                                                                Border.all(
                                                                              color: valueOrDefault<Color>(
                                                                                studentsItem.classref.isEmpty ? const Color(0xFF979797) : const Color(0xFFEDF1F3),
                                                                                const Color(0xFFEDF1F3),
                                                                              ),
                                                                              width: 1.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.17,
                                                                                height: MediaQuery.sizeOf(context).width * 0.17,
                                                                                clipBehavior: Clip.antiAlias,
                                                                                decoration: const BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Image.network(
                                                                                  studentsItem.studentImage,
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
                                                                    if (FFAppState()
                                                                        .selectedstudents
                                                                        .contains(
                                                                            studentsItem.studentId))
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              5.0,
                                                                              8.0,
                                                                              0.0),
                                                                          child:
                                                                              FlutterFlowIconButton(
                                                                            borderRadius:
                                                                                5.0,
                                                                            buttonSize:
                                                                                28.0,
                                                                            fillColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.check_sharp,
                                                                              color: FlutterFlowTheme.of(context).info,
                                                                              size: 15.0,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              print('IconButton pressed ...');
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ].addToEnd(const SizedBox(height: 5.0)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 8.0, 10.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 8.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.099,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.099,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  size: 24.0,
                                                ),
                                              ),
                                              Text(
                                                'Teacher',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        LinearPercentIndicator(
                                          percent: 1.0,
                                          width: 90.0,
                                          lineHeight: 12.0,
                                          animation: false,
                                          animateFromLastPercent: true,
                                          progressColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent4,
                                          barRadius: const Radius.circular(8.0),
                                          padding: EdgeInsets.zero,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.099,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.099,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.check_circle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                size: 24.0,
                                              ),
                                            ),
                                            Text(
                                              'Student',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: Container(
                                            width: 90.0,
                                            height: 10.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: LinearPercentIndicator(
                                              percent: 1.0,
                                              width: 90.0,
                                              lineHeight: 12.0,
                                              animation: true,
                                              animateFromLastPercent: true,
                                              progressColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent4,
                                              barRadius: const Radius.circular(8.0),
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.099,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.099,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryText,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    '03',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Save',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        8.0, 15.0, 0.0, 10.0),
                                    child: Text(
                                      'You\'re almost done! Please review the class details below to ensure everything is correct before finalizing.',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 8.0),
                                      child: Text(
                                        'Class Name - ${_model.classNameTextController.text}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                  if (_model.creatingclass == false)
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.11,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .lightblue,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 2.0,
                                                                0.0, 5.0),
                                                    child: RichText(
                                                      textScaler:
                                                          MediaQuery.of(context)
                                                              .textScaler,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: FFAppState()
                                                                .AddTeachersClass
                                                                .length
                                                                .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .snackbar,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          const TextSpan(
                                                            text:
                                                                ' Teachers Selected',
                                                            style: TextStyle(),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
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
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final teacherref =
                                                            FFAppState()
                                                                .AddTeachersClass
                                                                .sortedList(
                                                                    keyOf: (e) =>
                                                                        e.teacherName,
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
                                                                    .spaceEvenly,
                                                            children: List.generate(
                                                                teacherref
                                                                    .length,
                                                                (teacherrefIndex) {
                                                              final teacherrefItem =
                                                                  teacherref[
                                                                      teacherrefIndex];
                                                              return Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.1,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).width * 0.1,
                                                                          clipBehavior:
                                                                              Clip.antiAlias,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Image.network(
                                                                            teacherrefItem.teacherImage,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            teacherrefItem.teacherName,
                                                                            textAlign:
                                                                                TextAlign.center,
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
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 10.0, 0.0, 10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Students Selected - ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Text(
                                                  FFAppState()
                                                      .selectedstudents
                                                      .length
                                                      .toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ].divide(const SizedBox(width: 5.0)),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 5.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.95,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.4,
                                              decoration: const BoxDecoration(),
                                              child: Builder(
                                                builder: (context) {
                                                  final selectedStudents =
                                                      FFAppState()
                                                          .AddStudentClass
                                                          .sortedList(
                                                              keyOf: (e) =>
                                                                  e.studentName,
                                                              desc: false)
                                                          .toList();

                                                  return GridView.builder(
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 5.0,
                                                      mainAxisSpacing: 5.0,
                                                      childAspectRatio: 1.0,
                                                    ),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        selectedStudents.length,
                                                    itemBuilder: (context,
                                                        selectedStudentsIndex) {
                                                      final selectedStudentsItem =
                                                          selectedStudents[
                                                              selectedStudentsIndex];
                                                      return Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        2.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 3.0,
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
                                                                  color: const Color(
                                                                      0xFFA8C0F4),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: const Color(
                                                                        0xFFEDF1F3),
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          6.0),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.12,
                                                                        height: MediaQuery.sizeOf(context).width *
                                                                            0.12,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          selectedStudentsItem
                                                                              .studentImage,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              6.0),
                                                                          child:
                                                                              Text(
                                                                            selectedStudentsItem.studentName,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  letterSpacing: 0.0,
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
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    1.0, -1.0),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                              child:
                                                                  FlutterFlowIconButton(
                                                                borderRadius:
                                                                    5.0,
                                                                buttonSize:
                                                                    26.0,
                                                                fillColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                icon: Icon(
                                                                  Icons
                                                                      .check_sharp,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  size: 12.0,
                                                                ),
                                                                onPressed: () {
                                                                  print(
                                                                      'IconButton pressed ...');
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
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
                                  if (_model.creatingclass == true)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 5.0),
                                            child: Text(
                                              'Please wait while we are adding students to a class',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          CircularPercentIndicator(
                                            percent:
                                                functions.calculatePercentage(
                                                    FFAppState().loopmin,
                                                    FFAppState()
                                                        .selectedstudents
                                                        .length),
                                            radius: 60.0,
                                            lineWidth: 12.0,
                                            animation: true,
                                            animateFromLastPercent: true,
                                            progressColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .accent4,
                                            center: Text(
                                              FFAppState().loopmin.toString(),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        letterSpacing: 0.0,
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
                  ),
                  if (_model.pageno == 0)
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.1,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color(0xFFF4F4F4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    if (FFAppState().SelectedTeachers.isNotEmpty) {
                                      _model.pageno = 1;
                                      safeSetState(() {});
                                      await _model.pageViewController?.nextPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Atleast one teacher should be selected',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Next',
                                  icon: const Icon(
                                    Icons.east,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    iconAlignment: IconAlignment.end,
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_model.pageno == 1)
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.1,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color(0xFFF4F4F4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.pageno = 0;
                                    safeSetState(() {});
                                    await _model.pageViewController
                                        ?.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  },
                                  text: 'Back',
                                  icon: const Icon(
                                    Icons.arrow_back_outlined,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (FFAppState().selectedstudents.isNotEmpty) {
                                      _model.pageno = 2;
                                      safeSetState(() {});
                                      await _model.pageViewController?.nextPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Atleast one students should be select',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Next',
                                  icon: const Icon(
                                    Icons.east,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    iconAlignment: IconAlignment.end,
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_model.pageno == 2)
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.1,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color(0xFFF4F4F4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.pageno = 1;
                                    safeSetState(() {});
                                    await _model.pageViewController
                                        ?.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  },
                                  text: 'Edit',
                                  icon: Icon(
                                    Icons.keyboard_backspace,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Color(0xFFEFF0F6),
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      var schoolClassRecordReference =
                                          SchoolClassRecord.collection.doc();
                                      await schoolClassRecordReference.set({
                                        ...createSchoolClassRecordData(
                                          className: _model
                                              .classNameTextController.text,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'teachers_list':
                                                FFAppState().SelectedTeachers,
                                            'students_list':
                                                FFAppState().selectedstudents,
                                            'student_data':
                                                getStudentListListFirestoreData(
                                              FFAppState().AddStudentClass,
                                            ),
                                            'ListOfteachers':
                                                getTeacherListListFirestoreData(
                                              FFAppState().AddTeachersClass,
                                            ),
                                            'listOfteachersUser': FFAppState()
                                                .AddTeachersClass
                                                .map((e) => e.userRef)
                                                .withoutNulls
                                                .toList(),
                                          },
                                        ),
                                      });
                                      _model.classcreated = SchoolClassRecord
                                          .getDocumentFromData({
                                        ...createSchoolClassRecordData(
                                          className: _model
                                              .classNameTextController.text,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'teachers_list':
                                                FFAppState().SelectedTeachers,
                                            'students_list':
                                                FFAppState().selectedstudents,
                                            'student_data':
                                                getStudentListListFirestoreData(
                                              FFAppState().AddStudentClass,
                                            ),
                                            'ListOfteachers':
                                                getTeacherListListFirestoreData(
                                              FFAppState().AddTeachersClass,
                                            ),
                                            'listOfteachersUser': FFAppState()
                                                .AddTeachersClass
                                                .map((e) => e.userRef)
                                                .withoutNulls
                                                .toList(),
                                          },
                                        ),
                                      }, schoolClassRecordReference);

                                      await addClassAdminSchoolRecord.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'List_of_class':
                                                FieldValue.arrayUnion([
                                              _model.classcreated?.reference
                                            ]),
                                            'student_data_list':
                                                getStudentListListFirestoreData(
                                              functions.updateIsPresentStatus(
                                                  addClassAdminSchoolRecord
                                                      .studentDataList
                                                      .toList(),
                                                  FFAppState()
                                                      .AddStudentClass
                                                      .toList(),
                                                  _model
                                                      .classcreated!.reference),
                                            ),
                                          },
                                        ),
                                      });
                                      _model.creatingclass = true;
                                      safeSetState(() {});
                                      while (FFAppState().loopmin <
                                          FFAppState()
                                              .selectedstudents
                                              .length) {
                                        await FFAppState()
                                            .selectedstudents
                                            .elementAtOrNull(
                                                FFAppState().loopmin)!
                                            .update({
                                          ...createStudentsRecordData(
                                            className:
                                                _model.classcreated?.className,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'classref':
                                                  FieldValue.arrayUnion([
                                                _model.classcreated?.reference
                                              ]),
                                            },
                                          ),
                                        });
                                        FFAppState().loopmin =
                                            FFAppState().loopmin + 1;
                                        safeSetState(() {});
                                      }
                                      FFAppState().loopmin = 0;
                                      safeSetState(() {});
                                      triggerPushNotification(
                                        notificationTitle: 'Added to class',
                                        notificationText:
                                            'you are added to ${_model.classNameTextController.text} class',
                                        userRefs: FFAppState()
                                            .AddTeachersClass
                                            .map((e) => e.userRef)
                                            .withoutNulls
                                            .toList(),
                                        initialPageName: 'Class_view',
                                        parameterData: {
                                          'schoolclassref':
                                              _model.classcreated?.reference,
                                          'schoolref': widget.schoolref,
                                          'datePick': getCurrentTimestamp,
                                        },
                                      );

                                      await NotificationsRecord.collection
                                          .doc()
                                          .set({
                                        ...createNotificationsRecordData(
                                          content:
                                              'A new class has been assigned : ${_model.classNameTextController.text}',
                                          createDate: getCurrentTimestamp,
                                          isread: false,
                                          notification:
                                              updateNotificationStruct(
                                            NotificationStruct(
                                              notificationTitle:
                                                  'Added to a class',
                                              descriptions:
                                                  'Added to class ${_model.classNameTextController.text}',
                                              timeStamp: getCurrentTimestamp,
                                              isRead: false,
                                            ),
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          addedby: currentUserReference,
                                          heading: 'Added to class',
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'userref': FFAppState()
                                                .AddTeachersClass
                                                .map((e) => e.userRef)
                                                .withoutNulls
                                                .toList(),
                                            'towhome': [
                                              _model.classcreated?.className
                                            ],
                                          },
                                        ),
                                      });
                                      _model.students123 =
                                          await queryStudentsRecordOnce();
                                      triggerPushNotification(
                                        notificationTitle: 'Added to class',
                                        notificationText:
                                            'you are added to ${_model.classNameTextController.text} class',
                                        userRefs: functions
                                            .extractParentUserRefs(_model
                                                .students123!
                                                .where((e) => FFAppState()
                                                    .selectedstudents
                                                    .contains(e.reference))
                                                .toList())
                                            .toList(),
                                        initialPageName: 'Dashboard',
                                        parameterData: {},
                                      );

                                      await NotificationsRecord.collection
                                          .doc()
                                          .set({
                                        ...createNotificationsRecordData(
                                          content:
                                              'Your child has been added to the ${_model.classNameTextController.text} class',
                                          isread: false,
                                          notification:
                                              updateNotificationStruct(
                                            NotificationStruct(
                                              notificationTitle:
                                                  'Added to a class',
                                              descriptions:
                                                  'Added to class ${_model.classNameTextController.text}',
                                              timeStamp: getCurrentTimestamp,
                                              isRead: false,
                                            ),
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          createDate: getCurrentTimestamp,
                                          addedby: currentUserReference,
                                          heading: 'Added to class',
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'userref': functions
                                                .extractParentUserRefs(_model
                                                    .students123!
                                                    .where((e) => FFAppState()
                                                        .selectedstudents
                                                        .contains(e.reference))
                                                    .toList()),
                                            'towhome': [
                                              _model.classcreated?.className
                                            ],
                                          },
                                        ),
                                      });
                                      FFAppState().loopmin = 0;
                                      FFAppState().classname = '';
                                      FFAppState().SelectedTeachers = [];
                                      FFAppState().selectedstudents = [];
                                      FFAppState().AddStudentClass = [];
                                      FFAppState().AddTeachersClass = [];
                                      safeSetState(() {});
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: const AlignmentDirectional(
                                                    0.0, -0.8)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.08,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.6,
                                                child: const ClasscreatedWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      context.goNamed(
                                        'class_dashboard',
                                        queryParameters: {
                                          'schoolref': serializeParam(
                                            addClassAdminSchoolRecord.reference,
                                            ParamType.DocumentReference,
                                          ),
                                        }.withoutNulls,
                                      );

                                      safeSetState(() {});
                                    },
                                    text: 'Finished',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.06,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 16.0, 16.0, 16.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
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
          ),
        );
      },
    );
  }
}
