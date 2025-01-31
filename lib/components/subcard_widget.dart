import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'subcard_model.dart';
export 'subcard_model.dart';

class SubcardWidget extends StatefulWidget {
  const SubcardWidget({
    super.key,
    this.subId,
    this.subref,
  });

  final int? subId;
  final DocumentReference? subref;

  @override
  State<SubcardWidget> createState() => _SubcardWidgetState();
}

class _SubcardWidgetState extends State<SubcardWidget> {
  late SubcardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubcardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
      child: StreamBuilder<SubScriptionRecord>(
        stream: SubScriptionRecord.getDocument(widget.subref!),
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

          final cardSubScriptionRecord = snapshot.data!;

          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 200.0,
                              decoration: const BoxDecoration(),
                              child: Material(
                                color: Colors.transparent,
                                child: Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  child: CheckboxListTile(
                                    value: _model.checkboxListTileValue ??=
                                        widget.subId ==
                                            FFAppState().selectedSubscriptionId,
                                    onChanged: (newValue) async {
                                      safeSetState(() => _model
                                          .checkboxListTileValue = newValue!);
                                      if (newValue!) {
                                        _model.id = widget.subId;
                                        safeSetState(() {});
                                        FFAppState().subscription =
                                            SubscribtionDetailsStruct(
                                          subId: widget.subId,
                                          subName:
                                              cardSubScriptionRecord.name,
                                          subAmount:
                                              cardSubScriptionRecord.amount,
                                          frequency: cardSubScriptionRecord
                                              .frequency,
                                          subScriptionFeature:
                                              cardSubScriptionRecord
                                                  .featuresList,
                                          startDate: getCurrentTimestamp,
                                          endDate: functions.return30day(
                                              getCurrentTimestamp),
                                        );
                                        FFAppState().selectedSubscriptionId =
                                            widget.subId!;
                                        FFAppState().update(() {});
                                                                            } else {
                                        FFAppState().subscription =
                                            SubscribtionDetailsStruct();
                                        FFAppState().update(() {});
                                      }
                                    },
                                    title: Text(
                                      cardSubScriptionRecord.name,
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            fontFamily: 'Nunito',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    tileColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    activeColor:
                                        FlutterFlowTheme.of(context).primary,
                                    checkColor:
                                        FlutterFlowTheme.of(context).info,
                                    dense: false,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                      child: Text(
                        '${cardSubScriptionRecord.amount.toString()}/${cardSubScriptionRecord.frequency}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito',
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Builder(
                    builder: (context) {
                      final features =
                          cardSubScriptionRecord.featuresList.toList();

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children:
                            List.generate(features.length, (featuresIndex) {
                          final featuresItem = features[featuresIndex];
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryText,
                                size: 12.0,
                              ),
                              Text(
                                featuresItem,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryText,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ]
                                .divide(const SizedBox(width: 10.0))
                                .around(const SizedBox(width: 10.0)),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ].divide(const SizedBox(height: 5.0)),
            ),
          );
        },
      ),
    );
  }
}
