import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'nobracnhes_model.dart';
export 'nobracnhes_model.dart';

class NobracnhesWidget extends StatefulWidget {
  const NobracnhesWidget({super.key});

  @override
  State<NobracnhesWidget> createState() => _NobracnhesWidgetState();
}

class _NobracnhesWidgetState extends State<NobracnhesWidget> {
  late NobracnhesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NobracnhesModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'No Branches added',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Lottie.asset(
              'assets/jsons/Animation_-_1731397522746.json',
              width: MediaQuery.sizeOf(context).width * 0.9,
              height: MediaQuery.sizeOf(context).height * 0.3,
              fit: BoxFit.contain,
              animate: true,
            ),
          ),
        ],
      ),
    );
  }
}
