import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'emptynotice_model.dart';
export 'emptynotice_model.dart';

class EmptynoticeWidget extends StatefulWidget {
  const EmptynoticeWidget({super.key});

  @override
  State<EmptynoticeWidget> createState() => _EmptynoticeWidgetState();
}

class _EmptynoticeWidgetState extends State<EmptynoticeWidget> {
  late EmptynoticeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptynoticeModel());
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
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Lottie.asset(
            'assets/jsons/Animation_-_1731310611734.json',
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: MediaQuery.sizeOf(context).height * 0.3,
            fit: BoxFit.contain,
            animate: true,
          ),
        ),
        Text(
          'No events',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontSize: 18.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
