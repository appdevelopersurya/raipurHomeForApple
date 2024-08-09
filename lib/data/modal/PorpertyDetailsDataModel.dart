import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fmraipuromes/data/modal/AllPropertyModel.dart';

/// success : true
/// data : {"service_id":1,"title":"2 BHK HOUSE RESALE IN KACHNA SHANKAR NAGAR","frontdepth":null,"cyear":null,"floortype":"0","balconytype":"0","connectivity":null,"propertyownername":null,"othercondition":null,"residenttype":null,"title_slug":"2-bhk-house-resale-in-kachna-shankar-nagar","business_type":null,"business_name":null,"review_percent":"0","review_count":"0","visit_count":"56","short_desc":null,"colony":null,"town":"1","km_upto":"4","jio_location":"Shankar Nagar, Raipur, Chhattisgarh, India","latitude":"21.2510977","longitude":"81.6675975","propertyface":null,"roadsize":"10 FT","roadtype":"RAW","openside":"Single","name":null,"flattype":"2 BHK","bathroom":"1 Bathroom","room":"2 Room","constructionstatus":"Resale","postedby":null,"propertyinterior":"Un-Furnished","ameneties":[],"video_link":null,"txt_pass":null,"number":null,"feature_image":"uploads/Property/80691715247870.jpeg","memebership_started":"2024-06-05","address":"MODI NAGAR, NIKITA GAS GODOWN NEAR PIRDA KACHNA","state":null,"city":null,"type":"6","property_type":"9","builder_id":"1","size":"1000","construction_size":"1000 SQFT","Kyc_bank_ifsc_code":null,"images_1":null,"feature":"[]","images_3":null,"images_4":null,"images_5":null,"selected_categories":"5","selected_new_cat":null,"selected_certificate":null,"selected_specialist":null,"experience":null,"store_location":null,"gif_path":null,"video_path":null,"office_timings":null,"pricing":"3000000","pricetype":"Full Price","offer_price":"0","discount":null,"couple_discount":"0","family_discount":"0","is_review":"0","Kyc_Activation_status":"P","status":"1","feature_status":"0","verified_status":"0","sunday_Status":"0","profilt_status":"0","top_town_status":"0","user_suspended_status":"0","del_status":"0","otp":null,"last_login_ip":null,"last_login":null,"date_time":"2024-05-09 15:14:30","getapiimages":[{"property_id":"1","file_path":"uploads/Images/12201715247891.jpeg"},{"property_id":"1","file_path":"uploads/Images/55061715247900.jpeg"}],"getapi_categories":{"categories_id":5,"categories_name":"Sell"},"getapi_property_type":{"id":9,"name":"house"}}
/// suggestionProperty : [{"service_id":1,"title":"2 BHK HOUSE RESALE IN KACHNA SHANKAR NAGAR","frontdepth":null,"cyear":null,"floortype":"0","balconytype":"0","connectivity":null,"propertyownername":null,"othercondition":null,"residenttype":null,"title_slug":"2-bhk-house-resale-in-kachna-shankar-nagar","business_type":null,"business_name":null,"review_percent":"0","review_count":"0","visit_count":"56","short_desc":null,"colony":null,"town":"1","km_upto":"4","jio_location":"Shankar Nagar, Raipur, Chhattisgarh, India","latitude":"21.2510977","longitude":"81.6675975","propertyface":null,"roadsize":"10 FT","roadtype":"RAW","openside":"Single","name":null,"flattype":"2 BHK","bathroom":"1 Bathroom","room":"2 Room","constructionstatus":"Resale","postedby":null,"propertyinterior":"Un-Furnished","ameneties":"[]","video_link":null,"txt_pass":null,"number":null,"feature_image":"uploads/Property/80691715247870.jpeg","memebership_started":"2024-06-05","address":"MODI NAGAR, NIKITA GAS GODOWN NEAR PIRDA KACHNA","state":null,"city":null,"type":"6","property_type":"9","builder_id":"1","size":"1000","construction_size":"1000 SQFT","Kyc_bank_ifsc_code":null,"images_1":null,"feature":"[]","images_3":null,"images_4":null,"images_5":null,"selected_categories":"5","selected_new_cat":null,"selected_certificate":null,"selected_specialist":null,"experience":null,"store_location":null,"gif_path":null,"video_path":null,"office_timings":null,"pricing":"3000000","pricetype":"Full Price","offer_price":"0","discount":null,"couple_discount":"0","family_discount":"0","is_review":"0","Kyc_Activation_status":"P","status":"1","feature_status":"0","verified_status":"0","sunday_Status":"0","profilt_status":"0","top_town_status":"0","user_suspended_status":"0","del_status":"0","otp":null,"last_login_ip":null,"last_login":null,"date_time":"2024-05-09 15:14:30","getapiimages":[{"property_id":"1","file_path":"uploads/Images/12201715247891.jpeg"},{"property_id":"1","file_path":"uploads/Images/55061715247900.jpeg"}],"getapi_categories":{"categories_id":5,"categories_name":"Sell"},"getapi_property_type":{"id":9,"name":"house"},"getproperty_sub_type":{"id":6,"name":"Residential"}},{"service_id":5,"title":"COMMERCIAL SHOP AVAILABLE IN LALGANGA SHOPPING MALL","frontdepth":null,"cyear":null,"floortype":"0","balconytype":"0","connectivity":null,"propertyownername":null,"othercondition":null,"residenttype":null,"title_slug":"commercial-shop-available-in-lalganga-shopping-mall","business_type":null,"business_name":null,"review_percent":"0","review_count":"0","visit_count":"50","short_desc":null,"colony":null,"town":"1","km_upto":"4","jio_location":"Shankar Nagar, Raipur, Chhattisgarh, India","latitude":"21.2510977","longitude":"81.6675975","propertyface":null,"roadsize":"30","roadtype":"DAMAR","openside":"Single","name":null,"flattype":"0 BHK","bathroom":"0 Bathroom","room":"0","constructionstatus":"Resale","postedby":null,"propertyinterior":"Semi-Furnished","ameneties":"[]","video_link":null,"txt_pass":null,"number":null,"feature_image":"uploads/Property/50181715251176.jpeg","memebership_started":"2024-06-05","address":"JAI STHAMBH CHOWK","state":null,"city":null,"type":"7","property_type":"6","builder_id":"1","size":"370","construction_size":"270","Kyc_bank_ifsc_code":null,"images_1":null,"feature":"[]","images_3":null,"images_4":null,"images_5":null,"selected_categories":"5","selected_new_cat":null,"selected_certificate":null,"selected_specialist":null,"experience":null,"store_location":null,"gif_path":null,"video_path":null,"office_timings":null,"pricing":"3900000","pricetype":"Full Price","offer_price":"0","discount":null,"couple_discount":"0","family_discount":"0","is_review":"0","Kyc_Activation_status":"P","status":"1","feature_status":"1","verified_status":"0","sunday_Status":"0","profilt_status":"0","top_town_status":"0","user_suspended_status":"0","del_status":"0","otp":null,"last_login_ip":null,"last_login":null,"date_time":"2024-05-09 16:09:36","getapiimages":[],"getapi_categories":{"categories_id":5,"categories_name":"Sell"},"getapi_property_type":{"id":6,"name":"Shop"},"getproperty_sub_type":{"id":7,"name":"Commercial"}},{"service_id":158,"title":"3 BHK HOUSE AVAILABLE IN SHANKAR NAGAR","frontdepth":null,"cyear":null,"floortype":"0","balconytype":"0","connectivity":null,"propertyownername":null,"othercondition":null,"residenttype":null,"title_slug":"3-bhk-house-available-in-shankar-nagar","business_type":null,"business_name":null,"review_percent":"0","review_count":"0","visit_count":"6","short_desc":"SFSSGDGDG","colony":null,"town":"1","km_upto":"4","jio_location":"Shankar Nagar, Raipur, Chhattisgarh, India","latitude":"21.2510977","longitude":"81.6675975","propertyface":null,"roadsize":"25","roadtype":"RCC","openside":"Single","name":null,"flattype":"3 BHK","bathroom":"3 Bathroom","room":"3 Room","constructionstatus":"Resale","postedby":null,"propertyinterior":"Furnished","ameneties":"[]","video_link":null,"txt_pass":null,"number":null,"feature_image":"uploads/Property/72111716884843.jpeg","memebership_started":"2024-06-06","address":"SHANKAR NAGAR, RAIPUR","state":null,"city":null,"type":"6","property_type":"9","builder_id":"1","size":"2345","construction_size":"23456","Kyc_bank_ifsc_code":null,"images_1":null,"feature":"[]","images_3":null,"images_4":null,"images_5":null,"selected_categories":"5","selected_new_cat":null,"selected_certificate":null,"selected_specialist":null,"experience":null,"store_location":null,"gif_path":null,"video_path":null,"office_timings":null,"pricing":"4500000","pricetype":"Full Price","offer_price":"0","discount":null,"couple_discount":"0","family_discount":"0","is_review":"0","Kyc_Activation_status":"P","status":"1","feature_status":"1","verified_status":"0","sunday_Status":"0","profilt_status":"0","top_town_status":"0","user_suspended_status":"0","del_status":"0","otp":null,"last_login_ip":null,"last_login":null,"date_time":"2024-05-28 13:57:23","getapiimages":[{"property_id":"158","file_path":"public/Images/17306655957c8c4241716884860.jpeg"},{"property_id":"158","file_path":"public/Images/4816655957cd3fd51716884860.jpeg"},{"property_id":"158","file_path":"public/Images/33146655957d35c561716884861.jpeg"},{"property_id":"158","file_path":"public/Images/19626655957d943961716884861.jpeg"},{"property_id":"158","file_path":"public/Images/76616655957e014021716884862.jpeg"}],"getapi_categories":{"categories_id":5,"categories_name":"Sell"},"getapi_property_type":{"id":9,"name":"house"},"getproperty_sub_type":{"id":6,"name":"Residential"}},{"service_id":160,"title":"2 bhk house shankar nagar","frontdepth":null,"cyear":null,"floortype":"0","balconytype":"0","connectivity":null,"propertyownername":null,"othercondition":null,"residenttype":null,"title_slug":"2-bhk-house-shankar-nagar","business_type":null,"business_name":null,"review_percent":"0","review_count":"0","visit_count":"6","short_desc":null,"colony":null,"town":"1","km_upto":"4","jio_location":"Shankar Nagar, Raipur, Chhattisgarh, India","latitude":"21.2510977","longitude":"81.6675975","propertyface":null,"roadsize":"25","roadtype":"RAW","openside":"Single","name":null,"flattype":"2 BHK","bathroom":"2 Bathroom","room":"2 Room","constructionstatus":"New","postedby":null,"propertyinterior":"Un-Furnished","ameneties":"[]","video_link":null,"txt_pass":null,"number":null,"feature_image":"uploads/Property/52031717485345.jpeg","memebership_started":"2024-06-06","address":"SHANKAR NAGAR","state":null,"city":null,"type":"6","property_type":"9","builder_id":"1","size":"2344","construction_size":"3456","Kyc_bank_ifsc_code":null,"images_1":null,"feature":"[]","images_3":null,"images_4":null,"images_5":null,"selected_categories":"5","selected_new_cat":null,"selected_certificate":null,"selected_specialist":null,"experience":null,"store_location":null,"gif_path":null,"video_path":null,"office_timings":null,"pricing":"4500000","pricetype":"Monthly Price","offer_price":"0","discount":null,"couple_discount":"0","family_discount":"0","is_review":"0","Kyc_Activation_status":"P","status":"1","feature_status":"1","verified_status":"0","sunday_Status":"0","profilt_status":"0","top_town_status":"0","user_suspended_status":"0","del_status":"0","otp":null,"last_login_ip":null,"last_login":null,"date_time":"2024-06-04 12:45:45","getapiimages":[{"property_id":"160","file_path":"public/Images/9823665ebf3ab2c7e1717485370.jpeg"},{"property_id":"160","file_path":"public/Images/8897665ebf3ab4c061717485370.jpeg"},{"property_id":"160","file_path":"public/Images/4442665ebf3ab4e9f1717485370.jpeg"},{"property_id":"160","file_path":"public/Images/3601665ebf3ab50a91717485370.jpeg"},{"property_id":"160","file_path":"public/Images/1795665ebf3ab52a41717485370.jpeg"}],"getapi_categories":{"categories_id":5,"categories_name":"Sell"},"getapi_property_type":{"id":9,"name":"house"},"getproperty_sub_type":{"id":6,"name":"Residential"}}]
/// adminNumber : "7889456123"
/// adminWhatsappNumber : "7889456123"

