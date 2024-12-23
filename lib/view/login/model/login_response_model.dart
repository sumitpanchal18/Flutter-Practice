class LoginDataResponse {
  LoginDataResponse({
    num? status,
    String? message,
    Result? result,
  }) {
    _status = status;
    _message = message;
    _result = result;
  }

  LoginDataResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  num? _status;
  String? _message;
  Result? _result;

  num? get status => _status;
  String? get message => _message;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    String? headerToken,
    String? authorization,
    UserData? userData,
    List<String>? permissions,
    List<Properties>? properties,
    bool? autoLogin,
  }) {
    _headerToken = headerToken;
    _authorization = authorization;
    _userData = userData;
    _permissions = permissions;
    _properties = properties;
    _autoLogin = autoLogin;
  }

  Result.fromJson(dynamic json) {
    _headerToken = json['headerToken'];
    _authorization = json['Authorization'];
    _userData =
    json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
    _permissions =
    json['permissions'] != null ? json['permissions'].cast<String>() : [];
    if (json['properties'] != null) {
      _properties = [];
      json['properties'].forEach((v) {
        _properties?.add(Properties.fromJson(v));
      });
    }
    _autoLogin = json['autoLogin'];
  }

  String? _headerToken;
  String? _authorization;
  UserData? _userData;
  List<String>? _permissions;
  List<Properties>? _properties;
  bool? _autoLogin;

  String? get headerToken => _headerToken;
  String? get authorization => _authorization;
  UserData? get userData => _userData;
  List<String>? get permissions => _permissions;
  List<Properties>? get properties => _properties;
  bool? get autoLogin => _autoLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['headerToken'] = _headerToken;
    map['Authorization'] = _authorization;
    if (_userData != null) {
      map['user_data'] = _userData?.toJson();
    }
    map['permissions'] = _permissions;
    if (_properties != null) {
      map['properties'] = _properties?.map((v) => v.toJson()).toList();
    }
    map['autoLogin'] = _autoLogin;
    return map;
  }
}

class UserData {
  UserData({
    String? slug,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    dynamic profileThumb,
    num? statusId,
    dynamic street1,
    dynamic street2,
    dynamic countryId,
    dynamic city,
    dynamic stateId,
    dynamic postalCode,
    num? roleId,
    num? userId,
    String? profileThumbUrl,
    String? statusIdDisp,
    String? fullAddress,
    String? roleTypeName,
    String? fullName,
  }) {
    _slug = slug;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _profileThumb = profileThumb;
    _statusId = statusId;
    _street1 = street1;
    _street2 = street2;
    _countryId = countryId;
    _city = city;
    _stateId = stateId;
    _postalCode = postalCode;
    _roleId = roleId;
    _userId = userId;
    _profileThumbUrl = profileThumbUrl;
    _statusIdDisp = statusIdDisp;
    _fullAddress = fullAddress;
    _roleTypeName = roleTypeName;
    _fullName = fullName;
  }

  UserData.fromJson(dynamic json) {
    _slug = json['slug'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _phone = json['phone'];
    _profileThumb = json['profile_thumb'];
    _statusId = json['status_id'];
    _street1 = json['street_1'];
    _street2 = json['street_2'];
    _countryId = json['country_id'];
    _city = json['city'];
    _stateId = json['state_id'];
    _postalCode = json['postal_code'];
    _roleId = json['role_id'];
    _userId = json['user_id'];
    _profileThumbUrl = json['profile_thumb_url'];
    _statusIdDisp = json['status_id_disp'];
    _fullAddress = json['full_address'];
    _roleTypeName = json['role_type_name'];
    _fullName = json['full_name'];
  }

  String? _slug;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  dynamic _profileThumb;
  num? _statusId;
  dynamic _street1;
  dynamic _street2;
  dynamic _countryId;
  dynamic _city;
  dynamic _stateId;
  dynamic _postalCode;
  num? _roleId;
  num? _userId;
  String? _profileThumbUrl;
  String? _statusIdDisp;
  String? _fullAddress;
  String? _roleTypeName;
  String? _fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = _slug;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['profile_thumb'] = _profileThumb;
    map['status_id'] = _statusId;
    map['street_1'] = _street1;
    map['street_2'] = _street2;
    map['country_id'] = _countryId;
    map['city'] = _city;
    map['state_id'] = _stateId;
    map['postal_code'] = _postalCode;
    map['role_id'] = _roleId;
    map['user_id'] = _userId;
    map['profile_thumb_url'] = _profileThumbUrl;
    map['status_id_disp'] = _statusIdDisp;
    map['full_address'] = _fullAddress;
    map['role_type_name'] = _roleTypeName;
    map['full_name'] = _fullName;
    return map;
  }
}

class Properties {
  Properties({
    String? propertyName,
    String? slug,
    num? propertyId,
    num? customerId,
  }) {
    _propertyName = propertyName;
    _slug = slug;
    _propertyId = propertyId;
    _customerId = customerId;
  }

  Properties.fromJson(dynamic json) {
    _propertyName = json['property_name'];
    _slug = json['slug'];
    _propertyId = json['property_id'];
    _customerId = json['customer_id'];
  }

  String? _propertyName;
  String? _slug;
  num? _propertyId;
  num? _customerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_name'] = _propertyName;
    map['slug'] = _slug;
    map['property_id'] = _propertyId;
    map['customer_id'] = _customerId;
    return map;
  }
}
