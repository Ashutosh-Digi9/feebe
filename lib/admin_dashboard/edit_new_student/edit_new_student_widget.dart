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
import 'edit_new_student_model.dart';
export 'edit_new_student_model.dart';

class EditNewStudentWidget extends StatefulWidget {
  const EditNewStudentWidget({
    super.key,
    required this.studentref,
    required this.schoolref,
    required this.studentData,
  });

  final DocumentReference? studentref;
  final DocumentReference? schoolref;
  final StudentListStruct? studentData;

  @override
  State<EditNewStudentWidget> createState() => _EditNewStudentWidgetState();
}

class _EditNewStudentWidgetState extends State<EditNewStudentWidget> {
  late EditNewStudentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditNewStudentModel());
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
          decoration: BoxDecoration(
            color: Color(0xFFE9F0FD),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
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

                    await widget.schoolref!.update({
                      ...mapToFirestore(
                        {
                          'student_data_list': getStudentListListFirestoreData(
                            functions.removeStudentByRef(
                                _model.schoolCopy!.studentDataList.toList(),
                                widget.studentref!),
                          ),
                          'List_of_students':
                              FieldValue.arrayRemove([widget.studentref]),
                        },
                      ),
                    });
                    FFAppState().loopmin = 0;
                    safeSetState(() {});
                    while (FFAppState().loopmin <
                        containerStudentsRecord.parentsList.length) {
                      _model.apiResult58m = await RemoveParentCall.call(
                        toPhoneNumber: functions.newCustomFunction(
                            containerStudentsRecord.parentsDetails
                                .elementAtOrNull(FFAppState().loopmin)!
                                .parentsPhone),
                      );

                      await DeleteUserCall.call(
                        uid: containerStudentsRecord.parentsDetails
                            .elementAtOrNull(FFAppState().loopmin)
                            ?.userRef
                            ?.id,
                      );

                      FFAppState().loopmin = FFAppState().loopmin + 1;
                      safeSetState(() {});
                    }
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
                  size: 16.0,
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
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.edit,
                      color: FlutterFlowTheme.of(context).tertiaryText,
                      size: 20.0,
                    ),
                    Text(
                      'Edit',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.nunito(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(width: 15.0)).around(SizedBox(width: 15.0)),
                ),
              ),
            ].divide(SizedBox(height: 10.0)).around(SizedBox(height: 10.0)),
          ),
        );
      },
    );
  }
}
