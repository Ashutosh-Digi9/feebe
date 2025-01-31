import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'delete_model.dart';
export 'delete_model.dart';

class DeleteWidget extends StatefulWidget {
  const DeleteWidget({
    super.key,
    required this.schoolref,
    bool? isBranch,
  }) : isBranch = isBranch ?? false;

  final DocumentReference? schoolref;
  final bool isBranch;

  @override
  State<DeleteWidget> createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<DeleteWidget> {
  late DeleteModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteModel());
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
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Text(
                'Are you sure, you want to delete this ${widget.isBranch == true ? 'branch' : 'school'}? ',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Text(
                'on deletding all the deatils of this particular school will be deleted',
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).text1,
                      fontSize: 17.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.normal,
                    ),
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
                      height: 40.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily: 'Nunito',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            letterSpacing: 0.0,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      _model.schoolref = await SchoolRecord.getDocumentOnce(
                          widget.schoolref!);
                      FFAppState().recentsearchitem = functions
                          .removeItemsByType(
                              FFAppState().recentsearchitem.toList(),
                              _model.schoolref!.schoolDetails.schoolName)
                          .toList()
                          .cast<SearchitemsStruct>();
                      safeSetState(() {});
                      FFAppState().recentsearchitem = functions
                          .removeItemsByType(
                              FFAppState().recentsearchitem.toList(),
                              _model.schoolref!.principalDetails.principalName)
                          .toList()
                          .cast<SearchitemsStruct>();
                      safeSetState(() {});

                      await _model.schoolref!.principalDetails.principalId!
                          .update({
                        ...mapToFirestore(
                          {
                            'ListofSchool':
                                FieldValue.arrayRemove([widget.schoolref]),
                          },
                        ),
                      });

                      await widget.schoolref!.update(createSchoolRecordData(
                        schoolDetails: createSchoolDetailsStruct(
                          fieldValues: {
                            'no_of_branches': FieldValue.increment(-(1)),
                          },
                          clearUnsetFields: false,
                        ),
                      ));
                      FFAppState().loopmin = 0;
                      safeSetState(() {});
                      while (FFAppState().loopmin <
                          _model.schoolref!.listOfStudents.length) {
                        await _model.schoolref!.listOfStudents
                            .elementAtOrNull(FFAppState().loopmin)!
                            .delete();
                        FFAppState().loopmin = FFAppState().loopmin + 1;
                        safeSetState(() {});
                      }
                      FFAppState().loopmin = 0;
                      safeSetState(() {});
                      while (FFAppState().loopmin <
                          _model.schoolref!.listOfTeachers.length) {
                        await _model.schoolref!.listOfTeachers
                            .elementAtOrNull(FFAppState().loopmin)!
                            .delete();
                        FFAppState().loopmin = FFAppState().loopmin + 1;
                        safeSetState(() {});
                      }
                      await widget.schoolref!.delete();
                      Navigator.pop(context);

                      context.goNamed(
                        'Schooldeletedsuccessfully',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                          ),
                        },
                      );

                      context.pushNamed(
                        'Dashboard',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                          ),
                        },
                      );

                      safeSetState(() {});
                    },
                    text: 'Delete',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                        color: FlutterFlowTheme.of(context).secondaryBackground,
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
  }
}
