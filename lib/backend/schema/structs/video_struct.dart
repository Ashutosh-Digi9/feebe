// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class VideoStruct extends FFFirebaseStruct {
  VideoStruct({
    String? videopath,
    String? addedby,
    DateTime? date,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _videopath = videopath,
        _addedby = addedby,
        _date = date,
        super(firestoreUtilData);

  // "videopath" field.
  String? _videopath;
  String get videopath => _videopath ?? '';
  set videopath(String? val) => _videopath = val;

  bool hasVideopath() => _videopath != null;

  // "addedby" field.
  String? _addedby;
  String get addedby => _addedby ?? '';
  set addedby(String? val) => _addedby = val;

  bool hasAddedby() => _addedby != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  static VideoStruct fromMap(Map<String, dynamic> data) => VideoStruct(
        videopath: data['videopath'] as String?,
        addedby: data['addedby'] as String?,
        date: data['date'] as DateTime?,
      );

  static VideoStruct? maybeFromMap(dynamic data) =>
      data is Map ? VideoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'videopath': _videopath,
        'addedby': _addedby,
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'videopath': serializeParam(
          _videopath,
          ParamType.String,
        ),
        'addedby': serializeParam(
          _addedby,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static VideoStruct fromSerializableMap(Map<String, dynamic> data) =>
      VideoStruct(
        videopath: deserializeParam(
          data['videopath'],
          ParamType.String,
          false,
        ),
        addedby: deserializeParam(
          data['addedby'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
      );

  static VideoStruct fromAlgoliaData(Map<String, dynamic> data) => VideoStruct(
        videopath: convertAlgoliaParam(
          data['videopath'],
          ParamType.String,
          false,
        ),
        addedby: convertAlgoliaParam(
          data['addedby'],
          ParamType.String,
          false,
        ),
        date: convertAlgoliaParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        firestoreUtilData: FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'VideoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is VideoStruct &&
        videopath == other.videopath &&
        addedby == other.addedby &&
        date == other.date;
  }

  @override
  int get hashCode => const ListEquality().hash([videopath, addedby, date]);
}

VideoStruct createVideoStruct({
  String? videopath,
  String? addedby,
  DateTime? date,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    VideoStruct(
      videopath: videopath,
      addedby: addedby,
      date: date,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

VideoStruct? updateVideoStruct(
  VideoStruct? video, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    video
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addVideoStructData(
  Map<String, dynamic> firestoreData,
  VideoStruct? video,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (video == null) {
    return;
  }
  if (video.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && video.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final videoData = getVideoFirestoreData(video, forFieldValue);
  final nestedData = videoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = video.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getVideoFirestoreData(
  VideoStruct? video, [
  bool forFieldValue = false,
]) {
  if (video == null) {
    return {};
  }
  final firestoreData = mapToFirestore(video.toMap());

  // Add any Firestore field values
  video.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getVideoListFirestoreData(
  List<VideoStruct>? videos,
) =>
    videos?.map((e) => getVideoFirestoreData(e, true)).toList() ?? [];
