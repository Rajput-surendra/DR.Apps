/// response_code : "1"
/// message : "User Found"
/// user : {"username":"Doctor1","degree":"BAMS","address":"sfgsgwg","c_address":" ","email":"doctorTwo@gmail.com","mobile":"9787987978","registration_card":"https://developmentalphawizz.com/dr_booking/uploads/user_image/no-image.png","profile_pic":"https://developmentalphawizz.com/dr_booking/uploads/user_image/image_cropper_1685103846440.jpg","user_data":[{"id":"370","ip_address":null,"category_id":null,"company_name":null,"company_division":"1","designation_id":null,"title":"Prof.Dr.","gender":"Male","username":"Doctor1","password":"$2y$10$vhy1Pj0OsfEXzb6MJO0ELelOzKkTSc/wG/dpU1ZW5FHQmFOPydWKW","email":"doctorTwo@gmail.com","mobile":"9787987978","image":"https://developmentalphawizz.com/dr_booking/assets/no-image.png","balance":"0","activation_selector":null,"activation_code":null,"forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"0","last_login":"1685105125","active":"1","company":null,"address":"sfgsgwg","c_address":" ","doc_digree":"BAMS","bonus_type":"percentage_per_order","bonus":null,"cash_received":"0.00","dob":null,"country_code":null,"otp":"8401","roll":"1","city":"indore madhya pradesh india","area":null,"street":null,"pincode":null,"serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":"djzbh_L8QLGxSocwi1wyoe:APA91bHvsB8S4jtlRMCar5opjAUespWDLsCZ-P26_aWC9FrajRn8FZdgByiZRPsGzXKOIOaRRrazwqv2KRmIdgCIwDR9Q_VypAvsWCVw0GDAd53IedoJUuyJIHuDEjgZ-8QzdmAdhbFQ","device_token":null,"latitude":null,"longitude":null,"created_at":"2023-05-22 13:36:03","state_id":"11","city_id":"283","area_id":"5","experience":"4 Year","place_name":"new place","city_name":"Indore","state_name":"MADHYA PRADESH","clinics":[{"id":"21","user_id":"370","day":"TUE,WED,THU","clinic_name":"Hospital name Arvind","morning_shift":"1:33 PM - 2:33 PM","evening_shift":"3:33 PM - 4:33 PM","addresses":"Hospital near bypass road station indore","appoint_number":"8767687548","created_at":"2023-05-22 13:36:03","updated_at":"2023-05-22 13:36:03"},{"id":"22","user_id":"370","day":"MON,TUE","clinic_name":"Apna Clinic ","morning_shift":"8:34 PM - 6:35 PM","evening_shift":"11:35 PM - 10:34 PM","addresses":"Clicic New bay Vijay nagar indore ","appoint_number":"3646454849","created_at":"2023-05-22 13:36:03","updated_at":"2023-05-22 13:36:03"}]}]}

class GetUserProfileModel {
  GetUserProfileModel({
      String? responseCode, 
      String? message, 
      User? user,}){
    _responseCode = responseCode;
    _message = message;
    _user = user;
}

  GetUserProfileModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _responseCode;
  String? _message;
  User? _user;
GetUserProfileModel copyWith({  String? responseCode,
  String? message,
  User? user,
}) => GetUserProfileModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  user: user ?? _user,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// username : "Doctor1"
/// degree : "BAMS"
/// address : "sfgsgwg"
/// c_address : " "
/// email : "doctorTwo@gmail.com"
/// mobile : "9787987978"
/// registration_card : "https://developmentalphawizz.com/dr_booking/uploads/user_image/no-image.png"
/// profile_pic : "https://developmentalphawizz.com/dr_booking/uploads/user_image/image_cropper_1685103846440.jpg"
/// user_data : [{"id":"370","ip_address":null,"category_id":null,"company_name":null,"company_division":"1","designation_id":null,"title":"Prof.Dr.","gender":"Male","username":"Doctor1","password":"$2y$10$vhy1Pj0OsfEXzb6MJO0ELelOzKkTSc/wG/dpU1ZW5FHQmFOPydWKW","email":"doctorTwo@gmail.com","mobile":"9787987978","image":"https://developmentalphawizz.com/dr_booking/assets/no-image.png","balance":"0","activation_selector":null,"activation_code":null,"forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"0","last_login":"1685105125","active":"1","company":null,"address":"sfgsgwg","c_address":" ","doc_digree":"BAMS","bonus_type":"percentage_per_order","bonus":null,"cash_received":"0.00","dob":null,"country_code":null,"otp":"8401","roll":"1","city":"indore madhya pradesh india","area":null,"street":null,"pincode":null,"serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":"djzbh_L8QLGxSocwi1wyoe:APA91bHvsB8S4jtlRMCar5opjAUespWDLsCZ-P26_aWC9FrajRn8FZdgByiZRPsGzXKOIOaRRrazwqv2KRmIdgCIwDR9Q_VypAvsWCVw0GDAd53IedoJUuyJIHuDEjgZ-8QzdmAdhbFQ","device_token":null,"latitude":null,"longitude":null,"created_at":"2023-05-22 13:36:03","state_id":"11","city_id":"283","area_id":"5","experience":"4 Year","place_name":"new place","city_name":"Indore","state_name":"MADHYA PRADESH","clinics":[{"id":"21","user_id":"370","day":"TUE,WED,THU","clinic_name":"Hospital name Arvind","morning_shift":"1:33 PM - 2:33 PM","evening_shift":"3:33 PM - 4:33 PM","addresses":"Hospital near bypass road station indore","appoint_number":"8767687548","created_at":"2023-05-22 13:36:03","updated_at":"2023-05-22 13:36:03"},{"id":"22","user_id":"370","day":"MON,TUE","clinic_name":"Apna Clinic ","morning_shift":"8:34 PM - 6:35 PM","evening_shift":"11:35 PM - 10:34 PM","addresses":"Clicic New bay Vijay nagar indore ","appoint_number":"3646454849","created_at":"2023-05-22 13:36:03","updated_at":"2023-05-22 13:36:03"}]}]

class User {
  User({
      String? username, 
      String? degree, 
      String? address, 
      String? cAddress, 
      String? email, 
      String? mobile, 
      String? registrationCard, 
      String? profilePic, 
      List<UserData>? userData,}){
    _username = username;
    _degree = degree;
    _address = address;
    _cAddress = cAddress;
    _email = email;
    _mobile = mobile;
    _registrationCard = registrationCard;
    _profilePic = profilePic;
    _userData = userData;
}

