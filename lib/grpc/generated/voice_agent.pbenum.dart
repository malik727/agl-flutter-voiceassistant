//
//  Generated code. Do not modify.
//  source: voice_agent.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RecordAction extends $pb.ProtobufEnum {
  static const RecordAction START = RecordAction._(0, _omitEnumNames ? '' : 'START');
  static const RecordAction STOP = RecordAction._(1, _omitEnumNames ? '' : 'STOP');

  static const $core.List<RecordAction> values = <RecordAction> [
    START,
    STOP,
  ];

  static final $core.Map<$core.int, RecordAction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RecordAction? valueOf($core.int value) => _byValue[value];

  const RecordAction._($core.int v, $core.String n) : super(v, n);
}

class NLUModel extends $pb.ProtobufEnum {
  static const NLUModel SNIPS = NLUModel._(0, _omitEnumNames ? '' : 'SNIPS');
  static const NLUModel RASA = NLUModel._(1, _omitEnumNames ? '' : 'RASA');

  static const $core.List<NLUModel> values = <NLUModel> [
    SNIPS,
    RASA,
  ];

  static final $core.Map<$core.int, NLUModel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NLUModel? valueOf($core.int value) => _byValue[value];

  const NLUModel._($core.int v, $core.String n) : super(v, n);
}

class RecordMode extends $pb.ProtobufEnum {
  static const RecordMode MANUAL = RecordMode._(0, _omitEnumNames ? '' : 'MANUAL');
  static const RecordMode AUTO = RecordMode._(1, _omitEnumNames ? '' : 'AUTO');

  static const $core.List<RecordMode> values = <RecordMode> [
    MANUAL,
    AUTO,
  ];

  static final $core.Map<$core.int, RecordMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RecordMode? valueOf($core.int value) => _byValue[value];

  const RecordMode._($core.int v, $core.String n) : super(v, n);
}

class RecognizeStatusType extends $pb.ProtobufEnum {
  static const RecognizeStatusType REC_ERROR = RecognizeStatusType._(0, _omitEnumNames ? '' : 'REC_ERROR');
  static const RecognizeStatusType REC_SUCCESS = RecognizeStatusType._(1, _omitEnumNames ? '' : 'REC_SUCCESS');
  static const RecognizeStatusType REC_PROCESSING = RecognizeStatusType._(2, _omitEnumNames ? '' : 'REC_PROCESSING');
  static const RecognizeStatusType VOICE_NOT_RECOGNIZED = RecognizeStatusType._(3, _omitEnumNames ? '' : 'VOICE_NOT_RECOGNIZED');
  static const RecognizeStatusType INTENT_NOT_RECOGNIZED = RecognizeStatusType._(4, _omitEnumNames ? '' : 'INTENT_NOT_RECOGNIZED');
  static const RecognizeStatusType TEXT_NOT_RECOGNIZED = RecognizeStatusType._(5, _omitEnumNames ? '' : 'TEXT_NOT_RECOGNIZED');
  static const RecognizeStatusType NLU_MODEL_NOT_SUPPORTED = RecognizeStatusType._(6, _omitEnumNames ? '' : 'NLU_MODEL_NOT_SUPPORTED');

  static const $core.List<RecognizeStatusType> values = <RecognizeStatusType> [
    REC_ERROR,
    REC_SUCCESS,
    REC_PROCESSING,
    VOICE_NOT_RECOGNIZED,
    INTENT_NOT_RECOGNIZED,
    TEXT_NOT_RECOGNIZED,
    NLU_MODEL_NOT_SUPPORTED,
  ];

  static final $core.Map<$core.int, RecognizeStatusType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RecognizeStatusType? valueOf($core.int value) => _byValue[value];

  const RecognizeStatusType._($core.int v, $core.String n) : super(v, n);
}

class ExecuteStatusType extends $pb.ProtobufEnum {
  static const ExecuteStatusType EXEC_ERROR = ExecuteStatusType._(0, _omitEnumNames ? '' : 'EXEC_ERROR');
  static const ExecuteStatusType EXEC_SUCCESS = ExecuteStatusType._(1, _omitEnumNames ? '' : 'EXEC_SUCCESS');
  static const ExecuteStatusType KUKSA_CONN_ERROR = ExecuteStatusType._(2, _omitEnumNames ? '' : 'KUKSA_CONN_ERROR');
  static const ExecuteStatusType INTENT_NOT_SUPPORTED = ExecuteStatusType._(3, _omitEnumNames ? '' : 'INTENT_NOT_SUPPORTED');
  static const ExecuteStatusType INTENT_SLOTS_INCOMPLETE = ExecuteStatusType._(4, _omitEnumNames ? '' : 'INTENT_SLOTS_INCOMPLETE');

  static const $core.List<ExecuteStatusType> values = <ExecuteStatusType> [
    EXEC_ERROR,
    EXEC_SUCCESS,
    KUKSA_CONN_ERROR,
    INTENT_NOT_SUPPORTED,
    INTENT_SLOTS_INCOMPLETE,
  ];

  static final $core.Map<$core.int, ExecuteStatusType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExecuteStatusType? valueOf($core.int value) => _byValue[value];

  const ExecuteStatusType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
