import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:story_app/data/model/login/login_request.dart';

import '../../../common/utils/constants/state_status.dart';
import '../../../common/utils/network/network_failure.dart';
import '../../../data/api/api_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;

  LoginBloc({required this.apiService}) : super(const LoginState()) {
    on<Login>(mapLoginToState);
  }

  FutureOr<void> mapLoginToState(Login event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: StateStatus.loading));
      final data = await apiService.login(event.request);
      emit(state.copyWith(status: StateStatus.loaded, message: data.message));
    } catch (e) {
      if (e is FetchDataFailure) {
        emit(state.copyWith(status: StateStatus.error, message: e.message));
      }
    }
  }
}
