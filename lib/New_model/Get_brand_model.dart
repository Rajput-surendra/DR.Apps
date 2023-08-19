/// error : false
/// message : "Record Found Successfully"
/// data : [{"id":"8","user_id":"685","category_id":"11","name":"new brand","generic_name":"nice product and good quality\nin this","company_name":"alphawizz","logo":"","created_at":"2023-08-19 13:45:23","updated_at":"2023-08-19 13:45:23","is_details_added":false,"detail_text":"Click to add detail of brand","is_detail_plan_subscribed":false,"is_add_plan_subscribed":false},{"id":"9","user_id":"685","category_id":"11","name":"surendra","generic_name":"gtgtfcybyvhvhbttfb vgvgg","company_name":"ctgvgg","logo":"","created_at":"2023-08-19 13:46:48","updated_at":"2023-08-19 13:46:48","is_details_added":false,"detail_text":"Click to add detail of brand","is_detail_plan_subscribed":false,"is_add_plan_subscribed":false}]

class GetBrandModel {
  GetBrandModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetBrandModel.fromJson(dynamic json) {
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
GetBrandModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetBrandModel(  error: error ?? _error,
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

/// id : "8"
/// user_id : "685"
/// category_id : "11"
/// name : "new brand"
/// generic_name : "nice product and good quality\nin this"
/// company_name : "alphawizz"
/// logo : ""
/// created_at : "2023-08-19 13:45:23"
/// updated_at : "2023-08-19 13:45:23"
/// is_details_added : false
/// detail_text : "Click to add detail of brand"
/// is_detail_plan_subscribed : false
/// is_add_plan_subscribed : false

class Data {
  Data({
      String? id, 
      String? userId, 
      String? categoryId, 
      String? name, 
      String? genericName, 
      String? companyName, 
      String? logo, 
      String? createdAt, 
      String? updatedAt, 
      bool? isDetailsAdded, 
      String? detailText, 
      bool? isDetailPlanSubscribed, 
      bool? isAddPlanSubscribed,}){
    _id = id;
    _userId = userId;
    _categoryId = categoryId;
    _name = name;
    _genericName = genericName;
    _companyName = companyName;
    _logo = logo;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _isDetailsAdded = isDetailsAdded;
    _detailText = detailText;
    _isDetailPlanSubscribed = isDetailPlanSubscribed;
    _isAddPlanSubscribed = isAddPlanSubscribed;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _categoryId = json['category_id'];
    _name = json['name'];
    _genericName = json['generic_name'];
    _companyName = json['company_name'];
    _logo = json['logo'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _isDetailsAdded = json['is_details_added'];
    _detailText = json['detail_text'];
    _isDetailPlanSubscribed = json['is_detail_plan_subscribed'];
    _isAddPlanSubscribed = json['is_add_plan_subscribed'];
  }
  String? _id;
  String? _userId;
  String? _categoryId;
  String? _name;
  String? _genericName;
  String? _companyName;
  String? _logo;
  String? _createdAt;
  String? _updatedAt;
  bool? _isDetailsAdded;
  String? _detailText;
  bool? _isDetailPlanSubscribed;
  bool? _isAddPlanSubscribed;
Data copyWith({  String? id,
  String? userId,
  String? categoryId,
  String? name,
  String? genericName,
  String? companyName,
  String? logo,
  String? createdAt,
  String? updatedAt,
  bool? isDetailsAdded,
  String? detailText,
  bool? isDetailPlanSubscribed,
  bool? isAddPlanSubscribed,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  categoryId: categoryId ?? _categoryId,
  name: name ?? _name,
  genericName: genericName ?? _genericName,
  companyName: companyName ?? _companyName,
  logo: logo ?? _logo,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  isDetailsAdded: isDetailsAdded ?? _isDetailsAdded,
  detailText: detailText ?? _detailText,
  isDetailPlanSubscribed: isDetailPlanSubscribed ?? _isDetailPlanSubscribed,
  isAddPlanSubscribed: isAddPlanSubscribed ?? _isAddPlanSubscribed,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get categoryId => _categoryId;
  String? get name => _name;
  String? get genericName => _genericName;
  String? get companyName => _companyName;
  String? get logo => _logo;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  bool? get isDetailsAdded => _isDetailsAdded;
  String? get detailText => _detailText;
  bool? get isDetailPlanSubscribed => _isDetailPlanSubscribed;
  bool? get isAddPlanSubscribed => _isAddPlanSubscribed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['category_id'] = _categoryId;
    map['name'] = _name;
    map['generic_name'] = _genericName;
    map['company_name'] = _companyName;
    map['logo'] = _logo;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['is_details_added'] = _isDetailsAdded;
    map['detail_text'] = _detailText;
    map['is_detail_plan_subscribed'] = _isDetailPlanSubscribed;
    map['is_add_plan_subscribed'] = _isAddPlanSubscribed;
    return map;
  }

}