import 'dart:convert';

/// success : true
/// data : [{"id":"23","user_id":"6","title":"stsyys","description":"wysyys","categories":"For Rent","address":"whehe","property_image":"uploads/Property/6/1716646934.jpg","property_type":"house","type":"Agriculture"},{"id":"22","user_id":"6","title":"stsyys","description":"wysyys","categories":"For Rent","address":"whehe","property_image":"uploads/Property/6/1716646625.jpg","property_type":"Semi commercial","type":"Residential"}]

UserPropertyDataModel userPropertyDataModelFromJson(String str) =>
    UserPropertyDataModel.fromJson(json.decode(str));
String userPropertyDataModelToJson(UserPropertyDataModel data) =>
    json.encode(data.toJson());

class UserPropertyDataModel {
  UserPropertyDataModel({
    bool? success,
    List<Data>? data,
  }) {
    _success = success;
    _data = data;
  }

  UserPropertyDataModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data>? _data;
  UserPropertyDataModel copyWith({
    bool? success,
    List<Data>? data,
  }) =>
      UserPropertyDataModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "23"
/// user_id : "6"
/// title : "stsyys"
/// description : "wysyys"
/// categories : "For Rent"
/// address : "whehe"
/// property_image : "uploads/Property/6/1716646934.jpg"
/// property_type : "house"
/// type : "Agriculture"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    dynamic id,
    dynamic userId,
    dynamic title,
    dynamic description,
    dynamic categories,
    dynamic address,
    dynamic propertyImage,
    dynamic propertyType,
    dynamic type,
  }) {
    _id = id;
    _userId = userId;
    _title = title;
    _description = description;
    _categories = categories;
    _address = address;
    _propertyImage = propertyImage;
    _propertyType = propertyType;
    _type = type;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _title = json['title'];
    _description = json['description'];
    _categories = json['categories'];
    _address = json['address'];
    _propertyImage = json['property_image'];
    _propertyType = json['property_type'];
    _type = json['type'];
  }
  dynamic _id;
  dynamic _userId;
  dynamic _title;
  dynamic _description;
  dynamic _categories;
  dynamic _address;
  dynamic _propertyImage;
  dynamic _propertyType;
  dynamic _type;
  Data copyWith({
    dynamic id,
    dynamic userId,
    dynamic title,
    dynamic description,
    dynamic categories,
    dynamic address,
    dynamic propertyImage,
    dynamic propertyType,
    dynamic type,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        title: title ?? _title,
        description: description ?? _description,
        categories: categories ?? _categories,
        address: address ?? _address,
        propertyImage: propertyImage ?? _propertyImage,
        propertyType: propertyType ?? _propertyType,
        type: type ?? _type,
      );
  dynamic get id => _id;
  dynamic get userId => _userId;
  dynamic get title => _title;
  dynamic get description => _description;
  dynamic get categories => _categories;
  dynamic get address => _address;
  dynamic get propertyImage => _propertyImage;
  dynamic get propertyType => _propertyType;
  dynamic get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['title'] = _title;
    map['description'] = _description;
    map['categories'] = _categories;
    map['address'] = _address;
    map['property_image'] = _propertyImage;
    map['property_type'] = _propertyType;
    map['type'] = _type;
    return map;
  }
}
