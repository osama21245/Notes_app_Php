import 'package:flutter/material.dart';
import '../const/linkapi.dart';
import '../model/Notesmodel.dart';

class Card_w extends StatelessWidget {
  final NoteModel notemodel;

  final void Function()? ontap;

  const Card_w({super.key, required this.ontap, required this.notemodel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "$linkimageroute/${notemodel.notesImage}",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${notemodel.notesTitle}"),
                  subtitle: Text("${notemodel.notesContent}"),
                ))
          ],
        ),
      ),
    );
  }
}
