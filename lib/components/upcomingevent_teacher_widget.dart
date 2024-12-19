import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'upcomingevent_teacher_model.dart';
export 'upcomingevent_teacher_model.dart';

class UpcomingeventTeacherWidget extends StatefulWidget {
  const UpcomingeventTeacherWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  @override
  State<UpcomingeventTeacherWidget> createState() =>
      _UpcomingeventTeacherWidgetState();
}

class _UpcomingeventTeacherWidgetState
    extends State<UpcomingeventTeacherWidget> {
  late UpcomingeventTeacherModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpcomingeventTeacherModel());
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
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.18,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).lightblue,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.7,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 50.0,
                        buttonSize: 40.0,
                        fillColor: FlutterFlowTheme.of(context).lightblue,
                        icon: Icon(
                          Icons.hourglass_full,
                          color: FlutterFlowTheme.of(context).warning,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        decoration: const BoxDecoration(),
                        child: Text(
                          'Upcoming  ${containerSchoolRecord.listOfNotice.where((e) => !functions.isDatePassed(e.eventDate!)).toList().sortedList(keyOf: (e) => e.eventDate!, desc: false).firstOrNull?.eventName}',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Nunito',
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 15.0)),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    containerSchoolRecord.listOfNotice
                        .where((e) => !functions.isDatePassed(e.eventDate!))
                        .toList()
                        .sortedList(keyOf: (e) => e.eventDate!, desc: false)
                        .firstOrNull!
                        .eventTitle,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: FlutterFlowTheme.of(context).text1,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    dateTimeFormat(
                        "MMMEd",
                        containerSchoolRecord.listOfNotice
                            .where((e) => !functions.isDatePassed(e.eventDate!))
                            .toList()
                            .sortedList(keyOf: (e) => e.eventDate!, desc: false)
                            .firstOrNull!
                            .eventDate!),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito',
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ].divide(const SizedBox(height: 15.0)).around(const SizedBox(height: 15.0)),
          ),
        );
      },
    );
  }
}
