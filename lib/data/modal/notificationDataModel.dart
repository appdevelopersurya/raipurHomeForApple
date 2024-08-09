/// status : false
/// message : "No Notificatino Data Here."
/// data : [{"id":1,"title":"demo","descriptions":"descriptionDemo","created_at":"demoTime"}]

class NotificationDataModel {
  NotificationDataModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  NotificationDataModel.fromJson(dynamic json) {
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

  NotificationDataModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      NotificationDataModel(
        status: status ?? _status,
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

/// id : 1
/// title : "demo"
/// descriptions : "descriptionDemo"
/// created_at : "demoTime"

class Data {
  Data({
    dynamic id,
    String? title,
    String? descriptions,
    String? createdAt,
  }) {
    _id = id;
    _title = title;
    _descriptions = descriptions;
    _createdAt = createdAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _descriptions = json['descriptions'];
    _createdAt = json['created_at'];
  }

  dynamic _id;
  String? _title;
  String? _descriptions;
  String? _createdAt;

  Data copyWith({
    dynamic id,
    String? title,
    String? descriptions,
    String? createdAt,
  }) =>
      Data(
        id: id ?? _id,
        title: title ?? _title,
        descriptions: descriptions ?? _descriptions,
        createdAt: createdAt ?? _createdAt,
      );

  dynamic get id => _id;

  String? get title => _title;

  String? get descriptions => _descriptions;

  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['descriptions'] = _descriptions;
    map['created_at'] = _createdAt;
    return map;
  }
}
