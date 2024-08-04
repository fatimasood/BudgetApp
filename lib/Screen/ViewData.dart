import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'BuildListItem.dart';
import 'CustomDialog.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final ref = FirebaseDatabase.instance.ref('Post');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDialog({Map? post, bool isEdit = false, String? postId}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return ScaleTransition(
              scale: _scaleAnimation,
              child: CustomDialog(
                post: post,
                isEdit: isEdit,
                postId: postId,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentMonth = DateFormat('MMMM').format(DateTime.now());

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.shade300,
                  const Color.fromARGB(255, 244, 170, 170),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 55, left: 20),
                  child: Text(
                    'Saver Solutions',
                    style: GoogleFonts.raleway(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white70,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 20),
                  child: Row(
                    children: [
                      Text(
                        currentMonth,
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'Expenses',
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white70,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        iconSize: 30,
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.add_event,
                          progress: _controller,
                        ),
                        onPressed: _showDialog,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Container(
                width: double.infinity,
                // color: const Color.fromARGB(255, 251, 206, 241),
                child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final post = snapshot.value as Map;
                    final postId = snapshot.key;
                    return BuildListItem(
                      post,
                      postId!,
                      (id) {
                        _showDialog(
                          post: post,
                          isEdit: true,
                          postId: id,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
