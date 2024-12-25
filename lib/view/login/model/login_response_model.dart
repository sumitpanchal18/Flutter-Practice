class LoginDataResponse {
  LoginDataResponse({
    this.status,
    this.message,
    this.result,
  });

  LoginDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  num? status;
  String? message;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.headerToken,
    this.authorization,
    this.userData,
    required this.permissions,
    required this.properties,
    this.autoLogin,
  });

  Result.fromJson(Map<String, dynamic> json) {
    headerToken = json['headerToken'];
    authorization = json['Authorization'];
    userData = json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
    permissions = json['permissions']?.cast<String>() ?? [];
    properties = json['properties'] != null
        ? (json['properties'] as List).map((v) => Properties.fromJson(v)).toList()
        : [];
    autoLogin = json['autoLogin'];
  }

  String? headerToken;
  String? authorization;
  UserData? userData;
  List<String> permissions = [];
  List<Properties> properties = [];
  bool? autoLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['headerToken'] = headerToken;
    map['Authorization'] = authorization;
    if (userData != null) {
      map['user_data'] = userData?.toJson();
    }
    map['permissions'] = permissions;
    if (properties.isNotEmpty) {
      map['properties'] = properties.map((v) => v.toJson()).toList();
    }
    map['autoLogin'] = autoLogin;
    return map;
  }
}

class UserData {
  UserData({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.statusId,
    this.city,
    this.roleTypeName,
    this.fullName,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    statusId = json['status_id'];
    city = json['city'];
    roleTypeName = json['role_type_name'];
    fullName = json['full_name'];
  }

  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  num? statusId;
  String? city;
  String? roleTypeName;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['status_id'] = statusId;
    map['city'] = city;
    map['role_type_name'] = roleTypeName;
    map['full_name'] = fullName;
    return map;
  }
}

class Properties {
  Properties({
    this.propertyName,
    this.propertyId,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    propertyName = json['property_name'];
    propertyId = json['property_id'];
  }

  String? propertyName;
  num? propertyId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_name'] = propertyName;
    map['property_id'] = propertyId;
    return map;
  }
}
