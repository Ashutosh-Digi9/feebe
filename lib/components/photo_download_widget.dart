import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'photo_download_model.dart';
export 'photo_download_model.dart';

class PhotoDownloadWidget extends StatefulWidget {
  const PhotoDownloadWidget({super.key});

  @override
  State<PhotoDownloadWidget> createState() => _PhotoDownloadWidgetState();
}

class _PhotoDownloadWidgetState extends State<PhotoDownloadWidget> {
  late PhotoDownloadModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhotoDownloadModel());
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
      height: MediaQuery.sizeOf(context).height * 0.06,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                child: Stack(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.06,
                      height: MediaQuery.sizeOf(context).width * 0.06,
                      decoration: BoxDecoration(
                        color: Color(0xFF4BA22E),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Photo downloaded',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
