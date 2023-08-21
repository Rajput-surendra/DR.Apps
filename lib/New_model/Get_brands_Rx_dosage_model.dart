/// error : false
/// message : "Record Found Successfully"
/// data : [{"id":"12","user_id":"685","category_id":"1","name":"hbbybynh","generic_name":"byybybbybhbh","company_name":"gbgbgbbbhbg","details":{"indication":"tere bin tere bin tere bin tere bin tere bin tere bina kya hai song lyrics in hindi dubbed full movie","dosage":"qwerty in the world of the world of the world of the world","rx_info":"yrrhdhcnfh in the world of the world of the"},"images":["https://developmentalphawizz.com/dr_booking/uploads/review_image/image_cropper_1692605689279.jpg","https://developmentalphawizz.com/dr_booking/uploads/review_image/image_cropper_1692605695636.jpg","https://developmentalphawizz.com/dr_booking/uploads/review_image/image_cropper_1692605702110.jpg"],"logo":"https://developmentalphawizz.com/dr_booking/uploads/review_image/image_cropper_1692605662112.jpg","contact_details":[{"name":"test ","mobile":"7777777777"},{"name":"users ","mobile":"8888888888"},{"name":" demo","mobile":"9999999999"}],"created_at":"2023-08-21 13:42:41","updated_at":"2023-08-19 17:22:46","is_details_added":true,"detail_text":"Click to view detail of brand","is_detail_plan_subscribed":false,"is_add_plan_subscribed":false}]

class GetBrandsRxDosageModel {
  GetBrandsRxDosageModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetBrandsRxDosageModel.fromJson(dynamic json) {
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
GetBrandsRxDosageModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetBrandsRxDosageModel(  error: error ?? _error,
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

/// id : "12"
/// user_id : "685"
/// category_id : "1"
/// name : "hbbybynh"
/// generic_name : "byybybbybhbh"
/// company_name : "gbgbgbbbhbg"
/// details : {"indication":"tere bin tere bin tere bin tere bin tere bin tere bina kya hai song lyrics in hindi dubbed full movie","dosage":"qwerty in the world of the world of the world of the world","rx_info":"yrrhdhcnfh in the world of the world of the"}
/// images : ["https://developmentalphawizz.com/dr_booking/uploads/review_image/image_cropper_1692605689279.jpg","https://developmentalphawizz.com/dr_booking/uploads/review_image/image_cropper_1692605695636.jpg","https://developmentalphawizz.com/dr_booking/uploads/review_image/image_cropper_1692605702110.jpg"]
/// logo : "https://developmentalphawizz.com/dr_booking/uploads/review_image/image_cropper_1692605662112.jpg"
/// contact_details : [{"name":"test ","mobile":"7777777777"},{"name":"users ","mobile":"8888888888"},{"name":" demo","mobile":"9999999999"}]
/// created_at : "2023-08-21 13:42:41"
/// updated_at : "2023-08-19 17:22:46"
/// is_details_added : true
/// detail_text : "Click to view detail of brand"
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
      Details? details, 
      List<String>? images, 
      String? logo, 
      List<ContactDetails>? contactDetails, 
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
    _details = details;
    _images = images;
    _logo = logo;
    _contactDetails = contactDetails;
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
    _details = json['details'] != null ? Details.fromJson(json['details']) : null;
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _logo = json['logo'];
    if (json['contact_details'] != null) {
      _contactDetails = [];
      json['contact_details'].forEach((v) {
        _contactDetails?.add(ContactDetails.fromJson(v));
      });
    }
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
  Details? _details;
  List<String>? _images;
  String? _logo;
  List<ContactDetails>? _contactDetails;
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
  Details? details,
  List<String>? images,
  String? logo,
  List<ContactDetails>? contactDetails,
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
  details: details ?? _details,
  images: images ?? _images,
  logo: logo ?? _logo,
  contactDetails: contactDetails ?? _contactDetails,
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
  Details? get details => _details;
  List<String>? get images => _images;
  String? get logo => _logo;
  List<ContactDetails>? get contactDetails => _contactDetails;
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
    if (_details != null) {
      map['details'] = _details?.toJson();
    }
    map['images'] = _images;
    map['logo'] = _logo;
    if (_contactDetails != null) {
      map['contact_details'] = _contactDetails?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['is_details_added'] = _isDetailsAdded;
    map['detail_text'] = _detailText;
    map['is_detail_plan_subscribed'] = _isDetailPlanSubscribed;
    map['is_add_plan_subscribed'] = _isAddPlanSubscribed;
    return map;
  }

}

/// name : "test "
/// mobile : "7777777777"

class ContactDetails {
  ContactDetails({
      String? name, 
      String? mobile,}){
    _name = name;
    _mobile = mobile;
}

  ContactDetails.fromJson(dynamic json) {
    _name = json['name'];
    _mobile = json['mobile'];
  }
  String? _name;
  String? _mobile;
ContactDetails copyWith({  String? name,
  String? mobile,
}) => ContactDetails(  name: name ?? _name,
  mobile: mobile ?? _mobile,
);
  String? get name => _name;
  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['mobile'] = _mobile;
    return map;
  }

}

/// indication : "tere bin tere bin tere bin tere bin tere bin tere bina kya hai song lyrics in hindi dubbed full movie"
/// dosage : "qwerty in the world of the world of the world of the world"
/// rx_info : "yrrhdhcnfh in the world of the world of the"

class Details {
  Details({
      String? indication, 
      String? dosage, 
      String? rxInfo,}){
    _indication = indication;
    _dosage = dosage;
    _rxInfo = rxInfo;
}

  Details.fromJson(dynamic json) {
    _indication = json['indication'];
    _dosage = json['dosage'];
    _rxInfo = json['rx_info'];
  }
  String? _indication;
  String? _dosage;
  String? _rxInfo;
Details copyWith({  String? indication,
  String? dosage,
  String? rxInfo,
}) => Details(  indication: indication ?? _indication,
  dosage: dosage ?? _dosage,
  rxInfo: rxInfo ?? _rxInfo,
);
  String? get indication => _indication;
  String? get dosage => _dosage;
  String? get rxInfo => _rxInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['indication'] = _indication;
    map['dosage'] = _dosage;
    map['rx_info'] = _rxInfo;
    return map;
  }

}