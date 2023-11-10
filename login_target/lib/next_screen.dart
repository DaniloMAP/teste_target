import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'note_store.dart';
import 'note_card.dart';

class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  final NoteStore noteStore = NoteStore();
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  int? editingIndex;

  @override
  void initState() {
    super.initState();
    noteStore.loadNotes();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => focusNode.requestFocus());
  }

  void _addOrEditNote(bool isEditing, [int? index]) {
    if (textController.text.isNotEmpty) {
      if (isEditing && index != null) {
        noteStore.editNote(index, textController.text);
      } else {
        noteStore.addNote(textController.text);
      }
      textController.clear();
      focusNode.requestFocus();
      editingIndex = null;
    }
  }

  void _launchURL() async {
    const url = 'https://www.google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade800,
              Colors.teal.shade400,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Card(
                child: Observer(
                  builder: (_) => ListView.separated(
                    shrinkWrap: true,
                    itemCount: noteStore.notes.length,
                    separatorBuilder: (_, index) =>
                        Divider(color: Colors.black),
                    itemBuilder: (_, index) {
                      return NoteCard(
                        note: noteStore.notes[index],
                        onEdit: () {
                          setState(() {
                            textController.text = noteStore.notes[index];
                            editingIndex = index;
                          });
                          focusNode.requestFocus();
                        },
                        onDelete: () {
                          noteStore.removeNote(index);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: TextField(
                controller: textController,
                focusNode: focusNode,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Digite seu texto',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: TextStyle(color: Colors.black),
                onSubmitted: (_) =>
                    _addOrEditNote(editingIndex != null, editingIndex),
                textInputAction: TextInputAction.done,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: InkWell(
                child: Text(
                  'Política de Privacidade',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                onTap: _launchURL,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
