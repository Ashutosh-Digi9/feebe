import '/admin_dashboard/class_calendar_edit/class_calendar_edit_widget.dart';
import '/admin_dashboard/edit_notice_board/edit_notice_board_widget.dart';
import '/backend/backend.dart';
import '/confirmationpages/eventdeletedsuccessfully/eventdeletedsuccessfully_widget.dart';
import '/confirmationpages/noticeddeted/noticeddeted_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
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
  }) : classEvent = classEvent ?? false;

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
                  if (widget.classEvent == false) {
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
                            child: EditNoticeBoardWidget(
                              classref: containerSchoolClassRecord.reference,
                              eventid: widget.eventid!,
                              school: widget.schoolref!,
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
                            child: ClassCalendarEditWidget(
                              classref: containerSchoolClassRecord.reference,
                              eventid: widget.eventid!,
                              school: widget.schoolref!,
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

                        context.pushNamed(
                          'Class_view',
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
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
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

                        context.pushNamed(
                          'Class_view',
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
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
                        );
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
