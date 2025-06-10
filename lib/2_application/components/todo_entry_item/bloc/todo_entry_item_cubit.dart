import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_entry_item_cubit_state.dart';

class ToDoEntryItemCubit extends Cubit<ToDoEntryItemState> {
  ToDoEntryItemCubit({
    required this.entryId,
    required this.collectionId,
    required this.loadToDoEntry,
    required this.uploadToDoEntry,
  }) : super(ToDoEntryItemLoadingState());

  final EntryId entryId;
  final CollectionId collectionId;
  final LoadToDoEntry loadToDoEntry;
  final UpdateToDoEntry uploadToDoEntry;

  Future<void> fetch() async {
    try {
      final entry = await loadToDoEntry.call(
        ToDoEntryIdsParam(entryId: entryId, collectionId: collectionId),
      );

      return entry.fold(
        (left) => emit(ToDoEntryItemErrorState()),
        (right) => emit(ToDoEntryItemLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(ToDoEntryItemErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await uploadToDoEntry.call(
        ToDoEntryIdsParam(entryId: entryId, collectionId: collectionId),
      );

      return updatedEntry.fold(
        (left) => emit(ToDoEntryItemErrorState()),
        (right) => emit(ToDoEntryItemLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(ToDoEntryItemErrorState());
    }
  }
}
