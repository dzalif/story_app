part of 'login_bloc.dart';

class LoginState extends Equatable {
  final StateStatus status;
  final String? data;
  final String? message;

  const LoginState({
    this.status = StateStatus.iddle,
    this.data,
    this.message
  });

  LoginState copyWith({
    StateStatus? status,
    String? data,
    String? message
  }) {
    return LoginState(
        status: status ?? this.status,
        data: data ?? this.data,
        message: message ?? this.message
    );
  }

  bool get isLoading => status == StateStatus.loading;

  @override
  List<Object?> get props => [
    status,
    data,
    message
  ];
}
