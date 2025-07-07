import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_indi_student_model.dart';
export 'edit_indi_student_model.dart';

class EditIndiStudentWidget extends StatefulWidget {
  const EditIndiStudentWidget({
    super.key,
    required this.studentref,
    required this.schoolref,
    required this.stduentdatatype,
    required this.classref,
  });

  final DocumentReference? studentref;
  final DocumentReference? schoolref;
  final StudentListStruct? stduentdatatype;
  final List<DocumentReference>? classref;

  @override
  State<EditIndiStudentWidget> createState() => _EditIndiStudentWidgetState();
}

class _EditIndiStudentWidgetState extends State<EditIndiStudentWidget> {
  late EditIndiStudentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditIndiStudentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<StudentsRecord>(
      stream: StudentsRecord.getDocument(widget.studentref!),
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

        final containerStudentsRecord = snapshot.data!;

        return Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          decoration: BoxDecoration(
            color: Color(0xFFE9F0FD),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FFButtonWidget(
                onPressed: () async {
                  var confirmDialogResponse = await showDialog<bool>(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Alert!!'),
                            content: Text(
                                'Are you sure you want to delete this Child?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, true),
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      ) ??
                      false;
                  if (confirmDialogResponse) {
                    _model.schoolCopy =
                        await SchoolRecord.getDocumentOnce(widget.schoolref!);
                    await Future.wait([
                      Future(() async {
                        FFAppState().loopmin = 0;
                        safeSetState(() {});
                        while (
                            FFAppState().loopmin < widget.classref!.length) {
                          _model.classses =
                              await SchoolClassRecord.getDocumentOnce((widget
                                  .classref!
                                  .elementAtOrNull(FFAppState().loopmin))!);

                          await _model.classses!.reference.update({
                            ...mapToFirestore(
                              {
                                'students_list': FieldValue.arrayRemove(
                                    [widget.studentref]),
                                'student_data': getStudentListListFirestoreData(
                                  functions.removeStudentByRef(
                                      _model.classses!.studentData.toList(),
                                      widget.studentref!),
                                ),
                              },
                            ),
                          });
                          FFAppState().loopmin = FFAppState().loopmin + 1;
                          safeSetState(() {});
                        }
                        FFAppState().loopmin = 0;
                        safeSetState(() {});
                      }),
                      Future(() async {
                        await widget.schoolref!.update({
                          ...mapToFirestore(
                            {
                              'student_data_list':
                                  getStudentListListFirestoreData(
                                functions.removeStudentByRef(
                                    _model.schoolCopy!.studentDataList.toList(),
                                    widget.studentref!),
                              ),
                              'List_of_students':
                                  FieldValue.arrayRemove([widget.studentref]),
                            },
                          ),
                        });
                      }),
                      Future(() async {
                        while (FFAppState().loopminparent <
                            containerStudentsRecord.parentsDetails.length) {
                          _model.apiResult58m = await RemoveParentCall.call(
                            toPhoneNumber: functions.newCustomFunction(
                                containerStudentsRecord.parentsDetails
                                    .elementAtOrNull(
                                        FFAppState().loopminparent)!
                                    .parentsPhone),
                          );

                          _model.apiResultu1p = await DeleteParentCall.call(
                            name: containerStudentsRecord.parentsDetails
                                .elementAtOrNull(FFAppState().loopminparent)
                                ?.parentsName,
                            description:
                                'We would like to inform you that the profile of your child, ${containerStudentsRecord.studentName} has been successfully removed from our records in the ${_model.schoolCopy?.schoolDetails.schoolName} system.',
                            schoolName:
                                _model.schoolCopy?.schoolDetails.schoolName,
                            toEmail: containerStudentsRecord.parentsDetails
                                    .elementAtOrNull(
                                        FFAppState().loopminparent)!
                                    .isemail
                                ? containerStudentsRecord.parentsDetails
                                    .elementAtOrNull(FFAppState().loopminparent)
                                    ?.parentsEmail
                                : '${containerStudentsRecord.parentsDetails.elementAtOrNull(FFAppState().loopminparent)?.parentsEmail}@feebe.in',
                          );

                          _model.deledted = await DeleteUserCall.call(
                            uid: containerStudentsRecord.parentsDetails
                                .elementAtOrNull(FFAppState().loopminparent)
                                ?.userRef
                                ?.id,
                          );

                          FFAppState().loopminparent =
                              FFAppState().loopminparent + 1;
                          safeSetState(() {});
                        }
                        FFAppState().loopminparent = 0;
                        safeSetState(() {});
                      }),
                    ]);
                    FFAppState().loopmin = 0;
                    safeSetState(() {});
                    await widget.studentref!.delete();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Student deleted successfully!!',
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        duration: Duration(milliseconds: 4000),
                        backgroundColor: FlutterFlowTheme.of(context).secondary,
                      ),
                    );
                    if (valueOrDefault(currentUserDocument?.userRole, 0) == 3) {
                      context.goNamed(
                        DashboardWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                          ),
                        },
                      );
                    } else {
                      context.pushNamed(
                        ClassDashboardWidget.routeName,
                        queryParameters: {
                          'schoolref': serializeParam(
                            widget.schoolref,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                      );
                    }
                  }

                  safeSetState(() {});
                },
                text: ' Delete',
                icon: FaIcon(
                  FontAwesomeIcons.trashAlt,
                  size: 18.0,
                ),
                options: FFButtonOptions(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconColor: FlutterFlowTheme.of(context).tertiaryText,
                  color: Color(0xFFE9F0FD),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                  if (Navigator.of(context).canPop()) {
                    context.pop();
                  }
                  context.pushNamed(
                    EditClassStudentWidget.routeName,
                    queryParameters: {
                      'studentref': serializeParam(
                        widget.studentref,
                        ParamType.DocumentReference,
                      ),
                      'schoolref': serializeParam(
                        widget.schoolref,
                        ParamType.DocumentReference,
                      ),
                    }.withoutNulls,
                  );
                },
                text: 'Edit',
                icon: Icon(
                  Icons.edit,
                  size: 18.0,
                ),
                options: FFButtonOptions(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconColor: FlutterFlowTheme.of(context).tertiaryText,
                  color: Color(0xFFE9F0FD),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
