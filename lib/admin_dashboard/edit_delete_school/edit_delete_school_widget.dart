import '/admin_dashboard/edit_calender_school/edit_calender_school_widget.dart';
import '/admin_dashboard/edit_notice/edit_notice_widget.dart';
import '/backend/backend.dart';
import '/confirmationpages/eventdeletedsuccessfully/eventdeletedsuccessfully_widget.dart';
import '/confirmationpages/noticeddeted/noticeddeted_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
    required this.classref,
  });

  final int? eventid;
  final EventsNoticeStruct? event;
  final bool? noticebool;
  final DocumentReference? schoolref;
  final bool? schoolcal;
  final EventsNoticeStruct? eventImages;
  final List<DocumentReference>? classref;

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
    context.watch<FFAppState>();

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
            color: Color(0xFFE9F0FD),
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
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Alert!'),
                              content: Text(
                                  'Are you sure you want to delete this event / notice.'),
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
                        while (FFAppState().loopmin <
                            containerSchoolRecord.listOfClass.length) {
                          _model.classref =
                              await SchoolClassRecord.getDocumentOnce(
                                  containerSchoolRecord.listOfClass
                                      .elementAtOrNull(FFAppState().loopmin)!);

                          await _model.classref!.reference.update({
                            ...mapToFirestore(
                              {
                                'notice': getEventsNoticeListFirestoreData(
                                  functions.deleteEvent(
                                      _model.classref!.notice
                                          .where((e) =>
                                              e.eventId == widget.eventid)
                                          .toList()
                                          .firstOrNull!
                                          .eventId,
                                      _model.classref!.notice.toList()),
                                ),
                              },
                            ),
                          });
                          FFAppState().loopmin = FFAppState().loopmin + 1;
                          safeSetState(() {});
                        }
                        FFAppState().loopmin = 0;
                        safeSetState(() {});
                        FFAppState().loopmin = 0;
                        safeSetState(() {});
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: AlignmentDirectional(0.0, -0.8)
                                  .resolve(Directionality.of(context)),
                              child: Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.08,
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                child: NoticeddetedWidget(),
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
                        while (FFAppState().loopmin <
                            containerSchoolRecord.listOfClass.length) {
                          _model.classref1 =
                              await SchoolClassRecord.getDocumentOnce(
                                  containerSchoolRecord.listOfClass
                                      .elementAtOrNull(FFAppState().loopmin)!);

                          await _model.classref1!.reference.update({
                            ...mapToFirestore(
                              {
                                'calendar': getEventsNoticeListFirestoreData(
                                  functions.deleteEvent(
                                      _model.classref1!.calendar
                                          .where((e) =>
                                              e.eventId == widget.eventid)
                                          .toList()
                                          .firstOrNull!
                                          .eventId,
                                      _model.classref1!.calendar.toList()),
                                ),
                              },
                            ),
                          });
                          FFAppState().loopmin = FFAppState().loopmin + 1;
                          safeSetState(() {});
                        }
                        FFAppState().loopmin = 0;
                        safeSetState(() {});
                        FFAppState().loopmin = 0;
                        safeSetState(() {});
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: AlignmentDirectional(0.0, -0.8)
                                  .resolve(Directionality.of(context)),
                              child: Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.08,
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                child: EventdeletedsuccessfullyWidget(),
                              ),
                            );
                          },
                        );

                        context.pushNamed(
                          ClassDashboardWidget.routeName,
                          queryParameters: {
                            'schoolref': serializeParam(
                              widget.schoolref,
                              ParamType.DocumentReference,
                            ),
                            'tabindex': serializeParam(
                              2,
                              ParamType.int,
                            ),
                          }.withoutNulls,
                        );
                      }
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
                        'Delete ${widget.noticebool! ? 'Notice' : 'Event'}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.nunito(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
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
                  if (widget.schoolcal == false) {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      isDismissible: false,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            child: EditNoticeWidget(
                              school: widget.schoolref!,
                              eventid: widget.eventid!,
                              eventdata: widget.event!,
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
                      isDismissible: false,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            child: EditCalenderSchoolWidget(
                              school: widget.schoolref!,
                              eventid: widget.eventid!,
                              eventdata: widget.event!,
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
                      color: FlutterFlowTheme.of(context).tertiaryText,
                      size: 20.0,
                    ),
                    Text(
                      'Edit ${widget.noticebool! ? 'Notice' : 'Event'}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.nunito(
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
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
