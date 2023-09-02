import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:story_app/common/utils/network/network_failure.dart';
import 'package:story_app/data/model/register/register_request.dart';

import '../../../common/utils/constants/state_status.dart';
import '../../../data/api/api_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiService apiService;

  RegisterBloc({required this.apiService}) : super(const RegisterState()) {
    on<Register>(mapRegisterToState);
  }

  FutureOr<void> mapRegisterToState(Register event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(status: StateStatus.loading));
      final data = await apiService.register(event.request);
      emit(state.copyWith(status: StateStatus.loaded, message: data.message));
    } catch (e) {
      if (e is FetchDataFailure) {
        emit(state.copyWith(status: StateStatus.error, message: e.message));
      }
    }
  }
}
