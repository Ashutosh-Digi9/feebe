import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'editclass_model.dart';
export 'editclass_model.dart';

class EditclassWidget extends StatefulWidget {
  const EditclassWidget({
    super.key,
    required this.schoolRef,
    required this.classref,
  });

  final DocumentReference? schoolRef;
  final DocumentReference? classref;

  @override
  State<EditclassWidget> createState() => _EditclassWidgetState();
}

class _EditclassWidgetState extends State<EditclassWidget> {
  late EditclassModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditclassModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).tertiary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (valueOrDefault(currentUserDocument?.userRole, 0) == 6)
            AuthUserStreamWidget(
              builder: (context) => InkWell(
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
                                'Are you sure you want to delete this class?'),
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
                    await widget.schoolRef!.update({
                      ...mapToFirestore(
                        {
                          'List_of_class':
                              FieldValue.arrayRemove([widget.classref]),
                        },
                      ),
                    });
                    _model.student = await queryStudentsRecordOnce(
                      queryBuilder: (studentsRecord) => studentsRecord.where(
                        'classref',
                        arrayContains: widget.classref,
                      ),
                    );
                    while (FFAppState().loopmin < _model.student!.length) {
                      await _model.student!
                          .elementAtOrNull(FFAppState().loopmin)!
                          .reference
                          .update({
                        ...mapToFirestore(
                          {
                            'classref': FieldValue.delete(),
                          },
                        ),
                      });
                      FFAppState().loopmin = 1;
                      safeSetState(() {});
                    }
                    FFAppState().loopmin = 0;
                    safeSetState(() {});
                    await widget.classref!.delete();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Class deleted Sucessfully',
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).secondary,
                          ),
                        ),
                        duration: const Duration(milliseconds: 4000),
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryText,
                      ),
                    );

                    context.pushNamed(
                      'class_dashboard',
                      queryParameters: {
                        'schoolref': serializeParam(
                          widget.schoolRef,
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                    );
                  }

                  safeSetState(() {});
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  ].divide(const SizedBox(width: 15.0)).around(const SizedBox(width: 15.0)),
                ),
              ),
            ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.pushNamed(
                'editclassadmin',
                queryParameters: {
                  'schoolclassref': serializeParam(
                    widget.classref,
                    ParamType.DocumentReference,
                  ),
                  'schoolref': serializeParam(
                    widget.schoolRef,
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
              ].divide(const SizedBox(width: 15.0)).around(const SizedBox(width: 15.0)),
            ),
          ),
        ],
      ),
    );
  }
}
