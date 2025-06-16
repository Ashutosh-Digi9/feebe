import '/a_super_admin/draftsaved/draftsaved_widget.dart';
import '/admin_dashboard/calender/calender_widget.dart';
import '/admin_dashboard/editphoto/editphoto_widget.dart';
import '/admin_dashboard/parentdocument/parentdocument_widget.dart';
import '/admin_dashboard/parentphoto/parentphoto_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/shimmer_effects/class_dashboard_shimmer/class_dashboard_shimmer_widget.dart';
import '/shimmer_effects/quick_action_selectclass/quick_action_selectclass_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_student_manually_model.dart';
export 'add_student_manually_model.dart';

class AddStudentManuallyWidget extends StatefulWidget {
  const AddStudentManuallyWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  static String routeName = 'add_student_manually';
  static String routePath = '/addStudentManually';

  @override
  State<AddStudentManuallyWidget> createState() =>
      _AddStudentManuallyWidgetState();
}

class _AddStudentManuallyWidgetState extends State<AddStudentManuallyWidget> {
  late AddStudentManuallyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddStudentManuallyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().imageurl = '';
      FFAppState().studentimage = '';
      FFAppState().fileUrl = '';
      FFAppState().fileurl1 = '';
      FFAppState().fileurl2 = '';
      FFAppState().parent1 = '';
      FFAppState().parent2 = '';
      FFAppState().guardian = '';
      FFAppState().selectedDate = null;
      safeSetState(() {});
      _model.isguardian = false;
      safeSetState(() {});
    });

    _model.childnameTextController ??= TextEditingController();
    _model.childnameFocusNode ??= FocusNode();

    _model.allergiesTextController ??= TextEditingController();
    _model.allergiesFocusNode ??= FocusNode();

    _model.addressTextController ??= TextEditingController();
    _model.addressFocusNode ??= FocusNode();

    _model.parentnameTextController ??= TextEditingController();
    _model.parentnameFocusNode ??= FocusNode();

    _model.numberfatherTextController ??= TextEditingController();
    _model.numberfatherFocusNode ??= FocusNode();

    _model.emailfatherTextController ??= TextEditingController();
    _model.emailfatherFocusNode ??= FocusNode();

    _model.parent2TextController ??= TextEditingController();
    _model.parent2FocusNode ??= FocusNode();

    _model.numbermotherTextController ??= TextEditingController();
    _model.numbermotherFocusNode ??= FocusNode();

    _model.emailmotherTextController ??= TextEditingController();
    _model.emailmotherFocusNode ??= FocusNode();

    _model.gnameTextController ??= TextEditingController();
    _model.gnameFocusNode ??= FocusNode();

    _model.gnumberTextController ??= TextEditingController();
    _model.gnumberFocusNode ??= FocusNode();

    _model.gemailTextController ??= TextEditingController();
    _model.gemailFocusNode ??= FocusNode();
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
            body: ClassDashboardShimmerWidget(),
          );
        }

        final addStudentManuallySchoolRecord = snapshot.data!;

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
                    leading: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        var confirmDialogResponse = await showDialog<bool>(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text(
                                      'Would you like to save your progress '),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, true),
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                        if (confirmDialogResponse) {
                          if (_model.pageViewCurrentIndex == 0) {
                            if (FFAppState().selectedDate != null) {
                              var studentsRecordReference1 =
                                  StudentsRecord.collection.doc();
                              await studentsRecordReference1
                                  .set(createStudentsRecordData(
                                studentName:
                                    _model.childnameTextController.text,
                                studentGender: _model.genderValue,
                                studentAddress:
                                    _model.addressTextController.text,
                                dateOfBirth: FFAppState().selectedDate,
                                bloodGroup: _model.bloodtypeValue,
                                allergiesOthers:
                                    _model.allergiesTextController.text,
                                createdAt: getCurrentTimestamp,
                                studentImage: FFAppState().studentimage,
                                schoolref: widget.schoolref,
                                isDraft: true,
                                document: FFAppState().fileUrl,
                              ));
                              _model.studentdraft12 =
                                  StudentsRecord.getDocumentFromData(
                                      createStudentsRecordData(
                                        studentName:
                                            _model.childnameTextController.text,
                                        studentGender: _model.genderValue,
                                        studentAddress:
                                            _model.addressTextController.text,
                                        dateOfBirth: FFAppState().selectedDate,
                                        bloodGroup: _model.bloodtypeValue,
                                        allergiesOthers:
                                            _model.allergiesTextController.text,
                                        createdAt: getCurrentTimestamp,
                                        studentImage: FFAppState().studentimage,
                                        schoolref: widget.schoolref,
                                        isDraft: true,
                                        document: FFAppState().fileUrl,
                                      ),
                                      studentsRecordReference1);

                              await widget.schoolref!.update({
                                ...mapToFirestore(
                                  {
                                    'List_of_students': FieldValue.arrayUnion(
                                        [_model.studentdraft12?.reference]),
                                    'student_data_list': FieldValue.arrayUnion([
                                      getStudentListFirestoreData(
                                        createStudentListStruct(
                                          studentName: _model
                                              .studentdraft12?.studentName,
                                          studentId:
                                              _model.studentdraft12?.reference,
                                          studentImage: _model
                                              .studentdraft12?.studentImage,
                                          isDraft: true,
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });
                            } else {
                              var studentsRecordReference2 =
                                  StudentsRecord.collection.doc();
                              await studentsRecordReference2
                                  .set(createStudentsRecordData(
                                studentName:
                                    _model.childnameTextController.text,
                                studentGender: _model.genderValue,
                                studentAddress:
                                    _model.addressTextController.text,
                                bloodGroup: _model.bloodtypeValue,
                                allergiesOthers:
                                    _model.allergiesTextController.text,
                                createdAt: getCurrentTimestamp,
                                studentImage: FFAppState().studentimage,
                                schoolref: widget.schoolref,
                                isDraft: true,
                                document: FFAppState().fileUrl,
                              ));
                              _model.studentdraft123 =
                                  StudentsRecord.getDocumentFromData(
                                      createStudentsRecordData(
                                        studentName:
                                            _model.childnameTextController.text,
                                        studentGender: _model.genderValue,
                                        studentAddress:
                                            _model.addressTextController.text,
                                        bloodGroup: _model.bloodtypeValue,
                                        allergiesOthers:
                                            _model.allergiesTextController.text,
                                        createdAt: getCurrentTimestamp,
                                        studentImage: FFAppState().studentimage,
                                        schoolref: widget.schoolref,
                                        isDraft: true,
                                        document: FFAppState().fileUrl,
                                      ),
                                      studentsRecordReference2);

                              await widget.schoolref!.update({
                                ...mapToFirestore(
                                  {
                                    'List_of_students': FieldValue.arrayUnion(
                                        [_model.studentdraft123?.reference]),
                                    'student_data_list': FieldValue.arrayUnion([
                                      getStudentListFirestoreData(
                                        createStudentListStruct(
                                          studentName: _model
                                              .studentdraft123?.studentName,
                                          studentId:
                                              _model.studentdraft123?.reference,
                                          studentImage: _model
                                              .studentdraft123?.studentImage,
                                          isDraft: true,
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });
                            }
                          } else if (_model.pageViewCurrentIndex == 1) {
                            if ((_model.emailfatherTextController.text !=
                                    _model.emailmotherTextController.text) ||
                                (_model.emailmotherTextController.text ==
                                        '')) {
                              if (((_model.parent2TextController.text !=
                                              '') ||
                                      (_model.numbermotherTextController
                                                  .text !=
                                              '')) ||
                                  (_model.emailmotherTextController.text !=
                                          '')) {
                                if (_model.emailmotherTextController.text !=
                                        '') {
                                  _model
                                      .addToParentsdetails(ParentsDetailsStruct(
                                    parentsId: functions.generateUniqueId(),
                                    parentsName:
                                        _model.parent2TextController.text,
                                    parentsEmail: functions.isValidEmail(_model
                                            .emailmotherTextController.text)
                                        ? _model.emailmotherTextController.text
                                        : '${_model.emailmotherTextController.text}@feebe.in',
                                    parentsPhone:
                                        _model.numbermotherTextController.text,
                                    document: FFAppState().fileurl2,
                                    isemail: functions.isValidEmail(_model
                                            .emailmotherTextController.text)
                                        ? true
                                        : false,
                                    parentImage:
                                        !functions.isBlank(FFAppState().parent2)
                                            ? FFAppState().parent2
                                            : FFAppConstants.addImage,
                                  ));
                                  safeSetState(() {});
                                } else {
                                  _model
                                      .addToParentsdetails(ParentsDetailsStruct(
                                    parentsId: functions.generateUniqueId(),
                                    parentsName:
                                        _model.parent2TextController.text,
                                    parentsPhone:
                                        _model.numbermotherTextController.text,
                                    document: FFAppState().fileurl2,
                                    parentImage:
                                        !functions.isBlank(FFAppState().parent2)
                                            ? FFAppState().parent2
                                            : FFAppConstants.addImage,
                                  ));
                                  safeSetState(() {});
                                }
                              } else {
                                _model.parentsdetails = [];
                                safeSetState(() {});
                                if (_model.emailfatherTextController.text !=
                                        '') {
                                  _model
                                      .addToParentsdetails(ParentsDetailsStruct(
                                    parentsId: functions.generateUniqueId(),
                                    parentsName:
                                        _model.parentnameTextController.text,
                                    parentsEmail: functions.isValidEmail(_model
                                            .emailfatherTextController.text)
                                        ? _model.emailfatherTextController.text
                                        : '${_model.emailfatherTextController.text}@feebe.in',
                                    parentsPhone:
                                        _model.numberfatherTextController.text,
                                    document: FFAppState().fileurl1,
                                    isemail: functions.isValidEmail(_model
                                            .emailfatherTextController.text)
                                        ? true
                                        : false,
                                    parentImage:
                                        !functions.isBlank(FFAppState().parent1)
                                            ? FFAppState().parent1
                                            : FFAppConstants.addImage,
                                  ));
                                  safeSetState(() {});
                                } else {
                                  _model
                                      .addToParentsdetails(ParentsDetailsStruct(
                                    parentsId: functions.generateUniqueId(),
                                    parentsName:
                                        _model.parentnameTextController.text,
                                    parentsPhone:
                                        _model.numberfatherTextController.text,
                                    document: FFAppState().fileurl1,
                                    parentImage:
                                        !functions.isBlank(FFAppState().parent1)
                                            ? FFAppState().parent1
                                            : FFAppConstants.addImage,
                                  ));
                                  safeSetState(() {});
                                }
                              }

                              _model.pageno = 2;
                              safeSetState(() {});

                              var studentsRecordReference3 =
                                  StudentsRecord.collection.doc();
                              await studentsRecordReference3.set({
                                ...createStudentsRecordData(
                                  studentName:
                                      _model.childnameTextController.text,
                                  studentGender: _model.genderValue,
                                  studentAddress:
                                      _model.addressTextController.text,
                                  dateOfBirth: FFAppState().selectedDate != null
                                      ? FFAppState().selectedDate
                                      : getCurrentTimestamp,
                                  bloodGroup: _model.bloodtypeValue,
                                  allergiesOthers:
                                      _model.allergiesTextController.text,
                                  createdAt: getCurrentTimestamp,
                                  studentImage: FFAppState().studentimage,
                                  schoolref: widget.schoolref,
                                  isDraft: true,
                                  document: FFAppState().fileUrl,
                                ),
                                ...mapToFirestore(
                                  {
                                    'parents_details':
                                        getParentsDetailsListFirestoreData(
                                      _model.parentsdetails,
                                    ),
                                  },
                                ),
                              });
                              _model.studentdraftParent1 =
                                  StudentsRecord.getDocumentFromData({
                                ...createStudentsRecordData(
                                  studentName:
                                      _model.childnameTextController.text,
                                  studentGender: _model.genderValue,
                                  studentAddress:
                                      _model.addressTextController.text,
                                  dateOfBirth: FFAppState().selectedDate != null
                                      ? FFAppState().selectedDate
                                      : getCurrentTimestamp,
                                  bloodGroup: _model.bloodtypeValue,
                                  allergiesOthers:
                                      _model.allergiesTextController.text,
                                  createdAt: getCurrentTimestamp,
                                  studentImage: FFAppState().studentimage,
                                  schoolref: widget.schoolref,
                                  isDraft: true,
                                  document: FFAppState().fileUrl,
                                ),
                                ...mapToFirestore(
                                  {
                                    'parents_details':
                                        getParentsDetailsListFirestoreData(
                                      _model.parentsdetails,
                                    ),
                                  },
                                ),
                              }, studentsRecordReference3);

                              await widget.schoolref!.update({
                                ...mapToFirestore(
                                  {
                                    'List_of_students': FieldValue.arrayUnion([
                                      _model.studentdraftParent1?.reference
                                    ]),
                                    'student_data_list': FieldValue.arrayUnion([
                                      getStudentListFirestoreData(
                                        createStudentListStruct(
                                          studentName: _model
                                              .studentdraftParent1?.studentName,
                                          studentId: _model
                                              .studentdraftParent1?.reference,
                                          studentImage: _model
                                              .studentdraftParent1
                                              ?.studentImage,
                                          isDraft: true,
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Both parents email are same! Please add different email.',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 2350),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              );
                            }
                          } else {
                            if (((_model.gnameTextController.text !=
                                            '') ||
                                    (_model.gnumberTextController.text !=
                                            '')) ||
                                (_model.gemailTextController.text != '')) {
                              if (_model.gemailTextController.text != '') {
                                _model.addToParentsdetails(ParentsDetailsStruct(
                                  parentsId: functions.generateUniqueId(),
                                  parentsName: _model.gnameTextController.text,
                                  parentsEmail: functions.isValidEmail(
                                          _model.gemailTextController.text)
                                      ? _model.gemailTextController.text
                                      : '${_model.gemailTextController.text}@feebe.in',
                                  parentsPhone:
                                      _model.gnumberTextController.text,
                                  parentRelation: 'Gurdian',
                                  isemail: functions.isValidEmail(functions
                                          .isValidEmail(
                                              _model.gemailTextController.text)
                                          .toString())
                                      ? true
                                      : false,
                                  parentImage:
                                      !functions.isBlank(FFAppState().guardian)
                                          ? FFAppState().guardian
                                          : FFAppConstants.addImage,
                                ));
                                safeSetState(() {});
                              } else {
                                _model.addToParentsdetails(ParentsDetailsStruct(
                                  parentsId: functions.generateUniqueId(),
                                  parentsName: _model.gnameTextController.text,
                                  parentsPhone:
                                      _model.gnumberTextController.text,
                                  parentRelation: 'Gurdian',
                                  parentImage:
                                      !functions.isBlank(FFAppState().guardian)
                                          ? FFAppState().guardian
                                          : FFAppConstants.addImage,
                                ));
                                safeSetState(() {});
                              }

                              _model.pageno = 3;
                              safeSetState(() {});
                            } else {
                              _model.pageno = 3;
                              safeSetState(() {});
                            }

                            var studentsRecordReference4 =
                                StudentsRecord.collection.doc();
                            await studentsRecordReference4.set({
                              ...createStudentsRecordData(
                                studentName:
                                    _model.childnameTextController.text,
                                studentGender: _model.genderValue,
                                studentAddress:
                                    _model.addressTextController.text,
                                dateOfBirth: FFAppState().selectedDate,
                                bloodGroup: _model.bloodtypeValue,
                                allergiesOthers:
                                    _model.allergiesTextController.text,
                                createdAt: getCurrentTimestamp,
                                studentImage: FFAppState().studentimage,
                                schoolref: widget.schoolref,
                                isDraft: true,
                                document: FFAppState().fileUrl,
                              ),
                              ...mapToFirestore(
                                {
                                  'parents_details':
                                      getParentsDetailsListFirestoreData(
                                    _model.parentsdetails,
                                  ),
                                },
                              ),
                            });
                            _model.draftguardian =
                                StudentsRecord.getDocumentFromData({
                              ...createStudentsRecordData(
                                studentName:
                                    _model.childnameTextController.text,
                                studentGender: _model.genderValue,
                                studentAddress:
                                    _model.addressTextController.text,
                                dateOfBirth: FFAppState().selectedDate,
                                bloodGroup: _model.bloodtypeValue,
                                allergiesOthers:
                                    _model.allergiesTextController.text,
                                createdAt: getCurrentTimestamp,
                                studentImage: FFAppState().studentimage,
                                schoolref: widget.schoolref,
                                isDraft: true,
                                document: FFAppState().fileUrl,
                              ),
                              ...mapToFirestore(
                                {
                                  'parents_details':
                                      getParentsDetailsListFirestoreData(
                                    _model.parentsdetails,
                                  ),
                                },
                              ),
                            }, studentsRecordReference4);

                            await widget.schoolref!.update({
                              ...mapToFirestore(
                                {
                                  'List_of_students': FieldValue.arrayUnion(
                                      [_model.draftguardian?.reference]),
                                  'student_data_list': FieldValue.arrayUnion([
                                    getStudentListFirestoreData(
                                      createStudentListStruct(
                                        studentName:
                                            _model.draftguardian?.studentName,
                                        studentId:
                                            _model.draftguardian?.reference,
                                        studentImage:
                                            _model.draftguardian?.studentImage,
                                        isDraft: true,
                                        clearUnsetFields: false,
                                      ),
                                      true,
                                    )
                                  ]),
                                },
                              ),
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Progress saved',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).secondary,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).primaryText,
                            ),
                          );
                          FFAppState().studentimage = '';
                          FFAppState().fileUrl = '';
                          FFAppState().fileurl1 = '';
                          FFAppState().fileurl2 = '';
                          FFAppState().parent1 = '';
                          FFAppState().parent2 = '';
                          FFAppState().guardian = '';
                          FFAppState().selectedDate = null;
                          FFAppState().imageurl = '';
                          safeSetState(() {});
                          if (valueOrDefault(
                                  currentUserDocument?.userRole, 0) ==
                              2) {
                            context.goNamed(
                              ClassDashboardWidget.routeName,
                              queryParameters: {
                                'schoolref': serializeParam(
                                  addStudentManuallySchoolRecord.reference,
                                  ParamType.DocumentReference,
                                ),
                                'tabindex': serializeParam(
                                  3,
                                  ParamType.int,
                                ),
                              }.withoutNulls,
                            );
                          } else {
                            context.goNamed(
                              DashboardWidget.routeName,
                              queryParameters: {
                                'tabindex': serializeParam(
                                  3,
                                  ParamType.int,
                                ),
                              }.withoutNulls,
                            );
                          }
                        } else {
                          FFAppState().studentimage = '';
                          FFAppState().fileUrl = '';
                          FFAppState().fileurl1 = '';
                          FFAppState().fileurl2 = '';
                          FFAppState().parent1 = '';
                          FFAppState().parent2 = '';
                          FFAppState().guardian = '';
                          FFAppState().selectedDate = null;
                          FFAppState().imageurl = '';
                          safeSetState(() {});
                          Navigator.pop(context);
                          context.safePop();
                        }

                        safeSetState(() {});
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).bgColor1,
                        size: 28.0,
                      ),
                    ),
                    title: Text(
                      'Add Student',
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
                    actions: [
                      Visibility(
                        visible: _model.pageViewCurrentIndex != 3,
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Builder(
                            builder: (context) => Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.pageViewCurrentIndex == 0) {
                                    if (FFAppState().selectedDate != null) {
                                      var studentsRecordReference1 =
                                          StudentsRecord.collection.doc();
                                      await studentsRecordReference1
                                          .set(createStudentsRecordData(
                                        studentName:
                                            _model.childnameTextController.text,
                                        studentGender: _model.genderValue,
                                        studentAddress:
                                            _model.addressTextController.text,
                                        dateOfBirth: FFAppState().selectedDate,
                                        bloodGroup: _model.bloodtypeValue,
                                        allergiesOthers:
                                            _model.allergiesTextController.text,
                                        createdAt: getCurrentTimestamp,
                                        studentImage: FFAppState().studentimage,
                                        schoolref: widget.schoolref,
                                        isDraft: true,
                                        document: FFAppState().fileUrl,
                                      ));
                                      _model.studentdraft =
                                          StudentsRecord.getDocumentFromData(
                                              createStudentsRecordData(
                                                studentName: _model
                                                    .childnameTextController
                                                    .text,
                                                studentGender:
                                                    _model.genderValue,
                                                studentAddress: _model
                                                    .addressTextController.text,
                                                dateOfBirth:
                                                    FFAppState().selectedDate,
                                                bloodGroup:
                                                    _model.bloodtypeValue,
                                                allergiesOthers: _model
                                                    .allergiesTextController
                                                    .text,
                                                createdAt: getCurrentTimestamp,
                                                studentImage:
                                                    FFAppState().studentimage,
                                                schoolref: widget.schoolref,
                                                isDraft: true,
                                                document: FFAppState().fileUrl,
                                              ),
                                              studentsRecordReference1);

                                      await widget.schoolref!.update({
                                        ...mapToFirestore(
                                          {
                                            'List_of_students':
                                                FieldValue.arrayUnion([
                                              _model.studentdraft?.reference
                                            ]),
                                            'student_data_list':
                                                FieldValue.arrayUnion([
                                              getStudentListFirestoreData(
                                                createStudentListStruct(
                                                  studentName: _model
                                                      .studentdraft
                                                      ?.studentName,
                                                  studentId: _model
                                                      .studentdraft?.reference,
                                                  studentImage: _model
                                                      .studentdraft
                                                      ?.studentImage,
                                                  isDraft: true,
                                                  clearUnsetFields: false,
                                                ),
                                                true,
                                              )
                                            ]),
                                          },
                                        ),
                                      });
                                    } else {
                                      var studentsRecordReference2 =
                                          StudentsRecord.collection.doc();
                                      await studentsRecordReference2
                                          .set(createStudentsRecordData(
                                        studentName:
                                            _model.childnameTextController.text,
                                        studentGender: _model.genderValue,
                                        studentAddress:
                                            _model.addressTextController.text,
                                        bloodGroup: _model.bloodtypeValue,
                                        allergiesOthers:
                                            _model.allergiesTextController.text,
                                        createdAt: getCurrentTimestamp,
                                        studentImage: FFAppState().studentimage,
                                        schoolref: widget.schoolref,
                                        isDraft: true,
                                        document: FFAppState().fileUrl,
                                      ));
                                      _model.studentdraft1 =
                                          StudentsRecord.getDocumentFromData(
                                              createStudentsRecordData(
                                                studentName: _model
                                                    .childnameTextController
                                                    .text,
                                                studentGender:
                                                    _model.genderValue,
                                                studentAddress: _model
                                                    .addressTextController.text,
                                                bloodGroup:
                                                    _model.bloodtypeValue,
                                                allergiesOthers: _model
                                                    .allergiesTextController
                                                    .text,
                                                createdAt: getCurrentTimestamp,
                                                studentImage:
                                                    FFAppState().studentimage,
                                                schoolref: widget.schoolref,
                                                isDraft: true,
                                                document: FFAppState().fileUrl,
                                              ),
                                              studentsRecordReference2);

                                      await widget.schoolref!.update({
                                        ...mapToFirestore(
                                          {
                                            'List_of_students':
                                                FieldValue.arrayUnion([
                                              _model.studentdraft1?.reference
                                            ]),
                                            'student_data_list':
                                                FieldValue.arrayUnion([
                                              getStudentListFirestoreData(
                                                createStudentListStruct(
                                                  studentName: _model
                                                      .studentdraft1
                                                      ?.studentName,
                                                  studentId: _model
                                                      .studentdraft1?.reference,
                                                  studentImage: _model
                                                      .studentdraft1
                                                      ?.studentImage,
                                                  isDraft: true,
                                                  clearUnsetFields: false,
                                                ),
                                                true,
                                              )
                                            ]),
                                          },
                                        ),
                                      });
                                    }
                                  } else if (_model.pageViewCurrentIndex == 1) {
                                    if ((_model.emailfatherTextController
                                                .text !=
                                            _model.emailmotherTextController
                                                .text) ||
                                        (_model.emailmotherTextController
                                                    .text ==
                                                '')) {
                                      if (((_model.parent2TextController
                                                          .text !=
                                                      '') ||
                                              (_model.numbermotherTextController
                                                          .text !=
                                                      '')) ||
                                          (_model.emailmotherTextController
                                                      .text !=
                                                  '')) {
                                        if (_model.emailmotherTextController
                                                    .text !=
                                                '') {
                                          _model.addToParentsdetails(
                                              ParentsDetailsStruct(
                                            parentsId:
                                                functions.generateUniqueId(),
                                            parentsName: _model
                                                .parent2TextController.text,
                                            parentsEmail: functions
                                                    .isValidEmail(_model
                                                        .emailmotherTextController
                                                        .text)
                                                ? _model
                                                    .emailmotherTextController
                                                    .text
                                                : '${_model.emailmotherTextController.text}@feebe.in',
                                            parentsPhone: _model
                                                .numbermotherTextController
                                                .text,
                                            document: FFAppState().fileurl2,
                                            isemail: functions.isValidEmail(_model
                                                    .emailmotherTextController
                                                    .text)
                                                ? true
                                                : false,
                                            parentImage: !functions.isBlank(
                                                    FFAppState().parent2)
                                                ? FFAppState().parent2
                                                : FFAppConstants.addImage,
                                          ));
                                          safeSetState(() {});
                                        } else {
                                          _model.addToParentsdetails(
                                              ParentsDetailsStruct(
                                            parentsId:
                                                functions.generateUniqueId(),
                                            parentsName: _model
                                                .parent2TextController.text,
                                            parentsPhone: _model
                                                .numbermotherTextController
                                                .text,
                                            document: FFAppState().fileurl2,
                                            parentImage: !functions.isBlank(
                                                    FFAppState().parent2)
                                                ? FFAppState().parent2
                                                : FFAppConstants.addImage,
                                          ));
                                          safeSetState(() {});
                                        }
                                      } else {
                                        _model.parentsdetails = [];
                                        safeSetState(() {});
                                        if (_model.emailfatherTextController
                                                    .text !=
                                                '') {
                                          _model.addToParentsdetails(
                                              ParentsDetailsStruct(
                                            parentsId:
                                                functions.generateUniqueId(),
                                            parentsName: _model
                                                .parentnameTextController.text,
                                            parentsEmail: functions
                                                    .isValidEmail(_model
                                                        .emailfatherTextController
                                                        .text)
                                                ? _model
                                                    .emailfatherTextController
                                                    .text
                                                : '${_model.emailfatherTextController.text}@feebe.in',
                                            parentsPhone: _model
                                                .numberfatherTextController
                                                .text,
                                            document: FFAppState().fileurl1,
                                            isemail: functions.isValidEmail(_model
                                                    .emailfatherTextController
                                                    .text)
                                                ? true
                                                : false,
                                            parentImage: !functions.isBlank(
                                                    FFAppState().parent1)
                                                ? FFAppState().parent1
                                                : FFAppConstants.addImage,
                                          ));
                                          safeSetState(() {});
                                        } else {
                                          _model.addToParentsdetails(
                                              ParentsDetailsStruct(
                                            parentsId:
                                                functions.generateUniqueId(),
                                            parentsName: _model
                                                .parentnameTextController.text,
                                            parentsPhone: _model
                                                .numberfatherTextController
                                                .text,
                                            document: FFAppState().fileurl1,
                                            parentImage: !functions.isBlank(
                                                    FFAppState().parent1)
                                                ? FFAppState().parent1
                                                : FFAppConstants.addImage,
                                          ));
                                          safeSetState(() {});
                                        }
                                      }

                                      _model.pageno = 2;
                                      safeSetState(() {});

                                      var studentsRecordReference3 =
                                          StudentsRecord.collection.doc();
                                      await studentsRecordReference3.set({
                                        ...createStudentsRecordData(
                                          studentName: _model
                                              .childnameTextController.text,
                                          studentGender: _model.genderValue,
                                          studentAddress:
                                              _model.addressTextController.text,
                                          dateOfBirth:
                                              FFAppState().selectedDate,
                                          bloodGroup: _model.bloodtypeValue,
                                          allergiesOthers: _model
                                              .allergiesTextController.text,
                                          createdAt: getCurrentTimestamp,
                                          studentImage:
                                              FFAppState().studentimage,
                                          schoolref: widget.schoolref,
                                          isDraft: true,
                                          document: FFAppState().fileUrl,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'parents_details':
                                                getParentsDetailsListFirestoreData(
                                              _model.parentsdetails,
                                            ),
                                          },
                                        ),
                                      });
                                      _model.studentdraftParent =
                                          StudentsRecord.getDocumentFromData({
                                        ...createStudentsRecordData(
                                          studentName: _model
                                              .childnameTextController.text,
                                          studentGender: _model.genderValue,
                                          studentAddress:
                                              _model.addressTextController.text,
                                          dateOfBirth:
                                              FFAppState().selectedDate,
                                          bloodGroup: _model.bloodtypeValue,
                                          allergiesOthers: _model
                                              .allergiesTextController.text,
                                          createdAt: getCurrentTimestamp,
                                          studentImage:
                                              FFAppState().studentimage,
                                          schoolref: widget.schoolref,
                                          isDraft: true,
                                          document: FFAppState().fileUrl,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'parents_details':
                                                getParentsDetailsListFirestoreData(
                                              _model.parentsdetails,
                                            ),
                                          },
                                        ),
                                      }, studentsRecordReference3);

                                      await widget.schoolref!.update({
                                        ...mapToFirestore(
                                          {
                                            'List_of_students':
                                                FieldValue.arrayUnion([
                                              _model
                                                  .studentdraftParent?.reference
                                            ]),
                                            'student_data_list':
                                                FieldValue.arrayUnion([
                                              getStudentListFirestoreData(
                                                createStudentListStruct(
                                                  studentName: _model
                                                      .studentdraftParent
                                                      ?.studentName,
                                                  studentId: _model
                                                      .studentdraftParent
                                                      ?.reference,
                                                  studentImage: _model
                                                      .studentdraftParent
                                                      ?.studentImage,
                                                  isDraft: true,
                                                  clearUnsetFields: false,
                                                ),
                                                true,
                                              )
                                            ]),
                                          },
                                        ),
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Both parents email are same! Please add different email.',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 2350),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                      );
                                    }
                                  } else {
                                    if (((_model.gnameTextController
                                                        .text !=
                                                    '') ||
                                            (_model.gnumberTextController
                                                        .text !=
                                                    '')) ||
                                        (_model.gemailTextController.text !=
                                                '')) {
                                      if (_model.gemailTextController.text !=
                                              '') {
                                        _model.addToParentsdetails(
                                            ParentsDetailsStruct(
                                          parentsId:
                                              functions.generateUniqueId(),
                                          parentsName:
                                              _model.gnameTextController.text,
                                          parentsEmail: functions.isValidEmail(
                                                  _model.gemailTextController
                                                      .text)
                                              ? _model.gemailTextController.text
                                              : '${_model.gemailTextController.text}@feebe.in',
                                          parentsPhone:
                                              _model.gnumberTextController.text,
                                          parentRelation: 'Gurdian',
                                          isemail: functions.isValidEmail(
                                                  functions
                                                      .isValidEmail(_model
                                                          .gemailTextController
                                                          .text)
                                                      .toString())
                                              ? true
                                              : false,
                                          parentImage: !functions.isBlank(
                                                  FFAppState().guardian)
                                              ? FFAppState().guardian
                                              : FFAppConstants.addImage,
                                        ));
                                        safeSetState(() {});
                                      } else {
                                        _model.addToParentsdetails(
                                            ParentsDetailsStruct(
                                          parentsId:
                                              functions.generateUniqueId(),
                                          parentsName:
                                              _model.gnameTextController.text,
                                          parentsPhone:
                                              _model.gnumberTextController.text,
                                          parentRelation: 'Gurdian',
                                          parentImage: !functions.isBlank(
                                                  FFAppState().guardian)
                                              ? FFAppState().guardian
                                              : FFAppConstants.addImage,
                                        ));
                                        safeSetState(() {});
                                      }

                                      _model.pageno = 3;
                                      safeSetState(() {});
                                    } else {
                                      _model.pageno = 3;
                                      safeSetState(() {});
                                    }

                                    var studentsRecordReference4 =
                                        StudentsRecord.collection.doc();
                                    await studentsRecordReference4.set({
                                      ...createStudentsRecordData(
                                        studentName:
                                            _model.childnameTextController.text,
                                        studentGender: _model.genderValue,
                                        studentAddress:
                                            _model.addressTextController.text,
                                        dateOfBirth:
                                            FFAppState().selectedDate != null
                                                ? FFAppState().selectedDate
                                                : getCurrentTimestamp,
                                        bloodGroup: _model.bloodtypeValue,
                                        allergiesOthers:
                                            _model.allergiesTextController.text,
                                        createdAt: getCurrentTimestamp,
                                        studentImage: FFAppState().studentimage,
                                        schoolref: widget.schoolref,
                                        isDraft: true,
                                        document: FFAppState().fileUrl,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'parents_details':
                                              getParentsDetailsListFirestoreData(
                                            _model.parentsdetails,
                                          ),
                                        },
                                      ),
                                    });
                                    _model.studentdraftgau =
                                        StudentsRecord.getDocumentFromData({
                                      ...createStudentsRecordData(
                                        studentName:
                                            _model.childnameTextController.text,
                                        studentGender: _model.genderValue,
                                        studentAddress:
                                            _model.addressTextController.text,
                                        dateOfBirth:
                                            FFAppState().selectedDate != null
                                                ? FFAppState().selectedDate
                                                : getCurrentTimestamp,
                                        bloodGroup: _model.bloodtypeValue,
                                        allergiesOthers:
                                            _model.allergiesTextController.text,
                                        createdAt: getCurrentTimestamp,
                                        studentImage: FFAppState().studentimage,
                                        schoolref: widget.schoolref,
                                        isDraft: true,
                                        document: FFAppState().fileUrl,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'parents_details':
                                              getParentsDetailsListFirestoreData(
                                            _model.parentsdetails,
                                          ),
                                        },
                                      ),
                                    }, studentsRecordReference4);

                                    await widget.schoolref!.update({
                                      ...mapToFirestore(
                                        {
                                          'List_of_students':
                                              FieldValue.arrayUnion([
                                            _model.studentdraftgau?.reference
                                          ]),
                                          'student_data_list':
                                              FieldValue.arrayUnion([
                                            getStudentListFirestoreData(
                                              createStudentListStruct(
                                                studentName: _model
                                                    .studentdraftgau
                                                    ?.studentName,
                                                studentId: _model
                                                    .studentdraftgau?.reference,
                                                studentImage: _model
                                                    .studentdraftgau
                                                    ?.studentImage,
                                                isDraft: true,
                                                clearUnsetFields: false,
                                              ),
                                              true,
                                            )
                                          ]),
                                        },
                                      ),
                                    });
                                  }

                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, -0.7)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.1,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.3,
                                            child: DraftsavedWidget(
                                              schoolref: widget.schoolref!,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  safeSetState(() {});
                                },
                                child: Text(
                                  'Save Draft',
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
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
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
                    centerTitle: false,
                    elevation: 0.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    child: custom_widgets.BackButtonOverrider(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      onBack: () async {
                        if (_model.pageno == 3) {
                          _model.pageno = 2;
                          safeSetState(() {});
                          await _model.pageViewController?.animateToPage(
                            2,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        } else if (_model.pageno == 2) {
                          _model.pageno = 1;
                          safeSetState(() {});
                          await _model.pageViewController?.animateToPage(
                            1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        } else if (_model.pageno == 1) {
                          _model.pageno = 0;
                          safeSetState(() {});
                          await _model.pageViewController?.animateToPage(
                            0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        } else {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text(
                                        'Would you like to save your progress '),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            if (_model.pageViewCurrentIndex == 0) {
                              if (FFAppState().selectedDate != null) {
                                var studentsRecordReference1 =
                                    StudentsRecord.collection.doc();
                                await studentsRecordReference1
                                    .set(createStudentsRecordData(
                                  studentName:
                                      _model.childnameTextController.text,
                                  studentGender: _model.genderValue,
                                  studentAddress:
                                      _model.addressTextController.text,
                                  dateOfBirth: FFAppState().selectedDate,
                                  bloodGroup: _model.bloodtypeValue,
                                  allergiesOthers:
                                      _model.allergiesTextController.text,
                                  createdAt: getCurrentTimestamp,
                                  studentImage: FFAppState().studentimage,
                                  schoolref: widget.schoolref,
                                  isDraft: true,
                                  document: FFAppState().fileUrl,
                                ));
                                _model.studentdraft12back =
                                    StudentsRecord.getDocumentFromData(
                                        createStudentsRecordData(
                                          studentName: _model
                                              .childnameTextController.text,
                                          studentGender: _model.genderValue,
                                          studentAddress:
                                              _model.addressTextController.text,
                                          dateOfBirth:
                                              FFAppState().selectedDate,
                                          bloodGroup: _model.bloodtypeValue,
                                          allergiesOthers: _model
                                              .allergiesTextController.text,
                                          createdAt: getCurrentTimestamp,
                                          studentImage:
                                              FFAppState().studentimage,
                                          schoolref: widget.schoolref,
                                          isDraft: true,
                                          document: FFAppState().fileUrl,
                                        ),
                                        studentsRecordReference1);

                                await widget.schoolref!.update({
                                  ...mapToFirestore(
                                    {
                                      'List_of_students': FieldValue.arrayUnion(
                                          [_model.studentdraft12?.reference]),
                                      'student_data_list':
                                          FieldValue.arrayUnion([
                                        getStudentListFirestoreData(
                                          createStudentListStruct(
                                            studentName: _model
                                                .studentdraft12?.studentName,
                                            studentId: _model
                                                .studentdraft12?.reference,
                                            studentImage: _model
                                                .studentdraft12?.studentImage,
                                            isDraft: true,
                                            clearUnsetFields: false,
                                          ),
                                          true,
                                        )
                                      ]),
                                    },
                                  ),
                                });
                              } else {
                                var studentsRecordReference2 =
                                    StudentsRecord.collection.doc();
                                await studentsRecordReference2
                                    .set(createStudentsRecordData(
                                  studentName:
                                      _model.childnameTextController.text,
                                  studentGender: _model.genderValue,
                                  studentAddress:
                                      _model.addressTextController.text,
                                  bloodGroup: _model.bloodtypeValue,
                                  allergiesOthers:
                                      _model.allergiesTextController.text,
                                  createdAt: getCurrentTimestamp,
                                  studentImage: FFAppState().studentimage,
                                  schoolref: widget.schoolref,
                                  isDraft: true,
                                  document: FFAppState().fileUrl,
                                ));
                                _model.studentdraft123back =
                                    StudentsRecord.getDocumentFromData(
                                        createStudentsRecordData(
                                          studentName: _model
                                              .childnameTextController.text,
                                          studentGender: _model.genderValue,
                                          studentAddress:
                                              _model.addressTextController.text,
                                          bloodGroup: _model.bloodtypeValue,
                                          allergiesOthers: _model
                                              .allergiesTextController.text,
                                          createdAt: getCurrentTimestamp,
                                          studentImage:
                                              FFAppState().studentimage,
                                          schoolref: widget.schoolref,
                                          isDraft: true,
                                          document: FFAppState().fileUrl,
                                        ),
                                        studentsRecordReference2);

                                await widget.schoolref!.update({
                                  ...mapToFirestore(
                                    {
                                      'List_of_students': FieldValue.arrayUnion(
                                          [_model.studentdraft123?.reference]),
                                      'student_data_list':
                                          FieldValue.arrayUnion([
                                        getStudentListFirestoreData(
                                          createStudentListStruct(
                                            studentName: _model
                                                .studentdraft123?.studentName,
                                            studentId: _model
                                                .studentdraft123?.reference,
                                            studentImage: _model
                                                .studentdraft123?.studentImage,
                                            isDraft: true,
                                            clearUnsetFields: false,
                                          ),
                                          true,
                                        )
                                      ]),
                                    },
                                  ),
                                });
                              }
                            } else if (_model.pageViewCurrentIndex == 1) {
                              if ((_model.emailfatherTextController.text !=
                                      _model.emailmotherTextController.text) ||
                                  (_model.emailmotherTextController.text ==
                                          '')) {
                                if (((_model.parent2TextController.text !=
                                                '') ||
                                        (_model.numbermotherTextController
                                                    .text !=
                                                '')) ||
                                    (_model.emailmotherTextController.text !=
                                            '')) {
                                  if (_model.emailmotherTextController.text !=
                                          '') {
                                    _model.addToParentsdetails(
                                        ParentsDetailsStruct(
                                      parentsId: functions.generateUniqueId(),
                                      parentsName:
                                          _model.parent2TextController.text,
                                      parentsEmail: functions.isValidEmail(
                                              _model.emailmotherTextController
                                                  .text)
                                          ? _model
                                              .emailmotherTextController.text
                                          : '${_model.emailmotherTextController.text}@feebe.in',
                                      parentsPhone: _model
                                          .numbermotherTextController.text,
                                      document: FFAppState().fileurl2,
                                      isemail: functions.isValidEmail(_model
                                              .emailmotherTextController.text)
                                          ? true
                                          : false,
                                      parentImage: !functions
                                              .isBlank(FFAppState().parent2)
                                          ? FFAppState().parent2
                                          : FFAppConstants.addImage,
                                    ));
                                    safeSetState(() {});
                                  } else {
                                    _model.addToParentsdetails(
                                        ParentsDetailsStruct(
                                      parentsId: functions.generateUniqueId(),
                                      parentsName:
                                          _model.parent2TextController.text,
                                      parentsPhone: _model
                                          .numbermotherTextController.text,
                                      document: FFAppState().fileurl2,
                                      parentImage: !functions
                                              .isBlank(FFAppState().parent2)
                                          ? FFAppState().parent2
                                          : FFAppConstants.addImage,
                                    ));
                                    safeSetState(() {});
                                  }
                                } else {
                                  _model.parentsdetails = [];
                                  safeSetState(() {});
                                  if (_model.emailfatherTextController.text !=
                                          '') {
                                    _model.addToParentsdetails(
                                        ParentsDetailsStruct(
                                      parentsId: functions.generateUniqueId(),
                                      parentsName:
                                          _model.parentnameTextController.text,
                                      parentsEmail: functions.isValidEmail(
                                              _model.emailfatherTextController
                                                  .text)
                                          ? _model
                                              .emailfatherTextController.text
                                          : '${_model.emailfatherTextController.text}@feebe.in',
                                      parentsPhone: _model
                                          .numberfatherTextController.text,
                                      document: FFAppState().fileurl1,
                                      isemail: functions.isValidEmail(_model
                                              .emailfatherTextController.text)
                                          ? true
                                          : false,
                                      parentImage: !functions
                                              .isBlank(FFAppState().parent1)
                                          ? FFAppState().parent1
                                          : FFAppConstants.addImage,
                                    ));
                                    safeSetState(() {});
                                  } else {
                                    _model.addToParentsdetails(
                                        ParentsDetailsStruct(
                                      parentsId: functions.generateUniqueId(),
                                      parentsName:
                                          _model.parentnameTextController.text,
                                      parentsPhone: _model
                                          .numberfatherTextController.text,
                                      document: FFAppState().fileurl1,
                                      parentImage: !functions
                                              .isBlank(FFAppState().parent1)
                                          ? FFAppState().parent1
                                          : FFAppConstants.addImage,
                                    ));
                                    safeSetState(() {});
                                  }
                                }

                                _model.pageno = 2;
                                safeSetState(() {});

                                var studentsRecordReference3 =
                                    StudentsRecord.collection.doc();
                                await studentsRecordReference3.set({
                                  ...createStudentsRecordData(
                                    studentName:
                                        _model.childnameTextController.text,
                                    studentGender: _model.genderValue,
                                    studentAddress:
                                        _model.addressTextController.text,
                                    dateOfBirth:
                                        FFAppState().selectedDate != null
                                            ? FFAppState().selectedDate
                                            : getCurrentTimestamp,
                                    bloodGroup: _model.bloodtypeValue,
                                    allergiesOthers:
                                        _model.allergiesTextController.text,
                                    createdAt: getCurrentTimestamp,
                                    studentImage: FFAppState().studentimage,
                                    schoolref: widget.schoolref,
                                    isDraft: true,
                                    document: FFAppState().fileUrl,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'parents_details':
                                          getParentsDetailsListFirestoreData(
                                        _model.parentsdetails,
                                      ),
                                    },
                                  ),
                                });
                                _model.studentdraftParent1back =
                                    StudentsRecord.getDocumentFromData({
                                  ...createStudentsRecordData(
                                    studentName:
                                        _model.childnameTextController.text,
                                    studentGender: _model.genderValue,
                                    studentAddress:
                                        _model.addressTextController.text,
                                    dateOfBirth:
                                        FFAppState().selectedDate != null
                                            ? FFAppState().selectedDate
                                            : getCurrentTimestamp,
                                    bloodGroup: _model.bloodtypeValue,
                                    allergiesOthers:
                                        _model.allergiesTextController.text,
                                    createdAt: getCurrentTimestamp,
                                    studentImage: FFAppState().studentimage,
                                    schoolref: widget.schoolref,
                                    isDraft: true,
                                    document: FFAppState().fileUrl,
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'parents_details':
                                          getParentsDetailsListFirestoreData(
                                        _model.parentsdetails,
                                      ),
                                    },
                                  ),
                                }, studentsRecordReference3);

                                await widget.schoolref!.update({
                                  ...mapToFirestore(
                                    {
                                      'List_of_students':
                                          FieldValue.arrayUnion([
                                        _model.studentdraftParent1?.reference
                                      ]),
                                      'student_data_list':
                                          FieldValue.arrayUnion([
                                        getStudentListFirestoreData(
                                          createStudentListStruct(
                                            studentName: _model
                                                .studentdraftParent1
                                                ?.studentName,
                                            studentId: _model
                                                .studentdraftParent1?.reference,
                                            studentImage: _model
                                                .studentdraftParent1
                                                ?.studentImage,
                                            isDraft: true,
                                            clearUnsetFields: false,
                                          ),
                                          true,
                                        )
                                      ]),
                                    },
                                  ),
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Both parents email are same! Please add different email.',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 2350),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                  ),
                                );
                              }
                            } else {
                              if (((_model.gnameTextController.text !=
                                              '') ||
                                      (_model.gnumberTextController.text !=
                                              '')) ||
                                  (_model.gemailTextController.text != '')) {
                                if (_model.gemailTextController.text != '') {
                                  _model
                                      .addToParentsdetails(ParentsDetailsStruct(
                                    parentsId: functions.generateUniqueId(),
                                    parentsName:
                                        _model.gnameTextController.text,
                                    parentsEmail: functions.isValidEmail(
                                            _model.gemailTextController.text)
                                        ? _model.gemailTextController.text
                                        : '${_model.gemailTextController.text}@feebe.in',
                                    parentsPhone:
                                        _model.gnumberTextController.text,
                                    parentRelation: 'Gurdian',
                                    isemail: functions.isValidEmail(functions
                                            .isValidEmail(_model
                                                .gemailTextController.text)
                                            .toString())
                                        ? true
                                        : false,
                                    parentImage: !functions
                                            .isBlank(FFAppState().guardian)
                                        ? FFAppState().guardian
                                        : FFAppConstants.addImage,
                                  ));
                                  safeSetState(() {});
                                } else {
                                  _model
                                      .addToParentsdetails(ParentsDetailsStruct(
                                    parentsId: functions.generateUniqueId(),
                                    parentsName:
                                        _model.gnameTextController.text,
                                    parentsPhone:
                                        _model.gnumberTextController.text,
                                    parentRelation: 'Gurdian',
                                    parentImage: !functions
                                            .isBlank(FFAppState().guardian)
                                        ? FFAppState().guardian
                                        : FFAppConstants.addImage,
                                  ));
                                  safeSetState(() {});
                                }

                                _model.pageno = 3;
                                safeSetState(() {});
                              } else {
                                _model.pageno = 3;
                                safeSetState(() {});
                              }

                              var studentsRecordReference4 =
                                  StudentsRecord.collection.doc();
                              await studentsRecordReference4.set({
                                ...createStudentsRecordData(
                                  studentName:
                                      _model.childnameTextController.text,
                                  studentGender: _model.genderValue,
                                  studentAddress:
                                      _model.addressTextController.text,
                                  dateOfBirth: FFAppState().selectedDate,
                                  bloodGroup: _model.bloodtypeValue,
                                  allergiesOthers:
                                      _model.allergiesTextController.text,
                                  createdAt: getCurrentTimestamp,
                                  studentImage: FFAppState().studentimage,
                                  schoolref: widget.schoolref,
                                  isDraft: true,
                                  document: FFAppState().fileUrl,
                                ),
                                ...mapToFirestore(
                                  {
                                    'parents_details':
                                        getParentsDetailsListFirestoreData(
                                      _model.parentsdetails,
                                    ),
                                  },
                                ),
                              });
                              _model.draftguardianback =
                                  StudentsRecord.getDocumentFromData({
                                ...createStudentsRecordData(
                                  studentName:
                                      _model.childnameTextController.text,
                                  studentGender: _model.genderValue,
                                  studentAddress:
                                      _model.addressTextController.text,
                                  dateOfBirth: FFAppState().selectedDate,
                                  bloodGroup: _model.bloodtypeValue,
                                  allergiesOthers:
                                      _model.allergiesTextController.text,
                                  createdAt: getCurrentTimestamp,
                                  studentImage: FFAppState().studentimage,
                                  schoolref: widget.schoolref,
                                  isDraft: true,
                                  document: FFAppState().fileUrl,
                                ),
                                ...mapToFirestore(
                                  {
                                    'parents_details':
                                        getParentsDetailsListFirestoreData(
                                      _model.parentsdetails,
                                    ),
                                  },
                                ),
                              }, studentsRecordReference4);

                              await widget.schoolref!.update({
                                ...mapToFirestore(
                                  {
                                    'List_of_students': FieldValue.arrayUnion(
                                        [_model.draftguardian?.reference]),
                                    'student_data_list': FieldValue.arrayUnion([
                                      getStudentListFirestoreData(
                                        createStudentListStruct(
                                          studentName:
                                              _model.draftguardian?.studentName,
                                          studentId:
                                              _model.draftguardian?.reference,
                                          studentImage: _model
                                              .draftguardian?.studentImage,
                                          isDraft: true,
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Progress saved',
                                  style: TextStyle(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryText,
                              ),
                            );
                            FFAppState().studentimage = '';
                            FFAppState().fileUrl = '';
                            FFAppState().fileurl1 = '';
                            FFAppState().fileurl2 = '';
                            FFAppState().parent1 = '';
                            FFAppState().parent2 = '';
                            FFAppState().guardian = '';
                            FFAppState().selectedDate = null;
                            FFAppState().imageurl = '';
                            safeSetState(() {});
                            if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) ==
                                2) {
                              context.goNamed(
                                ClassDashboardWidget.routeName,
                                queryParameters: {
                                  'schoolref': serializeParam(
                                    addStudentManuallySchoolRecord.reference,
                                    ParamType.DocumentReference,
                                  ),
                                  'tabindex': serializeParam(
                                    3,
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            } else {
                              context.goNamed(
                                DashboardWidget.routeName,
                                queryParameters: {
                                  'tabindex': serializeParam(
                                    3,
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            }
                          } else {
                            FFAppState().studentimage = '';
                            FFAppState().fileUrl = '';
                            FFAppState().fileurl1 = '';
                            FFAppState().fileurl2 = '';
                            FFAppState().parent1 = '';
                            FFAppState().parent2 = '';
                            FFAppState().guardian = '';
                            FFAppState().selectedDate = null;
                            FFAppState().imageurl = '';
                            safeSetState(() {});
                            context.safePop();
                          }
                        }

                        safeSetState(() {});
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.82,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiary,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _model.pageViewController ??=
                              PageController(initialPage: 0),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Form(
                              key: _model.formKey3,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            width: 3.0,
                                                          ),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Text(
                                                            '01',
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
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
                                                      Container(
                                                        width: 50.0,
                                                        height: 3.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFD6DC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  'Student ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.099,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.099,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFF5F2F2),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          '02',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
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
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 3.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFD6DC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Parent',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.099,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.099,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFF5F2F2),
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          '03',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
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
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 3.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFD6DC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Guardian',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
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
                                                      color: Color(0xFFF5F2F2),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      '04',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
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
                                                Text(
                                                  'Save',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, -1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0,
                                                                0.0, 0.0),
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
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          enableDrag: false,
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
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.2,
                                                                  child:
                                                                      EditphotoWidget(
                                                                    person:
                                                                        false,
                                                                    child: true,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.3,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.3,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            FFAppState()
                                                                            .studentimage !=
                                                                        ''
                                                                ? FFAppState()
                                                                    .studentimage
                                                                : FFAppConstants
                                                                    .addImage,
                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 65.0,
                                                      child:
                                                          StyledVerticalDivider(
                                                        thickness: 2.0,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        lineStyle:
                                                            DividerLineStyle
                                                                .dashed,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.9,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .childnameTextController,
                                                      focusNode: _model
                                                          .childnameFocusNode,
                                                      autofocus: false,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelText:
                                                            'Child\'s name *',
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    (_model.childnameFocusNode?.hasFocus ??
                                                                            false)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primary
                                                                        : FlutterFlowTheme.of(context)
                                                                            .textfieldText,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .textfieldText,
                                                                  ),
                                                                  fontSize: (_model
                                                                              .childnameFocusNode
                                                                              ?.hasFocus ??
                                                                          false)
                                                                      ? 12.0
                                                                      : 16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintText:
                                                            'Child\'s name',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Color(
                                                                      0xFF747373),
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .textfieldDisable,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .text2,
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
                                                      keyboardType:
                                                          TextInputType.name,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .childnameTextControllerValidator
                                                          .asValidator(context),
                                                      inputFormatters: [
                                                        if (!isAndroid &&
                                                            !isiOS)
                                                          TextInputFormatter
                                                              .withFunction(
                                                                  (oldValue,
                                                                      newValue) {
                                                            return TextEditingValue(
                                                              selection: newValue
                                                                  .selection,
                                                              text: newValue
                                                                  .text
                                                                  .toCapitalization(
                                                                      TextCapitalization
                                                                          .sentences),
                                                            );
                                                          }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 10.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Builder(
                                                          builder: (context) =>
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
                                                            onTap: () async {
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (dialogContext) {
                                                                  return Dialog(
                                                                    elevation:
                                                                        0,
                                                                    insetPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(dialogContext)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.5,
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.4,
                                                                        child:
                                                                            CalenderWidget(
                                                                          allowpast:
                                                                              true,
                                                                          allowfuture:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.4,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.055,
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldDisable,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
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
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        if (FFAppState().selectedDate !=
                                                                            null)
                                                                          Text(
                                                                            dateTimeFormat("yMd",
                                                                                FFAppState().selectedDate),
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
                                                                          ),
                                                                        if (FFAppState().selectedDate ==
                                                                            null)
                                                                          Text(
                                                                            'DOB *',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).textfieldText,
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      FlutterFlowDropDown<
                                                          String>(
                                                        controller: _model
                                                                .genderValueController ??=
                                                            FormFieldController<
                                                                String>(null),
                                                        options: [
                                                          'Male',
                                                          'Female'
                                                        ],
                                                        onChanged: (val) =>
                                                            safeSetState(() =>
                                                                _model.genderValue =
                                                                    val),
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.4,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.055,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text2,
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
                                                        hintText: 'Gender *',
                                                        icon: Icon(
                                                          Icons.arrow_drop_down,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          size: 24.0,
                                                        ),
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        elevation: 2.0,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .textfieldDisable,
                                                        borderWidth: 1.0,
                                                        borderRadius: 8.0,
                                                        margin:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        hidesUnderline: true,
                                                        isOverButton: false,
                                                        isSearchable: false,
                                                        isMultiSelect: false,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 10.0),
                                                  child: FlutterFlowDropDown<
                                                      String>(
                                                    controller: _model
                                                            .bloodtypeValueController ??=
                                                        FormFieldController<
                                                            String>(null),
                                                    options: [
                                                      'A+',
                                                      'A-',
                                                      'B+',
                                                      'B-',
                                                      'AB+',
                                                      'AB- ',
                                                      'O+ ',
                                                      'O- '
                                                    ],
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .bloodtypeValue =
                                                            val),
                                                    width: 200.0,
                                                    textStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiaryText,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                    hintText: 'Blood Group',
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                    elevation: 2.0,
                                                    borderColor:
                                                        Color(0xFF747373),
                                                    borderWidth: 1.0,
                                                    borderRadius: 8.0,
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    hidesUnderline: true,
                                                    isOverButton: true,
                                                    isSearchable: false,
                                                    isMultiSelect: false,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.9,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .allergiesTextController,
                                                      focusNode: _model
                                                          .allergiesFocusNode,
                                                      autofocus: false,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelText: 'Allergies',
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    (_model.allergiesFocusNode?.hasFocus ??
                                                                            false)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primary
                                                                        : FlutterFlowTheme.of(context)
                                                                            .textfieldText,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .textfieldText,
                                                                  ),
                                                                  fontSize: (_model
                                                                              .allergiesFocusNode
                                                                              ?.hasFocus ??
                                                                          false)
                                                                      ? 12.0
                                                                      : 16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintText:
                                                            'Allergies(if any)',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Color(
                                                                      0xFF747373),
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .textfieldDisable,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .text2,
                                                                fontSize: 12.0,
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
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .allergiesTextControllerValidator
                                                          .asValidator(context),
                                                      inputFormatters: [
                                                        if (!isAndroid &&
                                                            !isiOS)
                                                          TextInputFormatter
                                                              .withFunction(
                                                                  (oldValue,
                                                                      newValue) {
                                                            return TextEditingValue(
                                                              selection: newValue
                                                                  .selection,
                                                              text: newValue
                                                                  .text
                                                                  .toCapitalization(
                                                                      TextCapitalization
                                                                          .sentences),
                                                            );
                                                          }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 10.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.9,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .addressTextController,
                                                      focusNode: _model
                                                          .addressFocusNode,
                                                      autofocus: false,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelText: 'Address *',
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    (_model.addressFocusNode?.hasFocus ??
                                                                            false)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primary
                                                                        : FlutterFlowTheme.of(context)
                                                                            .textfieldText,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .textfieldText,
                                                                  ),
                                                                  fontSize: (_model
                                                                              .addressFocusNode
                                                                              ?.hasFocus ??
                                                                          false)
                                                                      ? 12.0
                                                                      : 16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintText: 'Address',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Color(
                                                                      0xFF747373),
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .textfieldDisable,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .text2,
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
                                                      maxLines: 3,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .addressTextControllerValidator
                                                          .asValidator(context),
                                                      inputFormatters: [
                                                        if (!isAndroid &&
                                                            !isiOS)
                                                          TextInputFormatter
                                                              .withFunction(
                                                                  (oldValue,
                                                                      newValue) {
                                                            return TextEditingValue(
                                                              selection: newValue
                                                                  .selection,
                                                              text: newValue
                                                                  .text
                                                                  .toCapitalization(
                                                                      TextCapitalization
                                                                          .sentences),
                                                            );
                                                          }),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, -1.0),
                                                  child: Builder(
                                                    builder: (context) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          await showDialog(
                                                            context: context,
                                                            builder:
                                                                (dialogContext) {
                                                              return Dialog(
                                                                elevation: 0,
                                                                insetPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                alignment: AlignmentDirectional(
                                                                        0.0,
                                                                        1.0)
                                                                    .resolve(
                                                                        Directionality.of(
                                                                            context)),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            dialogContext)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.25,
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    child:
                                                                        ParentdocumentWidget(
                                                                      child:
                                                                          true,
                                                                      parent1:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        text: FFAppState()
                                                                        .fileUrl ==
                                                                    ''
                                                            ? 'Upload the document proof'
                                                            : 'Change the document proof',
                                                        icon: Icon(
                                                          Icons.photo_outlined,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.7,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.04,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconAlignment:
                                                              IconAlignment.end,
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                            font: GoogleFonts
                                                                .nunito(
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
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
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
                                                                color: Color(
                                                                    0xFFF4F5FA),
                                                                offset: Offset(
                                                                    0.0, -3.0),
                                                                blurRadius: 6.0,
                                                              )
                                                            ],
                                                          ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 0.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (FFAppState().fileUrl != '')
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        await launchURL(
                                                            FFAppState()
                                                                .fileUrl);
                                                      },
                                                      text: 'View file',
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.04,
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
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                        elevation: 0.0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                              ].addToEnd(
                                                  SizedBox(height: 30.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].addToEnd(SizedBox(height: 20.0)),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.pageViewController
                                                  ?.animateToPage(
                                                0,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.ease,
                                              );
                                              _model.pageno = 0;
                                              safeSetState(() {});
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.099,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.099,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.check,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 50.0,
                                                      height: 3.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFCFD6DC),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Student ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.099,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.099,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '02',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
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
                                                  Container(
                                                    width: 50.0,
                                                    height: 3.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFCFD6DC),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Parent',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.099,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.099,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFFF5F2F2),
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '03',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
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
                                                  Container(
                                                    width: 50.0,
                                                    height: 3.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFCFD6DC),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Guardian',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
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
                                                    color: Color(0xFFF5F2F2),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    '04',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
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
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
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
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Form(
                                          key: _model.formKey4,
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 10.0, 0.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Parent 1 *',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                                  fontSize:
                                                                      18.0,
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
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, -1.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
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
                                                                          Container(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.2,
                                                                        child:
                                                                            ParentphotoWidget(
                                                                          parent2:
                                                                              false,
                                                                          parent1:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            },
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.3,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.3,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  FFAppState().parent1 !=
                                                                              ''
                                                                      ? FFAppState()
                                                                          .parent1
                                                                      : FFAppConstants
                                                                          .addImage,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
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
                                                                    10.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.9,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .parentnameTextController,
                                                            focusNode: _model
                                                                .parentnameFocusNode,
                                                            autofocus: false,
                                                            textCapitalization:
                                                                TextCapitalization
                                                                    .sentences,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Parent\'s Name *',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          (_model.parentnameFocusNode?.hasFocus ?? false)
                                                                              ? FlutterFlowTheme.of(context).primary
                                                                              : FlutterFlowTheme.of(context).textfieldText,
                                                                          FlutterFlowTheme.of(context)
                                                                              .textfieldText,
                                                                        ),
                                                                        fontSize: (_model.parentnameFocusNode?.hasFocus ??
                                                                                false)
                                                                            ? 12.0
                                                                            : 16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintText:
                                                                  'Parent\'s Name',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFF737474),
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldDisable,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text2,
                                                                  fontSize:
                                                                      14.0,
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
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .parentnameTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                            inputFormatters: [
                                                              if (!isAndroid &&
                                                                  !isiOS)
                                                                TextInputFormatter
                                                                    .withFunction(
                                                                        (oldValue,
                                                                            newValue) {
                                                                  return TextEditingValue(
                                                                    selection:
                                                                        newValue
                                                                            .selection,
                                                                    text: newValue
                                                                        .text
                                                                        .toCapitalization(
                                                                            TextCapitalization.sentences),
                                                                  );
                                                                }),
                                                            ],
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
                                                                    10.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.9,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .numberfatherTextController,
                                                            focusNode: _model
                                                                .numberfatherFocusNode,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Phone Number *',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          (_model.numberfatherFocusNode?.hasFocus ?? false)
                                                                              ? FlutterFlowTheme.of(context).primary
                                                                              : FlutterFlowTheme.of(context).textfieldText,
                                                                          FlutterFlowTheme.of(context)
                                                                              .textfieldText,
                                                                        ),
                                                                        fontSize: (_model.numberfatherFocusNode?.hasFocus ??
                                                                                false)
                                                                            ? 12.0
                                                                            : 16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintText:
                                                                  'Phone Number ',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFF737474),
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldDisable,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text2,
                                                                  fontSize:
                                                                      14.0,
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
                                                            maxLength: 10,
                                                            buildCounter: (context,
                                                                    {required currentLength,
                                                                    required isFocused,
                                                                    maxLength}) =>
                                                                null,
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .numberfatherTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      '[0-9]'))
                                                            ],
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
                                                                    10.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.9,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .emailfatherTextController,
                                                            focusNode: _model
                                                                .emailfatherFocusNode,
                                                            autofocus: false,
                                                            textCapitalization:
                                                                TextCapitalization
                                                                    .none,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              labelText:
                                                                  'Username / Email *',
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          (_model.emailfatherFocusNode?.hasFocus ?? false)
                                                                              ? FlutterFlowTheme.of(context).primary
                                                                              : FlutterFlowTheme.of(context).textfieldText,
                                                                          FlutterFlowTheme.of(context)
                                                                              .textfieldText,
                                                                        ),
                                                                        fontSize: (_model.emailfatherFocusNode?.hasFocus ??
                                                                                false)
                                                                            ? 12.0
                                                                            : 16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintText:
                                                                  'Username / Email',
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .textfieldText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldDisable,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text2,
                                                                  fontSize:
                                                                      14.0,
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
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            validator: _model
                                                                .emailfatherTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                            inputFormatters: [
                                                              if (!isAndroid &&
                                                                  !isiOS)
                                                                TextInputFormatter
                                                                    .withFunction(
                                                                        (oldValue,
                                                                            newValue) {
                                                                  return TextEditingValue(
                                                                    selection:
                                                                        newValue
                                                                            .selection,
                                                                    text: newValue
                                                                        .text
                                                                        .toCapitalization(
                                                                            TextCapitalization.none),
                                                                  );
                                                                }),
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      '[a-z0-9@.]'))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, -1.0),
                                                        child: Builder(
                                                          builder: (context) =>
                                                              Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (dialogContext) {
                                                                    return Dialog(
                                                                      elevation:
                                                                          0,
                                                                      insetPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              1.0)
                                                                          .resolve(
                                                                              Directionality.of(context)),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          FocusScope.of(dialogContext)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.25,
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 1.0,
                                                                          child:
                                                                              ParentdocumentWidget(
                                                                            child:
                                                                                false,
                                                                            parent1:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              text: FFAppState()
                                                                              .fileurl1 ==
                                                                          ''
                                                                  ? 'Upload the document proof'
                                                                  : 'Change the document proof',
                                                              icon: Icon(
                                                                Icons
                                                                    .photo_outlined,
                                                                size: 20.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.7,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.04,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconAlignment:
                                                                    IconAlignment
                                                                        .end,
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
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
                                                                      color: Color(
                                                                          0xFFF4F5FA),
                                                                      offset: Offset(
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
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 0.5,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (FFAppState()
                                                                  .fileurl1 !=
                                                              '')
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, -1.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              await launchURL(
                                                                  FFAppState()
                                                                      .fileurl1);
                                                            },
                                                            text: 'View file',
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.7,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.04,
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
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
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
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 10.0, 10.0, 0.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Form(
                                                      key: _model.formKey2,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .disabled,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  'Parent 2',
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
                                                                        fontSize:
                                                                            18.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                          10.0,
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
                                                                onTap:
                                                                    () async {
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
                                                                        onTap:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              MediaQuery.viewInsetsOf(context),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.2,
                                                                            child:
                                                                                ParentphotoWidget(
                                                                              parent2: true,
                                                                              parent1: false,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ).then((value) =>
                                                                      safeSetState(
                                                                          () {}));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.3,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.3,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      FFAppState().parent2 !=
                                                                                  ''
                                                                          ? FFAppState()
                                                                              .parent2
                                                                          : FFAppConstants
                                                                              .addImage,
                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          10.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.9,
                                                                child:
                                                                    TextFormField(
                                                                  controller: _model
                                                                      .parent2TextController,
                                                                  focusNode: _model
                                                                      .parent2FocusNode,
                                                                  autofocus:
                                                                      false,
                                                                  textCapitalization:
                                                                      TextCapitalization
                                                                          .sentences,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    labelText:
                                                                        'Parent\'s Name',
                                                                    labelStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              valueOrDefault<Color>(
                                                                            (_model.parent2FocusNode?.hasFocus ?? false)
                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                : FlutterFlowTheme.of(context).textfieldText,
                                                                            FlutterFlowTheme.of(context).textfieldText,
                                                                          ),
                                                                          fontSize: (_model.parent2FocusNode?.hasFocus ?? false)
                                                                              ? 12.0
                                                                              : 16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Parent\'s Name',
                                                                    hintStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).textfieldText,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .textfieldDisable,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .text2,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  cursorColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  validator: _model
                                                                      .parent2TextControllerValidator
                                                                      .asValidator(
                                                                          context),
                                                                  inputFormatters: [
                                                                    if (!isAndroid &&
                                                                        !isiOS)
                                                                      TextInputFormatter.withFunction(
                                                                          (oldValue,
                                                                              newValue) {
                                                                        return TextEditingValue(
                                                                          selection:
                                                                              newValue.selection,
                                                                          text: newValue
                                                                              .text
                                                                              .toCapitalization(TextCapitalization.sentences),
                                                                        );
                                                                      }),
                                                                  ],
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
                                                                          10.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.9,
                                                                child:
                                                                    TextFormField(
                                                                  controller: _model
                                                                      .numbermotherTextController,
                                                                  focusNode: _model
                                                                      .numbermotherFocusNode,
                                                                  autofocus:
                                                                      false,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    labelText:
                                                                        'Phone Number ',
                                                                    labelStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              valueOrDefault<Color>(
                                                                            (_model.numbermotherFocusNode?.hasFocus ?? false)
                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                : FlutterFlowTheme.of(context).textfieldText,
                                                                            FlutterFlowTheme.of(context).textfieldText,
                                                                          ),
                                                                          fontSize: (_model.numbermotherFocusNode?.hasFocus ?? false)
                                                                              ? 12.0
                                                                              : 16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Phone Number ',
                                                                    hintStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).textfieldText,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .textfieldDisable,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .text2,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  maxLength: 10,
                                                                  buildCounter: (context,
                                                                          {required currentLength,
                                                                          required isFocused,
                                                                          maxLength}) =>
                                                                      null,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .phone,
                                                                  cursorColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  validator: _model
                                                                      .numbermotherTextControllerValidator
                                                                      .asValidator(
                                                                          context),
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            '[0-9]'))
                                                                  ],
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
                                                                          10.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.9,
                                                                child:
                                                                    TextFormField(
                                                                  controller: _model
                                                                      .emailmotherTextController,
                                                                  focusNode: _model
                                                                      .emailmotherFocusNode,
                                                                  autofocus:
                                                                      false,
                                                                  obscureText:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    labelText:
                                                                        'Username / Email',
                                                                    labelStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              valueOrDefault<Color>(
                                                                            (_model.emailmotherFocusNode?.hasFocus ?? false)
                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                : FlutterFlowTheme.of(context).textfieldText,
                                                                            FlutterFlowTheme.of(context).textfieldText,
                                                                          ),
                                                                          fontSize: (_model.emailmotherFocusNode?.hasFocus ?? false)
                                                                              ? 12.0
                                                                              : 16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Username /  Email',
                                                                    hintStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).textfieldText,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .textfieldDisable,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    filled:
                                                                        true,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .nunito(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .text2,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  cursorColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  validator: _model
                                                                      .emailmotherTextControllerValidator
                                                                      .asValidator(
                                                                          context),
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            '[a-z0-9@.]'))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0,
                                                                      -1.0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 1.0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: Container(
                                                                                height: MediaQuery.sizeOf(context).height * 0.25,
                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                child: ParentdocumentWidget(
                                                                                  child: false,
                                                                                  parent1: false,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    text: FFAppState().fileurl2 ==
                                                                                ''
                                                                        ? 'Upload the document proof'
                                                                        : 'Change the document proof',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .photo_outlined,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.7,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.04,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                      iconAlignment:
                                                                          IconAlignment
                                                                              .end,
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
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
                                                                        shadows: [
                                                                          Shadow(
                                                                            color:
                                                                                Color(0xFFF4F5FA),
                                                                            offset:
                                                                                Offset(0.0, -3.0),
                                                                            blurRadius:
                                                                                6.0,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      elevation:
                                                                          0.0,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        width:
                                                                            0.5,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            if (FFAppState()
                                                                        .fileurl2 !=
                                                                    '')
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child:
                                                                    FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    await launchURL(
                                                                        FFAppState()
                                                                            .fileurl2);
                                                                  },
                                                                  text:
                                                                      'View file',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.7,
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              ),
                                                          ].addToEnd(SizedBox(
                                                              height: 10.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].addToEnd(SizedBox(height: 20.0)),
                                    ),
                                  ),
                                ].addToEnd(SizedBox(height: 30.0)),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 5.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.pageno = 0;
                                                safeSetState(() {});
                                                await _model.pageViewController
                                                    ?.animateToPage(
                                                  0,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50.0,
                                                        height: 3.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFD6DC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Student ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.black,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.pageno = 1;
                                                _model.isguardian = true;
                                                safeSetState(() {});
                                                await _model.pageViewController
                                                    ?.previousPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50.0,
                                                        height: 3.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFD6DC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Parent',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.black,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.099,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.099,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          '03',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
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
                                                    Container(
                                                      width: 50.0,
                                                      height: 3.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFCFD6DC),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Guardian',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
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
                                                      color: Color(0xFFF5F2F2),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      '04',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
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
                                                Text(
                                                  'Save',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
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
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 10.0, 0.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Form(
                                          key: _model.formKey1,
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
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
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
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
                                                              child: Container(
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.2,
                                                                child:
                                                                    ParentphotoWidget(
                                                                  parent2:
                                                                      false,
                                                                  parent1:
                                                                      false,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.3,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.3,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        valueOrDefault<String>(
                                                          FFAppState().guardian !=
                                                                      ''
                                                              ? FFAppState()
                                                                  .parent1
                                                              : FFAppConstants
                                                                  .addImage,
                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 10.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.9,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .gnameTextController,
                                                    focusNode:
                                                        _model.gnameFocusNode,
                                                    autofocus: false,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText:
                                                          'Guardian\'s name',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  (_model.gnameFocusNode
                                                                              ?.hasFocus ??
                                                                          false)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .textfieldText,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldText,
                                                                ),
                                                                fontSize: (_model
                                                                            .gnameFocusNode
                                                                            ?.hasFocus ??
                                                                        false)
                                                                    ? 12.0
                                                                    : 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText:
                                                          'Guardian\'s name',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .textfieldText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .textfieldDisable,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
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
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .text2,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                    keyboardType:
                                                        TextInputType.name,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    validator: _model
                                                        .gnameTextControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      if (!isAndroid && !isiOS)
                                                        TextInputFormatter
                                                            .withFunction(
                                                                (oldValue,
                                                                    newValue) {
                                                          return TextEditingValue(
                                                            selection: newValue
                                                                .selection,
                                                            text: newValue.text
                                                                .toCapitalization(
                                                                    TextCapitalization
                                                                        .words),
                                                          );
                                                        }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 10.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.9,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .gnumberTextController,
                                                    focusNode:
                                                        _model.gnumberFocusNode,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText:
                                                          'Guardian\'s Number',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  (_model.gnumberFocusNode
                                                                              ?.hasFocus ??
                                                                          false)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .textfieldText,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldText,
                                                                ),
                                                                fontSize: (_model
                                                                            .gnumberFocusNode
                                                                            ?.hasFocus ??
                                                                        false)
                                                                    ? 12.0
                                                                    : 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText:
                                                          ' Guardian\'s Number',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .textfieldText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .textfieldDisable,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
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
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .text2,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                    maxLength: 10,
                                                    buildCounter: (context,
                                                            {required currentLength,
                                                            required isFocused,
                                                            maxLength}) =>
                                                        null,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    validator: _model
                                                        .gnumberTextControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]'))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 10.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.9,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .gemailTextController,
                                                    focusNode:
                                                        _model.gemailFocusNode,
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText:
                                                          ' Username /Email ',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  (_model.gemailFocusNode
                                                                              ?.hasFocus ??
                                                                          false)
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .textfieldText,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldText,
                                                                ),
                                                                fontSize: (_model
                                                                            .gemailFocusNode
                                                                            ?.hasFocus ??
                                                                        false)
                                                                    ? 12.0
                                                                    : 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintText:
                                                          'Username / Email',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .textfieldText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .textfieldDisable,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
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
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .text2,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    validator: _model
                                                        .gemailTextControllerValidator
                                                        .asValidator(context),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              '[a-z0-9@.]'))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ].addToEnd(SizedBox(height: 10.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          if (_model.formKey1.currentState ==
                                                  null ||
                                              !_model.formKey1.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                          _model.addToParentsdetails(
                                              ParentsDetailsStruct(
                                            parentsId:
                                                functions.generateUniqueId(),
                                            parentsName:
                                                _model.gnameTextController.text,
                                            parentsEmail: functions
                                                    .isValidEmail(_model
                                                        .gemailTextController
                                                        .text)
                                                ? _model
                                                    .gemailTextController.text
                                                : '${_model.gemailTextController.text}@feebe.in',
                                            parentsPhone: _model
                                                .gnumberTextController.text,
                                            parentRelation: 'Guardian',
                                            isemail: functions.isValidEmail(
                                                _model
                                                    .gemailTextController.text),
                                            parentImage: FFAppState().guardian,
                                          ));
                                          safeSetState(() {});
                                          _model.guardianCount =
                                              _model.guardianCount + 1;
                                          safeSetState(() {});
                                          FFAppState().guardian = '';
                                          safeSetState(() {});
                                          safeSetState(() {
                                            _model.gnumberTextController
                                                ?.clear();
                                            _model.gemailTextController
                                                ?.clear();
                                            _model.gnameTextController?.clear();
                                          });
                                        },
                                        text: 'Add Another',
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      final guardians = _model.parentsdetails
                                          .where((e) =>
                                              e.parentRelation != '')
                                          .toList();

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: guardians.length,
                                        itemBuilder: (context, guardiansIndex) {
                                          final guardiansItem =
                                              guardians[guardiansIndex];
                                          return Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Guardian ${functions.serialnumber(guardiansIndex).toString()}',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 16.0,
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
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.32,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        'Name : ',
                                                        textAlign:
                                                            TextAlign.start,
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
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.58,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        guardiansItem
                                                            .parentsName,
                                                        textAlign:
                                                            TextAlign.start,
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
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.32,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        'Phone Number : ',
                                                        textAlign:
                                                            TextAlign.start,
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
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.58,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        guardiansItem
                                                            .parentsPhone,
                                                        textAlign:
                                                            TextAlign.start,
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
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.32,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        'Username: ',
                                                        textAlign:
                                                            TextAlign.start,
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
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.58,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        guardiansItem
                                                            .parentsEmail,
                                                        textAlign:
                                                            TextAlign.start,
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
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
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
                                              ].divide(SizedBox(height: 5.0)),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.pageno = 0;
                                                safeSetState(() {});
                                                await _model.pageViewController
                                                    ?.animateToPage(
                                                  0,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50.0,
                                                        height: 3.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFD6DC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Student ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.black,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.pageno = 1;
                                                safeSetState(() {});
                                                await _model.pageViewController
                                                    ?.animateToPage(
                                                  1,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50.0,
                                                        height: 3.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFD6DC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Parent',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.black,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.pageno = 2;
                                                safeSetState(() {});
                                                await _model.pageViewController
                                                    ?.previousPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.099,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50.0,
                                                        height: 3.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFCFD6DC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Guardian',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.black,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
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
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      '04',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
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
                                                Text(
                                                  'Classes',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: StreamBuilder<SchoolRecord>(
                                      stream: SchoolRecord.getDocument(
                                          widget.schoolref!),
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

                                        final containerSchoolRecord =
                                            snapshot.data!;

                                        return Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.75,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Select class',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                        fontSize: 20.0,
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
                                                if ((_model.everyone == 0) ||
                                                    (_model.everyone == 1))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 12.0),
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
                                                        if (_model.everyone ==
                                                            1) {
                                                          _model.everyone = 0;
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.everyone = 1;
                                                          safeSetState(() {});
                                                        }
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
                                                                      14.0),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.9,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: _model
                                                                        .everyone ==
                                                                    1
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .lightblue
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14.0),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFFDDF1F6),
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
                                                              Text(
                                                                'Everyone',
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
                                                                          .primary,
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
                                                              Text(
                                                                'Student : ${containerSchoolRecord.studentDataList.where((e) => e.isDraft == false).toList().length.toString()}',
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .tertiaryText,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if ((_model.everyone == 0) ||
                                                    (_model.everyone == 2))
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  20.0,
                                                                  0.0,
                                                                  20.0,
                                                                  0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final schoolClassref =
                                                              containerSchoolRecord
                                                                  .listOfClass
                                                                  .toList();

                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                schoolClassref
                                                                    .length,
                                                            itemBuilder: (context,
                                                                schoolClassrefIndex) {
                                                              final schoolClassrefItem =
                                                                  schoolClassref[
                                                                      schoolClassrefIndex];
                                                              return Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            12.0),
                                                                child: StreamBuilder<
                                                                    SchoolClassRecord>(
                                                                  stream: SchoolClassRecord
                                                                      .getDocument(
                                                                          schoolClassrefItem),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            1.0,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.4,
                                                                        child:
                                                                            QuickActionSelectclassWidget(),
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
                                                                        if (!_model
                                                                            .classRef
                                                                            .contains(schoolClassrefItem)) {
                                                                          _model
                                                                              .addToClassRef(schoolClassrefItem);
                                                                          _model
                                                                              .addToClassname(containerSchoolClassRecord.className);
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model
                                                                              .removeFromClassRef(schoolClassrefItem);
                                                                          _model
                                                                              .removeFromClassname(containerSchoolClassRecord.className);
                                                                          safeSetState(
                                                                              () {});
                                                                        }

                                                                        if (_model.classRef.length !=
                                                                            0) {
                                                                          _model.everyone =
                                                                              2;
                                                                          safeSetState(
                                                                              () {});
                                                                        } else {
                                                                          _model.everyone =
                                                                              0;
                                                                          safeSetState(
                                                                              () {});
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
                                                                              BorderRadius.circular(14.0),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.8,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.1,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color: _model.classRef.contains(schoolClassrefItem)
                                                                                ? FlutterFlowTheme.of(context).lightblue
                                                                                : FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(14.0),
                                                                            border:
                                                                                Border.all(
                                                                              color: Color(0xFFDDF1F6),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Text(
                                                                                containerSchoolClassRecord.className,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.nunito(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                'Student  : ${containerSchoolClassRecord.studentsList.length.toString()}',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.nunito(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                              ].divide(SizedBox(height: 5.0)),
                                            ),
                                          ),
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
                  if (_model.pageno == 0)
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
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
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Color(0xFFF4F4F4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if ((_model.childnameTextController
                                                      .text ==
                                                  '') ||
                                          (_model.genderValue == null ||
                                              _model.genderValue == '') ||
                                          (_model.bloodtypeValue == null ||
                                              _model.bloodtypeValue == '') ||
                                          (_model.addressTextController
                                                      .text ==
                                                  '') ||
                                          (FFAppState().studentimage ==
                                                  '')) {
                                        _model.addToEmptypage(0);
                                        safeSetState(() {});
                                      } else {
                                        if (_model.formKey3.currentState ==
                                                null ||
                                            !_model.formKey3.currentState!
                                                .validate()) {
                                          return;
                                        }
                                        if (_model.genderValue == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Please select the gender',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                          return;
                                        }
                                        _model.removeFromEmptypage(0);
                                        safeSetState(() {});
                                      }

                                      _model.pageno = 1;
                                      safeSetState(() {});
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    },
                                    text: 'Next',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.06,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
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
                  if (_model.pageno == 1)
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
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
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Color(0xFFF4F4F4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.pageno = 0;
                                    safeSetState(() {});
                                    await _model.pageViewController
                                        ?.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  },
                                  text: 'Back',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
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
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if ((_model.parentnameTextController
                                                    .text ==
                                                '') ||
                                        (_model.numberfatherTextController
                                                    .text ==
                                                '') ||
                                        (_model.emailfatherTextController
                                                    .text ==
                                                '')) {
                                      _model.addToEmptypage(1);
                                      safeSetState(() {});
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        2,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                      _model.pageno = 2;
                                      safeSetState(() {});
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        2,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    } else {
                                      if (_model.formKey4.currentState ==
                                              null ||
                                          !_model.formKey4.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      _model.removeFromEmptypage(1);
                                      safeSetState(() {});
                                      if ((_model.numbermotherTextController
                                                      .text !=
                                                  '') ||
                                          (_model.parent2TextController
                                                      .text !=
                                                  '') ||
                                          (_model.emailmotherTextController
                                                      .text !=
                                                  '')) {
                                        if ((_model.numbermotherTextController
                                                        .text ==
                                                    '') ||
                                            (_model.parent2TextController
                                                        .text ==
                                                    '') ||
                                            (_model.emailmotherTextController
                                                        .text ==
                                                    '')) {
                                          _model.addToEmptypage(1);
                                          safeSetState(() {});
                                          _model.pageno = 2;
                                          safeSetState(() {});
                                          await _model.pageViewController
                                              ?.animateToPage(
                                            2,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        } else {
                                          if (_model.formKey2.currentState ==
                                                  null ||
                                              !_model.formKey2.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                          _model.removeFromEmptypage(1);
                                          safeSetState(() {});
                                          if (_model.emailfatherTextController
                                                  .text !=
                                              _model.emailmotherTextController
                                                  .text) {
                                            if (_model.formKey2.currentState ==
                                                    null ||
                                                !_model.formKey2.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                            _model.pageno = 2;
                                            safeSetState(() {});
                                            await _model.pageViewController
                                                ?.animateToPage(
                                              2,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'both emails cannot be same',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          }
                                        }
                                      } else {
                                        _model.pageno = 2;
                                        safeSetState(() {});
                                        await _model.pageViewController
                                            ?.animateToPage(
                                          2,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      }
                                    }
                                  },
                                  text: 'Next',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
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
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
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
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Color(0xFFF4F4F4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.pageno = 1;
                                    safeSetState(() {});
                                    await _model.pageViewController
                                        ?.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  },
                                  text: 'Back',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
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
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.emptypage
                                        .contains(FFAppState().page0)) {
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        0,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                      _model.pageno = 0;
                                      safeSetState(() {});
                                      if (_model.formKey3.currentState ==
                                              null ||
                                          !_model.formKey3.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      if (_model.genderValue == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please select the gender',
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
                                        return;
                                      }
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        2,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                      _model.pageno = 2;
                                      safeSetState(() {});
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        2,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                      _model.removeFromEmptypage(0);
                                      safeSetState(() {});
                                    }
                                    if (_model.emptypage
                                        .contains(FFAppState().page1)) {
                                      _model.pageno = 1;
                                      safeSetState(() {});
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                      if (_model.formKey4.currentState ==
                                              null ||
                                          !_model.formKey4.currentState!
                                              .validate()) {
                                        return;
                                      }
                                    }
                                    if ((_model.numbermotherTextController
                                                    .text !=
                                                '') ||
                                        (_model.parent2TextController.text !=
                                                '') ||
                                        (_model.emailmotherTextController
                                                    .text !=
                                                '')) {
                                      _model.pageno = 1;
                                      safeSetState(() {});
                                      await _model.pageViewController
                                          ?.animateToPage(
                                        1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                      if (_model.formKey2.currentState ==
                                              null ||
                                          !_model.formKey2.currentState!
                                              .validate()) {
                                        return;
                                      }
                                    }
                                    _model.removeFromEmptypage(1);
                                    safeSetState(() {});
                                    if ((_model.gnameTextController.text !=
                                                '') ||
                                        (_model.gnumberTextController.text !=
                                                '') ||
                                        (_model.gemailTextController.text !=
                                                '')) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Tap',
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
                                    } else {
                                      if (FFAppState().studentimage == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Please add student image',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                        _model.pageno = 0;
                                        safeSetState(() {});
                                        await _model.pageViewController
                                            ?.animateToPage(
                                          0,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      } else {
                                        if (FFAppState().selectedDate == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Please select the DOB',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                          _model.pageno = 0;
                                          safeSetState(() {});
                                          await _model.pageViewController
                                              ?.animateToPage(
                                            0,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        } else {
                                          _model.pageno = 3;
                                          safeSetState(() {});
                                          await _model.pageViewController
                                              ?.animateToPage(
                                            3,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        }
                                      }
                                    }
                                  },
                                  text: 'Next',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
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
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_model.pageno == 3)
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
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
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Color(0xFFF4F4F4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.pageno = 2;
                                    safeSetState(() {});
                                    await _model.pageViewController
                                        ?.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  },
                                  text: 'Back',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
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
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: (_model.everyone == 0)
                                      ? null
                                      : () async {
                                          _model.userdocument1 =
                                              await queryUsersRecordOnce();
                                          FFAppState().loopmin = 0;
                                          safeSetState(() {});
                                          _model.insertAtIndexInParentsdetails(
                                              0,
                                              ParentsDetailsStruct(
                                                parentsId: functions
                                                    .generateUniqueId(),
                                                parentsName: _model
                                                    .parentnameTextController
                                                    .text,
                                                parentsEmail: functions
                                                        .isValidEmail(_model
                                                            .emailfatherTextController
                                                            .text)
                                                    ? _model
                                                        .emailfatherTextController
                                                        .text
                                                    : '${_model.emailfatherTextController.text}@feebe.in',
                                                parentsPhone: _model
                                                    .numberfatherTextController
                                                    .text,
                                                document: FFAppState().fileurl1,
                                                isemail: functions.isValidEmail(
                                                        _model
                                                            .emailfatherTextController
                                                            .text)
                                                    ? true
                                                    : false,
                                                parentImage:
                                                    FFAppState().parent1,
                                              ));
                                          safeSetState(() {});
                                          if (_model.emailmotherTextController
                                                      .text !=
                                                  '') {
                                            _model
                                                .insertAtIndexInParentsdetails(
                                                    1,
                                                    ParentsDetailsStruct(
                                                      parentsId: functions
                                                          .generateUniqueId(),
                                                      parentsName: _model
                                                          .parent2TextController
                                                          .text,
                                                      parentsEmail: functions
                                                              .isValidEmail(_model
                                                                  .emailmotherTextController
                                                                  .text)
                                                          ? _model
                                                              .emailmotherTextController
                                                              .text
                                                          : '${_model.emailmotherTextController.text}@feebe.in',
                                                      parentsPhone: _model
                                                          .numbermotherTextController
                                                          .text,
                                                      document:
                                                          FFAppState().fileurl2,
                                                      isemail: functions
                                                              .isValidEmail(_model
                                                                  .emailmotherTextController
                                                                  .text)
                                                          ? true
                                                          : false,
                                                      parentImage:
                                                          FFAppState().parent2,
                                                    ));
                                            safeSetState(() {});
                                            _model.parentsdetails = functions
                                                .removeExactDuplicates(_model
                                                    .parentsdetails
                                                    .toList())!
                                                .toList()
                                                .cast<ParentsDetailsStruct>();
                                            safeSetState(() {});
                                          } else {
                                            _model.parentsdetails = functions
                                                .removeExactDuplicates(_model
                                                    .parentsdetails
                                                    .toList())!
                                                .toList()
                                                .cast<ParentsDetailsStruct>();
                                            safeSetState(() {});
                                          }

                                          if (_model.userdocument1
                                                  ?.where((e) =>
                                                      (e.email ==
                                                          _model
                                                              .emailfatherTextController
                                                              .text) &&
                                                      (e.userRole == 4))
                                                  .toList()
                                                  .length ==
                                              0) {
                                            while (FFAppState().loopmin <
                                                _model.parentsdetails.length) {
                                              _model.parentapi12 =
                                                  await CreateAccountCall.call(
                                                email: _model.parentsdetails
                                                    .elementAtOrNull(
                                                        FFAppState().loopmin)
                                                    ?.parentsEmail,
                                                displayName: _model
                                                    .parentsdetails
                                                    .elementAtOrNull(
                                                        FFAppState().loopmin)
                                                    ?.parentsName,
                                                userRole: 4,
                                                phoneNumber: _model
                                                    .parentsdetails
                                                    .elementAtOrNull(
                                                        FFAppState().loopmin)
                                                    ?.parentsPhone,
                                                password: _model.parentsdetails
                                                    .elementAtOrNull(
                                                        FFAppState().loopmin)
                                                    ?.parentsPhone,
                                              );

                                              if ((_model
                                                      .parentapi12?.succeeded ??
                                                  true)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '${_model.parentsdetails.elementAtOrNull(FFAppState().loopmin)?.parentsName}\'s account created.',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                  ),
                                                );
                                                _model.parentuserref =
                                                    await actions.stringToUser(
                                                  CreateAccountCall.userref(
                                                    (_model.parentapi12
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!,
                                                );

                                                await _model.parentuserref!
                                                    .update(
                                                        createUsersRecordData(
                                                  document: _model
                                                      .parentsdetails
                                                      .elementAtOrNull(
                                                          FFAppState().loopmin)
                                                      ?.document,
                                                  photoUrl: _model
                                                      .parentsdetails
                                                      .elementAtOrNull(
                                                          FFAppState().loopmin)
                                                      ?.parentImage,
                                                ));
                                                _model.addToParentsRef(
                                                    _model.parentuserref!);
                                                _model
                                                    .updateParentsdetailsAtIndex(
                                                  FFAppState().loopmin,
                                                  (e) => e
                                                    ..userRef =
                                                        _model.parentuserref,
                                                );
                                                safeSetState(() {});
                                                _model.parent1email =
                                                    await SendMailCall.call(
                                                  toEmail: _model.parentsdetails
                                                      .elementAtOrNull(
                                                          FFAppState().loopmin)
                                                      ?.parentsEmail,
                                                  userName: _model
                                                      .parentsdetails
                                                      .elementAtOrNull(
                                                          FFAppState().loopmin)
                                                      ?.parentsName,
                                                  password: _model
                                                      .parentsdetails
                                                      .elementAtOrNull(
                                                          FFAppState().loopmin)
                                                      ?.parentsPhone,
                                                  message:
                                                      'Welcome! You have successfully been onboarded to Feebe by ${addStudentManuallySchoolRecord.schoolDetails.schoolName} Feebe is designed to keep you informed, connected, and reassured every step of the way. ',
                                                );

                                                if ((_model.parent1email
                                                        ?.succeeded ??
                                                    true)) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'An email is sent to the Parent with their credentials.',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 3200),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        getJsonField(
                                                          (_model.parent1email
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.message''',
                                                        ).toString(),
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 3200),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  );
                                                }

                                                _model.sms =
                                                    await SendsmsCall.call(
                                                  toPhoneNumber: functions
                                                      .newCustomFunction(_model
                                                          .parentsdetails
                                                          .elementAtOrNull(
                                                              FFAppState()
                                                                  .loopmin)!
                                                          .parentsPhone),
                                                  userName: functions
                                                          .isValidEmail(_model
                                                              .parentsdetails
                                                              .elementAtOrNull(
                                                                  FFAppState()
                                                                      .loopmin)!
                                                              .parentsEmail)
                                                      ? _model.parentsdetails
                                                          .elementAtOrNull(
                                                              FFAppState()
                                                                  .loopmin)
                                                          ?.parentsEmail
                                                      : functions
                                                          .getUsernameFromEmail(_model
                                                              .parentsdetails
                                                              .elementAtOrNull(
                                                                  FFAppState()
                                                                      .loopmin)!
                                                              .parentsPhone),
                                                  userPassword: _model
                                                      .parentsdetails
                                                      .elementAtOrNull(
                                                          FFAppState().loopmin)
                                                      ?.parentsPhone,
                                                );

                                                if ((_model.sms?.succeeded ??
                                                    true)) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        getJsonField(
                                                          (_model.sms
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.message''',
                                                        ).toString(),
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        getJsonField(
                                                          (_model.sms
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.message''',
                                                        ).toString(),
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                }

                                                FFAppState().loopmin =
                                                    FFAppState().loopmin + 1;
                                                safeSetState(() {});
                                              } else {
                                                break;
                                              }
                                            }
                                            FFAppState().loopmin = 0;
                                            safeSetState(() {});

                                            var studentsRecordReference1 =
                                                StudentsRecord.collection.doc();
                                            await studentsRecordReference1.set({
                                              ...createStudentsRecordData(
                                                studentName: _model
                                                    .childnameTextController
                                                    .text,
                                                studentGender:
                                                    _model.genderValue,
                                                studentAddress: _model
                                                    .addressTextController.text,
                                                dateOfBirth:
                                                    FFAppState().selectedDate,
                                                bloodGroup:
                                                    _model.bloodtypeValue,
                                                schoolName:
                                                    addStudentManuallySchoolRecord
                                                        .schoolDetails
                                                        .schoolName,
                                                allergiesOthers: _model
                                                    .allergiesTextController
                                                    .text,
                                                createdAt: getCurrentTimestamp,
                                                studentImage:
                                                    FFAppState().studentimage,
                                                schoolref: widget.schoolref,
                                                document: FFAppState().fileUrl,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'Parents_list':
                                                      _model.parentsRef,
                                                  'parents_details':
                                                      getParentsDetailsListFirestoreData(
                                                    _model.parentsdetails,
                                                  ),
                                                  'classref': _model.classRef,
                                                  'class_name':
                                                      _model.classname,
                                                },
                                              ),
                                            });
                                            _model.student1 = StudentsRecord
                                                .getDocumentFromData({
                                              ...createStudentsRecordData(
                                                studentName: _model
                                                    .childnameTextController
                                                    .text,
                                                studentGender:
                                                    _model.genderValue,
                                                studentAddress: _model
                                                    .addressTextController.text,
                                                dateOfBirth:
                                                    FFAppState().selectedDate,
                                                bloodGroup:
                                                    _model.bloodtypeValue,
                                                schoolName:
                                                    addStudentManuallySchoolRecord
                                                        .schoolDetails
                                                        .schoolName,
                                                allergiesOthers: _model
                                                    .allergiesTextController
                                                    .text,
                                                createdAt: getCurrentTimestamp,
                                                studentImage:
                                                    FFAppState().studentimage,
                                                schoolref: widget.schoolref,
                                                document: FFAppState().fileUrl,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'Parents_list':
                                                      _model.parentsRef,
                                                  'parents_details':
                                                      getParentsDetailsListFirestoreData(
                                                    _model.parentsdetails,
                                                  ),
                                                  'classref': _model.classRef,
                                                  'class_name':
                                                      _model.classname,
                                                },
                                              ),
                                            }, studentsRecordReference1);

                                            await addStudentManuallySchoolRecord
                                                .reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'List_of_students':
                                                      FieldValue.arrayUnion([
                                                    _model.student1?.reference
                                                  ]),
                                                  'student_data_list':
                                                      FieldValue.arrayUnion([
                                                    getStudentListFirestoreData(
                                                      createStudentListStruct(
                                                        studentName: _model
                                                            .student1
                                                            ?.studentName,
                                                        studentId: _model
                                                            .student1
                                                            ?.reference,
                                                        studentImage: _model
                                                            .student1
                                                            ?.studentImage,
                                                        isAddedinClass:
                                                            _model.everyone == 0
                                                                ? false
                                                                : true,
                                                        fieldValues: {
                                                          'parent_list': _model
                                                              .student1
                                                              ?.parentsList,
                                                          'classref':
                                                              _model.classRef,
                                                        },
                                                        clearUnsetFields: false,
                                                      ),
                                                      true,
                                                    )
                                                  ]),
                                                },
                                              ),
                                            });
                                            FFAppState().loopmin = 0;
                                            safeSetState(() {});
                                            while (FFAppState().loopmin <
                                                _model.classRef.length) {
                                              await _model.classRef
                                                  .elementAtOrNull(
                                                      FFAppState().loopmin)!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'students_list':
                                                        FieldValue.arrayUnion([
                                                      _model.student1?.reference
                                                    ]),
                                                    'student_data':
                                                        FieldValue.arrayUnion([
                                                      getStudentListFirestoreData(
                                                        updateStudentListStruct(
                                                          StudentListStruct(
                                                            studentName: _model
                                                                .student1
                                                                ?.studentName,
                                                            studentId: _model
                                                                .student1
                                                                ?.reference,
                                                            studentImage: _model
                                                                .student1
                                                                ?.studentImage,
                                                            parentList: _model
                                                                .student1
                                                                ?.parentsList,
                                                            isAddedinClass:
                                                                true,
                                                            classref:
                                                                _model.classRef,
                                                            isDraft: false,
                                                          ),
                                                          clearUnsetFields:
                                                              false,
                                                        ),
                                                        true,
                                                      )
                                                    ]),
                                                  },
                                                ),
                                              });
                                              _model.classes =
                                                  await SchoolClassRecord
                                                      .getDocumentOnce(_model
                                                          .classRef
                                                          .elementAtOrNull(
                                                              FFAppState()
                                                                  .loopmin)!);
                                              triggerPushNotification(
                                                notificationTitle:
                                                    'New student added to class ${_model.classes?.className}',
                                                notificationText:
                                                    'New student added to class ${_model.classes?.className}',
                                                userRefs: _model
                                                    .classes!.listOfteachersUser
                                                    .toList(),
                                                initialPageName: 'Dashboard',
                                                parameterData: {
                                                  'fromlogin': false,
                                                },
                                              );

                                              await NotificationsRecord
                                                  .collection
                                                  .doc()
                                                  .set({
                                                ...createNotificationsRecordData(
                                                  content:
                                                      'New student added to class ${_model.classes?.className}',
                                                  descri:
                                                      'New student added to class ${_model.classes?.className}',
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'userref':
                                                        addStudentManuallySchoolRecord
                                                            .listOfteachersuser,
                                                  },
                                                ),
                                              });
                                              FFAppState().loopmin =
                                                  FFAppState().loopmin + 1;
                                              safeSetState(() {});
                                            }
                                            if (_model.allergiesTextController
                                                        .text !=
                                                    '') {
                                              await NotificationsRecord
                                                  .collection
                                                  .doc()
                                                  .set({
                                                ...createNotificationsRecordData(
                                                  content:
                                                      '${_model.childnameTextController.text}  allergies update',
                                                  isread: false,
                                                  notification:
                                                      updateNotificationStruct(
                                                    NotificationStruct(
                                                      notificationTitle:
                                                          '${_model.childnameTextController.text} \'s allergies update',
                                                      descriptions: _model
                                                          .allergiesTextController
                                                          .text,
                                                      timeStamp:
                                                          getCurrentTimestamp,
                                                      isRead: true,
                                                    ),
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  ),
                                                  createDate:
                                                      getCurrentTimestamp,
                                                  heading: 'Student allergy.',
                                                  addedby: currentUserReference,
                                                  descri: _model
                                                      .allergiesTextController
                                                      .text,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'schoolref': [
                                                      addStudentManuallySchoolRecord
                                                          .reference
                                                    ],
                                                  },
                                                ),
                                              });

                                              await NotificationsRecord
                                                  .collection
                                                  .doc()
                                                  .set({
                                                ...createNotificationsRecordData(
                                                  content:
                                                      '${_model.childnameTextController.text}  allergies update',
                                                  isread: false,
                                                  notification:
                                                      updateNotificationStruct(
                                                    NotificationStruct(
                                                      notificationTitle:
                                                          '${_model.childnameTextController.text} \'s allergies update',
                                                      descriptions: _model
                                                          .allergiesTextController
                                                          .text,
                                                      timeStamp:
                                                          getCurrentTimestamp,
                                                      isRead: true,
                                                    ),
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  ),
                                                  createDate:
                                                      getCurrentTimestamp,
                                                  addedby: currentUserReference,
                                                  heading: 'Student allergy',
                                                  descri: _model
                                                      .allergiesTextController
                                                      .text,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'userref':
                                                        addStudentManuallySchoolRecord
                                                            .listOfteachersuser,
                                                  },
                                                ),
                                              });
                                            }
                                            _model.pageno = 0;
                                            _model.parentsdetails = [];
                                            safeSetState(() {});
                                          } else {
                                            _model.parent2 =
                                                await queryUsersRecordOnce(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord.where(
                                                'email',
                                                isEqualTo: _model
                                                    .emailfatherTextController
                                                    .text,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);
                                            _model.student2Copy =
                                                await queryStudentsRecordOnce(
                                              queryBuilder: (studentsRecord) =>
                                                  studentsRecord.where(
                                                'Parents_list',
                                                arrayContains:
                                                    _model.parent2?.reference,
                                              ),
                                              singleRecord: true,
                                            ).then((s) => s.firstOrNull);

                                            var studentsRecordReference2 =
                                                StudentsRecord.collection.doc();
                                            await studentsRecordReference2.set({
                                              ...createStudentsRecordData(
                                                studentName: _model
                                                    .childnameTextController
                                                    .text,
                                                studentGender:
                                                    _model.genderValue,
                                                studentAddress: _model
                                                    .addressTextController.text,
                                                dateOfBirth:
                                                    FFAppState().selectedDate,
                                                bloodGroup:
                                                    _model.bloodtypeValue,
                                                schoolName:
                                                    addStudentManuallySchoolRecord
                                                        .schoolDetails
                                                        .schoolName,
                                                allergiesOthers: _model
                                                    .allergiesTextController
                                                    .text,
                                                createdAt: getCurrentTimestamp,
                                                studentImage:
                                                    FFAppState().studentimage,
                                                schoolref: widget.schoolref,
                                                document: FFAppState().fileUrl,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'Parents_list': _model
                                                      .student2Copy
                                                      ?.parentsList,
                                                  'parents_details':
                                                      getParentsDetailsListFirestoreData(
                                                    _model.student2Copy
                                                        ?.parentsDetails,
                                                  ),
                                                  'classref': _model.classRef,
                                                  'class_name':
                                                      _model.classname,
                                                },
                                              ),
                                            });
                                            _model.child2Copy = StudentsRecord
                                                .getDocumentFromData({
                                              ...createStudentsRecordData(
                                                studentName: _model
                                                    .childnameTextController
                                                    .text,
                                                studentGender:
                                                    _model.genderValue,
                                                studentAddress: _model
                                                    .addressTextController.text,
                                                dateOfBirth:
                                                    FFAppState().selectedDate,
                                                bloodGroup:
                                                    _model.bloodtypeValue,
                                                schoolName:
                                                    addStudentManuallySchoolRecord
                                                        .schoolDetails
                                                        .schoolName,
                                                allergiesOthers: _model
                                                    .allergiesTextController
                                                    .text,
                                                createdAt: getCurrentTimestamp,
                                                studentImage:
                                                    FFAppState().studentimage,
                                                schoolref: widget.schoolref,
                                                document: FFAppState().fileUrl,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'Parents_list': _model
                                                      .student2Copy
                                                      ?.parentsList,
                                                  'parents_details':
                                                      getParentsDetailsListFirestoreData(
                                                    _model.student2Copy
                                                        ?.parentsDetails,
                                                  ),
                                                  'classref': _model.classRef,
                                                  'class_name':
                                                      _model.classname,
                                                },
                                              ),
                                            }, studentsRecordReference2);

                                            await addStudentManuallySchoolRecord
                                                .reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'List_of_students':
                                                      FieldValue.arrayUnion([
                                                    _model.child2Copy?.reference
                                                  ]),
                                                  'student_data_list':
                                                      FieldValue.arrayUnion([
                                                    getStudentListFirestoreData(
                                                      createStudentListStruct(
                                                        studentName: _model
                                                            .child2Copy
                                                            ?.studentName,
                                                        studentId: _model
                                                            .child2Copy
                                                            ?.reference,
                                                        studentImage: _model
                                                            .child2Copy
                                                            ?.studentImage,
                                                        isAddedinClass:
                                                            _model.everyone == 0
                                                                ? false
                                                                : true,
                                                        fieldValues: {
                                                          'parent_list': _model
                                                              .child2Copy
                                                              ?.parentsList,
                                                          'classref':
                                                              _model.classRef,
                                                        },
                                                        clearUnsetFields: false,
                                                      ),
                                                      true,
                                                    )
                                                  ]),
                                                },
                                              ),
                                            });
                                            FFAppState().loopmin = 0;
                                            safeSetState(() {});
                                            while (FFAppState().loopmin <
                                                _model.classRef.length) {
                                              await _model.classRef
                                                  .elementAtOrNull(
                                                      FFAppState().loopmin)!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'students_list':
                                                        FieldValue.arrayUnion([
                                                      _model
                                                          .child2Copy?.reference
                                                    ]),
                                                    'student_data':
                                                        FieldValue.arrayUnion([
                                                      getStudentListFirestoreData(
                                                        updateStudentListStruct(
                                                          StudentListStruct(
                                                            studentName: _model
                                                                .child2Copy
                                                                ?.studentName,
                                                            studentId: _model
                                                                .child2Copy
                                                                ?.reference,
                                                            studentImage: _model
                                                                .child2Copy
                                                                ?.studentImage,
                                                            parentList: _model
                                                                .child2Copy
                                                                ?.parentsList,
                                                            isAddedinClass:
                                                                true,
                                                            classref:
                                                                _model.classRef,
                                                            isDraft: false,
                                                          ),
                                                          clearUnsetFields:
                                                              false,
                                                        ),
                                                        true,
                                                      )
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
                                          }

                                          FFAppState().studentimage = '';
                                          FFAppState().fileUrl = '';
                                          FFAppState().fileurl1 = '';
                                          FFAppState().fileurl2 = '';
                                          FFAppState().parent1 = '';
                                          FFAppState().parent2 = '';
                                          FFAppState().guardian = '';
                                          FFAppState().selectedDate = null;
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Student enrollment completed successfully!',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                          if (valueOrDefault(
                                                  currentUserDocument?.userRole,
                                                  0) ==
                                              2) {
                                            context.pushNamed(
                                              ClassDashboardWidget.routeName,
                                              queryParameters: {
                                                'schoolref': serializeParam(
                                                  addStudentManuallySchoolRecord
                                                      .reference,
                                                  ParamType.DocumentReference,
                                                ),
                                                'tabindex': serializeParam(
                                                  3,
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );
                                          } else {
                                            context.pushNamed(
                                              DashboardWidget.routeName,
                                              queryParameters: {
                                                'tabindex': serializeParam(
                                                  3,
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );
                                          }

                                          safeSetState(() {});
                                        },
                                  text: 'Save ',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
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
                                    borderRadius: BorderRadius.circular(8.0),
                                    disabledColor:
                                        FlutterFlowTheme.of(context).dIsable,
                                    disabledTextColor:
                                        FlutterFlowTheme.of(context).secondary,
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
