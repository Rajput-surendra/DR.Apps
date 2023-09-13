/// error : false
/// message : "Record found"
/// data : [{"id":"181","type":"doctor_plus_banner","type_id":"749","company_id":"0","image":"uploads/user_image/Screenshot_2023-08-09-19-06-00-698_com_newondemand_user2.jpg","video":"","slider":"link","speciality":"34","state_id":"11","city_id":"677","user_id":"749","specialization":null,"link":"","date_added":"2023-09-13 11:56:59"},{"id":"182","type":"doctor_plus_banner","type_id":"749","company_id":"0","image":"uploads/user_image/Screenshot_2023-08-09-19-04-38-954_com_newondemand_user.jpg","video":"","slider":"link","speciality":"34","state_id":"25","city_id":"115","user_id":"749","specialization":null,"link":"","date_added":"2023-09-13 11:58:26"}]

class AdversementListModel {
  AdversementListModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  AdversementListModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
AdversementListModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => AdversementListModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "181"
/// type : "doctor_plus_banner"
/// type_id : "749"
/// company_id : "0"
/// image : "uploads/user_image/Screenshot_2023-08-09-19-06-00-698_com_newondemand_user2.jpg"
/// video : ""
/// slider : "link"
/// speciality : "34"
/// state_id : "11"
/// city_id : "677"
/// user_id : "749"
/// specialization : null
/// link : ""
/// date_added : "2023-09-13 11:56:59"

class Data {
  Data({
      String? id, 
      String? type, 
      String? typeId, 
      String? companyId, 
      String? image, 
      String? video, 
      String? slider, 
      String? speciality, 
      String? stateId, 
      String? cityId, 
      String? userId, 
      dynamic specialization, 
      String? link, 
      String? dateAdded,}){
    _id = id;
    _type = type;
    _typeId = typeId;
    _companyId = companyId;
    _image = image;
    _video = video;
    _slider = slider;
    _speciality = speciality;
    _stateId = stateId;
    _cityId = cityId;
    _userId = userId;
    _specialization = specialization;
    _link = link;
    _dateAdded = dateAdded;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _typeId = json['type_id'];
    _companyId = json['company_id'];
    _image = json['image'];
    _video = json['video'];
    _slider = json['slider'];
    _speciality = json['speciality'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _userId = json['user_id'];
    _specialization = json['specialization'];
    _link = json['link'];
    _dateAdded = json['date_added'];
  }
  String? _id;
  String? _type;
  String? _typeId;
  String? _companyId;
  String? _image;
  String? _video;
  String? _slider;
  String? _speciality;
  String? _stateId;
  String? _cityId;
  String? _userId;
  dynamic _specialization;
  String? _link;
  String? _dateAdded;
Data copyWith({  String? id,
  String? type,
  String? typeId,
  String? companyId,
  String? image,
  String? video,
  String? slider,
  String? speciality,
  String? stateId,
  String? cityId,
  String? userId,
  dynamic specialization,
  String? link,
  String? dateAdded,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  typeId: typeId ?? _typeId,
  companyId: companyId ?? _companyId,
  image: image ?? _image,
  video: video ?? _video,
  slider: slider ?? _slider,
  speciality: speciality ?? _speciality,
  stateId: stateId ?? _stateId,
  cityId: cityId ?? _cityId,
  userId: userId ?? _userId,
  specialization: specialization ?? _specialization,
  link: link ?? _link,
  dateAdded: dateAdded ?? _dateAdded,
);
  String? get id => _id;
  String? get type => _type;
  String? get typeId => _typeId;
  String? get companyId => _companyId;
  String? get image => _image;
  String? get video => _video;
  String? get slider => _slider;
  String? get speciality => _speciality;
  String? get stateId => _stateId;
  String? get cityId => _cityId;
  String? get userId => _userId;
  dynamic get specialization => _specialization;
  String? get link => _link;
  String? get dateAdded => _dateAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['type_id'] = _typeId;
    map['company_id'] = _companyId;
    map['image'] = _image;
    map['video'] = _video;
    map['slider'] = _slider;
    map['speciality'] = _speciality;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['user_id'] = _userId;
    map['specialization'] = _specialization;
    map['link'] = _link;
    map['date_added'] = _dateAdded;
    return map;
  }

}