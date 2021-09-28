import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//store signed email to make type-ahead
List<String> hintEmail = [];

//store email and token to get password
FlutterSecureStorage rememberedAccount = new FlutterSecureStorage();