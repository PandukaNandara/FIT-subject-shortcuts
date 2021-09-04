import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class ConfigModule {
  @JsonKey(name: '3')
  final Level three;

  ConfigModule(this.three);

  factory ConfigModule.fromJson(Map<String, dynamic> json) =>
      _$ConfigModuleFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigModuleToJson(this);

  Subject? getSubject(String code) {
    return _getSubject(three.one, code);
  }

  Subject? _getSubject(List<Subject> list, String code) {
    try {
      return list.singleWhere((element) => element.code == code);
    } catch (_) {
      return null;
    }
  }
}

@JsonSerializable()
class Level {
  @JsonKey(name: '1')
  final List<Subject> one;

  @JsonKey(name: '2')
  final List<Subject>? two;

  Level(this.one, this.two);

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
  Map<String, dynamic> toJson() => _$LevelToJson(this);
}

@JsonSerializable()
class Subject {
  final String code;
  final String name;
  final String url;

  const Subject(this.code, this.name, this.url);

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
