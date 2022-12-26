import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/core/navigation/navigator.dart';
import 'package:gestion_maintenance_mobile/features/login/presentation/login_state_dialog.dart';
import 'package:gestion_maintenance_mobile/features/login/state/auth_block.dart';
import 'package:gestion_maintenance_mobile/infrastructure/services.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/remote_server_requests.dart';
import 'package:gestion_maintenance_mobile/infrastructure/workRequests/types.dart';

class AuthBloc extends Bloc<AuthEvents, AuthenticaionState> {
  AuthBloc({AuthenticaionState? initialState})
      : super(initialState ?? AuthenticaionState.initialState()) {
    on<LoginEvent>(_onLoginEvent);
    on<ReceiveLoginResponseEvent>(_onReceiveLoginResponseEvent);
  }

  FutureOr<void> _onLoginEvent(
      LoginEvent event, Emitter<AuthenticaionState> emit) {
    AppNavigator.displayDialog(const LoginStatusDialog());

    WorkRequest loginRequest = RemoteServerRequestBuilder.validateLogin(
        username: event.username,
        password: event.password,
        onResponse: (loginResponse) {
          ReceiveLoginResponseEvent event =
              ReceiveLoginResponseEvent(response: loginResponse);
          add(event);
        });
    ServicesCenter.instance().emitWorkRequest(loginRequest);
  }

  FutureOr<void> _onReceiveLoginResponseEvent(
      ReceiveLoginResponseEvent event, Emitter<AuthenticaionState> emit) {
    if (event.response.authenticated) {
      emit(state.copyWith(
        isAuthenticated: event.response.authenticated,
        workerId: event.response.workerId,
        workerDepartmentId: event.response.departement,
        workerName: event.response.workerName,
        errorOccured: event.response.errorOccured,
      ));
    }
  }
}
