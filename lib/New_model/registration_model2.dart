/// response_code : "1"
/// message : "user register success"
/// status : "success"
/// user : true
/// otp : null

class RegistrationModel {
  RegistrationModel({
      String? responseCode, 
      String? message, 
      String? status, 
      bool? user, 
      dynamic otp,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _user = user;
    _otp = otp;
}

  RegistrationModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _user = json['user'];
    _otp = json['otp'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  bool? _user;
  dynamic _otp;
RegistrationModel copyWith({  String? responseCode,
  String? message,
  String? status,
  bool? user,
  dynamic otp,
}) => RegistrationModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  user: user ?? _user,
  otp: otp ?? _otp,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  bool? get user => _user;
  dynamic get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    map['user'] = _user;
    map['otp'] = _otp;
    return map;
  }

}