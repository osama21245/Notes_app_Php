import 'package:flutter/material.dart';
import 'package:notes_php_app/components/crud.dart';
import 'package:notes_php_app/const/linkapi.dart';
import 'package:notes_php_app/main.dart';
import 'package:notes_php_app/widget/Textformwidget.dart';
import '../widget/Textformwidget.dart';
import '../widget/Valid.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    Crud _crud = Crud();

    bool isloading = false;

    GlobalKey<FormState> formstate = GlobalKey();

    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    login() async {
      if (formstate.currentState!.validate()) {
        isloading = true;
        setState(() {});
        var resonse = await _crud.postRequest(
            linklogin, {"email": email.text, "password": password.text});
        isloading = false;
        setState(() {});

        if (resonse["status"] == "sucsses") {
          pref.setString("id", resonse["data"]["id"].toString());
          pref.setString("email", resonse["data"]["email"]);
          pref.setString("password", resonse["data"]["password"]);
          Navigator.of(context)
              .pushNamedAndRemoveUntil("Home", ((route) => false));
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'The account is not exists email',
            desc: 'Check Your email or password ',
            btnOkOnPress: () {},
          )..show();
        }
        isloading = false;
      }
    }

    return Scaffold(
        body: isloading == true
            ? Center(
                child: Text("Loading..."),
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
                                await login();
                              },
                              child: Text("login"),
                              color: Color.fromARGB(255, 56, 56, 56),
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 70),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('signup');
                              },
                              child: Container(
                                child: Text("Sign Up"),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ));
  }
}