PorpertyDetailsDataModel porpertyDetailsDataModelFromJson(String str) =>
    PorpertyDetailsDataModel.fromJson(json.decode(str));
String porpertyDetailsDataModelToJson(PorpertyDetailsDataModel data) =>
    json.encode(data.toJson());

class PorpertyDetailsDataModel {
  PorpertyDetailsDataModel({
    bool? success,
    Data? data,
    List<SuggestionProperty>? suggestionProperty,
    dynamic adminNumber,
    dynamic adminWhatsappNumber,
    AdminDetails? adminDetails,
  }) {
    _success = success;
    _data = data;
    _suggestionProperty = suggestionProperty;
    _adminNumber = adminNumber;
    _adminWhatsappNumber = adminWhatsappNumber;
    _adminDetails = adminDetails;
  }

  PorpertyDetailsDataModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['suggestionProperty'] != null) {
      _suggestionProperty = [];
      json['suggestionProperty'].forEach((v) {
        _suggestionProperty?.add(SuggestionProperty.fromJson(v));
      });
    }
    _adminDetails = json['admin_details'] != null
        ? AdminDetails.fromJson(json['admin_details'])
        : null;
    _adminNumber = json['adminNumber'];
    _adminWhatsappNumber = json['adminWhatsappNumber'];
  }
  bool? _success;
  Data? _data;
  List<SuggestionProperty>? _suggestionProperty;
  dynamic _adminNumber;
  dynamic _adminWhatsappNumber;
  AdminDetails? _adminDetails;
  PorpertyDetailsDataModel copyWith({
    bool? success,
    Data? data,
    List<SuggestionProperty>? suggestionProperty,
    dynamic adminNumber,
    dynamic adminWhatsappNumber,
    AdminDetails? adminDetails,
  }) =>
      PorpertyDetailsDataModel(
        success: success ?? _success,
        data: data ?? _data,
        suggestionProperty: suggestionProperty ?? _suggestionProperty,
        adminNumber: adminNumber ?? _adminNumber,
        adminWhatsappNumber: adminWhatsappNumber ?? _adminWhatsappNumber,
        adminDetails: adminDetails ?? _adminDetails,
      );
  bool? get success => _success;
  Data? get data => _data;
  List<SuggestionProperty>? get suggestionProperty => _suggestionProperty;
  dynamic get adminNumber => _adminNumber;
  dynamic get adminWhatsappNumber => _adminWhatsappNumber;
  AdminDetails? get adminDetails => _adminDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_suggestionProperty != null) {
      map['suggestionProperty'] =
          _suggestionProperty?.map((v) => v.toJson()).toList();
    }
    map['adminNumber'] = _adminNumber;
    map['adminWhatsappNumber'] = _adminWhatsappNumber;
    if (_adminDetails != null) {
      map['admin_details'] = _adminDetails?.toJson();
    }
    return map;
  }
}

/// service_id : 1
/// title : "2 BHK HOUSE RESALE IN KACHNA SHANKAR NAGAR"
/// frontdepth : null
/// cyear : null
/// floortype : "0"
/// balconytype : "0"
/// connectivity : null
/// propertyownername : null
/// othercondition : null
/// residenttype : null
/// title_slug : "2-bhk-house-resale-in-kachna-shankar-nagar"
/// business_type : null
/// business_name : null
/// review_percent : "0"
/// review_count : "0"
/// visit_count : "56"
/// short_desc : null
/// colony : null
/// town : "1"
/// km_upto : "4"
/// jio_location : "Shankar Nagar, Raipur, Chhattisgarh, India"
/// latitude : "21.2510977"
/// longitude : "81.6675975"
/// propertyface : null
/// roadsize : "10 FT"
/// roadtype : "RAW"
/// openside : "Single"
/// name : null
/// flattype : "2 BHK"
/// bathroom : "1 Bathroom"
/// room : "2 Room"
/// constructionstatus : "Resale"
/// postedby : null
/// propertyinterior : "Un-Furnished"
/// ameneties : "[]"
/// video_link : null
/// txt_pass : null
/// number : null
/// feature_image : "uploads/Property/80691715247870.jpeg"
/// memebership_started : "2024-06-05"
/// address : "MODI NAGAR, NIKITA GAS GODOWN NEAR PIRDA KACHNA"
/// state : null
/// city : null
/// type : "6"
/// property_type : "9"
/// builder_id : "1"
/// size : "1000"
/// construction_size : "1000 SQFT"
/// Kyc_bank_ifsc_code : null
/// images_1 : null
/// feature : "[]"
/// images_3 : null
/// images_4 : null
/// images_5 : null
/// selected_categories : "5"
/// selected_new_cat : null
/// selected_certificate : null
/// selected_specialist : null
/// experience : null
/// store_location : null
/// gif_path : null
/// video_path : null
/// office_timings : null
/// pricing : "3000000"
/// pricetype : "Full Price"
/// offer_price : "0"
/// discount : null
/// couple_discount : "0"
/// family_discount : "0"
/// is_review : "0"
/// Kyc_Activation_status : "P"
/// status : "1"
/// feature_status : "0"
/// verified_status : "0"
/// sunday_Status : "0"
/// profilt_status : "0"
/// top_town_status : "0"
/// user_suspended_status : "0"
/// del_status : "0"
/// otp : null
/// last_login_ip : null
/// last_login : null
/// date_time : "2024-05-09 15:14:30"
/// getapiimages : [{"property_id":"1","file_path":"uploads/Images/12201715247891.jpeg"},{"property_id":"1","file_path":"uploads/Images/55061715247900.jpeg"}]
/// getapi_categories : {"categories_id":5,"categories_name":"Sell"}
/// getapi_property_type : {"id":9,"name":"house"}
/// getproperty_sub_type : {"id":6,"name":"Residential"}

SuggestionProperty suggestionPropertyFromJson(String str) =>
    SuggestionProperty.fromJson(json.decode(str));
String suggestionPropertyToJson(SuggestionProperty data) =>
    json.encode(data.toJson());

