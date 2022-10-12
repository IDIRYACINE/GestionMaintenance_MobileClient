
class AuthenticaionState{
  bool isAuthenticaed;
  String username;

  AuthenticaionState({
    required this.isAuthenticaed,
    required this.username,
  });

  factory AuthenticaionState.initialState() => AuthenticaionState(isAuthenticaed:false,username:"");

}