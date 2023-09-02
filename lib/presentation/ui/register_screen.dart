import 'package:flutter/material.dart';
import 'package:story_app/common/widgets/inputs/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameKey = GlobalKey<FormFieldState>();
  final _nameController = TextEditingController();
  final _emailKey = GlobalKey<FormFieldState>();
  final _emailController = TextEditingController();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16), child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('REGISTER', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16),
            CustomTextField(
              key: _nameKey,
              controller: _nameController,
              hintText: 'Nama',
              labelText: 'Nama',
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              key: _emailKey,
              controller: _emailController,
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
                child: ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {

                  }
                }, child: const Text('REGISTER'))),
            const SizedBox(height: 8),
          ],
        ),
      ),),
    );
  }

  bool _isValidEmail(String email) {
    // Simple email validation using a regular expression.
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }
}
