import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';
import 'package:unsecret/screens/authentication/profile_image_picker.dart';

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
                          controller: userId,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Id can't be empty";
                            } else {
                              connect.getData(value).then((value2) => {
                                    if (value2 == true)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    "Id is already taken try another")))
                                      }
                                  });
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Create UserID",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email Can't Empty";
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
                              return "password Can't Empty";
                            } else if (value != password.text) {
                              return "passwords Not matches, Try to match the password";
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
                    connect.saveData(name.text, userId.text, email.text,
                        contact.text, password.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const PickImage(),
                      ),
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
}
