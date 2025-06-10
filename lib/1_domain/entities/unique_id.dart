import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class UniqueId extends Equatable {
  const UniqueId._(this.value);

  final String value;

  factory UniqueId() => UniqueId._(const Uuid().v4());

  factory UniqueId.fromUniqueString(String uniqueString) =>
      UniqueId._(uniqueString);

  @override
  List<Object?> get props => [value];
}

class CollectionId extends UniqueId {
  const CollectionId._(super.value) : super._();

  factory CollectionId() => CollectionId._(const Uuid().v4());

  factory CollectionId.fromUniqueString(String uniqueString) =>
      CollectionId._(uniqueString);
}

class EntryId extends UniqueId {
  const EntryId._(super.value) : super._();

  factory EntryId() => EntryId._(const Uuid().v4());

  factory EntryId.fromUniqueString(String uniqueString) =>
      EntryId._(uniqueString);
}
