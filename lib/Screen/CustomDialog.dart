import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatefulWidget {
  final Map? post;
  final bool isEdit;
  final String? postId;

  const CustomDialog({
    super.key,
    this.post,
    this.isEdit = false,
    this.postId,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final categoryController = TextEditingController();
  final budgetController = TextEditingController();
  final totalController = TextEditingController();

  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.post != null) {
      final post = widget.post!;
      categoryController.text = post['category'];
      budgetController.text = post['spendingAmount'].toString();
      totalController.text = post['totalBudget'].toString();
    }
  }

  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isEdit ? 'Edit Budget Details' : 'Add Budget Details',
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(179, 37, 36, 36),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Category Name',
              ),
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: const Color.fromARGB(179, 37, 36, 36),
              ),
            ),
            const SizedBox(height: 7),
            TextField(
              controller: totalController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Budgeted Amount',
              ),
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: const Color.fromARGB(179, 37, 36, 36),
              ),
            ),
            const SizedBox(height: 7),
            TextField(
              controller: budgetController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Spending Amount',
              ),
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: const Color.fromARGB(179, 37, 36, 36),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(179, 37, 36, 36),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      final id = widget.isEdit
                          ? widget.postId
                          : databaseRef.push().key;
                      if (id != null) {
                        await databaseRef.child(id).set({
                          'id': id,
                          'category': categoryController.text,
                          'totalBudget': double.parse(totalController.text),
                          'budgetController':
                              double.parse(budgetController.text),
                        });

                        Navigator.of(context).pop();
                      }
                    } catch (error) {
                      setState(() {
                        loading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to add data: $error'),
                        ),
                      );
                    }
                  },
                  child: loading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        )
                      : Text(
                          widget.isEdit ? 'Update' : 'Add',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(179, 37, 36, 36),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
