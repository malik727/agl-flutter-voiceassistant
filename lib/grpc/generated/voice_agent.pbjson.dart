//
//  Generated code. Do not modify.
//  source: voice_agent.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use recordActionDescriptor instead')
const RecordAction$json = {
  '1': 'RecordAction',
  '2': [
    {'1': 'START', '2': 0},
    {'1': 'STOP', '2': 1},
  ],
};

/// Descriptor for `RecordAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List recordActionDescriptor =
    $convert.base64Decode('CgxSZWNvcmRBY3Rpb24SCQoFU1RBUlQQABIICgRTVE9QEAE=');

@$core.Deprecated('Use nLUModelDescriptor instead')
const NLUModel$json = {
  '1': 'NLUModel',
  '2': [
    {'1': 'SNIPS', '2': 0},
    {'1': 'RASA', '2': 1},
  ],
};

/// Descriptor for `NLUModel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nLUModelDescriptor =
    $convert.base64Decode('CghOTFVNb2RlbBIJCgVTTklQUxAAEggKBFJBU0EQAQ==');

@$core.Deprecated('Use recordModeDescriptor instead')
const RecordMode$json = {
  '1': 'RecordMode',
  '2': [
    {'1': 'MANUAL', '2': 0},
    {'1': 'AUTO', '2': 1},
  ],
};

/// Descriptor for `RecordMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List recordModeDescriptor =
    $convert.base64Decode('CgpSZWNvcmRNb2RlEgoKBk1BTlVBTBAAEggKBEFVVE8QAQ==');

@$core.Deprecated('Use recognizeStatusTypeDescriptor instead')
const RecognizeStatusType$json = {
  '1': 'RecognizeStatusType',
  '2': [
    {'1': 'REC_ERROR', '2': 0},
    {'1': 'REC_SUCCESS', '2': 1},
    {'1': 'REC_PROCESSING', '2': 2},
    {'1': 'VOICE_NOT_RECOGNIZED', '2': 3},
    {'1': 'INTENT_NOT_RECOGNIZED', '2': 4},
  ],
};

/// Descriptor for `RecognizeStatusType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List recognizeStatusTypeDescriptor = $convert.base64Decode(
    'ChNSZWNvZ25pemVTdGF0dXNUeXBlEg0KCVJFQ19FUlJPUhAAEg8KC1JFQ19TVUNDRVNTEAESEg'
    'oOUkVDX1BST0NFU1NJTkcQAhIYChRWT0lDRV9OT1RfUkVDT0dOSVpFRBADEhkKFUlOVEVOVF9O'
    'T1RfUkVDT0dOSVpFRBAE');

@$core.Deprecated('Use executeStatusTypeDescriptor instead')
const ExecuteStatusType$json = {
  '1': 'ExecuteStatusType',
  '2': [
    {'1': 'EXEC_ERROR', '2': 0},
    {'1': 'EXEC_SUCCESS', '2': 1},
    {'1': 'KUKSA_CONN_ERROR', '2': 2},
    {'1': 'INTENT_NOT_SUPPORTED', '2': 3},
    {'1': 'INTENT_SLOTS_INCOMPLETE', '2': 4},
  ],
};

/// Descriptor for `ExecuteStatusType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List executeStatusTypeDescriptor = $convert.base64Decode(
    'ChFFeGVjdXRlU3RhdHVzVHlwZRIOCgpFWEVDX0VSUk9SEAASEAoMRVhFQ19TVUNDRVNTEAESFA'
    'oQS1VLU0FfQ09OTl9FUlJPUhACEhgKFElOVEVOVF9OT1RfU1VQUE9SVEVEEAMSGwoXSU5URU5U'
    'X1NMT1RTX0lOQ09NUExFVEUQBA==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');

@$core.Deprecated('Use serviceStatusDescriptor instead')
const ServiceStatus$json = {
  '1': 'ServiceStatus',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 9, '10': 'version'},
    {'1': 'status', '3': 2, '4': 1, '5': 8, '10': 'status'},
  ],
};

/// Descriptor for `ServiceStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceStatusDescriptor = $convert.base64Decode(
    'Cg1TZXJ2aWNlU3RhdHVzEhgKB3ZlcnNpb24YASABKAlSB3ZlcnNpb24SFgoGc3RhdHVzGAIgAS'
    'gIUgZzdGF0dXM=');

@$core.Deprecated('Use wakeWordStatusDescriptor instead')
const WakeWordStatus$json = {
  '1': 'WakeWordStatus',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 8, '10': 'status'},
  ],
};

