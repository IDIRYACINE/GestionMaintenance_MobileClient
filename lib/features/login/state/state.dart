class AuthenticaionState {
  final bool isAuthenticated;

  final int workerId;

  final String workerName;

  final int workerDepartmentId;

  final bool errorOccured;

  AuthenticaionState( 
      {required this.isAuthenticated,
      required this.workerId,
      required this.workerName,
      this.errorOccured = false,
      required this.workerDepartmentId});

  AuthenticaionState copyWith(
      {bool? isAuthenticated,
      int? workerId,
      String? workerName,
      bool? errorOccured,
      int? workerDepartmentId}) {
    return AuthenticaionState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        workerId: workerId ?? this.workerId,
        workerName: workerName ?? this.workerName,
        errorOccured: errorOccured ?? this.errorOccured,
        workerDepartmentId: workerDepartmentId ?? this.workerDepartmentId);
  }

  static AuthenticaionState initialState() {
    return AuthenticaionState(
        isAuthenticated: false,
        workerId: -1,
        workerName: "",
        workerDepartmentId: -1);
  }
}
