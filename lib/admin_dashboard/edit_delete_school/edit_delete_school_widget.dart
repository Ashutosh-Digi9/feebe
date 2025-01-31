import '/admin_dashboard/edit_calender_school/edit_calender_school_widget.dart';
import '/admin_dashboard/edit_notice/edit_notice_widget.dart';
import '/backend/backend.dart';
import '/confirmationpages/eventdeletedsuccessfully/eventdeletedsuccessfully_widget.dart';
import '/confirmationpages/noticeddeted/noticeddeted_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
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
            color: const Color(0xFFE9F0FD),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (widget.schoolcal == false) {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            child: EditNoticeWidget(
                              school: widget.schoolref!,
                              eventid: widget.eventid!,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));

                    Navigator.pop(context);
                  } else {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            child: EditCalenderSchoolWidget(
                              school: widget.schoolref!,
                              eventid: widget.eventid!,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));

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
                  ].divide(const SizedBox(width: 15.0)).around(const SizedBox(width: 15.0)),
                ),
              ),
              Builder(
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
                              title: const Text('Alert!'),
                              content: const Text(
                                  'Are you sure you want to delete this event / notice.'),
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
                              'List_of_notice':
                                  getEventsNoticeListFirestoreData(
                                functions.deleteEvent(
                                    widget.eventid!,
                                    containerSchoolRecord.listOfNotice
                                        .toList()),
                              ),
                            },
                          ),
                        });
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: const AlignmentDirectional(0.0, -0.8)
                                  .resolve(Directionality.of(context)),
                              child: SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.08,
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                child: const NoticeddetedWidget(),
                              ),
                            );
                          },
                        );

                        Navigator.pop(context);
                      } else {
                        await containerSchoolRecord.reference.update({
                          ...mapToFirestore(
                            {
                              'Calendar_list': getEventsNoticeListFirestoreData(
                                functions.deleteEvent(
                                    widget.eventid!,
                                    containerSchoolRecord.calendarList
                                        .toList()),
                              ),
                            },
                          ),
                        });
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: const AlignmentDirectional(0.0, -0.8)
                                  .resolve(Directionality.of(context)),
                              child: SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.08,
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                child: const EventdeletedsuccessfullyWidget(),
                              ),
                            );
                          },
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
                    ]
                        .divide(const SizedBox(width: 15.0))
                        .around(const SizedBox(width: 15.0)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
