import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
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
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: const BoxDecoration(),
      child: StreamBuilder<StudentsRecord>(
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
              color: FlutterFlowTheme.of(context).tertiary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: const Text('Alert!!'),
                              content: const Text(
                                  'Are you sure you want to delete this Child?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: const Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      _model.school = await SchoolRecord.getDocumentOnce(
                          widget.schoolref!);

                      await widget.schoolref!.update({
                        ...mapToFirestore(
                          {
                            'student_data_list':
                                getStudentListListFirestoreData(
                              functions.removeStudentByRef(
                                  _model.school!.studentDataList.toList(),
                                  widget.studentref!),
                            ),
                            'List_of_students': FieldValue.arrayRemove(
                                [containerStudentsRecord.reference]),
                          },
                        ),
                      });
                      await containerStudentsRecord.reference.delete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            ' The child document has been deleted.',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).secondary,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryText,
                        ),
                      );
                      Navigator.pop(context);

                      context.goNamed(
                        'class_dashboard',
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
                    }

                    safeSetState(() {});
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      Text(
                        'Delete',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ]
                        .divide(const SizedBox(width: 15.0))
                        .around(const SizedBox(width: 15.0)),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);

                    context.pushNamed(
                      'new_student_edit',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      Text(
                        'Edit',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ]
                        .divide(const SizedBox(width: 15.0))
                        .around(const SizedBox(width: 15.0)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
