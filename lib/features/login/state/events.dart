

import 'package:gestion_maintenance_mobile/infrastructure/remoteServer/responses.dart';

class AuthEvents {}


class LoginEvent extends AuthEvents{
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}

class ReceiveLoginResponseEvent extends AuthEvents{
  final LoginResponse response;

  ReceiveLoginResponseEvent({required this.response});
}