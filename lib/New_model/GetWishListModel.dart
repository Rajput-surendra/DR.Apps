/// status : true
/// message : "Users wishlist"
/// data : {"webinar":[{"user_name":"deva","user_image":"https://developmentalphawizz.com/dr_booking/uploads/user_image/no-image.png","user_address":"","user_phone":"8463816337","user_digree":"mbba","id":"105","title":"hdhfhtj","from_time":"12:09 PM","to_time":null,"start_date":"2023-08-25","end_date":null,"description":null,"link":"dvvdbd","image":"https://developmentalphawizz.com/dr_booking/uploads/media/2023/64e84b8c6ffde.png","topic":"vdvdggdbhd","speaker":"gsvdbfb","moderator":"vxbfbbfb","status":"1","date":"2023-08-25 12:04:52","pharma_id":"689","type":"doctor-webinar","is_fav":false}],"event":[{"user_name":"deva","user_image":"https://developmentalphawizz.com/dr_booking/uploads/user_image/no-image.png","user_address":"","user_phone":"8463816337","user_digree":"mbba","id":"104","title":"vdbddhfh","name":"csvdvdb","mobile":"8484848495","start_date":"2023-08-25","end_date":"2023-08-26","designation":"dvdvdbdbdbd","status":"1","description":"","link":"vdvsdvdv","address":"gdbdvbdb","date":"2023-08-25 12:01:15","image":"https://developmentalphawizz.com/dr_booking/uploads/media/2023/64e84aa21ca1b.png","pharma_id":"689","type":"doctor-event","is_fav":false}],"requests":[],"awareness":[],"products":[]}

class GetWishListModel {
  GetWishListModel({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetWishListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
GetWishListModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => GetWishListModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// webinar : [{"user_name":"deva","user_image":"https://developmentalphawizz.com/dr_booking/uploads/user_image/no-image.png","user_address":"","user_phone":"8463816337","user_digree":"mbba","id":"105","title":"hdhfhtj","from_time":"12:09 PM","to_time":null,"start_date":"2023-08-25","end_date":null,"description":null,"link":"dvvdbd","image":"https://developmentalphawizz.com/dr_booking/uploads/media/2023/64e84b8c6ffde.png","topic":"vdvdggdbhd","speaker":"gsvdbfb","moderator":"vxbfbbfb","status":"1","date":"2023-08-25 12:04:52","pharma_id":"689","type":"doctor-webinar","is_fav":false}]
/// event : [{"user_name":"deva","user_image":"https://developmentalphawizz.com/dr_booking/uploads/user_image/no-image.png","user_address":"","user_phone":"8463816337","user_digree":"mbba","id":"104","title":"vdbddhfh","name":"csvdvdb","mobile":"8484848495","start_date":"2023-08-25","end_date":"2023-08-26","designation":"dvdvdbdbdbd","status":"1","description":"","link":"vdvsdvdv","address":"gdbdvbdb","date":"2023-08-25 12:01:15","image":"https://developmentalphawizz.com/dr_booking/uploads/media/2023/64e84aa21ca1b.png","pharma_id":"689","type":"doctor-event","is_fav":false}]
/// requests : []
/// awareness : []
/// products : []

class Data {
  Data({
      List<Webinar>? webinar, 
      List<Event>? event, 
      List<dynamic>? requests, 
      List<dynamic>? awareness, 
      List<dynamic>? products,}){
    _webinar = webinar;
    _event = event;
    _requests = requests;
    _awareness = awareness;
    _products = products;
}

  Data.fromJson(dynamic json) {
    if (json['webinar'] != null) {
      _webinar = [];
      json['webinar'].forEach((v) {
        _webinar?.add(Webinar.fromJson(v));
      });
    }
    if (json['event'] != null) {
      _event = [];
      json['event'].forEach((v) {
        _event?.add(Event.fromJson(v));
      });
    }
    if (json['requests'] != null) {
      _requests = [];
      json['requests'].forEach((v) {
        _requests?.add(v.fromJson(v));
      });
    }
    if (json['awareness'] != null) {
      _awareness = [];
      json['awareness'].forEach((v) {
        _awareness?.add(v.fromJson(v));
      });
    }
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(v.fromJson(v));
      });
    }
  }
  List<Webinar>? _webinar;
  List<Event>? _event;
  List<dynamic>? _requests;
  List<dynamic>? _awareness;
  List<dynamic>? _products;
Data copyWith({  List<Webinar>? webinar,
  List<Event>? event,
  List<dynamic>? requests,
  List<dynamic>? awareness,
  List<dynamic>? products,
}) => Data(  webinar: webinar ?? _webinar,
  event: event ?? _event,
  requests: requests ?? _requests,
  awareness: awareness ?? _awareness,
  products: products ?? _products,
);
  List<Webinar>? get webinar => _webinar;
  List<Event>? get event => _event;
  List<dynamic>? get requests => _requests;
  List<dynamic>? get awareness => _awareness;
  List<dynamic>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_webinar != null) {
      map['webinar'] = _webinar?.map((v) => v.toJson()).toList();
    }
    if (_event != null) {
      map['event'] = _event?.map((v) => v.toJson()).toList();
    }
    if (_requests != null) {
      map['requests'] = _requests?.map((v) => v.toJson()).toList();
    }
    if (_awareness != null) {
      map['awareness'] = _awareness?.map((v) => v.toJson()).toList();
    }
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// user_name : "deva"
/// user_image : "https://developmentalphawizz.com/dr_booking/uploads/user_image/no-image.png"
/// user_address : ""
/// user_phone : "8463816337"
/// user_digree : "mbba"
/// id : "104"
/// title : "vdbddhfh"
/// name : "csvdvdb"
/// mobile : "8484848495"
/// start_date : "2023-08-25"
/// end_date : "2023-08-26"
/// designation : "dvdvdbdbdbd"
/// status : "1"
/// description : ""
/// link : "vdvsdvdv"
/// address : "gdbdvbdb"
/// date : "2023-08-25 12:01:15"
/// image : "https://developmentalphawizz.com/dr_booking/uploads/media/2023/64e84aa21ca1b.png"
/// pharma_id : "689"
/// type : "doctor-event"
/// is_fav : false