class SuggestionProperty {
  SuggestionProperty({
    int? serviceId,
    dynamic title,
    dynamic frontdepth,
    dynamic cyear,
    dynamic floortype,
    dynamic balconytype,
    dynamic connectivity,
    dynamic propertyownername,
    dynamic othercondition,
    dynamic residenttype,
    dynamic titleSlug,
    dynamic businessType,
    dynamic businessName,
    dynamic reviewPercent,
    dynamic reviewCount,
    dynamic visitCount,
    dynamic shortDesc,
    dynamic colony,
    dynamic town,
    dynamic kmUpto,
    dynamic jioLocation,
    dynamic latitude,
    dynamic longitude,
    dynamic propertyface,
    dynamic roadsize,
    dynamic roadtype,
    dynamic openside,
    dynamic name,
    dynamic flattype,
    dynamic bathroom,
    dynamic room,
    dynamic constructionstatus,
    dynamic postedby,
    dynamic propertyinterior,
    dynamic ameneties,
    dynamic videoLink,
    dynamic txtPass,
    dynamic number,
    dynamic featureImage,
    dynamic memebershipStarted,
    dynamic address,
    dynamic state,
    dynamic city,
    dynamic type,
    dynamic propertyType,
    dynamic builderId,
    dynamic size,
    dynamic constructionSize,
    dynamic kycBankIfscCode,
    dynamic images1,
    dynamic feature,
    dynamic images3,
    dynamic images4,
    dynamic images5,
    dynamic selectedCategories,
    dynamic selectedNewCat,
    dynamic selectedCertificate,
    dynamic selectedSpecialist,
    dynamic experience,
    dynamic storeLocation,
    dynamic gifPath,
    dynamic videoPath,
    dynamic officeTimings,
    dynamic pricing,
    dynamic pricetype,
    dynamic offerPrice,
    dynamic discount,
    dynamic coupleDiscount,
    dynamic familyDiscount,
    dynamic isReview,
    dynamic kycActivationStatus,
    dynamic status,
    dynamic featureStatus,
    dynamic verifiedStatus,
    dynamic sundayStatus,
    dynamic profiltStatus,
    dynamic topTownStatus,
    dynamic userSuspendedStatus,
    dynamic delStatus,
    dynamic otp,
    dynamic lastLoginIp,
    dynamic lastLogin,
    dynamic dateTime,
    List<Getapiimages>? getapiimages,
    GetapiCategories? getapiCategories,
    GetapiPropertyType? getapiPropertyType,
    GetapiPType? getapiPType,
    GetpropertySubType? getpropertySubType,
  }) {
    _serviceId = serviceId;
    _title = title;
    _frontdepth = frontdepth;
    _cyear = cyear;
    _floortype = floortype;
    _balconytype = balconytype;
    _connectivity = connectivity;
    _propertyownername = propertyownername;
    _othercondition = othercondition;
    _residenttype = residenttype;
    _titleSlug = titleSlug;
    _businessType = businessType;
    _businessName = businessName;
    _reviewPercent = reviewPercent;
    _reviewCount = reviewCount;
    _visitCount = visitCount;
    _shortDesc = shortDesc;
    _colony = colony;
    _town = town;
    _kmUpto = kmUpto;
    _jioLocation = jioLocation;
    _latitude = latitude;
    _longitude = longitude;
    _propertyface = propertyface;
    _roadsize = roadsize;
    _roadtype = roadtype;
    _openside = openside;
    _name = name;
    _flattype = flattype;
    _bathroom = bathroom;
    _room = room;
    _constructionstatus = constructionstatus;
    _postedby = postedby;
    _propertyinterior = propertyinterior;
    _ameneties = ameneties;
    _videoLink = videoLink;
    _txtPass = txtPass;
    _number = number;
    _featureImage = featureImage;
    _memebershipStarted = memebershipStarted;
    _address = address;
    _state = state;
    _city = city;
    _type = type;
    _propertyType = propertyType;
    _builderId = builderId;
    _size = size;
    _constructionSize = constructionSize;
    _kycBankIfscCode = kycBankIfscCode;
    _images1 = images1;
    _feature = feature;
    _images3 = images3;
    _images4 = images4;
    _images5 = images5;
    _selectedCategories = selectedCategories;
    _selectedNewCat = selectedNewCat;
    _selectedCertificate = selectedCertificate;
    _selectedSpecialist = selectedSpecialist;
    _experience = experience;
    _storeLocation = storeLocation;
    _gifPath = gifPath;
    _videoPath = videoPath;
    _officeTimings = officeTimings;
    _pricing = pricing;
    _pricetype = pricetype;
    _offerPrice = offerPrice;
    _discount = discount;
    _coupleDiscount = coupleDiscount;
    _familyDiscount = familyDiscount;
    _isReview = isReview;
    _kycActivationStatus = kycActivationStatus;
    _status = status;
    _featureStatus = featureStatus;
    _verifiedStatus = verifiedStatus;
    _sundayStatus = sundayStatus;
    _profiltStatus = profiltStatus;
    _topTownStatus = topTownStatus;
    _userSuspendedStatus = userSuspendedStatus;
    _delStatus = delStatus;
    _otp = otp;
    _lastLoginIp = lastLoginIp;
    _lastLogin = lastLogin;
    _dateTime = dateTime;
    _getapiimages = getapiimages;
    _getapiCategories = getapiCategories;
    _getapiPropertyType = getapiPropertyType;
    _getapiPType = getapiPType;
    _getpropertySubType = getpropertySubType;
  }

