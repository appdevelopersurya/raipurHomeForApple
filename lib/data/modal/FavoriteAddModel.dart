import 'dart:convert';

/// success : true
/// data : {"user_id":"6","property_id":"5","id":26}

FavoriteAddModel favoriteAddModelFromJson(String str) =>
    FavoriteAddModel.fromJson(json.decode(str));
String favoriteAddModelToJson(FavoriteAddModel data) =>
    json.encode(data.toJson());

class FavoriteAddModel {
  FavoriteAddModel({
    bool? success,
    Data? data,
  }) {
    _success = success;
    _data = data;
  }

  FavoriteAddModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  Data? _data;
  FavoriteAddModel copyWith({
    bool? success,
    Data? data,
  }) =>
      FavoriteAddModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// user_id : "6"
/// property_id : "5"
/// id : 26

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? userId,
    String? propertyId,
    int? id,
  }) {
    _userId = userId;
    _propertyId = propertyId;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _propertyId = json['property_id'];
    _id = json['id'];
  }
  String? _userId;
  String? _propertyId;
  int? _id;
  Data copyWith({
    String? userId,
    String? propertyId,
    int? id,
  }) =>
      Data(
        userId: userId ?? _userId,
        propertyId: propertyId ?? _propertyId,
        id: id ?? _id,
      );
  String? get userId => _userId;
  String? get propertyId => _propertyId;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['property_id'] = _propertyId;
    map['id'] = _id;
    return map;
  }
}
