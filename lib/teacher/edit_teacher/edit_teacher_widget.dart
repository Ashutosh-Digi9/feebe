import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/teacher/delete_teacher/delete_teacher_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_teacher_model.dart';
export 'edit_teacher_model.dart';

class EditTeacherWidget extends StatefulWidget {
  const EditTeacherWidget({
    super.key,
    required this.teacherref,
    required this.schoolref,
  });

  final DocumentReference? teacherref;
  final DocumentReference? schoolref;

  @override
  State<EditTeacherWidget> createState() => _EditTeacherWidgetState();
}

class _EditTeacherWidgetState extends State<EditTeacherWidget> {
  late EditTeacherModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditTeacherModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            color: Color(0xFFE9F0FD),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Builder(
                builder: (context) => InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.3,
                            width: MediaQuery.sizeOf(context).width * 0.7,
                            child: DeleteTeacherWidget(
                              teacherref: widget.teacherref!,
                              schoolref: widget.schoolref!,
                            ),
                          ),
                        );
                      },
                    );

                    Navigator.pop(context);
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
                    ]
                        .divide(SizedBox(width: 15.0))
                        .around(SizedBox(width: 15.0)),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  _model.teacher = await UsersRecord.getDocumentOnce(
                      containerTeachersRecord.useref!);

                  context.pushNamed(
                    EditTeacherAdminWidget.routeName,
                    queryParameters: {
                      'schoolRef': serializeParam(
                        widget.schoolref,
                        ParamType.DocumentReference,
                      ),
                      'teacherref': serializeParam(
                        widget.teacherref,
                        ParamType.DocumentReference,
                      ),
                      'teacher': serializeParam(
                        TeacherListStruct(
                          teacherName: containerTeachersRecord.teacherName,
                          phoneNumber: containerTeachersRecord.phoneNumber,
                          emailId: containerTeachersRecord.emailId,
                          teacherImage: containerTeachersRecord.teacherImage,
                          teachersId: widget.teacherref,
                          userRef: containerTeachersRecord.useref,
                          isemail: _model.teacher?.isemail,
                        ),
                        ParamType.DataStruct,
                      ),
                    }.withoutNulls,
                  );

                  safeSetState(() {});
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
            ],
          ),
        );
      },
    );
  }
}
