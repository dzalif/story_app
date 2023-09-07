import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/common/utils/constants/prefs_key.dart';
import 'package:story_app/data/model/login/login_request.dart';
import 'package:story_app/data/model/login/login_response.dart';

import '../../../common/utils/constants/state_status.dart';
import '../../../common/utils/network/network_failure.dart';
import '../../../data/api/api_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;

  LoginBloc({required this.apiService}) : super(const LoginState()) {
    on<Login>(mapLoginToState);
    on<GetName>(mapNameToState);
  }

  FutureOr<void> mapLoginToState(Login event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: StateStatus.loading));
      final data = await apiService.login(event.request);
      _saveLoginData(data);
      emit(state.copyWith(status: StateStatus.loaded, message: data.message));
    } catch (e) {
      if (e is FetchDataFailure) {
        emit(state.copyWith(status: StateStatus.error, message: e.message));
      }
    }
  }

  void _saveLoginData(LoginResponse data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefsKey.token, data.loginResult.token!);
    await prefs.setString(PrefsKey.name, data.loginResult.name!);
  }

  FutureOr<void> mapNameToState(GetName event, Emitter<LoginState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(PrefsKey.name);
    emit(state.copyWith(status: StateStatus.loaded, name: name));
  }
}