  SuggestionProperty.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _title = json['title'];
    _frontdepth = json['frontdepth'];
    _cyear = json['cyear'];
    _floortype = json['floortype'];
    _balconytype = json['balconytype'];
    _connectivity = json['connectivity'];
    _propertyownername = json['propertyownername'];
    _othercondition = json['othercondition'];
    _residenttype = json['residenttype'];
    _titleSlug = json['title_slug'];
    _businessType = json['business_type'];
    _businessName = json['business_name'];
    _reviewPercent = json['review_percent'];
    _reviewCount = json['review_count'];
    _visitCount = json['visit_count'];
    _shortDesc = json['short_desc'];
    _colony = json['colony'];
    _town = json['town'];
    _kmUpto = json['km_upto'];
    _jioLocation = json['jio_location'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _propertyface = json['propertyface'];
    _roadsize = json['roadsize'];
    _roadtype = json['roadtype'];
    _openside = json['openside'];
    _name = json['name'];
    _flattype = json['flattype'];
    _bathroom = json['bathroom'];
    _room = json['room'];
    _constructionstatus = json['constructionstatus'];
    _postedby = json['postedby'];
    _propertyinterior = json['propertyinterior'];
    _ameneties = json['ameneties'];
    _videoLink = json['video_link'];
    _txtPass = json['txt_pass'];
    _number = json['number'];
    _featureImage = json['feature_image'];
    _memebershipStarted = json['memebership_started'];
    _address = json['address'];
    _state = json['state'];
    _city = json['city'];
    _type = json['type'];
    _propertyType = json['property_type'];
    _builderId = json['builder_id'];
    _size = json['size'];
    _constructionSize = json['construction_size'];
    _kycBankIfscCode = json['Kyc_bank_ifsc_code'];
    _images1 = json['images_1'];
    _feature = json['feature'];
    _images3 = json['images_3'];
    _images4 = json['images_4'];
    _images5 = json['images_5'];
    _selectedCategories = json['selected_categories'];
    _selectedNewCat = json['selected_new_cat'];
    _selectedCertificate = json['selected_certificate'];
    _selectedSpecialist = json['selected_specialist'];
    _experience = json['experience'];
    _storeLocation = json['store_location'];
    _gifPath = json['gif_path'];
    _videoPath = json['video_path'];
    _officeTimings = json['office_timings'];
    _pricing = json['pricing'];
    _pricetype = json['pricetype'];
    _offerPrice = json['offer_price'];
    _discount = json['discount'];
    _coupleDiscount = json['couple_discount'];
    _familyDiscount = json['family_discount'];
    _isReview = json['is_review'];
    _kycActivationStatus = json['Kyc_Activation_status'];
    _status = json['status'];
    _featureStatus = json['feature_status'];
    _verifiedStatus = json['verified_status'];
    _sundayStatus = json['sunday_Status'];
    _profiltStatus = json['profilt_status'];
    _topTownStatus = json['top_town_status'];
    _userSuspendedStatus = json['user_suspended_status'];
    _delStatus = json['del_status'];
    _otp = json['otp'];
    _lastLoginIp = json['last_login_ip'];
    _lastLogin = json['last_login'];
    _dateTime = json['date_time'];
    if (json['getapiimages'] != null) {
      _getapiimages = [];
      json['getapiimages'].forEach((v) {
        _getapiimages?.add(Getapiimages.fromJson(v));
      });
    }
    _getapiCategories = json['getapi_categories'] != null
        ? GetapiCategories.fromJson(json['getapi_categories'])
        : null;
    _getapiPropertyType = json['getapi_property_type'] != null
        ? GetapiPropertyType.fromJson(json['getapi_property_type'])
        : null;

    _getapiPType = json['get_p_type'] != null
        ? GetapiPType.fromJson(json['get_p_type'])
        : null;

    _getpropertySubType = json['getproperty_sub_type'] != null
        ? GetpropertySubType.fromJson(json['getproperty_sub_type'])
        : null;
  }
  int? _serviceId;
  dynamic _title;
  dynamic _frontdepth;
  dynamic _cyear;
  dynamic _floortype;
  dynamic _balconytype;
  dynamic _connectivity;
  dynamic _propertyownername;
  dynamic _othercondition;
  dynamic _residenttype;
  dynamic _titleSlug;
  dynamic _businessType;
  dynamic _businessName;
  dynamic _reviewPercent;
  dynamic _reviewCount;
  dynamic _visitCount;
  dynamic _shortDesc;
  dynamic _colony;
  dynamic _town;
  dynamic _kmUpto;
  dynamic _jioLocation;
  dynamic _latitude;
  dynamic _longitude;
  dynamic _propertyface;
  dynamic _roadsize;
  dynamic _roadtype;
  dynamic _openside;
  dynamic _name;
  dynamic _flattype;
  dynamic _bathroom;
  dynamic _room;
  dynamic _constructionstatus;
  dynamic _postedby;
  dynamic _propertyinterior;
  dynamic _ameneties;
  dynamic _videoLink;
  dynamic _txtPass;
  dynamic _number;
  dynamic _featureImage;
  dynamic _memebershipStarted;
  dynamic _address;
  dynamic _state;
  dynamic _city;
  dynamic _type;
  dynamic _propertyType;
  dynamic _builderId;
  dynamic _size;
  dynamic _constructionSize;
  dynamic _kycBankIfscCode;
  dynamic _images1;
  dynamic _feature;
  dynamic _images3;
  dynamic _images4;
  dynamic _images5;
  dynamic _selectedCategories;
  dynamic _selectedNewCat;
  dynamic _selectedCertificate;
  dynamic _selectedSpecialist;
  dynamic _experience;
  dynamic _storeLocation;
  dynamic _gifPath;
  dynamic _videoPath;
  dynamic _officeTimings;
  dynamic _pricing;
  dynamic _pricetype;
  dynamic _offerPrice;
  dynamic _discount;
  dynamic _coupleDiscount;
  dynamic _familyDiscount;
  dynamic _isReview;
  dynamic _kycActivationStatus;
  dynamic _status;
  dynamic _featureStatus;
  dynamic _verifiedStatus;
  dynamic _sundayStatus;
  dynamic _profiltStatus;
  dynamic _topTownStatus;
  dynamic _userSuspendedStatus;
  dynamic _delStatus;
  dynamic _otp;
  dynamic _lastLoginIp;
  dynamic _lastLogin;
  dynamic _dateTime;
  List<Getapiimages>? _getapiimages;
  GetapiCategories? _getapiCategories;
  GetapiPropertyType? _getapiPropertyType;
  GetapiPType? _getapiPType;
  GetpropertySubType? _getpropertySubType;
  SuggestionProperty copyWith({
    int? serviceId,
    dynamic title,
    dynamic frontdepth,
    dynamic cyear,
    dynamic floortype,
    dynamic balconytype,
    dynamic connectivity,
    dynamic propertyownername,
    dynamic othercondition,
    dynamic residenttype,
    dynamic titleSlug,
    dynamic businessType,
    dynamic businessName,
    dynamic reviewPercent,
    dynamic reviewCount,
    dynamic visitCount,
    dynamic shortDesc,
    dynamic colony,
    dynamic town,
    dynamic kmUpto,
    dynamic jioLocation,
    dynamic latitude,
    dynamic longitude,
    dynamic propertyface,
    dynamic roadsize,
    dynamic roadtype,
    dynamic openside,
    dynamic name,
    dynamic flattype,
    dynamic bathroom,
    dynamic room,
    dynamic constructionstatus,
    dynamic postedby,
    dynamic propertyinterior,
    dynamic ameneties,
    dynamic videoLink,
    dynamic txtPass,
    dynamic number,
    dynamic featureImage,
    dynamic memebershipStarted,
    dynamic address,
    dynamic state,
    dynamic city,
    dynamic type,
    dynamic propertyType,
    dynamic builderId,
    dynamic size,
    dynamic constructionSize,
    dynamic kycBankIfscCode,
    dynamic images1,
    dynamic feature,
    dynamic images3,
    dynamic images4,
    dynamic images5,
    dynamic selectedCategories,
    dynamic selectedNewCat,
    dynamic selectedCertificate,
    dynamic selectedSpecialist,
    dynamic experience,
    dynamic storeLocation,
    dynamic gifPath,
    dynamic videoPath,
    dynamic officeTimings,
    dynamic pricing,
    dynamic pricetype,
    dynamic offerPrice,
    dynamic discount,
    dynamic coupleDiscount,
    dynamic familyDiscount,
    dynamic isReview,
    dynamic kycActivationStatus,
    dynamic status,
    dynamic featureStatus,
    dynamic verifiedStatus,
    dynamic sundayStatus,
    dynamic profiltStatus,
    dynamic topTownStatus,
    dynamic userSuspendedStatus,
    dynamic delStatus,
    dynamic otp,
    dynamic lastLoginIp,
    dynamic lastLogin,
    dynamic dateTime,
    List<Getapiimages>? getapiimages,
    GetapiCategories? getapiCategories,
    GetapiPropertyType? getapiPropertyType,
    GetapiPType? getapiPType,
    GetpropertySubType? getpropertySubType,
  }) =>
      SuggestionProperty(
        serviceId: serviceId ?? _serviceId,
        title: title ?? _title,
        frontdepth: frontdepth ?? _frontdepth,
        cyear: cyear ?? _cyear,
        floortype: floortype ?? _floortype,
        balconytype: balconytype ?? _balconytype,
        connectivity: connectivity ?? _connectivity,
        propertyownername: propertyownername ?? _propertyownername,
        othercondition: othercondition ?? _othercondition,
        residenttype: residenttype ?? _residenttype,
        titleSlug: titleSlug ?? _titleSlug,
        businessType: businessType ?? _businessType,
        businessName: businessName ?? _businessName,
        reviewPercent: reviewPercent ?? _reviewPercent,
        reviewCount: reviewCount ?? _reviewCount,
        visitCount: visitCount ?? _visitCount,
        shortDesc: shortDesc ?? _shortDesc,
        colony: colony ?? _colony,
        town: town ?? _town,
        kmUpto: kmUpto ?? _kmUpto,
        jioLocation: jioLocation ?? _jioLocation,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        propertyface: propertyface ?? _propertyface,
        roadsize: roadsize ?? _roadsize,
        roadtype: roadtype ?? _roadtype,
        openside: openside ?? _openside,
        name: name ?? _name,
        flattype: flattype ?? _flattype,
        bathroom: bathroom ?? _bathroom,
        room: room ?? _room,
        constructionstatus: constructionstatus ?? _constructionstatus,
        postedby: postedby ?? _postedby,
        propertyinterior: propertyinterior ?? _propertyinterior,
        ameneties: ameneties ?? _ameneties,
        videoLink: videoLink ?? _videoLink,
        txtPass: txtPass ?? _txtPass,
        number: number ?? _number,
        featureImage: featureImage ?? _featureImage,
        memebershipStarted: memebershipStarted ?? _memebershipStarted,
        address: address ?? _address,
        state: state ?? _state,
        city: city ?? _city,
        type: type ?? _type,
        propertyType: propertyType ?? _propertyType,
        builderId: builderId ?? _builderId,
        size: size ?? _size,
        constructionSize: constructionSize ?? _constructionSize,
        kycBankIfscCode: kycBankIfscCode ?? _kycBankIfscCode,
        images1: images1 ?? _images1,
        feature: feature ?? _feature,
        images3: images3 ?? _images3,
        images4: images4 ?? _images4,
        images5: images5 ?? _images5,
        selectedCategories: selectedCategories ?? _selectedCategories,
        selectedNewCat: selectedNewCat ?? _selectedNewCat,
        selectedCertificate: selectedCertificate ?? _selectedCertificate,
        selectedSpecialist: selectedSpecialist ?? _selectedSpecialist,
        experience: experience ?? _experience,
        storeLocation: storeLocation ?? _storeLocation,
        gifPath: gifPath ?? _gifPath,
        videoPath: videoPath ?? _videoPath,
        officeTimings: officeTimings ?? _officeTimings,
        pricing: pricing ?? _pricing,
        pricetype: pricetype ?? _pricetype,
        offerPrice: offerPrice ?? _offerPrice,
        discount: discount ?? _discount,
        coupleDiscount: coupleDiscount ?? _coupleDiscount,
        familyDiscount: familyDiscount ?? _familyDiscount,
        isReview: isReview ?? _isReview,
        kycActivationStatus: kycActivationStatus ?? _kycActivationStatus,
        status: status ?? _status,
        featureStatus: featureStatus ?? _featureStatus,
        verifiedStatus: verifiedStatus ?? _verifiedStatus,
        sundayStatus: sundayStatus ?? _sundayStatus,
        profiltStatus: profiltStatus ?? _profiltStatus,
        topTownStatus: topTownStatus ?? _topTownStatus,
        userSuspendedStatus: userSuspendedStatus ?? _userSuspendedStatus,
        delStatus: delStatus ?? _delStatus,
        otp: otp ?? _otp,
        lastLoginIp: lastLoginIp ?? _lastLoginIp,
        lastLogin: lastLogin ?? _lastLogin,
        dateTime: dateTime ?? _dateTime,
        getapiimages: getapiimages ?? _getapiimages,
        getapiCategories: getapiCategories ?? _getapiCategories,
        getapiPropertyType: getapiPropertyType ?? _getapiPropertyType,
        getapiPType: getapiPType ?? _getapiPType,
        getpropertySubType: getpropertySubType ?? _getpropertySubType,
      );
  int? get serviceId => _serviceId;
  dynamic get title => _title;
  dynamic get frontdepth => _frontdepth;
  dynamic get cyear => _cyear;
  dynamic get floortype => _floortype;
  dynamic get balconytype => _balconytype;
  dynamic get connectivity => _connectivity;
  dynamic get propertyownername => _propertyownername;
  dynamic get othercondition => _othercondition;
  dynamic get residenttype => _residenttype;
  dynamic get titleSlug => _titleSlug;
  dynamic get businessType => _businessType;
  dynamic get businessName => _businessName;
  dynamic get reviewPercent => _reviewPercent;
  dynamic get reviewCount => _reviewCount;
  dynamic get visitCount => _visitCount;
  dynamic get shortDesc => _shortDesc;
  dynamic get colony => _colony;
  dynamic get town => _town;
  dynamic get kmUpto => _kmUpto;
  dynamic get jioLocation => _jioLocation;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  dynamic get propertyface => _propertyface;
  dynamic get roadsize => _roadsize;
  dynamic get roadtype => _roadtype;
  dynamic get openside => _openside;
  dynamic get name => _name;
  dynamic get flattype => _flattype;
  dynamic get bathroom => _bathroom;
  dynamic get room => _room;
  dynamic get constructionstatus => _constructionstatus;
  dynamic get postedby => _postedby;
  dynamic get propertyinterior => _propertyinterior;
  dynamic get ameneties => _ameneties;
  dynamic get videoLink => _videoLink;
  dynamic get txtPass => _txtPass;
  dynamic get number => _number;
  dynamic get featureImage => _featureImage;
  dynamic get memebershipStarted => _memebershipStarted;
  dynamic get address => _address;
  dynamic get state => _state;
  dynamic get city => _city;
  dynamic get type => _type;
  dynamic get propertyType => _propertyType;
  dynamic get builderId => _builderId;
  dynamic get size => _size;
  dynamic get constructionSize => _constructionSize;
  dynamic get kycBankIfscCode => _kycBankIfscCode;
  dynamic get images1 => _images1;
  dynamic get feature => _feature;
  dynamic get images3 => _images3;
  dynamic get images4 => _images4;
  dynamic get images5 => _images5;
  dynamic get selectedCategories => _selectedCategories;
  dynamic get selectedNewCat => _selectedNewCat;
  dynamic get selectedCertificate => _selectedCertificate;
  dynamic get selectedSpecialist => _selectedSpecialist;
  dynamic get experience => _experience;
  dynamic get storeLocation => _storeLocation;
  dynamic get gifPath => _gifPath;
  dynamic get videoPath => _videoPath;
  dynamic get officeTimings => _officeTimings;
  dynamic get pricing => _pricing;
  dynamic get pricetype => _pricetype;
  dynamic get offerPrice => _offerPrice;
  dynamic get discount => _discount;
  dynamic get coupleDiscount => _coupleDiscount;
  dynamic get familyDiscount => _familyDiscount;
  dynamic get isReview => _isReview;
  dynamic get kycActivationStatus => _kycActivationStatus;
  dynamic get status => _status;
  dynamic get featureStatus => _featureStatus;
  dynamic get verifiedStatus => _verifiedStatus;
  dynamic get sundayStatus => _sundayStatus;
  dynamic get profiltStatus => _profiltStatus;
  dynamic get topTownStatus => _topTownStatus;
  dynamic get userSuspendedStatus => _userSuspendedStatus;
  dynamic get delStatus => _delStatus;
  dynamic get otp => _otp;
  dynamic get lastLoginIp => _lastLoginIp;
  dynamic get lastLogin => _lastLogin;
  dynamic get dateTime => _dateTime;
  List<Getapiimages>? get getapiimages => _getapiimages;
  GetapiCategories? get getapiCategories => _getapiCategories;
  GetapiPropertyType? get getapiPropertyType => _getapiPropertyType;
  GetapiPType? get getapiPType => _getapiPType;
  GetpropertySubType? get getpropertySubType => _getpropertySubType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['title'] = _title;
    map['frontdepth'] = _frontdepth;
    map['cyear'] = _cyear;
    map['floortype'] = _floortype;
    map['balconytype'] = _balconytype;
    map['connectivity'] = _connectivity;
    map['propertyownername'] = _propertyownername;
    map['othercondition'] = _othercondition;
    map['residenttype'] = _residenttype;
    map['title_slug'] = _titleSlug;
    map['business_type'] = _businessType;
    map['business_name'] = _businessName;
    map['review_percent'] = _reviewPercent;
    map['review_count'] = _reviewCount;
    map['visit_count'] = _visitCount;
    map['short_desc'] = _shortDesc;
    map['colony'] = _colony;
    map['town'] = _town;
    map['km_upto'] = _kmUpto;
    map['jio_location'] = _jioLocation;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['propertyface'] = _propertyface;
    map['roadsize'] = _roadsize;
    map['roadtype'] = _roadtype;
    map['openside'] = _openside;
    map['name'] = _name;
    map['flattype'] = _flattype;
    map['bathroom'] = _bathroom;
    map['room'] = _room;
    map['constructionstatus'] = _constructionstatus;
    map['postedby'] = _postedby;
    map['propertyinterior'] = _propertyinterior;
    map['ameneties'] = _ameneties;
    map['video_link'] = _videoLink;
    map['txt_pass'] = _txtPass;
    map['number'] = _number;
    map['feature_image'] = _featureImage;
    map['memebership_started'] = _memebershipStarted;
    map['address'] = _address;
    map['state'] = _state;
    map['city'] = _city;
    map['type'] = _type;
    map['property_type'] = _propertyType;
    map['builder_id'] = _builderId;
    map['size'] = _size;
    map['construction_size'] = _constructionSize;
    map['Kyc_bank_ifsc_code'] = _kycBankIfscCode;
    map['images_1'] = _images1;
    map['feature'] = _feature;
    map['images_3'] = _images3;
    map['images_4'] = _images4;
    map['images_5'] = _images5;
    map['selected_categories'] = _selectedCategories;
    map['selected_new_cat'] = _selectedNewCat;
    map['selected_certificate'] = _selectedCertificate;
    map['selected_specialist'] = _selectedSpecialist;
    map['experience'] = _experience;
    map['store_location'] = _storeLocation;
    map['gif_path'] = _gifPath;
    map['video_path'] = _videoPath;
    map['office_timings'] = _officeTimings;
    map['pricing'] = _pricing;
    map['pricetype'] = _pricetype;
    map['offer_price'] = _offerPrice;
    map['discount'] = _discount;
    map['couple_discount'] = _coupleDiscount;
    map['family_discount'] = _familyDiscount;
    map['is_review'] = _isReview;
    map['Kyc_Activation_status'] = _kycActivationStatus;
    map['status'] = _status;
    map['feature_status'] = _featureStatus;
    map['verified_status'] = _verifiedStatus;
    map['sunday_Status'] = _sundayStatus;
    map['profilt_status'] = _profiltStatus;
    map['top_town_status'] = _topTownStatus;
    map['user_suspended_status'] = _userSuspendedStatus;
    map['del_status'] = _delStatus;
    map['otp'] = _otp;
    map['last_login_ip'] = _lastLoginIp;
    map['last_login'] = _lastLogin;
    map['date_time'] = _dateTime;
    if (_getapiimages != null) {
      map['getapiimages'] = _getapiimages?.map((v) => v.toJson()).toList();
    }
    if (_getapiCategories != null) {
      map['getapi_categories'] = _getapiCategories?.toJson();
    }
    if (_getapiPropertyType != null) {
      map['getapi_property_type'] = _getapiPropertyType?.toJson();
    }

