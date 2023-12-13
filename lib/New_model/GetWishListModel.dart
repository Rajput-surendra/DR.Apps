/// status : true
/// message : "Users wishlist"
/// data : {"webinar":[{"user_name":"gdgdsgg","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","user_address":"","user_phone":"5454848448","user_digree":"mbbs","id":"107","title":"tvtgvtvvtvt","from_time":"8:35 AM","to_time":null,"start_date":"2023-08-30","end_date":null,"description":null,"link":"gtgttg","image":"https://drplusapp.in/uploads/media/2023/64ea136fc02b5.png","topic":"tgvvtvtvvt","speaker":"tvgtvy","moderator":"v g vgbgvg","status":"1","date":"2023-08-26 20:29:59","pharma_id":"726","type":"doctor-webinar","is_fav":false}],"event":[{"user_name":"gdgdsgg","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","user_address":"","user_phone":"5454848448","user_digree":"mbbs","id":"106","title":"gdvddbbfn","name":"svgdbdvdvsv","mobile":"8494548845","start_date":"2023-08-30","end_date":"2023-08-29","designation":"bddbddhd","status":"1","description":"","link":"vsvdbd","address":"geegegrg","date":"2023-08-26 19:48:23","image":"https://drplusapp.in/uploads/media/2023/64ea099f405a1.png","pharma_id":"726","type":"doctor-event","is_fav":false}],"requests":[{"id":"90","user_id":"726","type":"Awareness inputs","json":{"mobile_no":"5858508585","dr_name":"","dr_association":"","degree":"","place":"fcfcfcfcf","request":"Poster","awareness_request":null,"topic":"gvvgvgvgvggvvgvf","clinic_hospital":"fcfvfvvffv","email":"test12345@gmail.com","message":"I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only.","awareness_day":"","moderator":"","degree_moderator":"","speaker_name":"","degree_speaker_name":"","degree_conference":"","date":"","time":"","event_name":"","conference":"","dr_photo":null,"dr_personalized":null},"created_at":"2023-08-26 18:06:01","updated_at":"2023-08-26 18:06:01","name":"gdgdsgg","doc_digree":"mbbs","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","is_favorite":true},{"id":"91","user_id":"726","type":"Worlds Awareness Day inputs","json":{"mobile_no":"","dr_name":"","dr_association":"","degree":"","place":"vgvggvgv","request":null,"awareness_request":"Video","topic":"","clinic_hospital":"rcrvvtvtvt","email":"test12345@gmail.com","message":" I Request to pharma companies can you please provide awareness input for my clinic/hospital/my social media a/c for awareness purpose only.","awareness_day":"vffvrvtvvft","moderator":"","degree_moderator":"","speaker_name":"","degree_speaker_name":"","degree_conference":"","date":"","time":"","event_name":"","conference":"","dr_photo":null,"dr_personalized":null},"created_at":"2023-08-26 18:14:26","updated_at":"2023-08-26 18:14:26","name":"gdgdsgg","doc_digree":"mbbs","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","is_favorite":true}],"awareness":[{"user_name":"yhhby","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","user_address":"","user_phone":"8962272839","user_digree":null,"id":"115","title":"hell","aware_input":"poster","aware_language":"Gujrati","date":"2023-08-17 13:39:59","image":"https://drplusapp.in/uploads/media/2023/64ddd5993cd95.jpg","pharma_id":"685","status":"1","thumbnail":null,"type":"pharma-awareness","is_fav":false}],"products":[{"user_name":"yhhby","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","user_address":"","user_phone":"8962272839","user_digree":null,"id":"115","title":"hell","aware_input":"poster","aware_language":"Gujrati","date":"2023-08-17 13:39:59","image":"https://drplusapp.in/uploads/media/2023/64ddd5993cd95.jpg","pharma_id":"685","status":"1","thumbnail":null,"type":"pharma-awareness","is_fav":false}]}

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

