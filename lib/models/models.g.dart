// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigModule _$ConfigModuleFromJson(Map<String, dynamic> json) {
  return ConfigModule(
    Level.fromJson(json['3'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConfigModuleToJson(ConfigModule instance) =>
    <String, dynamic>{
      '3': instance.three,
    };

Level _$LevelFromJson(Map<String, dynamic> json) {
  return Level(
    (json['1'] as List<dynamic>)
        .map((e) => Subject.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['2'] as List<dynamic>?)
        ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      '1': instance.one,
      '2': instance.two,
    };

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    json['code'] as String,
    _$enumDecode(_$SubjectModeEnumMap, json['mode']),
    json['name'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'url': instance.url,
      'mode': _$SubjectModeEnumMap[instance.mode],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$SubjectModeEnumMap = {
  SubjectMode.E: 'E',
  SubjectMode.C: 'C',
};
