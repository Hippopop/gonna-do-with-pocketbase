import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'gonna_do_model.g.dart';

/// The type definition for a JSON-serializable [Map].
typedef JsonMap = Map<String, dynamic>;


/// {@template gonna_do}
/// A single gonna_do item.
///
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [GonnaDo]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class GonnaDo extends Equatable {
  /// {@macro gonna_do}
  GonnaDo({
    String? id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the gonna_do.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of the gonna_do.
  ///
  /// Note that the title may be empty.
  final String title;

  /// The description of the gonna_do.
  ///
  /// Defaults to an empty string.
  final String description;

  /// Whether the gonna_do is completed.
  ///
  /// Defaults to `false`.
  final bool isCompleted;

  /// Returns a copy of this gonna_do with the given values updated.
  ///
  /// {@macro gonna_do}
  GonnaDo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return GonnaDo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Deserializes the given [JsonMap] into a [GonnaDo].
  static GonnaDo fromJson(JsonMap json) => _$GonnaDoFromJson(json);

  /// Converts this [GonnaDo] into a [JsonMap].
  JsonMap toJson() => _$GonnaDoToJson(this);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
