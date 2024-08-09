import 'dart:convert';

/// success : true
/// data : [{"id":1,"name":"SHANKAR NAGAR","icon_code":null,"image":"uploads/town/5301716121985.png","status":"1","date_time":null,"properties_count":"6"},{"id":2,"name":"TELIBANDHA","icon_code":null,"image":"uploads/town/14931716122011.png","status":"1","date_time":null,"properties_count":"0"},{"id":3,"name":"MOWA-SADDU","icon_code":null,"image":"uploads/town/79861716122029.png","status":"1","date_time":null,"properties_count":"1"},{"id":4,"name":"NAYA RAIPUR","icon_code":null,"image":"uploads/town/90271716122048.png","status":"1","date_time":null,"properties_count":"2"},{"id":5,"name":"BHATAGOAN","icon_code":null,"image":"uploads/town/97231716122069.png","status":"1","date_time":null,"properties_count":"4"},{"id":6,"name":"AMLIDIH","icon_code":null,"image":"uploads/town/25411716122097.png","status":"1","date_time":null,"properties_count":"0"},{"id":7,"name":"SANTOSHI NAGAR","icon_code":null,"image":"uploads/town/93431716122118.png","status":"1","date_time":null,"properties_count":"0"},{"id":8,"name":"DDU NAGAR","icon_code":null,"image":"uploads/town/41671715601663.png","status":"1","date_time":null,"properties_count":"2"},{"id":9,"name":"GUDHYARI","icon_code":null,"image":"uploads/town/94101716122327.png","status":"1","date_time":null,"properties_count":"0"},{"id":10,"name":"TATIBANDH","icon_code":null,"image":"uploads/town/65981716122419.png","status":"1","date_time":null,"properties_count":"1"}]

TrendingAreaModel trendingAreaModelFromJson(String str) =>
    TrendingAreaModel.fromJson(json.decode(str));
String trendingAreaModelToJson(TrendingAreaModel data) =>
    json.encode(data.toJson());

class TrendingAreaModel {
  TrendingAreaModel({
    dynamic success,
    List<Data>? data,
  }) {
    _success = success;
    _data = data;
  }

  TrendingAreaModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  dynamic _success;
  List<Data>? _data;
  TrendingAreaModel copyWith({
    dynamic success,
    List<Data>? data,
  }) =>
      TrendingAreaModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  dynamic get success => _success;
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

/// id : 1
/// name : "SHANKAR NAGAR"
/// icon_code : null
/// image : "uploads/town/5301716121985.png"
/// status : "1"
/// date_time : null
/// properties_count : "6"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    int? id,
    dynamic name,
    dynamic iconCode,
    dynamic image,
    dynamic status,
    dynamic dateTime,
    dynamic propertiesCount,
  }) {
    _id = id;
    _name = name;
    _iconCode = iconCode;
    _image = image;
    _status = status;
    _dateTime = dateTime;
    _propertiesCount = propertiesCount;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _iconCode = json['icon_code'];
    _image = json['image'];
    _status = json['status'];
    _dateTime = json['date_time'];
    _propertiesCount = json['properties_count'];
  }
  int? _id;
  dynamic _name;
  dynamic _iconCode;
  dynamic _image;
  dynamic _status;
  dynamic _dateTime;
  dynamic _propertiesCount;
  Data copyWith({
    int? id,
    dynamic name,
    dynamic iconCode,
    dynamic image,
    dynamic status,
    dynamic dateTime,
    dynamic propertiesCount,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        iconCode: iconCode ?? _iconCode,
        image: image ?? _image,
        status: status ?? _status,
        dateTime: dateTime ?? _dateTime,
        propertiesCount: propertiesCount ?? _propertiesCount,
      );
  int? get id => _id;
  dynamic get name => _name;
  dynamic get iconCode => _iconCode;
  dynamic get image => _image;
  dynamic get status => _status;
  dynamic get dateTime => _dateTime;
  dynamic get propertiesCount => _propertiesCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon_code'] = _iconCode;
    map['image'] = _image;
    map['status'] = _status;
    map['date_time'] = _dateTime;
    map['properties_count'] = _propertiesCount;
    return map;
  }
}
