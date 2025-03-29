import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/bottom_sheets.dart';
import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text_fields.dart';
import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/models/login_creds.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/repositories/auth_repository.dart';
import 'package:auspower_flutter/services/storage/storage_constants.dart';
import 'package:auspower_flutter/utilities/extensions/form_extension.dart';
import 'package:auspower_flutter/view/authentication/screens/saved_password_screen.dart';
import 'package:auspower_flutter/view/authentication/widgets/auth_scaffold.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController contUsername = TextEditingController();
  final TextEditingController contPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isRememberMe = false;

  // Function to get the version of the app

  void init() async {
    String value = await storage.read(key: StorageConstants.loginCreds) ?? '';
    storage.write(key: StorageConstants.onboarding, value: "true");
    if (value.isEmpty) return;
    Map<String, dynamic>? data = jsonDecode(value);
    if (data == null) return;
    commonBottomSheet(
        context, SavedPasswordScreen(creds: LoginCreds.fromJson(data)));
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Login in to your\nAccount',
      description: 'Enter your Username and password to log in',
      form: renderForm,
    );
  }

  Widget get renderForm {
    return Form(
        key: _formKey,
        child: Consumer<AuthProvider>(
          builder: (context, auth, child) => Column(children: [
            TextFormFieldCustom(
              controller: contUsername,
              label: 'Username',
              hint: 'Enter you username',
              keyboardType: TextInputType.name,
            ),
            const HeightFull(),
            TextFormFieldCustom(
                controller: contPassword,
                obscured: true,
                label: 'Password',
                hint: 'Enter you Password'),
            const HeightFull(multiplier: 2),
            Row(children: [
              Expanded(
                  child: ButtonPrimary(
                      onPressed: () => onLogin(),
                      label: 'Log In',
                      isLoading: auth.isLoading))
            ]),
            const HeightHalf(),
            Row(children: [
              CustomCheckBox(
                  value: isRememberMe,
                  title: 'Remember me',
                  onChanged: toggleCheckBox),
              const Spacer(),
            ]),
          ]),
        ));
  }

  void toggleCheckBox() {
    isRememberMe = !isRememberMe;
    setState(() {});
  }

  void onLogin() async {
    if (_formKey.hasError) return;
    LoginCreds params =
        LoginCreds(email: contUsername.text, password: contPassword.text);
    Map<String, dynamic> data = {
      "username": contUsername.text,
      "password": contPassword.text,
      // "user_id": ""
    };
    bool isLoggedIn = await AuthRepository().login(context, data);
    if (!isLoggedIn || !isRememberMe) return;
    storage.write(key: StorageConstants.loginCreds, value: jsonEncode(params));
  }

  @override
  void dispose() {
    contUsername.dispose();
    contPassword.dispose();
    super.dispose();
  }
}
