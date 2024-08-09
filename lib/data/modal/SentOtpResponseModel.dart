import 'dart:convert';

/// success : true
/// data : {"id":5,"request_ip":null,"number":"7999896115","otp":123456,"token":"d5146e1d997dc51c95fba174a50f15b8d47b8a3828c8ce99e1ddd4066c443037","status":"0","date_time":null}
/// message : "Otp Send To Your Number"

SentOtpResponseModel sentOtpResponseModelFromJson(String str) =>
    SentOtpResponseModel.fromJson(json.decode(str));
String sentOtpResponseModelToJson(SentOtpResponseModel data) =>
    json.encode(data.toJson());

class SentOtpResponseModel {
  SentOtpResponseModel({
    bool? success,
    Data? data,
    dynamic message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  SentOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _success;
  Data? _data;
  dynamic _message;
  SentOtpResponseModel copyWith({
    bool? success,
    Data? data,
    dynamic message,
  }) =>
      SentOtpResponseModel(
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

/// id : 5
/// request_ip : null
/// number : "7999896115"
/// otp : 123456
/// token : "d5146e1d997dc51c95fba174a50f15b8d47b8a3828c8ce99e1ddd4066c443037"
/// status : "0"
/// date_time : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    dynamic id,
    dynamic requestIp,
    dynamic number,
    dynamic otp,
    dynamic token,
    dynamic status,
    dynamic dateTime,
  }) {
    _id = id;
    _requestIp = requestIp;
    _number = number;
    _otp = otp;
    _token = token;
    _status = status;
    _dateTime = dateTime;
  }

  Data.fromJson(dynamic json) {
    _id = json['user_id'];
    _requestIp = json['request_ip'];
    _number = json['user_number'];
    _otp = json['otp'];
    _token = json['token'];
    _status = json['status'];
    _dateTime = json['date_time'];
  }
  dynamic _id;
  dynamic _requestIp;
  dynamic _number;
  dynamic _otp;
  dynamic _token;
  dynamic _status;
  dynamic _dateTime;
  Data copyWith({
    dynamic id,
    dynamic requestIp,
    dynamic number,
    dynamic otp,
    dynamic token,
    dynamic status,
    dynamic dateTime,
  }) =>
      Data(
        id: id ?? _id,
        requestIp: requestIp ?? _requestIp,
        number: number ?? _number,
        otp: otp ?? _otp,
        token: token ?? _token,
        status: status ?? _status,
        dateTime: dateTime ?? _dateTime,
      );
  dynamic get id => _id;
  dynamic get requestIp => _requestIp;
  dynamic get number => _number;
  dynamic get otp => _otp;
  dynamic get token => _token;
  dynamic get status => _status;
  dynamic get dateTime => _dateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _id;
    map['request_ip'] = _requestIp;
    map['user_number'] = _number;
    map['otp'] = _otp;
    map['token'] = _token;
    map['status'] = _status;
    map['date_time'] = _dateTime;
    return map;
  }
}
