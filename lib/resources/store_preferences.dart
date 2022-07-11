// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// import 'userHelper.dart';

// class StorePreferences {
//   static late SharedPreferences _preferences;

//   static const _keyUser = 'user';
//   static const myUser = UserHelper(imagePath: null, name: name, email: email, about: about, isDarkMode: isDarkMode)

//   static Future init() async =>
//       _preferences = await SharedPreferences.getInstance();

//   static Future setUser(UserHelper user) async {
//     final json = jsonEncode(user.toJson());

//     await _preferences.setString(_keyUser, json);
//   }

//   static UserHelper getUser() {
//     final json = _preferences.getString(_keyUser);

//     return json == null ? myUser : UserHelper.fromJson(jsonDecode(json));
//   }
// }
