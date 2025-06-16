import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'delete_teacher_model.dart';
export 'delete_teacher_model.dart';

class DeleteTeacherWidget extends StatefulWidget {
  const DeleteTeacherWidget({
    super.key,
    required this.teacherref,
    required this.schoolref,
  });

  final DocumentReference? teacherref;
  final DocumentReference? schoolref;

  @override
  State<DeleteTeacherWidget> createState() => _DeleteTeacherWidgetState();
}

class _DeleteTeacherWidgetState extends State<DeleteTeacherWidget> {
  late DeleteTeacherModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteTeacherModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<TeachersRecord>(
      stream: TeachersRecord.getDocument(widget.teacherref!),
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
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    'Are you sure, you want to delete teacher profile?',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                Text(
                  'Everything about this teacher will be deleted and cannot be retreived again',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'Cancel',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.nunito(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          await Future.wait([
                            Future(() async {
                              _model.school1 =
                                  await SchoolRecord.getDocumentOnce(
                                      widget.schoolref!);
                              _model.apiResultv86 = await DeletestaffCall.call(
                                name: containerTeachersRecord.teacherName,
                                description:
                                    'We’d like to inform you that your account has been removed from the ${_model.school1?.schoolDetails.schoolName} system. This action may have been taken due to a change in staffing or an administrative decision.',
                                schoolName:
                                    _model.school1?.schoolDetails.schoolName,
                                toEmail: containerTeachersRecord.isemail
                                    ? containerTeachersRecord.emailId
                                    : '${containerTeachersRecord.emailId}@feebe.in',
                              );

                              if (!(_model.apiResultv86?.succeeded ?? true)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      getJsonField(
                                        (_model.apiResultv86?.jsonBody ?? ''),
                                        r'''$.message''',
                                      ).toString(),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                              }
                              await RemoveTeacherCall.call(
                                toPhoneNumber: functions.newCustomFunction(
                                    containerTeachersRecord.phoneNumber),
                              );

                              await containerTeachersRecord.reference.delete();
                            }),
                            Future(() async {
                              _model.school =
                                  await SchoolRecord.getDocumentOnce(
                                      widget.schoolref!);

                              await widget.schoolref!.update({
                                ...mapToFirestore(
                                  {
                                    'teachers_data_list':
                                        getTeacherListListFirestoreData(
                                      functions.removeTeacherByRef(
                                          _model.school!.teachersDataList
                                              .toList(),
                                          widget.teacherref!),
                                    ),
                                    'List_of_teachers': FieldValue.arrayRemove(
                                        [widget.teacherref]),
                                    'listOfteachersuser':
                                        FieldValue.arrayRemove(
                                            [containerTeachersRecord.useref]),
                                  },
                                ),
                              });
                            }),
                            Future(() async {
                              FFAppState().loopmin = 0;
                              safeSetState(() {});
                              _model.classes = await querySchoolClassRecordOnce(
                                queryBuilder: (schoolClassRecord) =>
                                    schoolClassRecord.where(
                                  'teachers_list',
                                  arrayContains: widget.teacherref,
                                ),
                              );
                              while (FFAppState().loopmin <
                                  _model.classes!.length) {
                                _model.indviclass = await SchoolClassRecord
                                    .getDocumentOnce(_model.classes!
                                        .elementAtOrNull(FFAppState().loopmin)!
                                        .reference);

                                await _model.indviclass!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'teachers_list': FieldValue.arrayRemove(
                                          [widget.teacherref]),
                                      'listOfteachersUser':
                                          FieldValue.arrayRemove(
                                              [containerTeachersRecord.useref]),
                                      'ListOfteachers':
                                          getTeacherListListFirestoreData(
                                        functions.removeTeacherByRef(
                                            _model.indviclass!.listOfteachers
                                                .toList(),
                                            widget.teacherref!),
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
                          ]);
                          Navigator.pop(context);

                          context.pushNamed(
                            TeacherdeletedSuccesfullyWidget.routeName,
                            queryParameters: {
                              'schoolref': serializeParam(
                                widget.schoolref,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );

                          safeSetState(() {});
                        },
                        text: 'Delete',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.nunito(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ].divide(SizedBox(width: 5.0)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
