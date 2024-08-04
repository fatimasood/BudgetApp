import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget BuildListItem(Map post, String id, Function(String) onEdit) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Text(
        post['category'] ?? 'No Category',
        style: GoogleFonts.raleway(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Budget: ${post['totalBudget'] ?? '0.00'}',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            Text(
              'Spending Amount: ${post['budgetController'] ?? '0.00'}',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.red.shade300),
        onPressed: () {
          onEdit(id);
        },
      ),
    ),
  );
}
