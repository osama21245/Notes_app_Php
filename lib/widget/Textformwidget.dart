import 'package:flutter/material.dart';

class Textformwidet extends StatelessWidget {
  const Textformwidet(
      {super.key,
      required this.hinttext,
      required this.mycontroller,
      required this.valid});
  final TextEditingController mycontroller;
  final String? hinttext;
  final String? Function(String?) valid;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
            hintText: hinttext,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
