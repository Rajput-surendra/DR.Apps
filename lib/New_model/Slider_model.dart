/// status : true
/// message : "Plan lists"
/// data : [{"id":"27","name":"Pharma Sliding ads","description":"Pharma Sliding ads","amount":"999.00","time":"15 days","type":"1","plan_type":"2","is_plan":"1","created_at":"2023-08-19 13:13:14","update_at":"2023-06-26 12:13:37","is_purchased":false}]

class SliderModel {
  SliderModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SliderModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
SliderModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => SliderModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "27"
/// name : "Pharma Sliding ads"
/// description : "Pharma Sliding ads"
/// amount : "999.00"
/// time : "15 days"
/// type : "1"
/// plan_type : "2"
/// is_plan : "1"
/// created_at : "2023-08-19 13:13:14"
/// update_at : "2023-06-26 12:13:37"
/// is_purchased : false

class Data {
  Data({
      String? id, 
      String? name, 
      String? description, 
      String? amount, 
      String? time, 
      String? type, 
      String? planType, 
      String? isPlan, 
      String? createdAt, 
      String? updateAt, 
      bool? isPurchased,}){
    _id = id;
    _name = name;
    _description = description;
    _amount = amount;
    _time = time;
    _type = type;
    _planType = planType;
    _isPlan = isPlan;
    _createdAt = createdAt;
    _updateAt = updateAt;
    _isPurchased = isPurchased;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _amount = json['amount'];
    _time = json['time'];
    _type = json['type'];
    _planType = json['plan_type'];
    _isPlan = json['is_plan'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
    _isPurchased = json['is_purchased'];
  }
  String? _id;
  String? _name;
  String? _description;
  String? _amount;
  String? _time;
  String? _type;
  String? _planType;
  String? _isPlan;
  String? _createdAt;
  String? _updateAt;
  bool? _isPurchased;
Data copyWith({  String? id,
  String? name,
  String? description,
  String? amount,
  String? time,
  String? type,
  String? planType,
  String? isPlan,
  String? createdAt,
  String? updateAt,
  bool? isPurchased,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  amount: amount ?? _amount,
  time: time ?? _time,
  type: type ?? _type,
  planType: planType ?? _planType,
  isPlan: isPlan ?? _isPlan,
  createdAt: createdAt ?? _createdAt,
  updateAt: updateAt ?? _updateAt,
  isPurchased: isPurchased ?? _isPurchased,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get amount => _amount;
  String? get time => _time;
  String? get type => _type;
  String? get planType => _planType;
  String? get isPlan => _isPlan;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;
  bool? get isPurchased => _isPurchased;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['amount'] = _amount;
    map['time'] = _time;
    map['type'] = _type;
    map['plan_type'] = _planType;
    map['is_plan'] = _isPlan;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    map['is_purchased'] = _isPurchased;
    return map;
  }

}