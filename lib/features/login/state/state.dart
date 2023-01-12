class AuthenticaionState {
  final bool isAuthenticated;

  final int workerId;

  final String workerName;

  final int groupId;

  final List<int> workerDepartmentIds;

  final bool errorOccured;

  AuthenticaionState(
      {required this.isAuthenticated,
      required this.workerId,
      required this.workerName,
      required this.groupId,
      this.errorOccured = false,
      required this.workerDepartmentIds});

  AuthenticaionState copyWith(
      {bool? isAuthenticated,
      int? workerId,
      int? groupId,
      String? workerName,
      bool? errorOccured,
      List<int>? workerDepartmentIds}) {
    return AuthenticaionState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        workerId: workerId ?? this.workerId,
        workerName: workerName ?? this.workerName,
        errorOccured: errorOccured ?? this.errorOccured,
        groupId: groupId ?? this.groupId,
        workerDepartmentIds: workerDepartmentIds ?? this.workerDepartmentIds);
  }

  static AuthenticaionState initialState() {
    return AuthenticaionState(
        isAuthenticated: false,
        workerId: -1,
        workerName: "",
        workerDepartmentIds: [],
        groupId: -1);
  }
}
