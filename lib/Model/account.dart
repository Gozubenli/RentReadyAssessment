class Account {
  String accountid;
  String accountnumber;
  String name;
  int stateCode;
  String stateOrProvince;

  Account({required this.accountid, required this.accountnumber, required this.name, required this.stateCode, required this.stateOrProvince});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      accountid: json["accountid"] ?? "",
      accountnumber: json["accountnumber"] ?? "",
      name: json["name"] ?? "",
      stateCode: json["stateCode"] ?? 0,
      stateOrProvince: json["stateOrProvince"] ?? "");

  Map<String, dynamic> toJson() => {
        "accountid": accountid,
        "accountnumber": accountnumber,
        "name": name,
        "stateCode": stateCode,
        "stateOrProvince": stateOrProvince,
      };
}
