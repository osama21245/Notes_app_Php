import 'package:flutter/material.dart';
import 'package:notes_php_app/components/crud.dart';
import 'package:notes_php_app/widget/Textformwidget.dart';
import 'package:notes_php_app/widget/Valid.dart';
import '../widget/Textformwidget.dart';
import '../const/linkapi.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  @override
  Widget build(BuildContext context) {
    Crud _crud = Crud();

    bool isloading = false;

    GlobalKey<FormState> formstate = GlobalKey();

    TextEditingController email = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

    signup() async {
      if (formstate.currentState!.validate()) {
        isloading = true;
        setState(() {});
        var resonse = await _crud.postRequest(linksignup, {
          "username": username.text,
          "email": email.text,
          "password": password.text
        });
        isloading = false;
        setState(() {});
        if (resonse["status"] == "sucsses") {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("Succes", ((route) => false));
        } else {
          print("signup_field");
        }
        isloading = false;
      }
    }

    return Scaffold(
        body: isloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Form(
                        key: formstate,
                        child: Column(
                          children: [
                            Image.asset(
                              "lib/images/download (1).png",
                              width: 250,
                              height: 250,
                            ),
                            Textformwidet(
                              valid: (val1) {
                                return validunput(val1!, 3, 70);
                              },
                              mycontroller: username,
                              hinttext: "username",
                            ),
                            Textformwidet(
                              valid: (val1) {
                                return validunput(val1!, 6, 70);
                              },
                              mycontroller: email,
                              hinttext: "email",
                            ),
                            Textformwidet(
                              valid: (val1) {
                                return validunput(val1!, 5, 70);
                              },
                              mycontroller: password,
                              hinttext: "password",
                            ),
                            MaterialButton(
                              onPressed: () async {
                                await signup();
                              },
                              child: Text("signup"),
                              color: Color.fromARGB(255, 56, 56, 56),
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 70),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('./');
                              },
                              child: Container(
                                child: Text("login"),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ));
  }
}
