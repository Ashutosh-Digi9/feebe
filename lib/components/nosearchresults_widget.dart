import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'nosearchresults_model.dart';
export 'nosearchresults_model.dart';

class NosearchresultsWidget extends StatefulWidget {
  const NosearchresultsWidget({super.key});

  @override
  State<NosearchresultsWidget> createState() => _NosearchresultsWidgetState();
}

class _NosearchresultsWidgetState extends State<NosearchresultsWidget> {
  late NosearchresultsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NosearchresultsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/jsons/Animation_-_1731314874616.json',
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: MediaQuery.sizeOf(context).height * 0.2,
          fit: BoxFit.contain,
          animate: true,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: Text(
            'No search results found',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito',
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
