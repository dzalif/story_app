part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class Login extends LoginEvent {
  final LoginRequest request;

  const Login({required this.request});

  @override
  List<Object?> get props => [request];

}
