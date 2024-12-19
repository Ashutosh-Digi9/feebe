import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'emptytimeline_model.dart';
export 'emptytimeline_model.dart';

class EmptytimelineWidget extends StatefulWidget {
  const EmptytimelineWidget({super.key});

  @override
  State<EmptytimelineWidget> createState() => _EmptytimelineWidgetState();
}

class _EmptytimelineWidgetState extends State<EmptytimelineWidget> {
  late EmptytimelineModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptytimelineModel());
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
      children: [
        Lottie.asset(
          'assets/jsons/Animation_-_1732258634882.json',
          width: 200.0,
          height: 200.0,
          fit: BoxFit.contain,
          animate: true,
        ),
        Text(
          'No updates on timeline',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Nunito',
                fontSize: 16.0,
                letterSpacing: 0.0,
              ),
        ),
      ],
    );
  }
}