/// webinar : [{"user_name":"gdgdsgg","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","user_address":"","user_phone":"5454848448","user_digree":"mbbs","id":"107","title":"tvtgvtvvtvt","from_time":"8:35 AM","to_time":null,"start_date":"2023-08-30","end_date":null,"description":null,"link":"gtgttg","image":"https://drplusapp.in/uploads/media/2023/64ea136fc02b5.png","topic":"tgvvtvtvvt","speaker":"tvgtvy","moderator":"v g vgbgvg","status":"1","date":"2023-08-26 20:29:59","pharma_id":"726","type":"doctor-webinar","is_fav":false}]
/// event : [{"user_name":"gdgdsgg","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","user_address":"","user_phone":"5454848448","user_digree":"mbbs","id":"106","title":"gdvddbbfn","name":"svgdbdvdvsv","mobile":"8494548845","start_date":"2023-08-30","end_date":"2023-08-29","designation":"bddbddhd","status":"1","description":"","link":"vsvdbd","address":"geegegrg","date":"2023-08-26 19:48:23","image":"https://drplusapp.in/uploads/media/2023/64ea099f405a1.png","pharma_id":"726","type":"doctor-event","is_fav":false}]
/// requests : [{"id":"90","user_id":"726","type":"Awareness inputs","json":{"mobile_no":"5858508585","dr_name":"","dr_association":"","degree":"","place":"fcfcfcfcf","request":"Poster","awareness_request":null,"topic":"gvvgvgvgvggvvgvf","clinic_hospital":"fcfvfvvffv","email":"test12345@gmail.com","message":"I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only.","awareness_day":"","moderator":"","degree_moderator":"","speaker_name":"","degree_speaker_name":"","degree_conference":"","date":"","time":"","event_name":"","conference":"","dr_photo":null,"dr_personalized":null},"created_at":"2023-08-26 18:06:01","updated_at":"2023-08-26 18:06:01","name":"gdgdsgg","doc_digree":"mbbs","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","is_favorite":true},{"id":"91","user_id":"726","type":"Worlds Awareness Day inputs","json":{"mobile_no":"","dr_name":"","dr_association":"","degree":"","place":"vgvggvgv","request":null,"awareness_request":"Video","topic":"","clinic_hospital":"rcrvvtvtvt","email":"test12345@gmail.com","message":" I Request to pharma companies can you please provide awareness input for my clinic/hospital/my social media a/c for awareness purpose only.","awareness_day":"vffvrvtvvft","moderator":"","degree_moderator":"","speaker_name":"","degree_speaker_name":"","degree_conference":"","date":"","time":"","event_name":"","conference":"","dr_photo":null,"dr_personalized":null},"created_at":"2023-08-26 18:14:26","updated_at":"2023-08-26 18:14:26","name":"gdgdsgg","doc_digree":"mbbs","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","is_favorite":true}]
/// awareness : [{"user_name":"yhhby","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","user_address":"","user_phone":"8962272839","user_digree":null,"id":"115","title":"hell","aware_input":"poster","aware_language":"Gujrati","date":"2023-08-17 13:39:59","image":"https://drplusapp.in/uploads/media/2023/64ddd5993cd95.jpg","pharma_id":"685","status":"1","thumbnail":null,"type":"pharma-awareness","is_fav":false}]
/// products : [{"user_name":"yhhby","user_image":"https://drplusapp.in/uploads/user_image/no-image.png","user_address":"","user_phone":"8962272839","user_digree":null,"id":"115","title":"hell","aware_input":"poster","aware_language":"Gujrati","date":"2023-08-17 13:39:59","image":"https://drplusapp.in/uploads/media/2023/64ddd5993cd95.jpg","pharma_id":"685","status":"1","thumbnail":null,"type":"pharma-awareness","is_fav":false}]

class Data {
  Data({
      List<Webinar>? webinar, 
      List<Event>? event, 
      List<Requests>? requests, 
      List<Awareness>? awareness, 
      List<Products>? products,}){
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
        _requests?.add(Requests.fromJson(v));
      });
    }
    if (json['awareness'] != null) {
      _awareness = [];
      json['awareness'].forEach((v) {
        _awareness?.add(Awareness.fromJson(v));
      });
    }
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  List<Webinar>? _webinar;
  List<Event>? _event;
  List<Requests>? _requests;
  List<Awareness>? _awareness;
  List<Products>? _products;
Data copyWith({  List<Webinar>? webinar,
  List<Event>? event,
  List<Requests>? requests,
  List<Awareness>? awareness,
  List<Products>? products,
}) => Data(  webinar: webinar ?? _webinar,
  event: event ?? _event,
  requests: requests ?? _requests,
  awareness: awareness ?? _awareness,
  products: products ?? _products,
);
  List<Webinar>? get webinar => _webinar;
  List<Event>? get event => _event;
  List<Requests>? get requests => _requests;
  List<Awareness>? get awareness => _awareness;
  List<Products>? get products => _products;

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

/// user_name : "yhhby"
/// user_image : "https://drplusapp.in/uploads/user_image/no-image.png"
/// user_address : ""
/// user_phone : "8962272839"
/// user_digree : null
/// id : "115"
/// title : "hell"
/// aware_input : "poster"
/// aware_language : "Gujrati"
/// date : "2023-08-17 13:39:59"
/// image : "https://drplusapp.in/uploads/media/2023/64ddd5993cd95.jpg"
/// pharma_id : "685"
/// status : "1"
/// thumbnail : null
/// type : "pharma-awareness"
/// is_fav : false

