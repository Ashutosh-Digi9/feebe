import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'notice_post_model.dart';
export 'notice_post_model.dart';

class NoticePostWidget extends StatefulWidget {
  const NoticePostWidget({super.key});

  @override
  State<NoticePostWidget> createState() => _NoticePostWidgetState();
}

class _NoticePostWidgetState extends State<NoticePostWidget> {
  late NoticePostModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoticePostModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 0.6,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Lottie.asset(
            'assets/jsons/Animation_-_1730972410336.json',
            width: MediaQuery.sizeOf(context).width * 0.4,
            height: MediaQuery.sizeOf(context).height * 0.3,
            fit: BoxFit.contain,
            animate: true,
          ),
          Text(
            'Event Posted Succesfully',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito',
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