    if (_getapiPType != null) {
      map['get_p_type'] = _getapiPType?.toJson();
    }

    if (_getpropertySubType != null) {
      map['getproperty_sub_type'] = _getpropertySubType?.toJson();
    }
    return map;
  }
}

/// id : 6
/// name : "Residential"

GetpropertySubType getpropertySubTypeFromJson(String str) =>
    GetpropertySubType.fromJson(json.decode(str));
String getpropertySubTypeToJson(GetpropertySubType data) =>
    json.encode(data.toJson());

class GetpropertySubType {
  GetpropertySubType({
    int? id,
    dynamic name,
  }) {
    _id = id;
    _name = name;
  }

  GetpropertySubType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  dynamic _name;
  GetpropertySubType copyWith({
    int? id,
    dynamic name,
  }) =>
      GetpropertySubType(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  dynamic get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

GetapiPropertyType getapiPropertyTypeFromJson(String str) =>
    GetapiPropertyType.fromJson(json.decode(str));
String getapiPropertyTypeToJson(GetapiPropertyType data) =>
    json.encode(data.toJson());

class GetapiPropertyType {
  GetapiPropertyType({
    int? id,
    dynamic name,
  }) {
    _id = id;
    _name = name;
  }

  GetapiPropertyType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  dynamic _name;
  GetapiPropertyType copyWith({
    int? id,
    dynamic name,
  }) =>
      GetapiPropertyType(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  dynamic get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

/// id : 9
/// name : "house"

GetapiPType getapiPTypeFromJson(String str) =>
    GetapiPType.fromJson(json.decode(str));
String getapiPTypeToJson(GetapiPropertyType data) => json.encode(data.toJson());

class GetapiPType {
  GetapiPType({
    int? id,
    dynamic name,
  }) {
    _id = id;
    _name = name;
  }

  GetapiPType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  dynamic _name;
  GetapiPType copyWith({
    int? id,
    dynamic name,
  }) =>
      GetapiPType(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  dynamic get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

/// categories_id : 5
/// categories_name : "Sell"

GetapiCategories getapiCategoriesFromJson(String str) =>
    GetapiCategories.fromJson(json.decode(str));
String getapiCategoriesToJson(GetapiCategories data) =>
    json.encode(data.toJson());

class GetapiCategories {
  GetapiCategories({
    int? categoriesId,
    dynamic categoriesName,
  }) {
    _categoriesId = categoriesId;
    _categoriesName = categoriesName;
  }

  GetapiCategories.fromJson(dynamic json) {
    _categoriesId = json['categories_id'];
    _categoriesName = json['categories_name'];
  }
  int? _categoriesId;
  dynamic _categoriesName;
  GetapiCategories copyWith({
    int? categoriesId,
    dynamic categoriesName,
  }) =>
      GetapiCategories(
        categoriesId: categoriesId ?? _categoriesId,
        categoriesName: categoriesName ?? _categoriesName,
      );
  int? get categoriesId => _categoriesId;
  dynamic get categoriesName => _categoriesName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categories_id'] = _categoriesId;
    map['categories_name'] = _categoriesName;
    return map;
  }
}

/// property_id : "1"
/// file_path : "uploads/Images/12201715247891.jpeg"

Getapiimages getapiimagesFromJson(String str) =>
    Getapiimages.fromJson(json.decode(str));
String getapiimagesToJson(Getapiimages data) => json.encode(data.toJson());

class Getapiimages {
  Getapiimages({
    dynamic propertyId,
    dynamic filePath,
  }) {
    _propertyId = propertyId;
    _filePath = filePath;
  }

  Getapiimages.fromJson(dynamic json) {
    _propertyId = json['property_id'];
    _filePath = json['file_path'];
  }
  dynamic _propertyId;
  dynamic _filePath;
  Getapiimages copyWith({
    dynamic propertyId,
    dynamic filePath,
  }) =>
      Getapiimages(
        propertyId: propertyId ?? _propertyId,
        filePath: filePath ?? _filePath,
      );
  dynamic get propertyId => _propertyId;
  dynamic get filePath => _filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_id'] = _propertyId;
    map['file_path'] = _filePath;
    return map;
  }
}

/// service_id : 1
/// title : "2 BHK HOUSE RESALE IN KACHNA SHANKAR NAGAR"
/// frontdepth : null
/// cyear : null
/// floortype : "0"
/// balconytype : "0"
/// connectivity : null
/// propertyownername : null
/// othercondition : null
/// residenttype : null
/// title_slug : "2-bhk-house-resale-in-kachna-shankar-nagar"
/// business_type : null
/// business_name : null
/// review_percent : "0"
/// review_count : "0"
/// visit_count : "56"
/// short_desc : null
/// colony : null
/// town : "1"
/// km_upto : "4"
/// jio_location : "Shankar Nagar, Raipur, Chhattisgarh, India"
/// latitude : "21.2510977"
/// longitude : "81.6675975"
/// propertyface : null
/// roadsize : "10 FT"
/// roadtype : "RAW"
/// openside : "Single"
/// name : null
/// flattype : "2 BHK"
/// bathroom : "1 Bathroom"
/// room : "2 Room"
/// constructionstatus : "Resale"
/// postedby : null
/// propertyinterior : "Un-Furnished"
/// ameneties : []
/// video_link : null
/// txt_pass : null
/// number : null
/// feature_image : "uploads/Property/80691715247870.jpeg"
/// memebership_started : "2024-06-05"
/// address : "MODI NAGAR, NIKITA GAS GODOWN NEAR PIRDA KACHNA"
/// state : null
/// city : null
/// type : "6"
/// property_type : "9"
/// builder_id : "1"
/// size : "1000"
/// construction_size : "1000 SQFT"
/// Kyc_bank_ifsc_code : null
/// images_1 : null
/// feature : "[]"
/// images_3 : null
/// images_4 : null
/// images_5 : null
/// selected_categories : "5"
/// selected_new_cat : null
/// selected_certificate : null
/// selected_specialist : null
/// experience : null
/// store_location : null
/// gif_path : null
/// video_path : null
/// office_timings : null
/// pricing : "3000000"
/// pricetype : "Full Price"
/// offer_price : "0"
/// discount : null
/// couple_discount : "0"
/// family_discount : "0"
/// is_review : "0"
/// Kyc_Activation_status : "P"
/// status : "1"
/// feature_status : "0"
/// verified_status : "0"
/// sunday_Status : "0"
/// profilt_status : "0"
/// top_town_status : "0"
/// user_suspended_status : "0"
/// del_status : "0"
/// otp : null
/// last_login_ip : null
/// last_login : null
/// date_time : "2024-05-09 15:14:30"
/// getapiimages : [{"property_id":"1","file_path":"uploads/Images/12201715247891.jpeg"},{"property_id":"1","file_path":"uploads/Images/55061715247900.jpeg"}]
/// getapi_categories : {"categories_id":5,"categories_name":"Sell"}
/// getapi_property_type : {"id":9,"name":"house"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  set setBookmark(dynamic value) {
    _getBookMarkedProperty = value;
    if (kDebugMode) {
      print("bookmarked=====> $_getBookMarkedProperty");
    }
  }

  set loadingUpdate(dynamic newLoading) {
    _loading = newLoading;
    if (kDebugMode) {
      print("is loading =====> $_getBookMarkedProperty");
    }
  }

  Data({
    int? serviceId,
    dynamic title,
    dynamic frontdepth,
    dynamic cyear,
    dynamic floortype,
    dynamic balconytype,
    dynamic connectivity,
    dynamic propertyownername,
    dynamic othercondition,
    dynamic residenttype,
    dynamic titleSlug,
    dynamic businessType,
    dynamic businessName,
    dynamic reviewPercent,
    dynamic reviewCount,
    dynamic visitCount,
    dynamic shortDesc,
    dynamic colony,
    dynamic town,
    dynamic kmUpto,
    dynamic jioLocation,
    dynamic latitude,
    dynamic longitude,
    dynamic propertyface,
    dynamic roadsize,
    dynamic roadtype,
    dynamic openside,
    dynamic name,
    dynamic flattype,
    dynamic bathroom,
    dynamic room,
    dynamic constructionstatus,
    dynamic postedby,
    dynamic propertyinterior,
    List<Ameneties>? ameneties,
    dynamic videoLink,
    dynamic txtPass,
    dynamic number,
    dynamic featureImage,
    dynamic memebershipStarted,
    dynamic address,
    dynamic state,
    dynamic city,
    dynamic type,
    dynamic propertyType,
    dynamic builderId,
    dynamic size,
    dynamic constructionSize,
    dynamic kycBankIfscCode,
    dynamic images1,
    dynamic feature,
    dynamic images3,
    dynamic images4,
    dynamic images5,
    dynamic selectedCategories,
    dynamic selectedNewCat,
    dynamic selectedCertificate,
    dynamic selectedSpecialist,
    dynamic experience,
    dynamic storeLocation,
    dynamic gifPath,
    dynamic videoPath,
    dynamic officeTimings,
    dynamic pricing,
    dynamic pricetype,
    dynamic offerPrice,
    dynamic discount,
    dynamic coupleDiscount,
    dynamic familyDiscount,
    dynamic isReview,
    dynamic kycActivationStatus,
    dynamic status,
    dynamic featureStatus,
    dynamic verifiedStatus,
    dynamic sundayStatus,
    dynamic profiltStatus,
    dynamic topTownStatus,
    dynamic userSuspendedStatus,
    dynamic delStatus,
    dynamic otp,
    dynamic lastLoginIp,
    dynamic lastLogin,
    dynamic dateTime,
    dynamic getBookMarkedProperty,
    List<Getapiimages>? getapiimages,
    GetapiCategories? getapiCategories,
    GetapiPropertyType? getapiPropertyType,
    GetapiPType? getapiPType,
    dynamic loading = false,
  }) {
    _serviceId = serviceId;
    _title = title;
    _frontdepth = frontdepth;
    _cyear = cyear;
    _floortype = floortype;
    _balconytype = balconytype;
    _connectivity = connectivity;
    _propertyownername = propertyownername;
    _othercondition = othercondition;
    _residenttype = residenttype;
    _titleSlug = titleSlug;
    _businessType = businessType;
    _businessName = businessName;
    _reviewPercent = reviewPercent;
    _reviewCount = reviewCount;
    _visitCount = visitCount;
    _shortDesc = shortDesc;
    _colony = colony;
    _town = town;
    _kmUpto = kmUpto;
    _jioLocation = jioLocation;
    _latitude = latitude;
    _longitude = longitude;
    _propertyface = propertyface;
    _roadsize = roadsize;
    _roadtype = roadtype;
    _openside = openside;
    _name = name;
    _flattype = flattype;
    _bathroom = bathroom;
    _room = room;
    _constructionstatus = constructionstatus;
    _postedby = postedby;
    _propertyinterior = propertyinterior;
    _ameneties = ameneties;
    _videoLink = videoLink;
    _txtPass = txtPass;
    _number = number;
    _featureImage = featureImage;
    _memebershipStarted = memebershipStarted;
    _address = address;
    _state = state;
    _city = city;
    _type = type;
    _propertyType = propertyType;
    _builderId = builderId;
    _size = size;
    _constructionSize = constructionSize;
    _kycBankIfscCode = kycBankIfscCode;
    _images1 = images1;
    _feature = feature;
    _images3 = images3;
    _images4 = images4;
    _images5 = images5;
    _selectedCategories = selectedCategories;
    _selectedNewCat = selectedNewCat;
    _selectedCertificate = selectedCertificate;
    _selectedSpecialist = selectedSpecialist;
    _experience = experience;
    _storeLocation = storeLocation;
    _gifPath = gifPath;
    _videoPath = videoPath;
    _officeTimings = officeTimings;
    _pricing = pricing;
    _pricetype = pricetype;
    _offerPrice = offerPrice;
    _discount = discount;
    _coupleDiscount = coupleDiscount;
    _familyDiscount = familyDiscount;
    _isReview = isReview;
    _kycActivationStatus = kycActivationStatus;
    _status = status;
    _featureStatus = featureStatus;
    _verifiedStatus = verifiedStatus;
    _sundayStatus = sundayStatus;
    _profiltStatus = profiltStatus;
    _topTownStatus = topTownStatus;
    _userSuspendedStatus = userSuspendedStatus;
    _delStatus = delStatus;
    _otp = otp;
    _lastLoginIp = lastLoginIp;
    _lastLogin = lastLogin;
    _dateTime = dateTime;
    _getBookMarkedProperty = getBookMarkedProperty;
    _getapiimages = getapiimages;
    _getapiCategories = getapiCategories;
    _getapiPropertyType = getapiPropertyType;
    _getapiPType = getapiPType;
    _loading = loading;
  }

  Data.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _title = json['title'];
    _frontdepth = json['frontdepth'];
    _cyear = json['cyear'];
    _floortype = json['floortype'];
    _balconytype = json['balconytype'];
    _connectivity = json['connectivity'];
    _propertyownername = json['propertyownername'];
    _othercondition = json['othercondition'];
    _residenttype = json['residenttype'];
    _titleSlug = json['title_slug'];
    _businessType = json['business_type'];
    _businessName = json['business_name'];
    _reviewPercent = json['review_percent'];
    _reviewCount = json['review_count'];
    _visitCount = json['visit_count'];
    _shortDesc = json['short_desc'];
    _colony = json['colony'];
    _town = json['town'];
    _kmUpto = json['km_upto'];
    _jioLocation = json['jio_location'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _propertyface = json['propertyface'];
    _roadsize = json['roadsize'];
    _roadtype = json['roadtype'];
    _openside = json['openside'];
    _name = json['name'];
    _flattype = json['flattype'];
    _bathroom = json['bathroom'];
    _room = json['room'];
    _constructionstatus = json['constructionstatus'];
    _postedby = json['postedby'];
    _propertyinterior = json['propertyinterior'];
    _getBookMarkedProperty = json['get_book_marked_property_api'];
    if (json['ameneties'] != null) {
      _ameneties = [];
      json['ameneties'].forEach((v) {
        _ameneties?.add(Ameneties.fromJson(v));
      });
    }
    _videoLink = json['video_link'];
    _txtPass = json['txt_pass'];
    _number = json['number'];
    _featureImage = json['feature_image'];
    _memebershipStarted = json['memebership_started'];
    _address = json['address'];
    _state = json['state'];
    _city = json['city'];
    _type = json['type'];
    _propertyType = json['property_type'];
    _builderId = json['builder_id'];
    _size = json['size'];
    _constructionSize = json['construction_size'];
    _kycBankIfscCode = json['Kyc_bank_ifsc_code'];
    _images1 = json['images_1'];
    _feature = json['feature'];
    _images3 = json['images_3'];
    _images4 = json['images_4'];
    _images5 = json['images_5'];
    _selectedCategories = json['selected_categories'];
    _selectedNewCat = json['selected_new_cat'];
    _selectedCertificate = json['selected_certificate'];
    _selectedSpecialist = json['selected_specialist'];
    _experience = json['experience'];
    _storeLocation = json['store_location'];
    _gifPath = json['gif_path'];
    _videoPath = json['video_path'];
    _officeTimings = json['office_timings'];
    _pricing = json['pricing'];
    _pricetype = json['pricetype'];
    _offerPrice = json['offer_price'];
    _discount = json['discount'];
    _coupleDiscount = json['couple_discount'];
    _familyDiscount = json['family_discount'];
    _isReview = json['is_review'];
    _kycActivationStatus = json['Kyc_Activation_status'];
    _status = json['status'];
    _featureStatus = json['feature_status'];
    _verifiedStatus = json['verified_status'];
    _sundayStatus = json['sunday_Status'];
    _profiltStatus = json['profilt_status'];
    _topTownStatus = json['top_town_status'];
    _userSuspendedStatus = json['user_suspended_status'];
    _delStatus = json['del_status'];
    _otp = json['otp'];
    _lastLoginIp = json['last_login_ip'];
    _lastLogin = json['last_login'];
    _dateTime = json['date_time'];
    if (json['getapiimages'] != null) {
      _getapiimages = [];
      json['getapiimages'].forEach((v) {
        _getapiimages?.add(Getapiimages.fromJson(v));
      });
    }
    _getapiCategories = json['getapi_categories'] != null
        ? GetapiCategories.fromJson(json['getapi_categories'])
        : null;
    _getapiPropertyType = json['getapi_property_type'] != null
        ? GetapiPropertyType.fromJson(json['getapi_property_type'])
        : null;

    _getapiPType = json['get_p_type'] != null
        ? GetapiPType.fromJson(json['get_p_type'])
        : null;
  }
  int? _serviceId;
  dynamic _title;
  dynamic _frontdepth;
  dynamic _cyear;
  dynamic _floortype;
  dynamic _balconytype;
  dynamic _connectivity;
  dynamic _propertyownername;
  dynamic _othercondition;
  dynamic _residenttype;
  dynamic _titleSlug;
  dynamic _businessType;
  dynamic _businessName;
  dynamic _reviewPercent;
  dynamic _reviewCount;
  dynamic _visitCount;
  dynamic _shortDesc;
  dynamic _colony;
  dynamic _town;
  dynamic _kmUpto;
  dynamic _jioLocation;
  dynamic _latitude;
  dynamic _longitude;
  dynamic _propertyface;
  dynamic _roadsize;
  dynamic _roadtype;
  dynamic _openside;
  dynamic _name;
  dynamic _flattype;
  dynamic _bathroom;
  dynamic _room;
  dynamic _constructionstatus;
  dynamic _postedby;
  dynamic _propertyinterior;
  List<Ameneties>? _ameneties;
  dynamic _videoLink;
  dynamic _txtPass;
  dynamic _number;
  dynamic _featureImage;
  dynamic _memebershipStarted;
  dynamic _address;
  dynamic _state;
  dynamic _city;
  dynamic _type;
  dynamic _propertyType;
  dynamic _builderId;
  dynamic _size;
  dynamic _constructionSize;
  dynamic _kycBankIfscCode;
  dynamic _images1;
  dynamic _feature;
  dynamic _images3;
  dynamic _images4;
  dynamic _images5;
  dynamic _selectedCategories;
  dynamic _selectedNewCat;
  dynamic _selectedCertificate;
  dynamic _selectedSpecialist;
  dynamic _experience;
  dynamic _storeLocation;
  dynamic _gifPath;
  dynamic _videoPath;
  dynamic _officeTimings;
  dynamic _pricing;
  dynamic _pricetype;
  dynamic _offerPrice;
  dynamic _discount;
  dynamic _coupleDiscount;
  dynamic _familyDiscount;
  dynamic _isReview;
  dynamic _kycActivationStatus;
  dynamic _status;
  dynamic _featureStatus;
  dynamic _verifiedStatus;
  dynamic _sundayStatus;
  dynamic _profiltStatus;
  dynamic _topTownStatus;
  dynamic _userSuspendedStatus;
  dynamic _delStatus;
  dynamic _otp;
  dynamic _lastLoginIp;
  dynamic _lastLogin;
  dynamic _dateTime;
  dynamic _getBookMarkedProperty;
  List<Getapiimages>? _getapiimages;
  GetapiCategories? _getapiCategories;
  GetapiPropertyType? _getapiPropertyType;
  GetapiPType? _getapiPType;
  dynamic _loading = false;
  Data copyWith({
    int? serviceId,
    dynamic title,
    dynamic frontdepth,
    dynamic cyear,
    dynamic floortype,
    dynamic balconytype,
    dynamic connectivity,
    dynamic propertyownername,
    dynamic othercondition,
    dynamic residenttype,
    dynamic titleSlug,
    dynamic businessType,
    dynamic businessName,
    dynamic reviewPercent,
    dynamic reviewCount,
    dynamic visitCount,
    dynamic shortDesc,
    dynamic colony,
    dynamic town,
    dynamic kmUpto,
    dynamic jioLocation,
    dynamic latitude,
    dynamic longitude,
    dynamic propertyface,
    dynamic roadsize,
    dynamic roadtype,
    dynamic openside,
    dynamic name,
    dynamic flattype,
    dynamic bathroom,
    dynamic room,
    dynamic constructionstatus,
    dynamic postedby,
    dynamic propertyinterior,
    List<Ameneties>? ameneties,
    dynamic videoLink,
    dynamic txtPass,
    dynamic number,
    dynamic featureImage,
    dynamic memebershipStarted,
    dynamic address,
    dynamic state,
    dynamic city,
    dynamic type,
    dynamic propertyType,
    dynamic builderId,
    dynamic size,
    dynamic constructionSize,
    dynamic kycBankIfscCode,
    dynamic images1,
    dynamic feature,
    dynamic images3,
    dynamic images4,
    dynamic images5,
    dynamic selectedCategories,
    dynamic selectedNewCat,
    dynamic selectedCertificate,
    dynamic selectedSpecialist,
    dynamic experience,
    dynamic storeLocation,
    dynamic gifPath,
    dynamic videoPath,
    dynamic officeTimings,
    dynamic pricing,
    dynamic pricetype,
    dynamic offerPrice,
    dynamic discount,
    dynamic coupleDiscount,
    dynamic familyDiscount,
    dynamic isReview,
    dynamic kycActivationStatus,
    dynamic status,
    dynamic featureStatus,
    dynamic verifiedStatus,
    dynamic sundayStatus,
    dynamic profiltStatus,
    dynamic topTownStatus,
    dynamic userSuspendedStatus,
    dynamic delStatus,
    dynamic otp,
    dynamic lastLoginIp,
    dynamic lastLogin,
    dynamic dateTime,
    dynamic getBookMarkedProperty,
    List<Getapiimages>? getapiimages,
    GetapiCategories? getapiCategories,
    GetapiPropertyType? getapiPropertyType,
    GetapiPType? getapiPType,
    dynamic loading,
  }) =>
      Data(
        serviceId: serviceId ?? _serviceId,
        title: title ?? _title,
        frontdepth: frontdepth ?? _frontdepth,
        cyear: cyear ?? _cyear,
        floortype: floortype ?? _floortype,
        balconytype: balconytype ?? _balconytype,
        connectivity: connectivity ?? _connectivity,
        propertyownername: propertyownername ?? _propertyownername,
        othercondition: othercondition ?? _othercondition,
        residenttype: residenttype ?? _residenttype,
        titleSlug: titleSlug ?? _titleSlug,
        businessType: businessType ?? _businessType,
        businessName: businessName ?? _businessName,
        reviewPercent: reviewPercent ?? _reviewPercent,
        reviewCount: reviewCount ?? _reviewCount,
        visitCount: visitCount ?? _visitCount,
        shortDesc: shortDesc ?? _shortDesc,
        colony: colony ?? _colony,
        town: town ?? _town,
        kmUpto: kmUpto ?? _kmUpto,
        jioLocation: jioLocation ?? _jioLocation,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        propertyface: propertyface ?? _propertyface,
        roadsize: roadsize ?? _roadsize,
        roadtype: roadtype ?? _roadtype,
        openside: openside ?? _openside,
        name: name ?? _name,
        flattype: flattype ?? _flattype,
        bathroom: bathroom ?? _bathroom,
        room: room ?? _room,
        constructionstatus: constructionstatus ?? _constructionstatus,
        postedby: postedby ?? _postedby,
        propertyinterior: propertyinterior ?? _propertyinterior,
        ameneties: ameneties ?? _ameneties,
        videoLink: videoLink ?? _videoLink,
        txtPass: txtPass ?? _txtPass,
        number: number ?? _number,
        featureImage: featureImage ?? _featureImage,
        memebershipStarted: memebershipStarted ?? _memebershipStarted,
        address: address ?? _address,
        state: state ?? _state,
        city: city ?? _city,
        type: type ?? _type,
        propertyType: propertyType ?? _propertyType,
        builderId: builderId ?? _builderId,
        size: size ?? _size,
        constructionSize: constructionSize ?? _constructionSize,
        kycBankIfscCode: kycBankIfscCode ?? _kycBankIfscCode,
        images1: images1 ?? _images1,
        feature: feature ?? _feature,
        images3: images3 ?? _images3,
        images4: images4 ?? _images4,
        images5: images5 ?? _images5,
        selectedCategories: selectedCategories ?? _selectedCategories,
        selectedNewCat: selectedNewCat ?? _selectedNewCat,
        selectedCertificate: selectedCertificate ?? _selectedCertificate,
        selectedSpecialist: selectedSpecialist ?? _selectedSpecialist,
        experience: experience ?? _experience,
        storeLocation: storeLocation ?? _storeLocation,
        gifPath: gifPath ?? _gifPath,
        videoPath: videoPath ?? _videoPath,
        officeTimings: officeTimings ?? _officeTimings,
        pricing: pricing ?? _pricing,
        pricetype: pricetype ?? _pricetype,
        offerPrice: offerPrice ?? _offerPrice,
        discount: discount ?? _discount,
        coupleDiscount: coupleDiscount ?? _coupleDiscount,
        familyDiscount: familyDiscount ?? _familyDiscount,
        isReview: isReview ?? _isReview,
        kycActivationStatus: kycActivationStatus ?? _kycActivationStatus,
        status: status ?? _status,
        featureStatus: featureStatus ?? _featureStatus,
        verifiedStatus: verifiedStatus ?? _verifiedStatus,
        sundayStatus: sundayStatus ?? _sundayStatus,
        profiltStatus: profiltStatus ?? _profiltStatus,
        topTownStatus: topTownStatus ?? _topTownStatus,
        userSuspendedStatus: userSuspendedStatus ?? _userSuspendedStatus,
        delStatus: delStatus ?? _delStatus,
        otp: otp ?? _otp,
        lastLoginIp: lastLoginIp ?? _lastLoginIp,
        lastLogin: lastLogin ?? _lastLogin,
        dateTime: dateTime ?? _dateTime,
        getBookMarkedProperty: getBookMarkedProperty ?? _getBookMarkedProperty,
        getapiimages: getapiimages ?? _getapiimages,
        getapiCategories: getapiCategories ?? _getapiCategories,
        getapiPropertyType: getapiPropertyType ?? _getapiPropertyType,
        getapiPType: getapiPType ?? _getapiPType,
        loading: loading ?? _loading,
      );
  int? get serviceId => _serviceId;
  dynamic get title => _title;
  dynamic get frontdepth => _frontdepth;
  dynamic get cyear => _cyear;
  dynamic get floortype => _floortype;
  dynamic get balconytype => _balconytype;
  dynamic get connectivity => _connectivity;
  dynamic get propertyownername => _propertyownername;
  dynamic get othercondition => _othercondition;
  dynamic get residenttype => _residenttype;
  dynamic get titleSlug => _titleSlug;
  dynamic get businessType => _businessType;
  dynamic get businessName => _businessName;
  dynamic get reviewPercent => _reviewPercent;
  dynamic get reviewCount => _reviewCount;
  dynamic get visitCount => _visitCount;
  dynamic get shortDesc => _shortDesc;
  dynamic get colony => _colony;
  dynamic get town => _town;
  dynamic get kmUpto => _kmUpto;
  dynamic get jioLocation => _jioLocation;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  dynamic get propertyface => _propertyface;
  dynamic get roadsize => _roadsize;
  dynamic get roadtype => _roadtype;
  dynamic get openside => _openside;
  dynamic get name => _name;
  dynamic get flattype => _flattype;
  dynamic get bathroom => _bathroom;
  dynamic get room => _room;
  dynamic get constructionstatus => _constructionstatus;
  dynamic get postedby => _postedby;
  dynamic get propertyinterior => _propertyinterior;
  List<dynamic>? get ameneties => _ameneties;
  dynamic get videoLink => _videoLink;
  dynamic get txtPass => _txtPass;
  dynamic get number => _number;
  dynamic get featureImage => _featureImage;
  dynamic get memebershipStarted => _memebershipStarted;
  dynamic get address => _address;
  dynamic get state => _state;
  dynamic get city => _city;
  dynamic get type => _type;
  dynamic get propertyType => _propertyType;
  dynamic get builderId => _builderId;
  dynamic get size => _size;
  dynamic get constructionSize => _constructionSize;
  dynamic get kycBankIfscCode => _kycBankIfscCode;
  dynamic get images1 => _images1;
  dynamic get feature => _feature;
  dynamic get images3 => _images3;
  dynamic get images4 => _images4;
  dynamic get images5 => _images5;
  dynamic get selectedCategories => _selectedCategories;
  dynamic get selectedNewCat => _selectedNewCat;
  dynamic get selectedCertificate => _selectedCertificate;
  dynamic get selectedSpecialist => _selectedSpecialist;
  dynamic get experience => _experience;
  dynamic get storeLocation => _storeLocation;
  dynamic get gifPath => _gifPath;
  dynamic get videoPath => _videoPath;
  dynamic get officeTimings => _officeTimings;
  dynamic get pricing => _pricing;
  dynamic get pricetype => _pricetype;
  dynamic get offerPrice => _offerPrice;
  dynamic get discount => _discount;
  dynamic get coupleDiscount => _coupleDiscount;
  dynamic get familyDiscount => _familyDiscount;
  dynamic get isReview => _isReview;
  dynamic get kycActivationStatus => _kycActivationStatus;
  dynamic get status => _status;
  dynamic get featureStatus => _featureStatus;
  dynamic get verifiedStatus => _verifiedStatus;
  dynamic get sundayStatus => _sundayStatus;
  dynamic get profiltStatus => _profiltStatus;
  dynamic get topTownStatus => _topTownStatus;
  dynamic get userSuspendedStatus => _userSuspendedStatus;
  dynamic get delStatus => _delStatus;
  dynamic get otp => _otp;
  dynamic get lastLoginIp => _lastLoginIp;
  dynamic get lastLogin => _lastLogin;
  dynamic get dateTime => _dateTime;
  dynamic get getBookMarkedProperty => _getBookMarkedProperty;
  List<Getapiimages>? get getapiimages => _getapiimages;
  GetapiCategories? get getapiCategories => _getapiCategories;
  GetapiPropertyType? get getapiPropertyType => _getapiPropertyType;
  GetapiPType? get getapiPType => _getapiPType;
  dynamic get loading => _loading;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['title'] = _title;
    map['frontdepth'] = _frontdepth;
    map['cyear'] = _cyear;
    map['floortype'] = _floortype;
    map['balconytype'] = _balconytype;
    map['connectivity'] = _connectivity;
    map['propertyownername'] = _propertyownername;
    map['othercondition'] = _othercondition;
    map['residenttype'] = _residenttype;
    map['title_slug'] = _titleSlug;
    map['business_type'] = _businessType;
    map['business_name'] = _businessName;
    map['review_percent'] = _reviewPercent;
    map['review_count'] = _reviewCount;
    map['visit_count'] = _visitCount;
    map['short_desc'] = _shortDesc;
    map['colony'] = _colony;
    map['town'] = _town;
    map['km_upto'] = _kmUpto;
    map['jio_location'] = _jioLocation;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['propertyface'] = _propertyface;
    map['roadsize'] = _roadsize;
    map['roadtype'] = _roadtype;
    map['openside'] = _openside;
    map['name'] = _name;
    map['flattype'] = _flattype;
    map['bathroom'] = _bathroom;
    map['room'] = _room;
    map['constructionstatus'] = _constructionstatus;
    map['postedby'] = _postedby;
    map['propertyinterior'] = _propertyinterior;
    if (_ameneties != null) {
      map['ameneties'] = _ameneties?.map((v) => v.toJson()).toList();
    }
    map['video_link'] = _videoLink;
    map['txt_pass'] = _txtPass;
    map['number'] = _number;
    map['feature_image'] = _featureImage;
    map['memebership_started'] = _memebershipStarted;
    map['address'] = _address;
    map['state'] = _state;
    map['city'] = _city;
    map['type'] = _type;
    map['property_type'] = _propertyType;
    map['builder_id'] = _builderId;
    map['size'] = _size;
    map['construction_size'] = _constructionSize;
    map['Kyc_bank_ifsc_code'] = _kycBankIfscCode;
    map['images_1'] = _images1;
    map['feature'] = _feature;
    map['images_3'] = _images3;
    map['images_4'] = _images4;
    map['images_5'] = _images5;
    map['selected_categories'] = _selectedCategories;
    map['selected_new_cat'] = _selectedNewCat;
    map['selected_certificate'] = _selectedCertificate;
    map['selected_specialist'] = _selectedSpecialist;
    map['experience'] = _experience;
    map['store_location'] = _storeLocation;
    map['gif_path'] = _gifPath;
    map['video_path'] = _videoPath;
    map['office_timings'] = _officeTimings;
    map['pricing'] = _pricing;
    map['pricetype'] = _pricetype;
    map['offer_price'] = _offerPrice;
    map['discount'] = _discount;
    map['couple_discount'] = _coupleDiscount;
    map['family_discount'] = _familyDiscount;
    map['is_review'] = _isReview;
    map['Kyc_Activation_status'] = _kycActivationStatus;
    map['status'] = _status;
    map['feature_status'] = _featureStatus;
    map['verified_status'] = _verifiedStatus;
    map['sunday_Status'] = _sundayStatus;
    map['profilt_status'] = _profiltStatus;
    map['top_town_status'] = _topTownStatus;
    map['user_suspended_status'] = _userSuspendedStatus;
    map['del_status'] = _delStatus;
    map['otp'] = _otp;
    map['last_login_ip'] = _lastLoginIp;
    map['last_login'] = _lastLogin;
    map['date_time'] = _dateTime;
    map['get_book_marked_property_api'] = _getBookMarkedProperty;
    if (_getapiimages != null) {
      map['getapiimages'] = _getapiimages?.map((v) => v.toJson()).toList();
    }
    if (_getapiCategories != null) {
      map['getapi_categories'] = _getapiCategories?.toJson();
    }
    if (_getapiPropertyType != null) {
      map['getapi_property_type'] = _getapiPropertyType?.toJson();
    }

    if (_getapiPType != null) {
      map['get_p_type'] = _getapiPType?.toJson();
    }
    return map;
  }
}

Ameneties amenetiesFromJson(String str) => Ameneties.fromJson(json.decode(str));
String amenetiesToJson(Ameneties data) => json.encode(data.toJson());

class Ameneties {
  Ameneties({
    int? id,
    dynamic name,
    dynamic iconCode,
    dynamic image,
    dynamic status,
    dynamic dateTime,
  }) {
    _id = id;
    _name = name;
    _iconCode = iconCode;
    _image = image;
    _status = status;
    _dateTime = dateTime;
  }

  Ameneties.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _iconCode = json['icon_code'];
    _image = json['image'];
    _status = json['status'];
    _dateTime = json['date_time'];
  }
  int? _id;
  dynamic _name;
  dynamic _iconCode;
  dynamic _image;
  dynamic _status;
  dynamic _dateTime;
  Ameneties copyWith({
    int? id,
    dynamic name,
    dynamic iconCode,
    dynamic image,
    dynamic status,
    dynamic dateTime,
  }) =>
      Ameneties(
        id: id ?? _id,
        name: name ?? _name,
        iconCode: iconCode ?? _iconCode,
        image: image ?? _image,
        status: status ?? _status,
        dateTime: dateTime ?? _dateTime,
      );
  int? get id => _id;
  dynamic get name => _name;
  dynamic get iconCode => _iconCode;
  dynamic get image => _image;
  dynamic get status => _status;
  dynamic get dateTime => _dateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon_code'] = _iconCode;
    map['image'] = _image;
    map['status'] = _status;
    map['date_time'] = _dateTime;
    return map;
  }
}
