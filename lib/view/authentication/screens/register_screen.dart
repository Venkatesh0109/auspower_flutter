import 'package:flutter/material.dart';
import 'package:auspower_flutter/common/widgets/buttons.dart';
import 'package:auspower_flutter/common/widgets/text_fields.dart';
import 'package:auspower_flutter/constants/assets/local_images.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/repositories/auth_repository.dart';
import 'package:auspower_flutter/utilities/extensions/form_extension.dart';
import 'package:auspower_flutter/view/authentication/widgets/auth_scaffold.dart';
import 'package:auspower_flutter/view/authentication/widgets/divider_with_text.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController contName = TextEditingController();
  final TextEditingController contEmail = TextEditingController();
  final TextEditingController contMobile = TextEditingController();
  final TextEditingController contPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedCode = '+91';
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      automaticallyImplyLeading: true,
      title: 'Sign Up',
      description: 'Enter the below details to sign',
      form: renderForm,
    );
  }

  Widget get renderForm {
    return Form(
        key: _formKey,
        child: Consumer<AuthProvider>(
          builder: (context, auth, child) => Column(children: [
            TextFormFieldCustom(
                controller: contName, label: 'Name', hint: 'Enter you name'),
            const HeightFull(),
            TextFormFieldCustom(
              controller: contEmail,
              label: 'Email',
              hint: 'Enter you email',
              keyboardType: TextInputType.emailAddress,
            ),
            const HeightFull(),
            MobileTextField(
              contMobile: contMobile,
              selectedCode: selectedCode,
              onChanged: (e) => setState(() => selectedCode = e),
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
                      onPressed: onSignUp,
                      isLoading: auth.isLoading,
                      label: 'Sign Up')),
            ]),
            const HeightFull(multiplier: 2),
            const DividerWithText(title: 'Or'),
            const HeightFull(),
            ButtonOutlined(
                icon: Image.asset(LocalImages.google, height: 25),
                onPressed: onGoogleSignUp,
                label: 'Sign up with Google'),
          ]),
        ));
  }

  void onSignUp() {
    if (_formKey.hasError) return;
    AuthRepository().register(context, params: "");
  }

  void onGoogleSignUp() async {
    // fbauth.User? user = await AuthRepository().getGoogleCreds(context);
    // if (user == null) return;
    // authProvider.googleLoading = true;
    // RegistrationCreds params = RegistrationCreds(
    //     email: user.email ?? '',
    //     name: user.displayName,
    //     mobile: user.phoneNumber);
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) =>
    //         CreatePasswordScreen(params: params));
    // authProvider.googleLoading = false;
  }

  @override
  void dispose() {
    contEmail.dispose();
    contPassword.dispose();
    super.dispose();
  }
}
