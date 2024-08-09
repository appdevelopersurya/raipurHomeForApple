import 'dart:convert';

/// success : true
/// data : [{"id":5,"type_id":7,"name":"Office","icon_code":"<i class=\"fa fa-shop\" ></i>","image":null,"status":1,"date_time":null},{"id":6,"type_id":7,"name":"Shop","icon_code":"<i class=\"fa fa-house\" ></i>","image":null,"status":1,"date_time":null},{"id":7,"type_id":7,"name":"Semi commercial","icon_code":"<i class=\"fa fa-building\" aria-hidden=\"true\"></i>","image":null,"status":1,"date_time":null},{"id":8,"type_id":7,"name":"Apartments /flat","icon_code":"<i class=\"fa fa-building\" aria-hidden=\"true\"></i>","image":null,"status":1,"date_time":null},{"id":11,"type_id":7,"name":"Studio","icon_code":"<i class=\"fa fa-building\" aria-hidden=\"true\"></i>","image":null,"status":1,"date_time":null},{"id":12,"type_id":7,"name":"Godown","icon_code":"<i class=\"fa fa-building\" aria-hidden=\"true\"></i>","image":null,"status":1,"date_time":null},{"id":13,"type_id":7,"name":"Penthouse","icon_code":"<i class=\"fa fa-building\" aria-hidden=\"true\"></i>","image":null,"status":1,"date_time":null},{"id":34,"type_id":7,"name":"Plot","icon_code":"fa-address-book-o","image":null,"status":1,"date_time":null}]

PropertySubTypeDataModel propertySubTypeDataModelFromJson(String str) =>
    PropertySubTypeDataModel.fromJson(json.decode(str));
String propertySubTypeDataModelToJson(PropertySubTypeDataModel data) =>
    json.encode(data.toJson());

class PropertySubTypeDataModel {
  PropertySubTypeDataModel({
    bool? success,
    List<Data1>? data,
  }) {
    _success = success;
    _data = data;
  }

  PropertySubTypeDataModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data1.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data1>? _data;
  PropertySubTypeDataModel copyWith({
    bool? success,
    List<Data1>? data,
  }) =>
      PropertySubTypeDataModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  List<Data1>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 5
/// type_id : 7
/// name : "Office"
/// icon_code : "<i class=\"fa fa-shop\" ></i>"
/// image : null
/// status : 1
/// date_time : null

Data1 dataFromJson(String str) => Data1.fromJson(json.decode(str));
String dataToJson(Data1 data) => json.encode(data.toJson());

class Data1 {
  Data1({
    int? id,
    int? typeId,
    String? name,
    String? iconCode,
    dynamic image,
    int? status,
    dynamic dateTime,
  }) {
    _id = id;
    _typeId = typeId;
    _name = name;
    _iconCode = iconCode;
    _image = image;
    _status = status;
    _dateTime = dateTime;
  }

  Data1.fromJson(dynamic json) {
    _id = json['id'];
    _typeId = json['type_id'];
    _name = json['name'];
    _iconCode = json['icon_code'];
    _image = json['image'];
    _status = json['status'];
    _dateTime = json['date_time'];
  }
  int? _id;
  int? _typeId;
  String? _name;
  String? _iconCode;
  dynamic _image;
  int? _status;
  dynamic _dateTime;
  Data1 copyWith({
    int? id,
    int? typeId,
    String? name,
    String? iconCode,
    dynamic image,
    int? status,
    dynamic dateTime,
  }) =>
      Data1(
        id: id ?? _id,
        typeId: typeId ?? _typeId,
        name: name ?? _name,
        iconCode: iconCode ?? _iconCode,
        image: image ?? _image,
        status: status ?? _status,
        dateTime: dateTime ?? _dateTime,
      );
  int? get id => _id;
  int? get typeId => _typeId;
  String? get name => _name;
  String? get iconCode => _iconCode;
  dynamic get image => _image;
  int? get status => _status;
  dynamic get dateTime => _dateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type_id'] = _typeId;
    map['name'] = _name;
    map['icon_code'] = _iconCode;
    map['image'] = _image;
    map['status'] = _status;
    map['date_time'] = _dateTime;
    return map;
  }
}
