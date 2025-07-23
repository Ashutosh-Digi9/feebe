import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'noticeedited_model.dart';
export 'noticeedited_model.dart';

class NoticeeditedWidget extends StatefulWidget {
  const NoticeeditedWidget({super.key});

  @override
  State<NoticeeditedWidget> createState() => _NoticeeditedWidgetState();
}

class _NoticeeditedWidgetState extends State<NoticeeditedWidget> {
  late NoticeeditedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoticeeditedModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(
          milliseconds: 2000,
        ),
      );
      FFAppState().eventfiles = [];
      FFAppState().update(() {});
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: Color(0xFFE4EBF8),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Color(0x33000000),
            offset: Offset(
              1.0,
              1.0,
            ),
            spreadRadius: 2.0,
          )
        ],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Notice edited',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).text1,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Color(0xFFD7F9CB),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(9.0),
              child: FlutterFlowIconButton(
                borderRadius: 38.0,
                fillColor: Color(0xFF4BA22E),
                icon: Icon(
                  Icons.done,
                  color: FlutterFlowTheme.of(context).info,
                  size: 25.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
