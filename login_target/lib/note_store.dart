
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'note_store.g.dart';

class NoteStore = _NoteStore with _$NoteStore;

abstract class _NoteStore with Store {
  @observable
  ObservableList<String> notes = ObservableList<String>();

  @action
  void addNote(String note) {
    notes.add(note);
    saveNotes();
  }

  @action
  void editNote(int index, String note) {
    notes[index] = note;
    saveNotes();
  }

  @action
  void removeNote(int index) {
    notes.removeAt(index);
    saveNotes();
  }

  @action
  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNotes = prefs.getStringList('notes') ?? [];
    notes.clear();
    notes.addAll(ObservableList<String>.of(savedNotes));
  }

  @action
  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', notes.toList());
  }
}
