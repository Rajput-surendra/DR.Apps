/// error : false
/// message : "Free Graphics"
/// data : [{"id":"1","title":"Dr Panel","image":"https://drplusapp.in/uploads/no-image.png","is_parent":"1","parent_id":"0","status":"1","created_at":"2023-08-02 17:43:32","updated_at":"2023-08-02 17:34:45","total":"1","childs":[{"id":"3","title":"Dummy Image","image":"https://drplusapp.in/uploads/no-image.png","is_parent":"0","parent_id":"1","status":"1","created_at":"2023-08-02 17:36:47","updated_at":"2023-08-02 17:36:47"}]},{"id":"2","title":"Graphics","image":"https://drplusapp.in/uploads/no-image.png","is_parent":"1","parent_id":"0","status":"1","created_at":"2023-08-02 17:43:37","updated_at":"2023-08-02 17:34:56","total":"1","childs":[{"id":"4","title":"Dummy Image","image":"https://drplusapp.in/uploads/no-image.png","is_parent":"0","parent_id":"2","status":"1","created_at":"2023-08-02 17:36:47","updated_at":"2023-08-02 17:36:47"}]}]

class GetGraphicModel {
  GetGraphicModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetGraphicModel.fromJson(dynamic json) {
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
GetGraphicModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetGraphicModel(  error: error ?? _error,
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

/// id : "1"
/// title : "Dr Panel"
/// image : "https://drplusapp.in/uploads/no-image.png"
/// is_parent : "1"
/// parent_id : "0"
/// status : "1"
/// created_at : "2023-08-02 17:43:32"
/// updated_at : "2023-08-02 17:34:45"
/// total : "1"
/// childs : [{"id":"3","title":"Dummy Image","image":"https://drplusapp.in/uploads/no-image.png","is_parent":"0","parent_id":"1","status":"1","created_at":"2023-08-02 17:36:47","updated_at":"2023-08-02 17:36:47"}]

class Data {
  Data({
      String? id, 
      String? title, 
      String? image, 
      String? isParent, 
      String? parentId, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? total, 
      List<Childs>? childs,}){
    _id = id;
    _title = title;
    _image = image;
    _isParent = isParent;
    _parentId = parentId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _total = total;
    _childs = childs;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _image = json['image'];
    _isParent = json['is_parent'];
    _parentId = json['parent_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _total = json['total'];
    if (json['childs'] != null) {
      _childs = [];
      json['childs'].forEach((v) {
        _childs?.add(Childs.fromJson(v));
      });
    }
  }
  String? _id;
  String? _title;
  String? _image;
  String? _isParent;
  String? _parentId;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _total;
  List<Childs>? _childs;
Data copyWith({  String? id,
  String? title,
  String? image,
  String? isParent,
  String? parentId,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? total,
  List<Childs>? childs,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  image: image ?? _image,
  isParent: isParent ?? _isParent,
  parentId: parentId ?? _parentId,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  total: total ?? _total,
  childs: childs ?? _childs,
);
  String? get id => _id;
  String? get title => _title;
  String? get image => _image;
  String? get isParent => _isParent;
  String? get parentId => _parentId;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get total => _total;
  List<Childs>? get childs => _childs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    map['is_parent'] = _isParent;
    map['parent_id'] = _parentId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['total'] = _total;
    if (_childs != null) {
      map['childs'] = _childs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// title : "Dummy Image"
/// image : "https://drplusapp.in/uploads/no-image.png"
/// is_parent : "0"
/// parent_id : "1"
/// status : "1"
/// created_at : "2023-08-02 17:36:47"
/// updated_at : "2023-08-02 17:36:47"

class Childs {
  Childs({
      String? id, 
      String? title, 
      String? image, 
      String? isParent, 
      String? parentId, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _title = title;
    _image = image;
    _isParent = isParent;
    _parentId = parentId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Childs.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _image = json['image'];
    _isParent = json['is_parent'];
    _parentId = json['parent_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _title;
  String? _image;
  String? _isParent;
  String? _parentId;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
Childs copyWith({  String? id,
  String? title,
  String? image,
  String? isParent,
  String? parentId,
  String? status,
  String? createdAt,
  String? updatedAt,
}) => Childs(  id: id ?? _id,
  title: title ?? _title,
  image: image ?? _image,
  isParent: isParent ?? _isParent,
  parentId: parentId ?? _parentId,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get title => _title;
  String? get image => _image;
  String? get isParent => _isParent;
  String? get parentId => _parentId;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    map['is_parent'] = _isParent;
    map['parent_id'] = _parentId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}