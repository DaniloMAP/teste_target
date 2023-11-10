// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NoteStore on _NoteStore, Store {
  late final _$notesAtom = Atom(name: '_NoteStore.notes', context: context);

  @override
  ObservableList<String> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<String> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$_NoteStoreActionController =
      ActionController(name: '_NoteStore', context: context);

  @override
  void addNote(String note) {
    final _$actionInfo =
        _$_NoteStoreActionController.startAction(name: '_NoteStore.addNote');
    try {
      return super.addNote(note);
    } finally {
      _$_NoteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editNote(int index, String newNote) {
    final _$actionInfo =
        _$_NoteStoreActionController.startAction(name: '_NoteStore.editNote');
    try {
      return super.editNote(index, newNote);
    } finally {
      _$_NoteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeNote(int index) {
    final _$actionInfo =
        _$_NoteStoreActionController.startAction(name: '_NoteStore.removeNote');
    try {
      return super.removeNote(index);
    } finally {
      _$_NoteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes}
    ''';
  }
}
