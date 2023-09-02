part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class Register extends RegisterEvent {
  final RegisterRequest request;

  const Register({required this.request});

  @override
  List<Object?> get props => [request];
}
