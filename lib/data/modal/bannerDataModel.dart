import 'dart:convert';

/// success : true
/// data : [{"id":7,"slider_img":"uploads/Slider/22871714817961.webp","slider_status":"1","creates_at":"2024-05-04 15:49:21"},{"id":8,"slider_img":"uploads/Slider/98261714817976.webp","slider_status":"1","creates_at":"2024-05-04 15:49:36"}]

BannerDataModel bannerDataModelFromJson(String str) =>
    BannerDataModel.fromJson(json.decode(str));

String bannerDataModelToJson(BannerDataModel data) =>
    json.encode(data.toJson());

class BannerDataModel {
  BannerDataModel({
    bool? success,
    List<Data>? data,
    List<ExploreCategory>? exploreCategory,
  }) {
    _success = success;
    _data = data;
    _exploreCategory = exploreCategory;
  }

  BannerDataModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['explore_category'] != null) {
      _exploreCategory = [];
      json['explore_category'].forEach((v) {
        _exploreCategory?.add(ExploreCategory.fromJson(v));
      });
    }
  }

  bool? _success;
  List<Data>? _data;
  List<ExploreCategory>? _exploreCategory;

  BannerDataModel copyWith({
    bool? success,
    List<Data>? data,
    List<ExploreCategory>? exploreCategory,
  }) =>
      BannerDataModel(
        success: success ?? _success,
        data: data ?? _data,
        exploreCategory: exploreCategory ?? _exploreCategory,
      );

  bool? get success => _success;

  List<Data>? get data => _data;

  List<ExploreCategory>? get exploreCategory => _exploreCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_exploreCategory != null) {
      map['explore_category'] =
          _exploreCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 7
/// slider_img : "uploads/Slider/22871714817961.webp"
/// slider_status : "1"
/// creates_at : "2024-05-04 15:49:21"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    int? id,
    dynamic sliderImg,
    dynamic sliderStatus,
    dynamic createsAt,
    dynamic url,
  }) {
    _id = id;
    _sliderImg = sliderImg;
    _sliderStatus = sliderStatus;
    _createsAt = createsAt;
    _url = url;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _sliderImg = json['slider_img'];
    _sliderStatus = json['slider_status'];
    _createsAt = json['creates_at'];
    _url = json['url'];
  }

  int? _id;
  dynamic _sliderImg;
  dynamic _sliderStatus;
  dynamic _createsAt;
  dynamic _url;

  Data copyWith({
    int? id,
    dynamic sliderImg,
    dynamic sliderStatus,
    dynamic createsAt,
    dynamic url,
  }) =>
      Data(
        id: id ?? _id,
        sliderImg: sliderImg ?? _sliderImg,
        sliderStatus: sliderStatus ?? _sliderStatus,
        createsAt: createsAt ?? _createsAt,
        url: url ?? _url,
      );

  int? get id => _id;

  dynamic get sliderImg => _sliderImg;

  dynamic get sliderStatus => _sliderStatus;

  dynamic get createsAt => _createsAt;

  dynamic get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['slider_img'] = _sliderImg;
    map['slider_status'] = _sliderStatus;
    map['creates_at'] = _createsAt;
    map['url'] = _url;
    return map;
  }
}

/// id : 6
/// name : "Residential"
/// icon_code : "<i class=\"fa-solid fa-house\" ></i>https://raipurhomes.com/public/house.png"
/// image : "https://raipurhomes.com/public/residentialcat.jpg"
/// status : 1
/// date_time : null
/// properties_count : 295

class ExploreCategory {
  ExploreCategory({
    dynamic? id,
    String? name,
    String? iconCode,
    String? image,
    dynamic? status,
    dynamic dateTime,
    dynamic? propertiesCount,
  }) {
    _id = id;
    _name = name;
    _iconCode = iconCode;
    _image = image;
    _status = status;
    _dateTime = dateTime;
    _propertiesCount = propertiesCount;
  }

  ExploreCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _iconCode = json['icon_code'];
    _image = json['image'];
    _status = json['status'];
    _dateTime = json['date_time'];
    _propertiesCount = json['properties_count'];
  }

  dynamic? _id;
  String? _name;
  String? _iconCode;
  String? _image;
  dynamic? _status;
  dynamic _dateTime;
  dynamic? _propertiesCount;

  ExploreCategory copyWith({
    dynamic? id,
    String? name,
    String? iconCode,
    String? image,
    dynamic? status,
    dynamic dateTime,
    dynamic? propertiesCount,
  }) =>
      ExploreCategory(
        id: id ?? _id,
        name: name ?? _name,
        iconCode: iconCode ?? _iconCode,
        image: image ?? _image,
        status: status ?? _status,
        dateTime: dateTime ?? _dateTime,
        propertiesCount: propertiesCount ?? _propertiesCount,
      );

  dynamic? get id => _id;

  String? get name => _name;

  String? get iconCode => _iconCode;

  String? get image => _image;

  dynamic? get status => _status;

  dynamic get dateTime => _dateTime;

  dynamic? get propertiesCount => _propertiesCount;

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
