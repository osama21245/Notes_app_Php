import 'package:flutter/material.dart';
import 'package:notes_php_app/const/linkapi.dart';
import 'package:notes_php_app/main.dart';
import 'package:notes_php_app/model/Notesmodel.dart';
import 'package:notes_php_app/notes/edit.dart';
import 'package:notes_php_app/widget/card.dart';

import '../components/crud.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with Crud {
  @override
  getnotes() async {
    var response = await postRequest(linkview, {"id": pref.getString("id")});
    return response;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 225, 225),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                pref.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, "./", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.pushNamed(context, "Add");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getnotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["status"] == "faild") {
                      return Center(
                        child: Text("لا توجد رسائل"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onLongPress: () async {
                              await Alertdialog_r(context, snapshot, i);
                            },
                            child: Card_w(
                                notemodel: NoteModel.fromJson(
                                    snapshot.data["data"][i]),
                                ontap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Editscreen(
                                            Notes: snapshot.data["data"][i],
                                          )));
                                }),
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  }
                  return Center(
                    child: Text("Loading..."),
                  );
                })
            // Card_w(Title: "wael", Content: "wee", ontap: (){})
          ],
        ),
      ),
    );
  }

  //aletdialog

  Future<void> Alertdialog_r(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, int i) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Warning"),
              content: Text("Are you sure you want to delete this message ?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("no")),
                TextButton(
                    onPressed: () async {
                      setState(() {});
                      var response = await postRequest(linkdelete, {
                        "id": snapshot.data["data"][i]["notes_id"].toString(),
                        "imagename":
                            snapshot.data["data"][i]["notes_image"].toString()
                      });
                      if (response["status"] == "sucsses") {
                        Navigator.of(context).pop();
                      }
                      setState(() {});
                    },
                    child: Text("yes"))
              ],
            ));
  }
}
