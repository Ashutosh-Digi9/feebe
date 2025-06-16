import '/admin_dashboard/class_calendar_edit/class_calendar_edit_widget.dart';
import '/admin_dashboard/edit_notice_board/edit_notice_board_widget.dart';
import '/backend/backend.dart';
import '/confirmationpages/eventdeletedsuccessfully/eventdeletedsuccessfully_widget.dart';
import '/confirmationpages/noticeddeted/noticeddeted_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_delete_notice_model.dart';
export 'edit_delete_notice_model.dart';

class EditDeleteNoticeWidget extends StatefulWidget {
  const EditDeleteNoticeWidget({
    super.key,
    required this.classref,
    required this.eventid,
    bool? classEvent,
    this.event,
    required this.noticebool,
    this.eventImage,
    required this.schoolref,
  }) : this.classEvent = classEvent ?? false;

  final DocumentReference? classref;
  final int? eventid;
  final bool classEvent;
  final EventsNoticeStruct? event;
  final bool? noticebool;
  final EventsNoticeStruct? eventImage;
  final DocumentReference? schoolref;

  @override
  State<EditDeleteNoticeWidget> createState() => _EditDeleteNoticeWidgetState();
}

class _EditDeleteNoticeWidgetState extends State<EditDeleteNoticeWidget> {
  late EditDeleteNoticeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditDeleteNoticeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SchoolClassRecord>(
      stream: SchoolClassRecord.getDocument(widget.classref!),
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

        final containerSchoolClassRecord = snapshot.data!;

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
                      if (widget.classEvent == true) {
                        await containerSchoolClassRecord.reference.update({
                          ...mapToFirestore(
                            {
                              'calendar': getEventsNoticeListFirestoreData(
                                functions.deleteEvent(
                                    widget.eventid!,
                                    containerSchoolClassRecord.calendar
                                        .toList()),
                              ),
                            },
                          ),
                        });
                        _model.schoolref1 = await SchoolRecord.getDocumentOnce(
                            widget.schoolref!);

                        await _model.schoolref1!.reference.update({
                          ...mapToFirestore(
                            {
                              'Calendar_list': getEventsNoticeListFirestoreData(
                                functions.deleteEvent(widget.eventid!,
                                    _model.schoolref1!.calendarList.toList()),
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
                          CalenderClassWidget.routeName,
                          queryParameters: {
                            'schoolclassref': serializeParam(
                              widget.classref,
                              ParamType.DocumentReference,
                            ),
                            'schoolref': serializeParam(
                              widget.schoolref,
                              ParamType.DocumentReference,
                            ),
                            'mainpage': serializeParam(
                              false,
                              ParamType.bool,
                            ),
                            'studentpage': serializeParam(
                              false,
                              ParamType.bool,
                            ),
                          }.withoutNulls,
                        );
                      } else {
                        await containerSchoolClassRecord.reference.update({
                          ...mapToFirestore(
                            {
                              'notice': getEventsNoticeListFirestoreData(
                                functions.deleteEvent(widget.eventid!,
                                    containerSchoolClassRecord.notice.toList()),
                              ),
                            },
                          ),
                        });
                        _model.schoolref = await SchoolRecord.getDocumentOnce(
                            widget.schoolref!);

                        await _model.schoolref!.reference.update({
                          ...mapToFirestore(
                            {
                              'List_of_notice':
                                  getEventsNoticeListFirestoreData(
                                functions.deleteEvent(widget.eventid!,
                                    _model.schoolref!.listOfNotice.toList()),
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

                        context.pushNamed(
                          ClassViewWidget.routeName,
                          queryParameters: {
                            'schoolclassref': serializeParam(
                              widget.classref,
                              ParamType.DocumentReference,
                            ),
                            'schoolref': serializeParam(
                              widget.schoolref,
                              ParamType.DocumentReference,
                            ),
                            'datePick': serializeParam(
                              getCurrentTimestamp,
                              ParamType.DateTime,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
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
                        .divide(SizedBox(width: 10.0))
                        .around(SizedBox(width: 10.0)),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (widget.classEvent == false) {
                    FFAppState().eventfiles = [];
                    safeSetState(() {});
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
                            child: EditNoticeBoardWidget(
                              classref: containerSchoolClassRecord.reference,
                              eventid: widget.eventid!,
                              school: widget.schoolref!,
                              eventdata: widget.event!,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));

                    Navigator.pop(context);
                  } else {
                    FFAppState().eventfiles = [];
                    safeSetState(() {});
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
                            child: ClassCalendarEditWidget(
                              classref: containerSchoolClassRecord.reference,
                              eventid: widget.eventid!,
                              school: widget.schoolref!,
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
                  ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
