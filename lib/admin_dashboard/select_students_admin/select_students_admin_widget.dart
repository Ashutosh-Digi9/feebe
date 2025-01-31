import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/attenancemarkshimmer/attenancemarkshimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'select_students_admin_model.dart';
export 'select_students_admin_model.dart';

class SelectStudentsAdminWidget extends StatefulWidget {
  const SelectStudentsAdminWidget({
    super.key,
    required this.schoolref,
    this.classref,
  });

  final DocumentReference? schoolref;
  final DocumentReference? classref;

  @override
  State<SelectStudentsAdminWidget> createState() =>
      _SelectStudentsAdminWidgetState();
}

class _SelectStudentsAdminWidgetState extends State<SelectStudentsAdminWidget> {
  late SelectStudentsAdminModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectStudentsAdminModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.schoolDocument =
          await SchoolClassRecord.getDocumentOnce(widget.classref!);
      FFAppState().selectedstudents = _model.schoolDocument!.studentsList
          .toList()
          .cast<DocumentReference>();
      FFAppState().AddStudentClass =
          _model.schoolDocument!.studentData.toList().cast<StudentListStruct>();
      FFAppState().studentimage = '';
      safeSetState(() {});
    });
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
            body: const AttenancemarkshimmerWidget(),
          );
        }

        final selectStudentsAdminSchoolRecord = snapshot.data!;

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
                  context.safePop();
                },
              ),
              title: Text(
                '${_model.schoolDocument?.className}-  add students',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.78,
                      decoration: const BoxDecoration(),
                      child: SingleChildScrollView(
                        primary: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Student - ${FFAppState().selectedstudents.length.toString()}',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 40.0),
                                child: Builder(
                                  builder: (context) {
                                    final students =
                                        selectStudentsAdminSchoolRecord
                                            .studentDataList
                                            .where((e) => e.isDraft == false)
                                            .toList();

                                    return GridView.builder(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        30.0,
                                      ),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio: 0.9,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: students.length,
                                      itemBuilder: (context, studentsIndex) {
                                        final studentsItem =
                                            students[studentsIndex];
                                        return Stack(
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (!FFAppState()
                                                    .selectedstudents
                                                    .contains(studentsItem
                                                        .studentId)) {
                                                  FFAppState()
                                                      .addToSelectedstudents(
                                                          studentsItem
                                                              .studentId!);
                                                  FFAppState()
                                                      .addToAddStudentClass(
                                                          StudentListStruct(
                                                    studentName: studentsItem
                                                        .studentName,
                                                    studentId:
                                                        studentsItem.studentId,
                                                    studentImage: studentsItem
                                                        .studentImage,
                                                    parentList:
                                                        studentsItem.parentList,
                                                    isAddedinClass: true,
                                                    classref:
                                                        studentsItem.classref,
                                                  ));
                                                  safeSetState(() {});
                                                } else {
                                                  FFAppState()
                                                      .removeFromSelectedstudents(
                                                          studentsItem
                                                              .studentId!);
                                                  FFAppState().AddStudentClass =
                                                      functions
                                                          .removeStudentByRef(
                                                              FFAppState()
                                                                  .AddStudentClass
                                                                  .toList(),
                                                              studentsItem
                                                                  .studentId!)
                                                          .toList()
                                                          .cast<
                                                              StudentListStruct>();
                                                  safeSetState(() {});
                                                }
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 5.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.3,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        valueOrDefault<Color>(
                                                      FFAppState()
                                                              .selectedstudents
                                                              .contains(
                                                                  studentsItem
                                                                      .studentId)
                                                          ? const Color(0xFFA8C0F4)
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .lightblue,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                      color:
                                                          valueOrDefault<Color>(
                                                        studentsItem.classref.isNotEmpty
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.2,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.2,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          studentsItem
                                                              .studentImage,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.15,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
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
                                                        child: Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Text(
                                                            studentsItem
                                                                .studentName,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                    1.0, -1.0),
                                                child: Icon(
                                                  Icons.check_box,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 24.0,
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
                    Material(
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
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) !=
                                1)
                              AuthUserStreamWidget(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    if (FFAppState().selectedstudents.isNotEmpty) {
                                      await widget.classref!.update({
                                        ...mapToFirestore(
                                          {
                                            'students_list':
                                                FFAppState().selectedstudents,
                                            'student_data':
                                                getStudentListListFirestoreData(
                                              FFAppState().AddStudentClass,
                                            ),
                                          },
                                        ),
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Class Updated.',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                      );

                                      context.goNamed(
                                        'Class_view',
                                        queryParameters: {
                                          'schoolclassref': serializeParam(
                                            widget.classref,
                                            ParamType.DocumentReference,
                                          ),
                                          'schoolref': serializeParam(
                                            widget.schoolref,
                                            ParamType.DocumentReference,
                                          ),
                                          'datePick': serializeParam(
                                            getCurrentTimestamp,
                                            ParamType.DateTime,
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
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Minimum 1 student must be present in the class',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Update Students',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(10.0),
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
        );
      },
    );
  }
}
