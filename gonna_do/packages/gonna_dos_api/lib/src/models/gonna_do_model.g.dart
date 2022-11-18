// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gonna_do_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GonnaDo _$GonnaDoFromJson(Map<String, dynamic> json) => GonnaDo(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$GonnaDoToJson(GonnaDo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
    };
