import '/admin_dashboard/edit_calender_school/edit_calender_school_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'notice_board_edit_model.dart';
export 'notice_board_edit_model.dart';

class NoticeBoardEditWidget extends StatefulWidget {
  const NoticeBoardEditWidget({
    super.key,
    required this.school,
    required this.eventid,
    this.eventname,
    this.eventdescription,
    this.eventtitle,
    this.eventdate,
    this.eventimage,
    required this.eventdatatype,
  });

  final DocumentReference? school;
  final int? eventid;
  final String? eventname;
  final String? eventdescription;
  final String? eventtitle;
  final DateTime? eventdate;
  final List<String>? eventimage;
  final EventsNoticeStruct? eventdatatype;

  @override
  State<NoticeBoardEditWidget> createState() => _NoticeBoardEditWidgetState();
}

class _NoticeBoardEditWidgetState extends State<NoticeBoardEditWidget> {
  late NoticeBoardEditModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoticeBoardEditModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.school!),
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

        final containerSchoolRecord = snapshot.data!;

        return Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tertiary,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: InkWell(
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
                            alignment: const AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: EditCalenderSchoolWidget(
                              school: widget.school!,
                              eventid: widget.eventid!,
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
                          Icons.edit_sharp,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                        Text(
                          'Edit Notice',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ]
                          .divide(const SizedBox(width: 15.0))
                          .around(const SizedBox(width: 15.0)),
                    ),
                  ),
                ),
              ),
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
                            title: const Text('Alert!'),
                            content: const Text(
                                'Are you sure you want to delete this notice.'),
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
                    await containerSchoolRecord.reference.update({
                      ...mapToFirestore(
                        {
                          'Calendar_list': FieldValue.arrayRemove([
                            getEventsNoticeFirestoreData(
                              updateEventsNoticeStruct(
                                widget.eventdatatype,
                                clearUnsetFields: false,
                              ),
                              true,
                            )
                          ]),
                        },
                      ),
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Calendar events deleted sucessfully.',
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
                          widget.school,
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                    );
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
                    Text(
                      'Delete Notice',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Nunito',
                            fontSize: 14.0,
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
      },
    );
  }
}
