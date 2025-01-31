import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'notice_details_model.dart';
export 'notice_details_model.dart';

class NoticeDetailsWidget extends StatefulWidget {
  const NoticeDetailsWidget({
    super.key,
    this.eventDetails,
  });

  final EventsNoticeStruct? eventDetails;

  @override
  State<NoticeDetailsWidget> createState() => _NoticeDetailsWidgetState();
}

class _NoticeDetailsWidgetState extends State<NoticeDetailsWidget> {
  late NoticeDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoticeDetailsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).tertiary,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).info,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: FlutterFlowTheme.of(context).alternate,
              size: 20.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Notice',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.54,
                                  decoration: const BoxDecoration(),
                                  child: Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        widget.eventDetails?.eventTitle,
                                        'abc',
                                      ),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.35,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.04,
                                  decoration: BoxDecoration(
                                    color: valueOrDefault<Color>(
                                      () {
                                        if (widget.eventDetails?.eventName ==
                                            'Notice') {
                                          return const Color(0xFFFFFCF0);
                                        } else if (widget
                                                .eventDetails?.eventName ==
                                            'Reminder') {
                                          return const Color(0xC3FBF0FF);
                                        } else {
                                          return const Color(0xFFFFFCF0);
                                        }
                                      }(),
                                      FlutterFlowTheme.of(context).text,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color: valueOrDefault<Color>(
                                        () {
                                          if (widget.eventDetails?.eventName ==
                                              'Notice') {
                                            return const Color(0xFFB0FF6A);
                                          } else if (widget
                                                  .eventDetails?.eventName ==
                                              'Reminder') {
                                            return const Color(0xFFADA6EB);
                                          } else {
                                            return const Color(0xFFFF976A);
                                          }
                                        }(),
                                        FlutterFlowTheme.of(context).text,
                                      ),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (widget.eventDetails?.eventName ==
                                          'Notice')
                                        const Icon(
                                          Icons.push_pin,
                                          color: Color(0xFF99D63C),
                                          size: 20.0,
                                        ),
                                      if (widget.eventDetails?.eventName ==
                                          'Reminder')
                                        Icon(
                                          Icons.alarm,
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          size: 20.0,
                                        ),
                                      if (widget.eventDetails?.eventName ==
                                          'General')
                                        Icon(
                                          Icons.mode_comment,
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          size: 20.0,
                                        ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            widget.eventDetails?.eventName,
                                            'notice',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ]
                                        .divide(const SizedBox(width: 2.0))
                                        .around(const SizedBox(width: 2.0)),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              dateTimeFormat(
                                  "yMMMd", widget.eventDetails!.eventDate!),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              decoration: const BoxDecoration(),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.eventDetails?.eventDescription,
                                  'abc',
                                ),
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            if (widget.eventDetails?.eventImages.isNotEmpty)
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Builder(
                                  builder: (context) {
                                    final images = widget
                                            .eventDetails?.eventImages
                                            .toList() ??
                                        [];

                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(images.length,
                                          (imagesIndex) {
                                        final imagesItem = images[imagesIndex];
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              imagesItem,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.3,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ),
                          ]
                              .divide(const SizedBox(height: 10.0))
                              .around(const SizedBox(height: 10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ].addToEnd(const SizedBox(height: 40.0)),
            ),
          ),
        ),
      ),
    );
  }
}