class Event {
  Event({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      String? userDigree, 
      String? id, 
      String? title, 
      String? name, 
      String? mobile, 
      String? startDate, 
      String? endDate, 
      String? designation, 
      String? status, 
      String? description, 
      String? link, 
      String? address, 
      String? date, 
      String? image, 
      String? pharmaId, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _name = name;
    _mobile = mobile;
    _startDate = startDate;
    _endDate = endDate;
    _designation = designation;
    _status = status;
    _description = description;
    _link = link;
    _address = address;
    _date = date;
    _image = image;
    _pharmaId = pharmaId;
    _type = type;
    _isFav = isFav;
}

  Event.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _name = json['name'];
    _mobile = json['mobile'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _designation = json['designation'];
    _status = json['status'];
    _description = json['description'];
    _link = json['link'];
    _address = json['address'];
    _date = json['date'];
    _image = json['image'];
    _pharmaId = json['pharma_id'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  String? _userDigree;
  String? _id;
  String? _title;
  String? _name;
  String? _mobile;
  String? _startDate;
  String? _endDate;
  String? _designation;
  String? _status;
  String? _description;
  String? _link;
  String? _address;
  String? _date;
  String? _image;
  String? _pharmaId;
  String? _type;
  bool? _isFav;
Event copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  String? userDigree,
  String? id,
  String? title,
  String? name,
  String? mobile,
  String? startDate,
  String? endDate,
  String? designation,
  String? status,
  String? description,
  String? link,
  String? address,
  String? date,
  String? image,
  String? pharmaId,
  String? type,
  bool? isFav,
}) => Event(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  designation: designation ?? _designation,
  status: status ?? _status,
  description: description ?? _description,
  link: link ?? _link,
  address: address ?? _address,
  date: date ?? _date,
  image: image ?? _image,
  pharmaId: pharmaId ?? _pharmaId,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  String? get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get designation => _designation;
  String? get status => _status;
  String? get description => _description;
  String? get link => _link;
  String? get address => _address;
  String? get date => _date;
  String? get image => _image;
  String? get pharmaId => _pharmaId;
  String? get type => _type;
  bool? get isFav => _isFav;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    map['user_address'] = _userAddress;
    map['user_phone'] = _userPhone;
    map['user_digree'] = _userDigree;
    map['id'] = _id;
    map['title'] = _title;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['designation'] = _designation;
    map['status'] = _status;
    map['description'] = _description;
    map['link'] = _link;
    map['address'] = _address;
    map['date'] = _date;
    map['image'] = _image;
    map['pharma_id'] = _pharmaId;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}

/// user_name : "deva"
/// user_image : "https://developmentalphawizz.com/dr_booking/uploads/user_image/no-image.png"
/// user_address : ""
/// user_phone : "8463816337"
/// user_digree : "mbba"
/// id : "105"
/// title : "hdhfhtj"
/// from_time : "12:09 PM"
/// to_time : null
/// start_date : "2023-08-25"
/// end_date : null
/// description : null
/// link : "dvvdbd"
/// image : "https://developmentalphawizz.com/dr_booking/uploads/media/2023/64e84b8c6ffde.png"
/// topic : "vdvdggdbhd"
/// speaker : "gsvdbfb"
/// moderator : "vxbfbbfb"
/// status : "1"
/// date : "2023-08-25 12:04:52"
/// pharma_id : "689"
/// type : "doctor-webinar"
/// is_fav : false

class Webinar {
  Webinar({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      String? userDigree, 
      String? id, 
      String? title, 
      String? fromTime, 
      dynamic toTime, 
      String? startDate, 
      dynamic endDate, 
      dynamic description, 
      String? link, 
      String? image, 
      String? topic, 
      String? speaker, 
      String? moderator, 
      String? status, 
      String? date, 
      String? pharmaId, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _fromTime = fromTime;
    _toTime = toTime;
    _startDate = startDate;
    _endDate = endDate;
    _description = description;
    _link = link;
    _image = image;
    _topic = topic;
    _speaker = speaker;
    _moderator = moderator;
    _status = status;
    _date = date;
    _pharmaId = pharmaId;
    _type = type;
    _isFav = isFav;
}

  Webinar.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _description = json['description'];
    _link = json['link'];
    _image = json['image'];
    _topic = json['topic'];
    _speaker = json['speaker'];
    _moderator = json['moderator'];
    _status = json['status'];
    _date = json['date'];
    _pharmaId = json['pharma_id'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  String? _userDigree;
  String? _id;
  String? _title;
  String? _fromTime;
  dynamic _toTime;
  String? _startDate;
  dynamic _endDate;
  dynamic _description;
  String? _link;
  String? _image;
  String? _topic;
  String? _speaker;
  String? _moderator;
  String? _status;
  String? _date;
  String? _pharmaId;
  String? _type;
  bool? _isFav;
Webinar copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  String? userDigree,
  String? id,
  String? title,
  String? fromTime,
  dynamic toTime,
  String? startDate,
  dynamic endDate,
  dynamic description,
  String? link,
  String? image,
  String? topic,
  String? speaker,
  String? moderator,
  String? status,
  String? date,
  String? pharmaId,
  String? type,
  bool? isFav,
}) => Webinar(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  description: description ?? _description,
  link: link ?? _link,
  image: image ?? _image,
  topic: topic ?? _topic,
  speaker: speaker ?? _speaker,
  moderator: moderator ?? _moderator,
  status: status ?? _status,
  date: date ?? _date,
  pharmaId: pharmaId ?? _pharmaId,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  String? get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get fromTime => _fromTime;
  dynamic get toTime => _toTime;
  String? get startDate => _startDate;
  dynamic get endDate => _endDate;
  dynamic get description => _description;
  String? get link => _link;
  String? get image => _image;
  String? get topic => _topic;
  String? get speaker => _speaker;
  String? get moderator => _moderator;
  String? get status => _status;
  String? get date => _date;
  String? get pharmaId => _pharmaId;
  String? get type => _type;
  bool? get isFav => _isFav;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    map['user_address'] = _userAddress;
    map['user_phone'] = _userPhone;
    map['user_digree'] = _userDigree;
    map['id'] = _id;
    map['title'] = _title;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['description'] = _description;
    map['link'] = _link;
    map['image'] = _image;
    map['topic'] = _topic;
    map['speaker'] = _speaker;
    map['moderator'] = _moderator;
    map['status'] = _status;
    map['date'] = _date;
    map['pharma_id'] = _pharmaId;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}