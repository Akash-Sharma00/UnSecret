import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unsecret/connect_to_fire.dart';
import 'package:unsecret/screens/authentication/new_account.dart';
import 'package:unsecret/screens/main_windows/home_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Icon ispass = const Icon(Icons.visibility_off);
  bool hidePass = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("UnSecret"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            CircleAvatar(
                radius: 60,
                child: Image.asset("asset/free_icon.png",
                    width: 200, height: 200)),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Login Now",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "Please enter the details below to continue",
              style: TextStyle(color: Colors.grey[500]),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              scrollPadding: const EdgeInsets.only(bottom: 40),
              controller: password,
              keyboardType: TextInputType.emailAddress,
              obscureText: hidePass,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                hintText: "Enter Password",
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePass = !hidePass;
                      });
                    },
                    icon: hidePass ? const Icon(Icons.visibility) : ispass),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    var w = MediaQuery.of(context).size.width * 0.9;
                    showModalBottomSheet(
                        isScrollControlled: true,
                        enableDrag: false,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        builder: (context) => buildSheet(w));
                  },
                  child: const Text("Forgot Paswword?",
                      style: TextStyle(color: Colors.green)),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    verifyDetails(email.text, password.text);
                    ConnectToFire().getUserData("id", email.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text("Login"),
                )),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateNewAccount()));
              },
              child: RichText(
                text: const TextSpan(
                  text: "Don't have an account!",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: ' Register',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }

  void verifyDetails(String email, String password) async {
    final auth = FirebaseAuth.instance;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "Please enter all details",
            style: TextStyle(color: Colors.red),
          )));
      return;
    }
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.red),
          )));
      return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>  HomePage(index: 2,)));
  }
}

Widget buildSheet(double w) {
  TextEditingController emailid = TextEditingController();
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Enter registered email to get reset password link",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 40,
        ),
        TextField(
            controller: emailid,
            keyboardType: TextInputType.emailAddress,
            scrollPadding: const EdgeInsets.only(bottom: 40),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail),
                hintText: "Enter Email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixText: '@gmail.com')),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
            width: w,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                final auth = FirebaseAuth.instance;
                try {
                  await auth.sendPasswordResetEmail(email: emailid.text);
                } catch (e) {
                  Fluttertoast.showToast(msg: e.toString());
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("Submit"),
            )),
      ],
    ),
  );
}
