part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final StateStatus status;
  final String? data;
  final String? message;

  const RegisterState({
    this.status = StateStatus.iddle,
    this.data,
    this.message
  });

  RegisterState copyWith({
    StateStatus? status,
    String? data,
    String? message
  }) {
    return RegisterState(
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
