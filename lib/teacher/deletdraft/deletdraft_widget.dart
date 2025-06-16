import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'deletdraft_model.dart';
export 'deletdraft_model.dart';

class DeletdraftWidget extends StatefulWidget {
  const DeletdraftWidget({
    super.key,
    required this.studentref,
    required this.schoolref,
  });

  final DocumentReference? studentref;
  final DocumentReference? schoolref;

  @override
  State<DeletdraftWidget> createState() => _DeletdraftWidgetState();
}

class _DeletdraftWidgetState extends State<DeletdraftWidget> {
  late DeletdraftModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeletdraftModel());
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
      decoration: BoxDecoration(
        color: Color(0xFFE9F0FD),
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
                        title:
                            Text('Are you sure you want to delete this draft?'),
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
                _model.school =
                    await SchoolRecord.getDocumentOnce(widget.schoolref!);

                await _model.school!.reference.update({
                  ...mapToFirestore(
                    {
                      'student_data_list': getStudentListListFirestoreData(
                        functions.removeStudentByRef(
                            _model.school!.studentDataList.toList(),
                            widget.studentref!),
                      ),
                      'List_of_students':
                          FieldValue.arrayRemove([widget.studentref]),
                    },
                  ),
                });
                await widget.studentref!.delete();

                context.pushNamed(
                  ClassDashboardWidget.routeName,
                  queryParameters: {
                    'schoolref': serializeParam(
                      widget.schoolref,
                      ParamType.DocumentReference,
                    ),
                    'tabindex': serializeParam(
                      3,
                      ParamType.int,
                    ),
                  }.withoutNulls,
                );
              } else {
                Navigator.pop(context);
              }

              safeSetState(() {});
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  FFIcons.ktrashEmpty,
                  color: FlutterFlowTheme.of(context).tertiaryText,
                  size: 20.0,
                ),
                Text(
                  'Delete',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ].divide(SizedBox(width: 15.0)).around(SizedBox(width: 15.0)),
            ),
          ),
        ],
      ),
    );
  }
}
