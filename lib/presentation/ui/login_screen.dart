import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/common/widgets/inputs/custom_text_field.dart';
import 'package:story_app/route/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailKey = GlobalKey<FormFieldState>();
  final _emailController = TextEditingController();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  key: _emailKey,
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'Email',
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!_isValidEmail(value)) {
                      return 'Email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  key: _passwordKey,
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'Password',
                  labelText: 'Password',
                  obscureText: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // const LinearProgressIndicator(),
                // const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: const Text('LOGIN'))),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun ? '),
                    GestureDetector(
                        onTap: () {
                          context.go('${AppRoutes.loginScreen}/${AppRoutes.registerScreen}');
                        },
                        child: const Text('Register',
                            style: TextStyle(color: Colors.brown))),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Simple email validation using a regular expression.
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }
}
