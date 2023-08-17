/// error : false
/// message : "Record found"
/// data : [{"id":"71","user_id":"639","type":"Personalized Awareness","json":{"mobile_no":"","dr_name":"demo","dr_association":"","degree":"","place":"indoor ","request":null,"awareness_request":null,"topic":"yyyy","clinic_hospital":"india ","email":"indor@gmail.com","message":"I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only","awareness_day":"","moderator":"","degree_moderator":"","speaker_name":"","degree_speaker_name":"mbbs","degree_conference":"","date":"","time":"","event_name":"","conference":"","dr_photo":"Yes","dr_personalized":"Standy"},"created_at":"2023-08-08 17:53:05","updated_at":"2023-08-08 17:53:05","name":"rr rr","doc_digree":"mmm","user_image":"https://developmentalphawizz.com/dr_booking/uploads/user_image/image_cropper_1691142548716.jpg","is_favorite":true}]

class GetRequestModel {
  GetRequestModel({
      bool? error, 
      String? message, 
      List<RequetDataList>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetRequestModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RequetDataList.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<RequetDataList>? _data;
GetRequestModel copyWith({  bool? error,
  String? message,
  List<RequetDataList>? data,
}) => GetRequestModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<RequetDataList>? get data => _data;

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

/// id : "71"
/// user_id : "639"
/// type : "Personalized Awareness"
/// json : {"mobile_no":"","dr_name":"demo","dr_association":"","degree":"","place":"indoor ","request":null,"awareness_request":null,"topic":"yyyy","clinic_hospital":"india ","email":"indor@gmail.com","message":"I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only","awareness_day":"","moderator":"","degree_moderator":"","speaker_name":"","degree_speaker_name":"mbbs","degree_conference":"","date":"","time":"","event_name":"","conference":"","dr_photo":"Yes","dr_personalized":"Standy"}
/// created_at : "2023-08-08 17:53:05"
/// updated_at : "2023-08-08 17:53:05"
/// name : "rr rr"
/// doc_digree : "mmm"
/// user_image : "https://developmentalphawizz.com/dr_booking/uploads/user_image/image_cropper_1691142548716.jpg"
/// is_favorite : true

class RequetDataList {
  RequetDataList({
      String? id, 
      String? userId, 
      String? type, 
      Json? json, 
      String? createdAt, 
      String? updatedAt, 
      String? name, 
      String? docDigree, 
      String? userImage,
      bool? isSelected,
      bool? isFavorite,}){
    _id = id;
    _userId = userId;
    _type = type;
    _json = json;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
    _docDigree = docDigree;
    _userImage = userImage;
    _isFavorite = isFavorite;
}

  RequetDataList.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _type = json['type'];
    _json = json['json'] != null ? Json.fromJson(json['json']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _name = json['name'];
    _docDigree = json['doc_digree'];
    _userImage = json['user_image'];
    _isFavorite = json['is_favorite'];
  }
  String? _id;
  String? _userId;
  String? _type;
  Json? _json;
  String? _createdAt;
  String? _updatedAt;
  String? _name;
  String? _docDigree;
  String? _userImage;
  bool? _isFavorite;
  bool? isSelected;
RequetDataList copyWith({  String? id,
  String? userId,
  String? type,
  Json? json,
  String? createdAt,
  String? updatedAt,
  String? name,
  String? docDigree,
  String? userImage,
  bool? isFavorite,
  bool? isSelected,
}) => RequetDataList(  id: id ?? _id,
  userId: userId ?? _userId,
  type: type ?? _type,
  json: json ?? _json,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  name: name ?? _name,
  docDigree: docDigree ?? _docDigree,
  userImage: userImage ?? _userImage,
  isFavorite: isFavorite ?? _isFavorite,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get type => _type;
  Json? get json => _json;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get name => _name;
  String? get docDigree => _docDigree;
  String? get userImage => _userImage;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    if (_json != null) {
      map['json'] = _json?.toJson();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['name'] = _name;
    map['doc_digree'] = _docDigree;
    map['user_image'] = _userImage;
    map['is_favorite'] = _isFavorite;
    return map;
  }

}

/// mobile_no : ""
/// dr_name : "demo"
/// dr_association : ""
/// degree : ""
/// place : "indoor "
/// request : null
/// awareness_request : null
/// topic : "yyyy"
/// clinic_hospital : "india "
/// email : "indor@gmail.com"
/// message : "I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only"
/// awareness_day : ""
/// moderator : ""
/// degree_moderator : ""
/// speaker_name : ""
/// degree_speaker_name : "mbbs"
/// degree_conference : ""
/// date : ""
/// time : ""
/// event_name : ""
/// conference : ""
/// dr_photo : "Yes"
/// dr_personalized : "Standy"

class Json {
  Json({
      String? mobileNo, 
      String? drName, 
      String? drAssociation, 
      String? degree, 
      String? place, 
      dynamic request, 
      dynamic awarenessRequest, 
      String? topic, 
      String? clinicHospital, 
      String? email, 
      String? message, 
      String? awarenessDay, 
      String? moderator, 
      String? degreeModerator, 
      String? speakerName, 
      String? degreeSpeakerName, 
      String? degreeConference, 
      String? date, 
      String? time, 
      String? eventName, 
      String? conference, 
      String? drPhoto, 
      String? drPersonalized,}){
    _mobileNo = mobileNo;
    _drName = drName;
    _drAssociation = drAssociation;
    _degree = degree;
    _place = place;
    _request = request;
    _awarenessRequest = awarenessRequest;
    _topic = topic;
    _clinicHospital = clinicHospital;
    _email = email;
    _message = message;
    _awarenessDay = awarenessDay;
    _moderator = moderator;
    _degreeModerator = degreeModerator;
    _speakerName = speakerName;
    _degreeSpeakerName = degreeSpeakerName;
    _degreeConference = degreeConference;
    _date = date;
    _time = time;
    _eventName = eventName;
    _conference = conference;
    _drPhoto = drPhoto;
    _drPersonalized = drPersonalized;
}

  Json.fromJson(dynamic json) {
    _mobileNo = json['mobile_no'];
    _drName = json['dr_name'];
    _drAssociation = json['dr_association'];
    _degree = json['degree'];
    _place = json['place'];
    _request = json['request'];
    _awarenessRequest = json['awareness_request'];
    _topic = json['topic'];
    _clinicHospital = json['clinic_hospital'];
    _email = json['email'];
    _message = json['message'];
    _awarenessDay = json['awareness_day'];
    _moderator = json['moderator'];
    _degreeModerator = json['degree_moderator'];
    _speakerName = json['speaker_name'];
    _degreeSpeakerName = json['degree_speaker_name'];
    _degreeConference = json['degree_conference'];
    _date = json['date'];
    _time = json['time'];
    _eventName = json['event_name'];
    _conference = json['conference'];
    _drPhoto = json['dr_photo'];
    _drPersonalized = json['dr_personalized'];
  }
  String? _mobileNo;
  String? _drName;
  String? _drAssociation;
  String? _degree;
  String? _place;
  dynamic _request;
  dynamic _awarenessRequest;
  String? _topic;
  String? _clinicHospital;
  String? _email;
  String? _message;
  String? _awarenessDay;
  String? _moderator;
  String? _degreeModerator;
  String? _speakerName;
  String? _degreeSpeakerName;
  String? _degreeConference;
  String? _date;
  String? _time;
  String? _eventName;
  String? _conference;
  String? _drPhoto;
  String? _drPersonalized;
Json copyWith({  String? mobileNo,
  String? drName,
  String? drAssociation,
  String? degree,
  String? place,
  dynamic request,
  dynamic awarenessRequest,
  String? topic,
  String? clinicHospital,
  String? email,
  String? message,
  String? awarenessDay,
  String? moderator,
  String? degreeModerator,
  String? speakerName,
  String? degreeSpeakerName,
  String? degreeConference,
  String? date,
  String? time,
  String? eventName,
  String? conference,
  String? drPhoto,
  String? drPersonalized,
}) => Json(  mobileNo: mobileNo ?? _mobileNo,
  drName: drName ?? _drName,
  drAssociation: drAssociation ?? _drAssociation,
  degree: degree ?? _degree,
  place: place ?? _place,
  request: request ?? _request,
  awarenessRequest: awarenessRequest ?? _awarenessRequest,
  topic: topic ?? _topic,
  clinicHospital: clinicHospital ?? _clinicHospital,
  email: email ?? _email,
  message: message ?? _message,
  awarenessDay: awarenessDay ?? _awarenessDay,
  moderator: moderator ?? _moderator,
  degreeModerator: degreeModerator ?? _degreeModerator,
  speakerName: speakerName ?? _speakerName,
  degreeSpeakerName: degreeSpeakerName ?? _degreeSpeakerName,
  degreeConference: degreeConference ?? _degreeConference,
  date: date ?? _date,
  time: time ?? _time,
  eventName: eventName ?? _eventName,
  conference: conference ?? _conference,
  drPhoto: drPhoto ?? _drPhoto,
  drPersonalized: drPersonalized ?? _drPersonalized,
);
  String? get mobileNo => _mobileNo;
  String? get drName => _drName;
  String? get drAssociation => _drAssociation;
  String? get degree => _degree;
  String? get place => _place;
  dynamic get request => _request;
  dynamic get awarenessRequest => _awarenessRequest;
  String? get topic => _topic;
  String? get clinicHospital => _clinicHospital;
  String? get email => _email;
  String? get message => _message;
  String? get awarenessDay => _awarenessDay;
  String? get moderator => _moderator;
  String? get degreeModerator => _degreeModerator;
  String? get speakerName => _speakerName;
  String? get degreeSpeakerName => _degreeSpeakerName;
  String? get degreeConference => _degreeConference;
  String? get date => _date;
  String? get time => _time;
  String? get eventName => _eventName;
  String? get conference => _conference;
  String? get drPhoto => _drPhoto;
  String? get drPersonalized => _drPersonalized;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_no'] = _mobileNo;
    map['dr_name'] = _drName;
    map['dr_association'] = _drAssociation;
    map['degree'] = _degree;
    map['place'] = _place;
    map['request'] = _request;
    map['awareness_request'] = _awarenessRequest;
    map['topic'] = _topic;
    map['clinic_hospital'] = _clinicHospital;
    map['email'] = _email;
    map['message'] = _message;
    map['awareness_day'] = _awarenessDay;
    map['moderator'] = _moderator;
    map['degree_moderator'] = _degreeModerator;
    map['speaker_name'] = _speakerName;
    map['degree_speaker_name'] = _degreeSpeakerName;
    map['degree_conference'] = _degreeConference;
    map['date'] = _date;
    map['time'] = _time;
    map['event_name'] = _eventName;
    map['conference'] = _conference;
    map['dr_photo'] = _drPhoto;
    map['dr_personalized'] = _drPersonalized;
    return map;
  }

}