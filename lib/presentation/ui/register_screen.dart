import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/common/utils/constants/state_status.dart';
import 'package:story_app/common/widgets/inputs/custom_text_field.dart';
import 'package:story_app/common/widgets/snackbar/custom_snackbar.dart';
import 'package:story_app/data/model/register/register_request.dart';
import 'package:story_app/presentation/bloc/register/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status == StateStatus.error) {
          CustomSnackBar.showError(context, state.message);
        }
        if (state.status == StateStatus.loaded) {
          CustomSnackBar.showSuccess(context, 'Berhasil register');
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
                  maxLength: 8,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
                  if (state.isLoading) {
                    return const LoadingIndicator();
                  }
                  return const SizedBox();
                }),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var request = RegisterRequest(name: _nameController.text, email: _emailController.text, password: _passwordController.text);
                        BlocProvider.of<RegisterBloc>(context).add(Register(request: request));
                      }
                    }, child: const Text('REGISTER'))),
                const SizedBox(height: 8),
              ],
            ),
          ),),
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

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        LinearProgressIndicator(),
        SizedBox(height: 16),
      ],
    );
  }
}

