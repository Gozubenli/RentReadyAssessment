class Account {
  int? id;
  String name;
  String stateCode;
  String stateOrProvince;

  Account({this.id, required this.name, required this.stateCode, required this.stateOrProvince});

  factory Account.fromJson(Map<String, dynamic> json) =>
      Account(id: json["id"], name: json["name"] ?? "", stateCode: json["stateCode"] ?? "", stateOrProvince: json["stateOrProvince"] ?? "");

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "name": name,
        "stateCode": stateCode,
        "stateOrProvince": stateOrProvince,
      };
}
