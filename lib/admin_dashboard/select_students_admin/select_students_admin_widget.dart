import '/admin_dashboard/search_student_admin/search_student_admin_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/attenancemarkshimmer/attenancemarkshimmer_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
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

  static String routeName = 'SelectStudentsAdmin';
  static String routePath = '/selectStudentsAdmin';

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
      _model.previousstudents = _model.schoolDocument!.studentsList
          .toList()
          .cast<DocumentReference>();
      _model.previousstudentsdata =
          _model.schoolDocument!.studentData.toList().cast<StudentListStruct>();
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
            body: AttenancemarkshimmerWidget(),
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
            appBar: responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
              desktop: false,
            )
                ? AppBar(
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
                        size: 26.0,
                      ),
                      onPressed: () async {
                        FFAppState().selectedstudents = _model.previousstudents
                            .toList()
                            .cast<DocumentReference>();
                        FFAppState().AddStudentClass = _model
                            .previousstudentsdata
                            .toList()
                            .cast<StudentListStruct>();
                        safeSetState(() {});
                        context.safePop();
                      },
                    ),
                    title: Text(
                      '${_model.schoolDocument?.className}- Students',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    actions: [],
                    centerTitle: false,
                    elevation: 0.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.79,
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        primary: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 15.0, 10.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.75,
                                            child: SearchStudentAdminWidget(
                                              school: widget.schoolref!,
                                              editclass: true,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.055,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    borderRadius: BorderRadius.circular(46.0),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.search_rounded,
                                          color: Color(0xFFD1D1D1),
                                          size: 28.0,
                                        ),
                                        Text(
                                          'Search for Students',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFFAEAEAE),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ]
                                          .divide(SizedBox(width: 10.0))
                                          .around(SizedBox(width: 10.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Selected - ${FFAppState().selectedstudents.length.toString()}',
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 10.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (FFAppState()
                                                .selectedstudents
                                                .length !=
                                            selectStudentsAdminSchoolRecord
                                                .studentDataList
                                                .where(
                                                    (e) => e.isDraft == false)
                                                .toList()
                                                .length) {
                                          FFAppState().selectedstudents =
                                              selectStudentsAdminSchoolRecord
                                                  .studentDataList
                                                  .where(
                                                      (e) => e.isDraft == false)
                                                  .toList()
                                                  .map((e) => e.studentId)
                                                  .withoutNulls
                                                  .toList()
                                                  .cast<DocumentReference>();
                                          FFAppState().AddStudentClass =
                                              selectStudentsAdminSchoolRecord
                                                  .studentDataList
                                                  .where(
                                                      (e) => e.isDraft == false)
                                                  .toList()
                                                  .cast<StudentListStruct>();
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Added all the students to class',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 550),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
                                        } else {
                                          FFAppState().selectedstudents = [];
                                          FFAppState().AddStudentClass = [];
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Removed all the students from class',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 750),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        FFAppState().selectedstudents.length ==
                                                selectStudentsAdminSchoolRecord
                                                    .studentDataList
                                                    .where((e) =>
                                                        e.isDraft == false)
                                                    .toList()
                                                    .length
                                            ? 'DeSelect All'
                                            : 'Select All',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 20.0, 10.0, 40.0),
                              child: Builder(
                                builder: (context) {
                                  final students =
                                      selectStudentsAdminSchoolRecord
                                          .studentDataList
                                          .where((e) => e.isDraft == false)
                                          .toList()
                                          .sortedList(
                                              keyOf: (e) => e.studentName,
                                              desc: false)
                                          .toList();

                                  return GridView.builder(
                                    padding: EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      0,
                                      30.0,
                                    ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 15.0,
                                      childAspectRatio: 0.9,
                                    ),
                                    primary: false,
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
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (!FFAppState()
                                                  .selectedstudents
                                                  .contains(
                                                      studentsItem.studentId)) {
                                                FFAppState()
                                                    .addToSelectedstudents(
                                                        studentsItem
                                                            .studentId!);
                                                FFAppState()
                                                    .addToAddStudentClass(
                                                        StudentListStruct(
                                                  studentName:
                                                      studentsItem.studentName,
                                                  studentId:
                                                      studentsItem.studentId,
                                                  studentImage:
                                                      studentsItem.studentImage,
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
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                color: valueOrDefault<Color>(
                                                  FFAppState()
                                                          .selectedstudents
                                                          .contains(studentsItem
                                                              .studentId)
                                                      ? Color(0xFFA8C0F4)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  FlutterFlowTheme.of(context)
                                                      .lightblue,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 2.0,
                                                    color: Color(0x08E4E5E7),
                                                    offset: Offset(
                                                      0.0,
                                                      1.0,
                                                    ),
                                                    spreadRadius: 0.0,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .stroke,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.16,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.16,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      studentsItem.studentImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      studentsItem.studentName
                                                          .maybeHandleOverflow(
                                                        maxChars: 10,
                                                        replacement: '…',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
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
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
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
                                          ),
                                          if (FFAppState()
                                              .selectedstudents
                                              .contains(studentsItem.studentId))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, -1.1),
                                              child: Icon(
                                                Icons.check_box,
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                          ].addToEnd(SizedBox(height: 20.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.08,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondary,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xFFF4F4F4),
                            ),
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
                                      _model.newlist =
                                          await actions.returnNewList(
                                        _model.previousstudentsdata.toList(),
                                        FFAppState().AddStudentClass.toList(),
                                      );
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('studentlist'),
                                            content: Text(_model.newlist!
                                                .firstOrNull!.studentId!.id),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      if (FFAppState()
                                              .selectedstudents
                                              .length !=
                                          0) {
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
                                        FFAppState().loopminparent = 0;
                                        safeSetState(() {});
                                        while (FFAppState().loopminparent <
                                            _model.newlist!.length) {
                                          await (_model.newlist!
                                                  .elementAtOrNull(FFAppState()
                                                      .loopminparent))!
                                              .studentId!
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'classref':
                                                    FieldValue.arrayRemove(
                                                        [widget.classref]),
                                              },
                                            ),
                                          });
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('removed'),
                                                content: Text(
                                                    '${(_model.newlist?.elementAtOrNull(FFAppState().loopminparent))?.studentName}${widget.classref?.id}'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          FFAppState().loopminparent =
                                              FFAppState().loopminparent + 1;
                                          safeSetState(() {});
                                        }
                                        FFAppState().loopminparent = 0;
                                        safeSetState(() {});
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        while (FFAppState().loopmin <
                                            FFAppState()
                                                .selectedstudents
                                                .length) {
                                          _model.studentReading =
                                              await StudentsRecord
                                                  .getDocumentOnce(FFAppState()
                                                      .selectedstudents
                                                      .elementAtOrNull(
                                                          FFAppState()
                                                              .loopmin)!);

                                          await selectStudentsAdminSchoolRecord
                                              .listOfStudents
                                              .elementAtOrNull(
                                                  FFAppState().loopmin)!
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'classref': functions
                                                    .updateStudentClassRef(
                                                        _model.studentReading!,
                                                        FFAppState()
                                                            .selectedstudents
                                                            .toList(),
                                                        widget.classref!),
                                              },
                                            ),
                                          });

                                          await _model.studentReading!.reference
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'classref':
                                                    FieldValue.arrayUnion(
                                                        [widget.classref]),
                                              },
                                            ),
                                          });
                                          FFAppState().loopmin =
                                              FFAppState().loopmin + 1;
                                          safeSetState(() {});
                                        }
                                        FFAppState().loopmin = 0;
                                        FFAppState().selectedstudents = [];
                                        FFAppState().AddStudentClass = [];
                                        safeSetState(() {});
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
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        );

                                        context.goNamed(
                                          ClassViewWidget.routeName,
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
                                            kTransitionInfoKey: TransitionInfo(
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
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Update Students',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.05,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.nunito(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
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
