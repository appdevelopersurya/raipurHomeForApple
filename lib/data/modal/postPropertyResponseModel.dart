import 'dart:convert';

/// success : true
/// data : {"user_id":"5","title":"new house","description":"HOUSE","categories":"Rent","property_type":"house","type":"Residential","address":"new raipur side","status":0,"date_time":"2024-05-25T11:39:45.636926Z","id":11}
/// message : "Submited Successfully"

PostPropertyResponseModel postPropertyResponseModelFromJson(String str) =>
    PostPropertyResponseModel.fromJson(json.decode(str));
String postPropertyResponseModelToJson(PostPropertyResponseModel data) =>
    json.encode(data.toJson());

class PostPropertyResponseModel {
  PostPropertyResponseModel({
    bool? success,
    Data? data,
    dynamic message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  PostPropertyResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _success;
  Data? _data;
  dynamic _message;
  PostPropertyResponseModel copyWith({
    bool? success,
    Data? data,
    dynamic message,
  }) =>
      PostPropertyResponseModel(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );
  bool? get success => _success;
  Data? get data => _data;
  dynamic get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }
}

/// user_id : "5"
/// title : "new house"
/// description : "HOUSE"
/// categories : "Rent"
/// property_type : "house"
/// type : "Residential"
/// address : "new raipur side"
/// status : 0
/// date_time : "2024-05-25T11:39:45.636926Z"
/// id : 11

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    dynamic userId,
    dynamic title,
    dynamic description,
    dynamic categories,
    dynamic propertyType,
    dynamic type,
    dynamic address,
    int? status,
    dynamic dateTime,
    int? id,
  }) {
    _userId = userId;
    _title = title;
    _description = description;
    _categories = categories;
    _propertyType = propertyType;
    _type = type;
    _address = address;
    _status = status;
    _dateTime = dateTime;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _title = json['title'];
    _description = json['description'];
    _categories = json['categories'];
    _propertyType = json['property_type'];
    _type = json['type'];
    _address = json['address'];
    _status = json['status'];
    _dateTime = json['date_time'];
    _id = json['id'];
  }
  dynamic _userId;
  dynamic _title;
  dynamic _description;
  dynamic _categories;
  dynamic _propertyType;
  dynamic _type;
  dynamic _address;
  int? _status;
  dynamic _dateTime;
  int? _id;
  Data copyWith({
    dynamic userId,
    dynamic title,
    dynamic description,
    dynamic categories,
    dynamic propertyType,
    dynamic type,
    dynamic address,
    int? status,
    dynamic dateTime,
    int? id,
  }) =>
      Data(
        userId: userId ?? _userId,
        title: title ?? _title,
        description: description ?? _description,
        categories: categories ?? _categories,
        propertyType: propertyType ?? _propertyType,
        type: type ?? _type,
        address: address ?? _address,
        status: status ?? _status,
        dateTime: dateTime ?? _dateTime,
        id: id ?? _id,
      );
  dynamic get userId => _userId;
  dynamic get title => _title;
  dynamic get description => _description;
  dynamic get categories => _categories;
  dynamic get propertyType => _propertyType;
  dynamic get type => _type;
  dynamic get address => _address;
  int? get status => _status;
  dynamic get dateTime => _dateTime;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['title'] = _title;
    map['description'] = _description;
    map['categories'] = _categories;
    map['property_type'] = _propertyType;
    map['type'] = _type;
    map['address'] = _address;
    map['status'] = _status;
    map['date_time'] = _dateTime;
    map['id'] = _id;
    return map;
  }
}
