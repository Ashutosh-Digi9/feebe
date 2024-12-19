import '/admin_dashboard/edit_calender_school/edit_calender_school_widget.dart';
import '/admin_dashboard/edit_notice/edit_notice_widget.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'edit_delete_school_model.dart';
export 'edit_delete_school_model.dart';

class EditDeleteSchoolWidget extends StatefulWidget {
  const EditDeleteSchoolWidget({
    super.key,
    required this.eventid,
    this.event,
    required this.noticebool,
    required this.schoolref,
    required this.schoolcal,
    this.eventImages,
  });

  final int? eventid;
  final EventsNoticeStruct? event;
  final bool? noticebool;
  final DocumentReference? schoolref;
  final bool? schoolcal;
  final EventsNoticeStruct? eventImages;

  @override
  State<EditDeleteSchoolWidget> createState() => _EditDeleteSchoolWidgetState();
}

class _EditDeleteSchoolWidgetState extends State<EditDeleteSchoolWidget> {
  late EditDeleteSchoolModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditDeleteSchoolModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.schoolref!),
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
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tertiary,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(
                builder: (context) => InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (widget.schoolcal == false) {
                      await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: const AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.65,
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: EditNoticeWidget(
                                school: widget.schoolref!,
                                eventid: widget.eventid!,
                              ),
                            ),
                          );
                        },
                      );

                      Navigator.pop(context);
                    } else {
                      await showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return Dialog(
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            alignment: const AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.65,
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: EditCalenderSchoolWidget(
                                school: widget.schoolref!,
                                eventid: widget.eventid!,
                              ),
                            ),
                          );
                        },
                      );

                      Navigator.pop(context);
                    }
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
                        'Edit ${widget.noticebool! ? 'Notice' : 'Event'}',
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
                    if (widget.schoolcal == false) {
                      await containerSchoolRecord.reference.update({
                        ...mapToFirestore(
                          {
                            'List_of_notice': FieldValue.arrayRemove([
                              getEventsNoticeFirestoreData(
                                updateEventsNoticeStruct(
                                  widget.eventImages ?? widget.event,
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
                            'Notice deleted sucessfully.',
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
                    } else {
                      await containerSchoolRecord.reference.update({
                        ...mapToFirestore(
                          {
                            'Calendar_list': FieldValue.arrayRemove([
                              getEventsNoticeFirestoreData(
                                updateEventsNoticeStruct(
                                  widget.eventImages ?? widget.event,
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
                            ' Calendar event deleted successfully.',
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
                    }
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
                    Text(
                      'Delete ${widget.noticebool! ? 'Notice' : 'Event'}',
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
      },
    );
  }
}
