
class Departement {
  final int departmentId;
  final String departmentName;

  Departement({required this.departmentId, required this.departmentName});

  Departement.fromJson(Map<String, dynamic> json)
      : departmentId = json['departmentId'],
        departmentName = json['departmentName'];

  Map<String, dynamic> toJson() =>
      {'departmentId': departmentId, 'departmentName': departmentName};
}