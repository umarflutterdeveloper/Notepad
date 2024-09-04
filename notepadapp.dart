import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/notepadcontroller.dart';
import 'noteeditorscreen.dart';

class NotepadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NotepadController controller = Get.put(NotepadController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notepad',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        elevation: 4.0,
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    elevation: 3.0,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15.0),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        controller.notes[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        controller.editNoteAt(index);
                        Get.to(() => NoteEditorScreen());
                      },
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.blue,
                        ),
                        onPressed: () => _showDeleteConfirmationDialog(context, controller, index),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.clearCurrentNote();
                  Get.to(() => NoteEditorScreen());
                },
                style: ElevatedButton.styleFrom
                  (backgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.add),
                    Text('New Note')
                  ],
                ),
                
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, NotepadController controller, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Note",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                controller.deleteNoteAt(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
