import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController userId = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController contact = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController cPass = TextEditingController();
    ConnectToFire connect = ConnectToFire();
    final formKey = GlobalKey<FormState>();
    bool useID = false;

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: Stack(children: [
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 150,
                    color: Colors.green,
                    child: const Text(
                      "Welcome To Un-Secret",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    )),
                const Positioned(
                    top: 90,
                    left: 165,
                    child: Text(
                      "~World With No Secrets",
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                    )),
                Positioned(
                  left: 10,
                  top: 125,
                  child: CircleAvatar(
                    radius: 30,
                    child: Image.asset("asset/free_icon.png"),
                  ),
                )
              ]),
            ),
            const Text(
              "Log In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name Can't Empty";
                          } else if (value.contains(RegExp(r'[0-9]'))) {
                            return "Numbers are not allowed";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          onChanged: (userID) async {
                            useID = await connect.getData(userID);
                          },
                          controller: userId,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name Can't Empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Create UserID",
                              suffixIcon: useID
                                  ? const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.add_task,
                                      color: Colors.green,
                                    ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name Can't Empty";
                          } else if (!value.endsWith("@gmail.com")) {
                            return "Invalide Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            suffixText: '@gmail.com'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: contact,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name Can't Empty";
                          } else if (value.length != 10) {
                            return "Contact Must have 10 digits";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Contact",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixText: '+91'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: password,
                          obscureText: true,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name Can't Empty";
                            } else if (value.length != 8) {
                              return "Password must have length of 8";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Create Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              suffixIcon: const Icon(Icons.security))),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: cPass,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name Can't Empty";
                            } else if (value != password.text) {
                              return "password Not matches, Try to match the password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              suffixIcon: const Icon(Icons.security))),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    connect.saveData(
                        name.text, userId.text, email.text, contact.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text("Create Account")),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }

  validator(String text) {
    if (text.contains('a')) {
      return "Field Can't be Empty";
    } else {
      return null;
    }
  }
}

// class TextFormField extends StatelessWidget {
//   const TextFormField({
//     Key? key,
//     this.ic,
//     this.pric,
//     this.sfic,
//     this.tx,
//     this.prtx,
//     this.passwordText,
//   }) : super(key: key);
//   final Icon? ic, pric, sfic;
//   final String? tx, prtx;
//   final bool? passwordText;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(.0),
//       child: TextField(
//           obscureText: passwordText!,
//           decoration: InputDecoration(
//               hintText: tx,
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               prefixIcon: sfic,
//               suffixText: prtx)),
//     );
  // }
// }
