import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_php_app/components/crud.dart';
import 'package:notes_php_app/main.dart';

import '../const/linkapi.dart';
import '../widget/Textformwidget.dart';
import '../widget/Valid.dart';

class Editscreen extends StatefulWidget {
  final Notes;

  const Editscreen({super.key, this.Notes});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> with Crud {
  File? myfile;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController Title = TextEditingController();
  TextEditingController content = TextEditingController();

  editnotes() async {
    if (formstate.currentState!.validate()) {
      var response;
      if (myfile != null) {
        response = await PostRequestwithfile(
            linkupdate,
            {
              "title": Title.text,
              "content": content.text,
              "id": widget.Notes["notes_id"].toString(),
              "imagename": widget.Notes['notes_image'].toString()
            },
            myfile!);
      } else {
        response = await postRequest(
          linkupdate,
          {
            "title": Title.text,
            "content": content.text,
            "id": widget.Notes["notes_id"].toString(),
            "imagename": widget.Notes['notes_image'].toString()
          },
        );
      }

      if (response["status"] == "sucsses") {
        Navigator.of(context).pushReplacementNamed("Home");
      }
    }
  }

  @override
  void initState() {
    Title.text = widget.Notes["notes_title"];
    content.text = widget.Notes["notes_content"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 225, 225),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Add Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Form(
            key: formstate,
            child: ListView(children: [
              SizedBox(
                height: 7,
              ),
              Textformwidet(
                  hinttext: "Title",
                  mycontroller: Title,
                  valid: (val1) {
                    return validunput(val1!, 1, 40);
                  }),
              SizedBox(
                height: 7,
              ),
              Textformwidet(
                  hinttext: "content",
                  mycontroller: content,
                  valid: (val1) {
                    return validunput(val1!, 6, 261);
                  }),
              Container(
                  child: MaterialButton(
                      child: Text("Edit image "),
                      color: myfile == null
                          ? Colors.grey
                          : Color.fromARGB(255, 148, 106, 106),
                      textColor: Colors.white,
                      onPressed: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Choose image",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Color.fromARGB(
                                                  255, 117, 117, 117)),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        InkWell(
                                            child: Container(
                                          width: 250,
                                          child: MaterialButton(
                                              child: Text("from camera"),
                                              color: Colors.grey,
                                              textColor: Colors.white,
                                              onPressed: () async {
                                                XFile? xfile =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                Navigator.of(context).pop();
                                                myfile = File(xfile!.path);
                                                setState(() {});
                                              }),
                                        )),
                                        InkWell(
                                            child: Container(
                                          width: 250,
                                          child: MaterialButton(
                                              child: Text("from gallery"),
                                              color: Colors.grey,
                                              textColor: Colors.white,
                                              onPressed: () async {
                                                XFile? xfile =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                Navigator.of(context).pop();
                                                myfile = File(xfile!.path);
                                                setState(() {});
                                              }),
                                        ))
                                      ],
                                    ),
                                  ),
                                ));
                      })),
              Container(
                child: MaterialButton(
                    child: Text("save"),
                    color: Colors.grey,
                    textColor: Colors.white,
                    onPressed: () async {
                      await editnotes();
                    }),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
