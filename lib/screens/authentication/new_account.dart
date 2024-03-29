import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';

import 'profile_image_picker.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  static final TextEditingController userId = TextEditingController();
  static final TextEditingController name = TextEditingController();
  static final TextEditingController email = TextEditingController();
  static final TextEditingController contact = TextEditingController();
  static final TextEditingController password = TextEditingController();
  static final TextEditingController cPass = TextEditingController();
  static final ConnectToFire connect = ConnectToFire();
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Stack(children: [
                Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    height: 100,
                    color: Colors.green,
                    child: const Text(
                      "Welcome To Un-Secret",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    )),
                const Positioned(
                    top: 40,
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
                  top: 65,
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
                            prefixIcon: const Icon(Icons.text_format),
                            hintText: "Enter Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: userId,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Id can't be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.bookmark_outlined),
                              hintText: "Create UserID",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email Can't Empty";
                          } else if (!value.endsWith("@gmail.com")) {
                            return "Invalide Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            hintText: "Enter Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            suffixText: '@gmail.com'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: contact,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Contact Can't Empty";
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
                              return "Password Can't Empty";
                            } else if (value.length < 6) {
                              return "Password must have length of 6";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "  Create Password",
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
                              return "password Can't Empty";
                            } else if (value != password.text) {
                              return "passwords Not matches, Try to match the password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "  Confirm Password",
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate() &&
                      await connect.getUserEmail(email.text) == true &&
                      await connect.getUserId(userId.text) == true) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => PickImage(
                              name: name.text,
                              email: email.text,
                              contact: contact.text,
                              id: userId.text,
                              password: password.text,
                            )));
                  }
                },
                // },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("Create Account"),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }


}
