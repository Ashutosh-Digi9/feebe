// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class QuickActionDatatypeStruct extends FFFirebaseStruct {
  QuickActionDatatypeStruct({
    bool? isUploading,
    String? errorMessage,
    String? videoUrl,
    String? imageUrl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _isUploading = isUploading,
        _errorMessage = errorMessage,
        _videoUrl = videoUrl,
        _imageUrl = imageUrl,
        super(firestoreUtilData);

  // "isUploading" field.
  bool? _isUploading;
  bool get isUploading => _isUploading ?? false;
  set isUploading(bool? val) => _isUploading = val;

  bool hasIsUploading() => _isUploading != null;

  // "errorMessage" field.
  String? _errorMessage;
  String get errorMessage => _errorMessage ?? '';
  set errorMessage(String? val) => _errorMessage = val;

  bool hasErrorMessage() => _errorMessage != null;

  // "videoUrl" field.
  String? _videoUrl;
  String get videoUrl => _videoUrl ?? '';
  set videoUrl(String? val) => _videoUrl = val;

  bool hasVideoUrl() => _videoUrl != null;

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  static QuickActionDatatypeStruct fromMap(Map<String, dynamic> data) =>
      QuickActionDatatypeStruct(
        isUploading: data['isUploading'] as bool?,
        errorMessage: data['errorMessage'] as String?,
        videoUrl: data['videoUrl'] as String?,
        imageUrl: data['imageUrl'] as String?,
      );

  static QuickActionDatatypeStruct? maybeFromMap(dynamic data) => data is Map
      ? QuickActionDatatypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'isUploading': _isUploading,
        'errorMessage': _errorMessage,
        'videoUrl': _videoUrl,
        'imageUrl': _imageUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'isUploading': serializeParam(
          _isUploading,
          ParamType.bool,
        ),
        'errorMessage': serializeParam(
          _errorMessage,
          ParamType.String,
        ),
        'videoUrl': serializeParam(
          _videoUrl,
          ParamType.String,
        ),
        'imageUrl': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static QuickActionDatatypeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      QuickActionDatatypeStruct(
        isUploading: deserializeParam(
          data['isUploading'],
          ParamType.bool,
          false,
        ),
        errorMessage: deserializeParam(
          data['errorMessage'],
          ParamType.String,
          false,
        ),
        videoUrl: deserializeParam(
          data['videoUrl'],
          ParamType.String,
          false,
        ),
        imageUrl: deserializeParam(
          data['imageUrl'],
          ParamType.String,
          false,
        ),
      );

  static QuickActionDatatypeStruct fromAlgoliaData(Map<String, dynamic> data) =>
      QuickActionDatatypeStruct(
        isUploading: convertAlgoliaParam(
          data['isUploading'],
          ParamType.bool,
          false,
        ),
        errorMessage: convertAlgoliaParam(
          data['errorMessage'],
          ParamType.String,
          false,
        ),
        videoUrl: convertAlgoliaParam(
          data['videoUrl'],
          ParamType.String,
          false,
        ),
        imageUrl: convertAlgoliaParam(
          data['imageUrl'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'QuickActionDatatypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is QuickActionDatatypeStruct &&
        isUploading == other.isUploading &&
        errorMessage == other.errorMessage &&
        videoUrl == other.videoUrl &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([isUploading, errorMessage, videoUrl, imageUrl]);
}

QuickActionDatatypeStruct createQuickActionDatatypeStruct({
  bool? isUploading,
  String? errorMessage,
  String? videoUrl,
  String? imageUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuickActionDatatypeStruct(
      isUploading: isUploading,
      errorMessage: errorMessage,
      videoUrl: videoUrl,
      imageUrl: imageUrl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

QuickActionDatatypeStruct? updateQuickActionDatatypeStruct(
  QuickActionDatatypeStruct? quickActionDatatype, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    quickActionDatatype
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addQuickActionDatatypeStructData(
  Map<String, dynamic> firestoreData,
  QuickActionDatatypeStruct? quickActionDatatype,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (quickActionDatatype == null) {
    return;
  }
  if (quickActionDatatype.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && quickActionDatatype.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final quickActionDatatypeData =
      getQuickActionDatatypeFirestoreData(quickActionDatatype, forFieldValue);
  final nestedData =
      quickActionDatatypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      quickActionDatatype.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getQuickActionDatatypeFirestoreData(
  QuickActionDatatypeStruct? quickActionDatatype, [
  bool forFieldValue = false,
]) {
  if (quickActionDatatype == null) {
    return {};
  }
  final firestoreData = mapToFirestore(quickActionDatatype.toMap());

  // Add any Firestore field values
  quickActionDatatype.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuickActionDatatypeListFirestoreData(
  List<QuickActionDatatypeStruct>? quickActionDatatypes,
) =>
    quickActionDatatypes
        ?.map((e) => getQuickActionDatatypeFirestoreData(e, true))
        .toList() ??
    [];
