import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'options_admin_model.dart';
export 'options_admin_model.dart';

class OptionsAdminWidget extends StatefulWidget {
  const OptionsAdminWidget({
    super.key,
    required this.schoolref,
  });

  final DocumentReference? schoolref;

  @override
  State<OptionsAdminWidget> createState() => _OptionsAdminWidgetState();
}

class _OptionsAdminWidgetState extends State<OptionsAdminWidget> {
  late OptionsAdminModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionsAdminModel());
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
          width: MediaQuery.sizeOf(context).width * 0.15,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).lightBg,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'All',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Nunito',
                        letterSpacing: 0.0,
                      ),
                ),
                Builder(
                  builder: (context) {
                    final classes = containerSchoolRecord.listOfClass.toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: classes.length,
                      itemBuilder: (context, classesIndex) {
                        final classesItem = classes[classesIndex];
                        return Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.14,
                            decoration: const BoxDecoration(),
                            child: StreamBuilder<SchoolClassRecord>(
                              stream:
                                  SchoolClassRecord.getDocument(classesItem),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final textSchoolClassRecord = snapshot.data!;

                                return Text(
                                  textSchoolClassRecord.className,
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
