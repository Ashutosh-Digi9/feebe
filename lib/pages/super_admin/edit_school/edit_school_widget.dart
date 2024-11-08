import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/super_admin/delete/delete_widget.dart';
import 'package:flutter/material.dart';
import 'edit_school_model.dart';
export 'edit_school_model.dart';

class EditSchoolWidget extends StatefulWidget {
  const EditSchoolWidget({super.key});

  @override
  State<EditSchoolWidget> createState() => _EditSchoolWidgetState();
}

class _EditSchoolWidgetState extends State<EditSchoolWidget> {
  late EditSchoolModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditSchoolModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.15,
      height: MediaQuery.sizeOf(context).height * 0.1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).lightBg,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Builder(
            builder: (context) => InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                Navigator.pop(context);
                await showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return Dialog(
                      elevation: 0,
                      insetPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      alignment: const AlignmentDirectional(0.0, 0.0)
                          .resolve(Directionality.of(context)),
                      child: const DeleteWidget(),
                    );
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                  Text(
                    'Delete',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ].divide(const SizedBox(width: 15.0)).around(const SizedBox(width: 15.0)),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
              Text(
                'Edit',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ].divide(const SizedBox(width: 15.0)).around(const SizedBox(width: 15.0)),
          ),
        ],
      ),
    );
  }
}
