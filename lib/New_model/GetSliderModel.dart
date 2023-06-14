/// error : false
/// data : [{"id":"1","type":"link","type_id":"0","image":"https://developmentalphawizz.com/dr_booking/uploads/media/2023/download_(58).jpg","link":"https://youtube.com/","date_added":"2023-03-25 13:23:26","data":[{"id":"1","type":"link","type_id":"0","image":"uploads/media/2023/download_(58).jpg","link":"https://youtube.com/","date_added":"2023-03-25 13:23:26"},{"id":"2","type":"default","type_id":"0","image":"uploads/media/2023/file_example_MP4_480_1_5MG1.mp4","link":null,"date_added":"2023-03-25 13:23:57"}]},{"id":"2","type":"default","type_id":"0","image":"https://developmentalphawizz.com/dr_booking/uploads/media/2023/file_example_MP4_480_1_5MG1.mp4","link":null,"date_added":"2023-03-25 13:23:57","data":[]}]

class GetSliderModel {
  GetSliderModel({
    bool? error,
    List<Data>? data,}){
    _error = error;
    _data = data;
  }

  GetSliderModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
  GetSliderModel copyWith({  bool? error,
    List<Data>? data,
  }) => GetSliderModel(  error: error ?? _error,
    data: data ?? _data,
  );
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// type : "link"
/// type_id : "0"
/// image : "https://developmentalphawizz.com/dr_booking/uploads/media/2023/download_(58).jpg"
/// link : "https://youtube.com/"
/// date_added : "2023-03-25 13:23:26"
/// data : [{"id":"1","type":"link","type_id":"0","image":"uploads/media/2023/download_(58).jpg","link":"https://youtube.com/","date_added":"2023-03-25 13:23:26"},{"id":"2","type":"default","type_id":"0","image":"uploads/media/2023/file_example_MP4_480_1_5MG1.mp4","link":null,"date_added":"2023-03-25 13:23:57"}]

class   Data {
  Data({
    String? id,
    String? type,
    String? typeId,
    String? image,
    String? link,
    String? dateAdded,
    List<Data>? data,}){
    _id = id;
    _type = type;
    _typeId = typeId;
    _image = image;
    _link = link;
    _dateAdded = dateAdded;
    _data = data;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _typeId = json['type_id'];
    _image = json['image'];
    _link = json['link'];
    _dateAdded = json['date_added'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _id;
  String? _type;
  String? _typeId;
  String? _image;
  String? _link;
  String? _dateAdded;
  List<Data>? _data;
  Data copyWith({  String? id,
    String? type,
    String? typeId,
    String? image,
    String? link,
    String? dateAdded,
    List<Data>? data,
  }) => Data(  id: id ?? _id,
    type: type ?? _type,
    typeId: typeId ?? _typeId,
    image: image ?? _image,
    link: link ?? _link,
    dateAdded: dateAdded ?? _dateAdded,
    data: data ?? _data,
  );
  String? get id => _id;
  String? get type => _type;
  String? get typeId => _typeId;
  String? get image => _image;
  String? get link => _link;
  String? get dateAdded => _dateAdded;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['type_id'] = _typeId;
    map['image'] = _image;
    map['link'] = _link;
    map['date_added'] = _dateAdded;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// type : "link"
/// type_id : "0"
/// image : "uploads/media/2023/download_(58).jpg"
/// link : "https://youtube.com/"
/// date_added : "2023-03-25 13:23:26"
