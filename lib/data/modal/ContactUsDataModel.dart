import 'dart:convert';

/// success : true
/// data : {"Admin_email":"admin@gmail.com","Admin_number":" 9844444497","number_2":"9099999943","number_3":" 9099999934","admin_whatsapp_number":"2135468790"}

ContactUsDataModel contactUsDataModelFromJson(String str) =>
    ContactUsDataModel.fromJson(json.decode(str));

String contactUsDataModelToJson(ContactUsDataModel data) =>
    json.encode(data.toJson());

class ContactUsDataModel {
  ContactUsDataModel({
    bool? success,
    Data? data,
  }) {
    _success = success;
    _data = data;
  }

  ContactUsDataModel.fromJson(dynamic json) {
    _success = json['success'];

    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;

  Data? _data;

  ContactUsDataModel copyWith({
    bool? success,
    Data? data,
  }) =>
      ContactUsDataModel(
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

/// Admin_email : "admin@gmail.com"
/// Admin_number : " 9844444497"
/// number_2 : "9099999943"
/// number_3 : " 9099999934"
/// admin_whatsapp_number : "2135468790"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    dynamic adminEmail,
    dynamic adminNumber,
    dynamic number2,
    dynamic number3,
    dynamic enquiryNumber,
    dynamic adminWhatsappNumber,
    dynamic videoLink,
    dynamic instagramID,
    dynamic fbID,
    dynamic ytChannelID,
    dynamic pdfLink,
    dynamic address,
  }) {
    _adminEmail = adminEmail;
    _adminNumber = adminNumber;
    _number2 = number2;
    _number3 = number3;
    _enquiryNumber = enquiryNumber;
    _adminWhatsappNumber = adminWhatsappNumber;
    _videoLink = videoLink;
    _instagramID = instagramID;
    _fbID = fbID;
    _ytChannelID = ytChannelID;
    _pdfLink = pdfLink;
    _address = address;
  }

  Data.fromJson(dynamic json) {
    _adminEmail = json['Admin_email'];
    _adminNumber = json['Admin_number'];
    _number2 = json['number_2'];
    _number3 = json['number_3'];
    _enquiryNumber = json['enquery_number'];
    _adminWhatsappNumber = json['admin_whatsapp_number'];
    _videoLink = json['youtube_video_link'];
    _instagramID = json['insta_id_link'];
    _fbID = json['fb_id_link'];
    _ytChannelID = json['youtube_id_link'];
    _pdfLink = json['rpr_catalogue_link'];
    _address = json['company_address'];
  }

  dynamic _adminEmail;
  dynamic _adminNumber;
  dynamic _number2;
  dynamic _number3;
  dynamic _enquiryNumber;
  dynamic _adminWhatsappNumber;
  dynamic _videoLink;
  dynamic _instagramID;
  dynamic _fbID;
  dynamic _ytChannelID;
  dynamic _pdfLink;
  dynamic _address;

  Data copyWith({
    dynamic adminEmail,
    dynamic adminNumber,
    dynamic number2,
    dynamic number3,
    dynamic enquiryNumber,
    dynamic adminWhatsappNumber,
    dynamic videoLink,
    dynamic instagramID,
    dynamic fbID,
    dynamic ytChannelID,
    dynamic pdfLink,
    dynamic address,
  }) =>
      Data(
        adminEmail: adminEmail ?? _adminEmail,
        adminNumber: adminNumber ?? _adminNumber,
        number2: number2 ?? _number2,
        number3: number3 ?? _number3,
        enquiryNumber: enquiryNumber ?? _enquiryNumber,
        adminWhatsappNumber: adminWhatsappNumber ?? _adminWhatsappNumber,
        videoLink: videoLink ?? _videoLink,
        instagramID: instagramID ?? _instagramID,
        fbID: fbID ?? _fbID,
        ytChannelID: ytChannelID ?? _ytChannelID,
        pdfLink: pdfLink ?? _pdfLink,
        address: address ?? _address,
      );

  dynamic get adminEmail => _adminEmail;

  dynamic get adminNumber => _adminNumber;

  dynamic get number2 => _number2;

  dynamic get number3 => _number3;

  dynamic get enquiryNumber => _enquiryNumber;

  dynamic get adminWhatsappNumber => _adminWhatsappNumber;

  dynamic get videoLink => _videoLink;

  dynamic get instagramID => _instagramID;

  dynamic get fbID => _fbID;

  dynamic get ytChannelID => _ytChannelID;

  dynamic get pdfLink => _pdfLink;

  dynamic get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Admin_email'] = _adminEmail;
    map['Admin_number'] = _adminNumber;
    map['number_2'] = _number2;
    map['number_3'] = _number3;
    map['enquery_number'] = _enquiryNumber;
    map['admin_whatsapp_number'] = _adminWhatsappNumber;
    map['youtube_video_link'] = _videoLink;
    map['insta_id_link'] = _instagramID;
    map['fb_id_link'] = _fbID;
    map['youtube_id_link'] = _ytChannelID;
    map['rpr_catalogue_link'] = _pdfLink;
    map['company_address'] = _address;
    return map;
  }
}
