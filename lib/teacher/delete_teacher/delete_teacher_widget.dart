import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    'Are you sure, you want to delete teacher profile?',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito',
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  'Everything about this teacher will be deleted and cannot be retreived again',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Nunito',
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
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
                            }),
                          ]);
                          Navigator.pop(context);

                          context.pushNamed(
                            'TeacherdeletedSuccesfully',
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ].divide(const SizedBox(width: 5.0)),
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
