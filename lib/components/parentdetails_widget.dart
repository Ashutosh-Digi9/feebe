import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'parentdetails_model.dart';
export 'parentdetails_model.dart';

class ParentdetailsWidget extends StatefulWidget {
  const ParentdetailsWidget({
    super.key,
    required this.userref,
  });

  final DocumentReference? userref;

  @override
  State<ParentdetailsWidget> createState() => _ParentdetailsWidgetState();
}

class _ParentdetailsWidgetState extends State<ParentdetailsWidget> {
  late ParentdetailsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ParentdetailsModel());

    _model.parentname1FocusNode ??= FocusNode();

    _model.number1FocusNode ??= FocusNode();

    _model.email1FocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.userref!),
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

        final containerUsersRecord = snapshot.data!;

        return Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 0.15,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: TextFormField(
                    controller: _model.parentname1TextController ??=
                        TextEditingController(
                      text: containerUsersRecord.displayName,
                    ),
                    focusNode: _model.parentname1FocusNode,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Nunito',
                                letterSpacing: 0.0,
                              ),
                      hintText: 'Parent\'s name',
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                            fontFamily: 'Nunito',
                            color: FlutterFlowTheme.of(context).tertiaryText,
                            letterSpacing: 0.0,
                          ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                    keyboardType: TextInputType.name,
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    validator: _model.parentname1TextControllerValidator
                        .asValidator(context),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: TextFormField(
                    controller: _model.number1TextController ??=
                        TextEditingController(
                      text: containerUsersRecord.phoneNumber,
                    ),
                    focusNode: _model.number1FocusNode,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Nunito',
                                letterSpacing: 0.0,
                              ),
                      hintText: 'Number',
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                            fontFamily: 'Nunito',
                            color: FlutterFlowTheme.of(context).tertiaryText,
                            letterSpacing: 0.0,
                          ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                    maxLength: 10,
                    buildCounter: (context,
                            {required currentLength,
                            required isFocused,
                            maxLength}) =>
                        null,
                    keyboardType: TextInputType.phone,
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    validator: _model.number1TextControllerValidator
                        .asValidator(context),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: TextFormField(
                    controller: _model.email1TextController ??=
                        TextEditingController(
                      text: containerUsersRecord.email,
                    ),
                    focusNode: _model.email1FocusNode,
                    autofocus: false,
                    readOnly: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Nunito',
                                letterSpacing: 0.0,
                              ),
                      hintText: 'Email',
                      hintStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                            fontFamily: 'Nunito',
                            color: FlutterFlowTheme.of(context).tertiaryText,
                            letterSpacing: 0.0,
                          ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito',
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                        ),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    validator: _model.email1TextControllerValidator
                        .asValidator(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
