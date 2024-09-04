import 'package:get/get.dart';

class NotepadController extends GetxController {
  var notes = <String>[].obs;
  var currentNote = ''.obs;
  var isEditing = false.obs;
  var editingIndex = (-1).obs;

  void saveNote() {
    if (currentNote.value.isNotEmpty) {
      notes.add(currentNote.value);
      clearCurrentNote();
    }
  }

  void updateNote() {
    if (currentNote.value.isNotEmpty && editingIndex.value != -1) {
      notes[editingIndex.value] = currentNote.value;
      clearCurrentNote();
    }
  }

  void updateCurrentNote(String value) {
    currentNote.value = value;
  }

  void editNoteAt(int index) {
    currentNote.value = notes[index];
    isEditing.value = true;
    editingIndex.value = index;
  }

  void clearCurrentNote() {
    currentNote.value = '';
    isEditing.value = false;
    editingIndex.value = -1;
  }

  void deleteNoteAt(int index) {
    notes.removeAt(index);
    if (isEditing.value && editingIndex.value == index) {
      clearCurrentNote();
    }
  }
}
