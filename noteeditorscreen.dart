import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/notepadcontroller.dart';

class NoteEditorScreen extends StatefulWidget {
  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final NotepadController controller = Get.find<NotepadController>();
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: controller.currentNote.value);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.isEditing.value ? 'Edit Note' : 'Add Note',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            if (controller.isEditing.value)
              ElevatedButton(
                  onPressed: () {
                    controller.updateNote();
                    Get.back(); // Navigate back to HomeScreen
                  },
                  child: Icon(Icons.save)
              ),
          ],
        )),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                onChanged: (value) {
                  controller.updateCurrentNote(value);
                },
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Your note',
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            if (controller.isEditing.value) SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {
                if (controller.isEditing.value) {
                  controller.updateNote();
                } else {
                  controller.saveNote();
                }
                Get.back(); // Navigate back to HomeScreen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                controller.isEditing.value ? 'Save Changes' : 'Save Note',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
