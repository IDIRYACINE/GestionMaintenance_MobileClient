
import 'package:rxdart/subjects.dart';
import 'types.dart';

class AuthenticaionState implements AuthBlock {
  late BehaviorSubject<bool> _isAuthenticaed;
  late BehaviorSubject<String> _username;

  AuthenticaionState({
    required bool isAuthenticaed,
    required String username,
  }){
    _isAuthenticaed = BehaviorSubject<bool>.seeded(isAuthenticaed);
    _username = BehaviorSubject<String>.seeded(username);
  }

  factory AuthenticaionState.initialState() => AuthenticaionState(isAuthenticaed:false,username:"");

  @override
  void dispose(){
    _isAuthenticaed.close();
    _username.close();
  }

  @override
  Stream<bool> get isAuthenticaed => _isAuthenticaed.stream;

  @override
  Stream<String> get username => _username.stream;

  

}