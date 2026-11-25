import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Portfolio project synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.projectUrl,
    this.projectImageUrl ="",
  });

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  final String technologies;
  final String projectUrl;
  
  @JsonKey(defaultValue: '')
  final String projectImageUrl;
}