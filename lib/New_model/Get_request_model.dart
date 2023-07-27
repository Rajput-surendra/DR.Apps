/// error : false
/// message : "Request added successfully"
/// data : [{"int":"3","user_id":"602","type":"Awareness inputs","json":{"dr_name":"tvfgffv","dr_association":"","degree":"fvfvvvf","place":"ffv","request":"Leaflet","awareness_request":null,"topic":"fvfv","clinic_hospital":"gvg ","email":" fgg@gmail.com","message":"fvvfg ","awareness_day":"","moderator":"","speaker_name":"","date":"","time":"","event_name":"","conference":""},"created_at":"2023-07-26 17:18:13","updated_at":"2023-07-26 17:18:13"},{"int":"5","user_id":"602","type":"Awareness inputs","json":{"dr_name":"vdgegdvdgdrh","dr_association":"","degree":"","place":"bdbdbfb","request":"Leaflet","awareness_request":null,"topic":"gsgeg","clinic_hospital":"bfbfbfh","email":"tttt@gmail.com","message":"bdbdh","awareness_day":"","moderator":"","speaker_name":"","date":"","time":"","event_name":"","conference":""},"created_at":"2023-07-26 17:33:44","updated_at":"2023-07-26 17:33:44"},{"int":"6","user_id":"602","type":"Worlds Awareness Day inputs","json":{"dr_name":"vtvtvtv","dr_association":"","degree":"mca","place":"fvfvgv","request":null,"awareness_request":"Poster","topic":"","clinic_hospital":"crcrc","email":"fvfvgv","message":"g g g ","awareness_day":"tvfgg","moderator":"","speaker_name":"","date":"","time":"","event_name":"","conference":""},"created_at":"2023-07-26 17:36:12","updated_at":"2023-07-26 17:36:12"},{"int":"7","user_id":"602","type":"Online Webinar Invitation Designs","json":{"dr_name":"","dr_association":"tggtg","degree":"vffvr","place":"vc g ","request":null,"awareness_request":"Poster","topic":"VF g ","clinic_hospital":"fvfvgv","email":"fvf f fvvxbttv@ail.com","message":"bgbybgbgb","awareness_day":"","moderator":"g. gvb","speaker_name":" f fgvtvt","date":"2023-07-27","time":"9:42 PM","event_name":"","conference":""},"created_at":"2023-07-26 17:40:54","updated_at":"2023-07-26 17:40:54"}]

class GetRequestModel {
  GetRequestModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
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
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetRequestModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetRequestModel(  error: error ?? _error,
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

/// int : "3"
/// user_id : "602"
/// type : "Awareness inputs"
/// json : {"dr_name":"tvfgffv","dr_association":"","degree":"fvfvvvf","place":"ffv","request":"Leaflet","awareness_request":null,"topic":"fvfv","clinic_hospital":"gvg ","email":" fgg@gmail.com","message":"fvvfg ","awareness_day":"","moderator":"","speaker_name":"","date":"","time":"","event_name":"","conference":""}
/// created_at : "2023-07-26 17:18:13"
/// updated_at : "2023-07-26 17:18:13"

class Data {
  Data({
      String? int, 
      String? userId, 
      String? type, 
      Json? json, 
      String? createdAt,
      String? userImage,

      String? updatedAt,}){
    _int = int;
    _userId = userId;
    _type = type;
    _json = json;
    _userImage = userImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _int = json['int'];
    _userId = json['user_id'];
    _type = json['type'];
    _userImage = json['user_image'];
    _json = json['json'] != null ? Json.fromJson(json['json']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _int;
  String? _userId;
  String? _type;
  String? _userImage;
  Json? _json;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? int,
  String? userId,
  String? type,
  String? userImage,
  Json? json,
  String? createdAt,
  String? updatedAt,
}) => Data(  int: int ?? _int,
  userId: userId ?? _userId,
  type: type ?? _type,
  json: json ?? _json,
  userImage: userImage ?? _userImage,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get int => _int;
  String? get userId => _userId;
  String? get type => _type;
  String? get userImage => _userImage;
  Json? get json => _json;

  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['int'] = _int;
    map['user_id'] = _userId;
    map['user_image'] = _userImage;
    map['type'] = _type;
    if (_json != null) {
      map['json'] = _json?.toJson();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// dr_name : "tvfgffv"
/// dr_association : ""
/// degree : "fvfvvvf"
/// place : "ffv"
/// request : "Leaflet"
/// awareness_request : null
/// topic : "fvfv"
/// clinic_hospital : "gvg "
/// email : " fgg@gmail.com"
/// message : "fvvfg "
/// awareness_day : ""
/// moderator : ""
/// speaker_name : ""
/// date : ""
/// time : ""
/// event_name : ""
/// conference : ""

class Json {
  Json({
      String? drName, 
      String? drAssociation, 
      String? degree, 
      String? place, 
      String? request, 
      dynamic awarenessRequest, 
      String? topic, 
      String? clinicHospital, 
      String? email, 
      String? message, 
      String? awarenessDay, 
      String? moderator, 
      String? speakerName, 
      String? date, 
      String? time, 
      String? eventName, 
      String? conference,}){
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
    _speakerName = speakerName;
    _date = date;
    _time = time;
    _eventName = eventName;
    _conference = conference;
}

  Json.fromJson(dynamic json) {
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
    _speakerName = json['speaker_name'];
    _date = json['date'];
    _time = json['time'];
    _eventName = json['event_name'];
    _conference = json['conference'];
  }
  String? _drName;
  String? _drAssociation;
  String? _degree;
  String? _place;
  String? _request;
  dynamic _awarenessRequest;
  String? _topic;
  String? _clinicHospital;
  String? _email;
  String? _message;
  String? _awarenessDay;
  String? _moderator;
  String? _speakerName;
  String? _date;
  String? _time;
  String? _eventName;
  String? _conference;
Json copyWith({  String? drName,
  String? drAssociation,
  String? degree,
  String? place,
  String? request,
  dynamic awarenessRequest,
  String? topic,
  String? clinicHospital,
  String? email,
  String? message,
  String? awarenessDay,
  String? moderator,
  String? speakerName,
  String? date,
  String? time,
  String? eventName,
  String? conference,
}) => Json(  drName: drName ?? _drName,
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
  speakerName: speakerName ?? _speakerName,
  date: date ?? _date,
  time: time ?? _time,
  eventName: eventName ?? _eventName,
  conference: conference ?? _conference,
);
  String? get drName => _drName;
  String? get drAssociation => _drAssociation;
  String? get degree => _degree;
  String? get place => _place;
  String? get request => _request;
  dynamic get awarenessRequest => _awarenessRequest;
  String? get topic => _topic;
  String? get clinicHospital => _clinicHospital;
  String? get email => _email;
  String? get message => _message;
  String? get awarenessDay => _awarenessDay;
  String? get moderator => _moderator;
  String? get speakerName => _speakerName;
  String? get date => _date;
  String? get time => _time;
  String? get eventName => _eventName;
  String? get conference => _conference;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['speaker_name'] = _speakerName;
    map['date'] = _date;
    map['time'] = _time;
    map['event_name'] = _eventName;
    map['conference'] = _conference;
    return map;
  }

}