  User.fromJson(dynamic json) {
    _username = json['username'];
    _degree = json['degree'];
    _address = json['address'];
    _cAddress = json['c_address'];
    _email = json['email'];
    _mobile = json['mobile'];
    _registrationCard = json['registration_card'];
    _profilePic = json['profile_pic'];
    if (json['user_data'] != null) {
      _userData = [];
      json['user_data'].forEach((v) {
        _userData?.add(UserData.fromJson(v));
      });
    }
  }
  String? _username;
  String? _degree;
  String? _address;
  String? _cAddress;
  String? _email;
  String? _mobile;
  String? _registrationCard;
  String? _profilePic;
  List<UserData>? _userData;
User copyWith({  String? username,
  String? degree,
  String? address,
  String? cAddress,
  String? email,
  String? mobile,
  String? registrationCard,
  String? profilePic,
  List<UserData>? userData,
}) => User(  username: username ?? _username,
  degree: degree ?? _degree,
  address: address ?? _address,
  cAddress: cAddress ?? _cAddress,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  registrationCard: registrationCard ?? _registrationCard,
  profilePic: profilePic ?? _profilePic,
  userData: userData ?? _userData,
);
  String? get username => _username;
  String? get degree => _degree;
  String? get address => _address;
  String? get cAddress => _cAddress;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get registrationCard => _registrationCard;
  String? get profilePic => _profilePic;
  List<UserData>? get userData => _userData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['degree'] = _degree;
    map['address'] = _address;
    map['c_address'] = _cAddress;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['registration_card'] = _registrationCard;
    map['profile_pic'] = _profilePic;
    if (_userData != null) {
      map['user_data'] = _userData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "370"
/// ip_address : null
/// category_id : null
/// company_name : null
/// company_division : "1"
/// designation_id : null
/// title : "Prof.Dr."
/// gender : "Male"
/// username : "Doctor1"
/// password : "$2y$10$vhy1Pj0OsfEXzb6MJO0ELelOzKkTSc/wG/dpU1ZW5FHQmFOPydWKW"
/// email : "doctorTwo@gmail.com"
/// mobile : "9787987978"
/// image : "https://developmentalphawizz.com/dr_booking/assets/no-image.png"
/// balance : "0"
/// activation_selector : null
/// activation_code : null
/// forgotten_password_selector : null
/// forgotten_password_code : null
/// forgotten_password_time : null
/// remember_selector : null
/// remember_code : null
/// created_on : "0"
/// last_login : "1685105125"
/// active : "1"
/// company : null
/// address : "sfgsgwg"
/// c_address : " "
/// doc_digree : "BAMS"
/// bonus_type : "percentage_per_order"
/// bonus : null
/// cash_received : "0.00"
/// dob : null
/// country_code : null
/// otp : "8401"
/// roll : "1"
/// city : "indore madhya pradesh india"
/// area : null
/// street : null
/// pincode : null
/// serviceable_zipcodes : null
/// apikey : null
/// referral_code : null
/// friends_code : null
/// fcm_id : "djzbh_L8QLGxSocwi1wyoe:APA91bHvsB8S4jtlRMCar5opjAUespWDLsCZ-P26_aWC9FrajRn8FZdgByiZRPsGzXKOIOaRRrazwqv2KRmIdgCIwDR9Q_VypAvsWCVw0GDAd53IedoJUuyJIHuDEjgZ-8QzdmAdhbFQ"
/// device_token : null
/// latitude : null
/// longitude : null
/// created_at : "2023-05-22 13:36:03"
/// state_id : "11"
/// city_id : "283"
/// area_id : "5"
/// experience : "4 Year"
/// place_name : "new place"
/// city_name : "Indore"
/// state_name : "MADHYA PRADESH"
/// clinics : [{"id":"21","user_id":"370","day":"TUE,WED,THU","clinic_name":"Hospital name Arvind","morning_shift":"1:33 PM - 2:33 PM","evening_shift":"3:33 PM - 4:33 PM","addresses":"Hospital near bypass road station indore","appoint_number":"8767687548","created_at":"2023-05-22 13:36:03","updated_at":"2023-05-22 13:36:03"},{"id":"22","user_id":"370","day":"MON,TUE","clinic_name":"Apna Clinic ","morning_shift":"8:34 PM - 6:35 PM","evening_shift":"11:35 PM - 10:34 PM","addresses":"Clicic New bay Vijay nagar indore ","appoint_number":"3646454849","created_at":"2023-05-22 13:36:03","updated_at":"2023-05-22 13:36:03"}]

class UserData {
  UserData({
      String? id, 
      dynamic ipAddress, 
      dynamic categoryId, 
      dynamic companyName, 
      String? companyDivision, 
      dynamic designationId, 
      String? title, 
      String? gender, 
      String? username, 
      String? password, 
      String? email, 
      String? mobile, 
      String? image, 
      String? balance, 
      dynamic activationSelector, 
      dynamic activationCode, 
      dynamic forgottenPasswordSelector, 
      dynamic forgottenPasswordCode, 
      dynamic forgottenPasswordTime, 
      dynamic rememberSelector, 
      dynamic rememberCode, 
      String? createdOn, 
      String? lastLogin, 
      String? active, 
      dynamic company, 
      String? address, 
      String? cAddress, 
      String? docDigree, 
      String? bonusType, 
      dynamic bonus, 
      String? cashReceived, 
      dynamic dob, 
      dynamic countryCode, 
      String? otp, 
      String? roll, 
      String? city, 
      dynamic area, 
      dynamic street, 
      dynamic pincode, 
      dynamic serviceableZipcodes, 
      dynamic apikey, 
      dynamic referralCode, 
      dynamic friendsCode, 
      String? fcmId, 
      dynamic deviceToken, 
      dynamic latitude, 
      dynamic longitude, 
      String? createdAt, 
      String? stateId, 
      String? cityId, 
      String? areaId, 
      String? experience, 
      String? placeName, 
      String? cityName, 
      String? stateName, 
      List<Clinics>? clinics,}){
    _id = id;
    _ipAddress = ipAddress;
    _categoryId = categoryId;
    _companyName = companyName;
    _companyDivision = companyDivision;
    _designationId = designationId;
    _title = title;
    _gender = gender;
    _username = username;
    _password = password;
    _email = email;
    _mobile = mobile;
    _image = image;
    _balance = balance;
    _activationSelector = activationSelector;
    _activationCode = activationCode;
    _forgottenPasswordSelector = forgottenPasswordSelector;
    _forgottenPasswordCode = forgottenPasswordCode;
    _forgottenPasswordTime = forgottenPasswordTime;
    _rememberSelector = rememberSelector;
    _rememberCode = rememberCode;
    _createdOn = createdOn;
    _lastLogin = lastLogin;
    _active = active;
    _company = company;
    _address = address;
    _cAddress = cAddress;
    _docDigree = docDigree;
    _bonusType = bonusType;
    _bonus = bonus;
    _cashReceived = cashReceived;
    _dob = dob;
    _countryCode = countryCode;
    _otp = otp;
    _roll = roll;
    _city = city;
    _area = area;
    _street = street;
    _pincode = pincode;
    _serviceableZipcodes = serviceableZipcodes;
    _apikey = apikey;
    _referralCode = referralCode;
    _friendsCode = friendsCode;
    _fcmId = fcmId;
    _deviceToken = deviceToken;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _stateId = stateId;
    _cityId = cityId;
    _areaId = areaId;
    _experience = experience;
    _placeName = placeName;
    _cityName = cityName;
    _stateName = stateName;
    _clinics = clinics;
}

  UserData.fromJson(dynamic json) {
    _id = json['id'];
    _ipAddress = json['ip_address'];
    _categoryId = json['category_id'];
    _companyName = json['company_name'];
    _companyDivision = json['company_division'];
    _designationId = json['designation_id'];
    _title = json['title'];
    _gender = json['gender'];
    _username = json['username'];
    _password = json['password'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _balance = json['balance'];
    _activationSelector = json['activation_selector'];
    _activationCode = json['activation_code'];
    _forgottenPasswordSelector = json['forgotten_password_selector'];
    _forgottenPasswordCode = json['forgotten_password_code'];
    _forgottenPasswordTime = json['forgotten_password_time'];
    _rememberSelector = json['remember_selector'];
    _rememberCode = json['remember_code'];
    _createdOn = json['created_on'];
    _lastLogin = json['last_login'];
    _active = json['active'];
    _company = json['company'];
    _address = json['address'];
    _cAddress = json['c_address'];
    _docDigree = json['doc_digree'];
    _bonusType = json['bonus_type'];
    _bonus = json['bonus'];
    _cashReceived = json['cash_received'];
    _dob = json['dob'];
    _countryCode = json['country_code'];
    _otp = json['otp'];
    _roll = json['roll'];
    _city = json['city'];
    _area = json['area'];
    _street = json['street'];
    _pincode = json['pincode'];
    _serviceableZipcodes = json['serviceable_zipcodes'];
    _apikey = json['apikey'];
    _referralCode = json['referral_code'];
    _friendsCode = json['friends_code'];
    _fcmId = json['fcm_id'];
    _deviceToken = json['device_token'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _areaId = json['area_id'];
    _experience = json['experience'];
    _placeName = json['place_name'];
    _cityName = json['city_name'];
    _stateName = json['state_name'];
    if (json['clinics'] != null) {
      _clinics = [];
      json['clinics'].forEach((v) {
        _clinics?.add(Clinics.fromJson(v));
      });
    }
  }
  String? _id;
  dynamic _ipAddress;
  dynamic _categoryId;
  dynamic _companyName;
  String? _companyDivision;
  dynamic _designationId;
  String? _title;
  String? _gender;
  String? _username;
  String? _password;
  String? _email;
  String? _mobile;
  String? _image;
  String? _balance;
  dynamic _activationSelector;
  dynamic _activationCode;
  dynamic _forgottenPasswordSelector;
  dynamic _forgottenPasswordCode;
  dynamic _forgottenPasswordTime;
  dynamic _rememberSelector;
  dynamic _rememberCode;
  String? _createdOn;
  String? _lastLogin;
  String? _active;
  dynamic _company;
  String? _address;
  String? _cAddress;
  String? _docDigree;
  String? _bonusType;
  dynamic _bonus;
  String? _cashReceived;
  dynamic _dob;
  dynamic _countryCode;
  String? _otp;
  String? _roll;
  String? _city;
  dynamic _area;
  dynamic _street;
  dynamic _pincode;
  dynamic _serviceableZipcodes;
  dynamic _apikey;
  dynamic _referralCode;
  dynamic _friendsCode;
  String? _fcmId;
  dynamic _deviceToken;
  dynamic _latitude;
  dynamic _longitude;
  String? _createdAt;
  String? _stateId;
  String? _cityId;
  String? _areaId;
  String? _experience;
  String? _placeName;
  String? _cityName;
  String? _stateName;
  List<Clinics>? _clinics;
UserData copyWith({  String? id,
  dynamic ipAddress,
  dynamic categoryId,
  dynamic companyName,
  String? companyDivision,
  dynamic designationId,
  String? title,
  String? gender,
  String? username,
  String? password,
  String? email,
  String? mobile,
  String? image,
  String? balance,
  dynamic activationSelector,
  dynamic activationCode,
  dynamic forgottenPasswordSelector,
  dynamic forgottenPasswordCode,
  dynamic forgottenPasswordTime,
  dynamic rememberSelector,
  dynamic rememberCode,
  String? createdOn,
  String? lastLogin,
  String? active,
  dynamic company,
  String? address,
  String? cAddress,
  String? docDigree,
  String? bonusType,
  dynamic bonus,
  String? cashReceived,
  dynamic dob,
  dynamic countryCode,
  String? otp,
  String? roll,
  String? city,
  dynamic area,
  dynamic street,
  dynamic pincode,
  dynamic serviceableZipcodes,
  dynamic apikey,
  dynamic referralCode,
  dynamic friendsCode,
  String? fcmId,
  dynamic deviceToken,
  dynamic latitude,
  dynamic longitude,
  String? createdAt,
  String? stateId,
  String? cityId,
  String? areaId,
  String? experience,
  String? placeName,
  String? cityName,
  String? stateName,
  List<Clinics>? clinics,
}) => UserData(  id: id ?? _id,
  ipAddress: ipAddress ?? _ipAddress,
  categoryId: categoryId ?? _categoryId,
  companyName: companyName ?? _companyName,
  companyDivision: companyDivision ?? _companyDivision,
  designationId: designationId ?? _designationId,
  title: title ?? _title,
  gender: gender ?? _gender,
  username: username ?? _username,
  password: password ?? _password,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  image: image ?? _image,
  balance: balance ?? _balance,
  activationSelector: activationSelector ?? _activationSelector,
  activationCode: activationCode ?? _activationCode,
  forgottenPasswordSelector: forgottenPasswordSelector ?? _forgottenPasswordSelector,
  forgottenPasswordCode: forgottenPasswordCode ?? _forgottenPasswordCode,
  forgottenPasswordTime: forgottenPasswordTime ?? _forgottenPasswordTime,
  rememberSelector: rememberSelector ?? _rememberSelector,
  rememberCode: rememberCode ?? _rememberCode,
  createdOn: createdOn ?? _createdOn,
  lastLogin: lastLogin ?? _lastLogin,
  active: active ?? _active,
  company: company ?? _company,
  address: address ?? _address,
  cAddress: cAddress ?? _cAddress,
  docDigree: docDigree ?? _docDigree,
  bonusType: bonusType ?? _bonusType,
  bonus: bonus ?? _bonus,
  cashReceived: cashReceived ?? _cashReceived,
  dob: dob ?? _dob,
  countryCode: countryCode ?? _countryCode,
  otp: otp ?? _otp,
  roll: roll ?? _roll,
  city: city ?? _city,
  area: area ?? _area,
  street: street ?? _street,
  pincode: pincode ?? _pincode,
  serviceableZipcodes: serviceableZipcodes ?? _serviceableZipcodes,
  apikey: apikey ?? _apikey,
  referralCode: referralCode ?? _referralCode,
  friendsCode: friendsCode ?? _friendsCode,
  fcmId: fcmId ?? _fcmId,
  deviceToken: deviceToken ?? _deviceToken,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  createdAt: createdAt ?? _createdAt,
  stateId: stateId ?? _stateId,
  cityId: cityId ?? _cityId,
  areaId: areaId ?? _areaId,
  experience: experience ?? _experience,
  placeName: placeName ?? _placeName,
  cityName: cityName ?? _cityName,
  stateName: stateName ?? _stateName,
  clinics: clinics ?? _clinics,
);
  String? get id => _id;
  dynamic get ipAddress => _ipAddress;
  dynamic get categoryId => _categoryId;
  dynamic get companyName => _companyName;
  String? get companyDivision => _companyDivision;
  dynamic get designationId => _designationId;
  String? get title => _title;
  String? get gender => _gender;
  String? get username => _username;
  String? get password => _password;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get image => _image;
  String? get balance => _balance;
  dynamic get activationSelector => _activationSelector;
  dynamic get activationCode => _activationCode;
  dynamic get forgottenPasswordSelector => _forgottenPasswordSelector;
  dynamic get forgottenPasswordCode => _forgottenPasswordCode;
  dynamic get forgottenPasswordTime => _forgottenPasswordTime;
  dynamic get rememberSelector => _rememberSelector;
  dynamic get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  String? get lastLogin => _lastLogin;
  String? get active => _active;
  dynamic get company => _company;
  String? get address => _address;
  String? get cAddress => _cAddress;
  String? get docDigree => _docDigree;
  String? get bonusType => _bonusType;
  dynamic get bonus => _bonus;
  String? get cashReceived => _cashReceived;
  dynamic get dob => _dob;
  dynamic get countryCode => _countryCode;
  String? get otp => _otp;
  String? get roll => _roll;
  String? get city => _city;
  dynamic get area => _area;
  dynamic get street => _street;
  dynamic get pincode => _pincode;
  dynamic get serviceableZipcodes => _serviceableZipcodes;
  dynamic get apikey => _apikey;
  dynamic get referralCode => _referralCode;
  dynamic get friendsCode => _friendsCode;
  String? get fcmId => _fcmId;
  dynamic get deviceToken => _deviceToken;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  String? get createdAt => _createdAt;
  String? get stateId => _stateId;
  String? get cityId => _cityId;
  String? get areaId => _areaId;
  String? get experience => _experience;
  String? get placeName => _placeName;
  String? get cityName => _cityName;
  String? get stateName => _stateName;
  List<Clinics>? get clinics => _clinics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ip_address'] = _ipAddress;
    map['category_id'] = _categoryId;
    map['company_name'] = _companyName;
    map['company_division'] = _companyDivision;
    map['designation_id'] = _designationId;
    map['title'] = _title;
    map['gender'] = _gender;
    map['username'] = _username;
    map['password'] = _password;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['balance'] = _balance;
    map['activation_selector'] = _activationSelector;
    map['activation_code'] = _activationCode;
    map['forgotten_password_selector'] = _forgottenPasswordSelector;
    map['forgotten_password_code'] = _forgottenPasswordCode;
    map['forgotten_password_time'] = _forgottenPasswordTime;
    map['remember_selector'] = _rememberSelector;
    map['remember_code'] = _rememberCode;
    map['created_on'] = _createdOn;
    map['last_login'] = _lastLogin;
    map['active'] = _active;
    map['company'] = _company;
    map['address'] = _address;
    map['c_address'] = _cAddress;
    map['doc_digree'] = _docDigree;
    map['bonus_type'] = _bonusType;
    map['bonus'] = _bonus;
    map['cash_received'] = _cashReceived;
    map['dob'] = _dob;
    map['country_code'] = _countryCode;
    map['otp'] = _otp;
    map['roll'] = _roll;
    map['city'] = _city;
    map['area'] = _area;
    map['street'] = _street;
    map['pincode'] = _pincode;
    map['serviceable_zipcodes'] = _serviceableZipcodes;
    map['apikey'] = _apikey;
    map['referral_code'] = _referralCode;
    map['friends_code'] = _friendsCode;
    map['fcm_id'] = _fcmId;
    map['device_token'] = _deviceToken;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['area_id'] = _areaId;
    map['experience'] = _experience;
    map['place_name'] = _placeName;
    map['city_name'] = _cityName;
    map['state_name'] = _stateName;
    if (_clinics != null) {
      map['clinics'] = _clinics?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "21"
/// user_id : "370"
/// day : "TUE,WED,THU"
/// clinic_name : "Hospital name Arvind"
/// morning_shift : "1:33 PM - 2:33 PM"
/// evening_shift : "3:33 PM - 4:33 PM"
/// addresses : "Hospital near bypass road station indore"
/// appoint_number : "8767687548"
/// created_at : "2023-05-22 13:36:03"
/// updated_at : "2023-05-22 13:36:03"

class Clinics {
  Clinics({
      String? id, 
      String? userId, 
      String? day, 
      String? clinicName, 
      String? morningShift, 
      String? eveningShift, 
      String? addresses, 
      String? appointNumber, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _day = day;
    _clinicName = clinicName;
    _morningShift = morningShift;
    _eveningShift = eveningShift;
    _addresses = addresses;
    _appointNumber = appointNumber;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Clinics.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _day = json['day'];
    _clinicName = json['clinic_name'];
    _morningShift = json['morning_shift'];
    _eveningShift = json['evening_shift'];
    _addresses = json['addresses'];
    _appointNumber = json['appoint_number'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _day;
  String? _clinicName;
  String? _morningShift;
  String? _eveningShift;
  String? _addresses;
  String? _appointNumber;
  String? _createdAt;
  String? _updatedAt;
Clinics copyWith({  String? id,
  String? userId,
  String? day,
  String? clinicName,
  String? morningShift,
  String? eveningShift,
  String? addresses,
  String? appointNumber,
  String? createdAt,
  String? updatedAt,
}) => Clinics(  id: id ?? _id,
  userId: userId ?? _userId,
  day: day ?? _day,
  clinicName: clinicName ?? _clinicName,
  morningShift: morningShift ?? _morningShift,
  eveningShift: eveningShift ?? _eveningShift,
  addresses: addresses ?? _addresses,
  appointNumber: appointNumber ?? _appointNumber,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get day => _day;
  String? get clinicName => _clinicName;
  String? get morningShift => _morningShift;
  String? get eveningShift => _eveningShift;
  String? get addresses => _addresses;
  String? get appointNumber => _appointNumber;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['day'] = _day;
    map['clinic_name'] = _clinicName;
    map['morning_shift'] = _morningShift;
    map['evening_shift'] = _eveningShift;
    map['addresses'] = _addresses;
    map['appoint_number'] = _appointNumber;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}