/// Descriptor for `WakeWordStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wakeWordStatusDescriptor = $convert
    .base64Decode('Cg5XYWtlV29yZFN0YXR1cxIWCgZzdGF0dXMYASABKAhSBnN0YXR1cw==');

@$core.Deprecated('Use recognizeControlDescriptor instead')
const RecognizeControl$json = {
  '1': 'RecognizeControl',
  '2': [
    {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.RecordAction',
      '10': 'action'
    },
    {
      '1': 'nlu_model',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.NLUModel',
      '10': 'nluModel'
    },
    {
      '1': 'record_mode',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.RecordMode',
      '10': 'recordMode'
    },
    {'1': 'stream_id', '3': 4, '4': 1, '5': 9, '10': 'streamId'},
  ],
};

/// Descriptor for `RecognizeControl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recognizeControlDescriptor = $convert.base64Decode(
    'ChBSZWNvZ25pemVDb250cm9sEiUKBmFjdGlvbhgBIAEoDjINLlJlY29yZEFjdGlvblIGYWN0aW'
    '9uEiYKCW5sdV9tb2RlbBgCIAEoDjIJLk5MVU1vZGVsUghubHVNb2RlbBIsCgtyZWNvcmRfbW9k'
    'ZRgDIAEoDjILLlJlY29yZE1vZGVSCnJlY29yZE1vZGUSGwoJc3RyZWFtX2lkGAQgASgJUghzdH'
    'JlYW1JZA==');

@$core.Deprecated('Use intentSlotDescriptor instead')
const IntentSlot$json = {
  '1': 'IntentSlot',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `IntentSlot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List intentSlotDescriptor = $convert.base64Decode(
    'CgpJbnRlbnRTbG90EhIKBG5hbWUYASABKAlSBG5hbWUSFAoFdmFsdWUYAiABKAlSBXZhbHVl');

@$core.Deprecated('Use recognizeResultDescriptor instead')
const RecognizeResult$json = {
  '1': 'RecognizeResult',
  '2': [
    {'1': 'command', '3': 1, '4': 1, '5': 9, '10': 'command'},
    {'1': 'intent', '3': 2, '4': 1, '5': 9, '10': 'intent'},
    {
      '1': 'intent_slots',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.IntentSlot',
      '10': 'intentSlots'
    },
    {'1': 'stream_id', '3': 4, '4': 1, '5': 9, '10': 'streamId'},
    {
      '1': 'status',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.RecognizeStatusType',
      '10': 'status'
    },
  ],
};

/// Descriptor for `RecognizeResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recognizeResultDescriptor = $convert.base64Decode(
    'Cg9SZWNvZ25pemVSZXN1bHQSGAoHY29tbWFuZBgBIAEoCVIHY29tbWFuZBIWCgZpbnRlbnQYAi'
    'ABKAlSBmludGVudBIuCgxpbnRlbnRfc2xvdHMYAyADKAsyCy5JbnRlbnRTbG90UgtpbnRlbnRT'
    'bG90cxIbCglzdHJlYW1faWQYBCABKAlSCHN0cmVhbUlkEiwKBnN0YXR1cxgFIAEoDjIULlJlY2'
    '9nbml6ZVN0YXR1c1R5cGVSBnN0YXR1cw==');

@$core.Deprecated('Use executeInputDescriptor instead')
const ExecuteInput$json = {
  '1': 'ExecuteInput',
  '2': [
    {'1': 'intent', '3': 1, '4': 1, '5': 9, '10': 'intent'},
    {
      '1': 'intent_slots',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.IntentSlot',
      '10': 'intentSlots'
    },
  ],
};

/// Descriptor for `ExecuteInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executeInputDescriptor = $convert.base64Decode(
    'CgxFeGVjdXRlSW5wdXQSFgoGaW50ZW50GAEgASgJUgZpbnRlbnQSLgoMaW50ZW50X3Nsb3RzGA'
    'IgAygLMgsuSW50ZW50U2xvdFILaW50ZW50U2xvdHM=');

@$core.Deprecated('Use executeResultDescriptor instead')
const ExecuteResult$json = {
  '1': 'ExecuteResult',
  '2': [
    {'1': 'response', '3': 1, '4': 1, '5': 9, '10': 'response'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.ExecuteStatusType',
      '10': 'status'
    },
  ],
};

/// Descriptor for `ExecuteResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executeResultDescriptor = $convert.base64Decode(
    'Cg1FeGVjdXRlUmVzdWx0EhoKCHJlc3BvbnNlGAEgASgJUghyZXNwb25zZRIqCgZzdGF0dXMYAi'
    'ABKA4yEi5FeGVjdXRlU3RhdHVzVHlwZVIGc3RhdHVz');
