import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'calender_details_parent_model.dart';
export 'calender_details_parent_model.dart';

class CalenderDetailsParentWidget extends StatefulWidget {
  const CalenderDetailsParentWidget({
    super.key,
    this.eventDetails,
  });

  final EventsNoticeStruct? eventDetails;

  @override
  State<CalenderDetailsParentWidget> createState() =>
      _CalenderDetailsParentWidgetState();
}

class _CalenderDetailsParentWidgetState
    extends State<CalenderDetailsParentWidget> {
  late CalenderDetailsParentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalenderDetailsParentModel());
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
              size: 28.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Event',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito',
                  letterSpacing: 0.0,
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
                                Text(
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
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 10.0, 0.0),
                                  child: Container(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.03,
                                    decoration: BoxDecoration(
                                      color: () {
                                        if (valueOrDefault<String>(
                                              widget.eventDetails?.eventTitle,
                                              'abbc',
                                            ) ==
                                            'Event') {
                                          return const Color(0xFFFFFCF0);
                                        } else if (valueOrDefault<String>(
                                              widget.eventDetails?.eventTitle,
                                              'abbc',
                                            ) ==
                                            'Birthday') {
                                          return const Color(0xFFF0F0FF);
                                        } else {
                                          return const Color(0xFFFBFCFF);
                                        }
                                      }(),
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(
                                        color: () {
                                          if (valueOrDefault<String>(
                                                widget
                                                    .eventDetails?.eventTitle,
                                                'abbc',
                                              ) ==
                                              'Event') {
                                            return const Color(0xFFFFE26A);
                                          } else if (valueOrDefault<String>(
                                                widget
                                                    .eventDetails?.eventTitle,
                                                'abbc',
                                              ) ==
                                              'Birthday') {
                                            return const Color(0xFF635AAC);
                                          } else {
                                            return const Color(0xFF7DD7FE);
                                          }
                                        }(),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (valueOrDefault<String>(
                                                widget
                                                    .eventDetails?.eventTitle,
                                                'abbc',
                                              ) ==
                                              'Event')
                                            const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                              child: Icon(
                                                Icons.bolt,
                                                color: Color(0xFFF8BA0B),
                                                size: 24.0,
                                              ),
                                            ),
                                          if (valueOrDefault<String>(
                                                widget
                                                    .eventDetails?.eventTitle,
                                                'abbc',
                                              ) ==
                                              'Holiday')
                                            const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                              child: Icon(
                                                Icons.celebration_sharp,
                                                color: Color(0xFF072F78),
                                                size: 24.0,
                                              ),
                                            ),
                                          if (valueOrDefault<String>(
                                                widget
                                                    .eventDetails?.eventTitle,
                                                'abbc',
                                              ) ==
                                              'Birthday')
                                            const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                              child: Icon(
                                                Icons.cake,
                                                color: Color(0xFFB0A7FD),
                                                size: 24.0,
                                              ),
                                            ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                widget.eventDetails?.eventName,
                                                'abbc',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color: () {
                                                          if (valueOrDefault<
                                                                  String>(
                                                                widget
                                                                    .eventDetails
                                                                    ?.eventTitle,
                                                                'abbc',
                                                              ) ==
                                                              'Event') {
                                                            return const Color(
                                                                0xFFC29800);
                                                          } else if (valueOrDefault<
                                                                  String>(
                                                                widget
                                                                    .eventDetails
                                                                    ?.eventTitle,
                                                                'abbc',
                                                              ) ==
                                                              'Holiday') {
                                                            return const Color(
                                                                0xFF072F78);
                                                          } else {
                                                            return const Color(
                                                                0xFF4E0B6B);
                                                          }
                                                        }(),
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