class Products {
  Products({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      dynamic userDigree, 
      String? id, 
      String? title, 
      String? awareInput, 
      String? awareLanguage, 
      String? date, 
      String? image, 
      String? pharmaId, 
      String? status, 
      dynamic thumbnail, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _awareInput = awareInput;
    _awareLanguage = awareLanguage;
    _date = date;
    _image = image;
    _pharmaId = pharmaId;
    _status = status;
    _thumbnail = thumbnail;
    _type = type;
    _isFav = isFav;
}

  Products.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _awareInput = json['aware_input'];
    _awareLanguage = json['aware_language'];
    _date = json['date'];
    _image = json['image'];
    _pharmaId = json['pharma_id'];
    _status = json['status'];
    _thumbnail = json['thumbnail'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  dynamic _userDigree;
  String? _id;
  String? _title;
  String? _awareInput;
  String? _awareLanguage;
  String? _date;
  String? _image;
  String? _pharmaId;
  String? _status;
  dynamic _thumbnail;
  String? _type;
  bool? _isFav;
Products copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  dynamic userDigree,
  String? id,
  String? title,
  String? awareInput,
  String? awareLanguage,
  String? date,
  String? image,
  String? pharmaId,
  String? status,
  dynamic thumbnail,
  String? type,
  bool? isFav,
}) => Products(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  awareInput: awareInput ?? _awareInput,
  awareLanguage: awareLanguage ?? _awareLanguage,
  date: date ?? _date,
  image: image ?? _image,
  pharmaId: pharmaId ?? _pharmaId,
  status: status ?? _status,
  thumbnail: thumbnail ?? _thumbnail,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  dynamic get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get awareInput => _awareInput;
  String? get awareLanguage => _awareLanguage;
  String? get date => _date;
  String? get image => _image;
  String? get pharmaId => _pharmaId;
  String? get status => _status;
  dynamic get thumbnail => _thumbnail;
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
    map['aware_input'] = _awareInput;
    map['aware_language'] = _awareLanguage;
    map['date'] = _date;
    map['image'] = _image;
    map['pharma_id'] = _pharmaId;
    map['status'] = _status;
    map['thumbnail'] = _thumbnail;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}

/// user_name : "yhhby"
/// user_image : "https://drplusapp.in/uploads/user_image/no-image.png"
/// user_address : ""
/// user_phone : "8962272839"
/// user_digree : null
/// id : "115"
/// title : "hell"
/// aware_input : "poster"
/// aware_language : "Gujrati"
/// date : "2023-08-17 13:39:59"
/// image : "https://drplusapp.in/uploads/media/2023/64ddd5993cd95.jpg"
/// pharma_id : "685"
/// status : "1"
/// thumbnail : null
/// type : "pharma-awareness"
/// is_fav : false

class Awareness {
  Awareness({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      dynamic userDigree, 
      String? id, 
      String? title, 
      String? awareInput, 
      String? awareLanguage, 
      String? date, 
      String? image, 
      String? pharmaId, 
      String? status, 
      dynamic thumbnail, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _awareInput = awareInput;
    _awareLanguage = awareLanguage;
    _date = date;
    _image = image;
    _pharmaId = pharmaId;
    _status = status;
    _thumbnail = thumbnail;
    _type = type;
    _isFav = isFav;
}

  Awareness.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _awareInput = json['aware_input'];
    _awareLanguage = json['aware_language'];
    _date = json['date'];
    _image = json['image'];
    _pharmaId = json['pharma_id'];
    _status = json['status'];
    _thumbnail = json['thumbnail'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  dynamic _userDigree;
  String? _id;
  String? _title;
  String? _awareInput;
  String? _awareLanguage;
  String? _date;
  String? _image;
  String? _pharmaId;
  String? _status;
  dynamic _thumbnail;
  String? _type;
  bool? _isFav;
Awareness copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  dynamic userDigree,
  String? id,
  String? title,
  String? awareInput,
  String? awareLanguage,
  String? date,
  String? image,
  String? pharmaId,
  String? status,
  dynamic thumbnail,
  String? type,
  bool? isFav,
}) => Awareness(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  awareInput: awareInput ?? _awareInput,
  awareLanguage: awareLanguage ?? _awareLanguage,
  date: date ?? _date,
  image: image ?? _image,
  pharmaId: pharmaId ?? _pharmaId,
  status: status ?? _status,
  thumbnail: thumbnail ?? _thumbnail,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  dynamic get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get awareInput => _awareInput;
  String? get awareLanguage => _awareLanguage;
  String? get date => _date;
  String? get image => _image;
  String? get pharmaId => _pharmaId;
  String? get status => _status;
  dynamic get thumbnail => _thumbnail;
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
    map['aware_input'] = _awareInput;
    map['aware_language'] = _awareLanguage;
    map['date'] = _date;
    map['image'] = _image;
    map['pharma_id'] = _pharmaId;
    map['status'] = _status;
    map['thumbnail'] = _thumbnail;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}

/// id : "90"
/// user_id : "726"
/// type : "Awareness inputs"
/// json : {"mobile_no":"5858508585","dr_name":"","dr_association":"","degree":"","place":"fcfcfcfcf","request":"Poster","awareness_request":null,"topic":"gvvgvgvgvggvvgvf","clinic_hospital":"fcfvfvvffv","email":"test12345@gmail.com","message":"I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only.","awareness_day":"","moderator":"","degree_moderator":"","speaker_name":"","degree_speaker_name":"","degree_conference":"","date":"","time":"","event_name":"","conference":"","dr_photo":null,"dr_personalized":null}
/// created_at : "2023-08-26 18:06:01"
/// updated_at : "2023-08-26 18:06:01"
/// name : "gdgdsgg"
/// doc_digree : "mbbs"
/// user_image : "https://drplusapp.in/uploads/user_image/no-image.png"
/// is_favorite : true

class Requests {
  Requests({
      String? id, 
      String? userId, 
      String? type, 
      Json? json, 
      String? createdAt, 
      String? updatedAt, 
      String? name, 
      String? docDigree, 
      String? userImage, 
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

  Requests.fromJson(dynamic json) {
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
Requests copyWith({  String? id,
  String? userId,
  String? type,
  Json? json,
  String? createdAt,
  String? updatedAt,
  String? name,
  String? docDigree,
  String? userImage,
  bool? isFavorite,
}) => Requests(  id: id ?? _id,
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

/// mobile_no : "5858508585"
/// dr_name : ""
/// dr_association : ""
/// degree : ""
/// place : "fcfcfcfcf"
/// request : "Poster"
/// awareness_request : null
/// topic : "gvvgvgvgvggvvgvf"
/// clinic_hospital : "fcfvfvvffv"
/// email : "test12345@gmail.com"
/// message : "I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only."
/// awareness_day : ""
/// moderator : ""
/// degree_moderator : ""
/// speaker_name : ""
/// degree_speaker_name : ""
/// degree_conference : ""
/// date : ""
/// time : ""
/// event_name : ""
/// conference : ""
/// dr_photo : null
/// dr_personalized : null

class Json {
  Json({
      String? mobileNo, 
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
      String? degreeModerator, 
      String? speakerName, 
      String? degreeSpeakerName, 
      String? degreeConference, 
      String? date, 
      String? time, 
      String? eventName, 
      String? conference, 
      dynamic drPhoto, 
      dynamic drPersonalized,}){
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
  String? _request;
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
  dynamic _drPhoto;
  dynamic _drPersonalized;
Json copyWith({  String? mobileNo,
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
  String? degreeModerator,
  String? speakerName,
  String? degreeSpeakerName,
  String? degreeConference,
  String? date,
  String? time,
  String? eventName,
  String? conference,
  dynamic drPhoto,
  dynamic drPersonalized,
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
  String? get request => _request;
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
  dynamic get drPhoto => _drPhoto;
  dynamic get drPersonalized => _drPersonalized;

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

/// user_name : "gdgdsgg"
/// user_image : "https://drplusapp.in/uploads/user_image/no-image.png"
/// user_address : ""
/// user_phone : "5454848448"
/// user_digree : "mbbs"
/// id : "106"
/// title : "gdvddbbfn"
/// name : "svgdbdvdvsv"
/// mobile : "8494548845"
/// start_date : "2023-08-30"
/// end_date : "2023-08-29"
/// designation : "bddbddhd"
/// status : "1"
/// description : ""
/// link : "vsvdbd"
/// address : "geegegrg"
/// date : "2023-08-26 19:48:23"
/// image : "https://drplusapp.in/uploads/media/2023/64ea099f405a1.png"
/// pharma_id : "726"
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

/// user_name : "gdgdsgg"
/// user_image : "https://drplusapp.in/uploads/user_image/no-image.png"
/// user_address : ""
/// user_phone : "5454848448"
/// user_digree : "mbbs"
/// id : "107"
/// title : "tvtgvtvvtvt"
/// from_time : "8:35 AM"
/// to_time : null
/// start_date : "2023-08-30"
/// end_date : null
/// description : null
/// link : "gtgttg"
/// image : "https://drplusapp.in/uploads/media/2023/64ea136fc02b5.png"
/// topic : "tgvvtvtvvt"
/// speaker : "tvgtvy"
/// moderator : "v g vgbgvg"
/// status : "1"
/// date : "2023-08-26 20:29:59"
/// pharma_id : "726"
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