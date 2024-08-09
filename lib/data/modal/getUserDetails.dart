import 'dart:convert';

/// success : true
/// data : {"user_id":9,"main_user_id":"5","user_name":"charlie CSD1","user_username":null,"user_email":"charlie1@gmail.com","user_password":null,"txt_pass":null,"user_number":null,"gender":null,"firebase_link":null,"firebase_text":null,"device_type":"\"no_value\"","device_id":"\"no_value\"","user_number_code":null,"user_alternative_number":null,"user_direct_id":null,"latitude":null,"longitude":null,"business_type":null,"user_package":null,"user_package_all":null,"user_package_sum":null,"user_botbuy_total":null,"investment_limit":null,"current_roi_percentage":null,"days_left":null,"user_level_open":"0","user_level":null,"today_income":null,"user_address":"raipura mahadev ghat 1","user_profile":null,"user_country":null,"user_state":null,"user_cities":null,"user_image":null,"grade_rank":null,"city":"raipur","Kyc_pan_card_name":null,"Kyc_bank_account_number":null,"Kyc_bank_ifsc_code":null,"Kyc_bank_name":null,"Kyc_holder_name":null,"Kyc_phonepay_number":null,"Kyc_paytm_number":null,"Kyc_googlepay_number":null,"user_wallet":"0","reward_wallet":null,"membership_started_time":null,"membership_activate_time":null,"user_memebership_started":null,"user_memebership_expired":null,"user_id_active_status":"0","user_suspended_status":"0","is_register":"1","otp":null,"del_status":"0","last_login":null,"last_login_ip":null,"created_at":"2024-05-23 23:43:01","updated_by":"0"}

GetUserDetails getUserDetailsFromJson(String str) =>
    GetUserDetails.fromJson(json.decode(str));

String getUserDetailsToJson(GetUserDetails data) => json.encode(data.toJson());

class GetUserDetails {
  GetUserDetails({
    bool? success,
    String? message,
    Data? data,
  }) {
    _success = success;
    _message = message;
    _data = data;
  }

  GetUserDetails.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  String? _message;
  Data? _data;

  GetUserDetails copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      GetUserDetails(
        success: success ?? _success,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get success => _success;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// user_id : 9
/// main_user_id : "5"
/// user_name : "charlie CSD1"
/// user_username : null
/// user_email : "charlie1@gmail.com"
/// user_password : null
/// txt_pass : null
/// user_number : null
/// gender : null
/// firebase_link : null
/// firebase_text : null
/// device_type : "\"no_value\""
/// device_id : "\"no_value\""
/// user_number_code : null
/// user_alternative_number : null
/// user_direct_id : null
/// latitude : null
/// longitude : null
/// business_type : null
/// user_package : null
/// user_package_all : null
/// user_package_sum : null
/// user_botbuy_total : null
/// investment_limit : null
/// current_roi_percentage : null
/// days_left : null
/// user_level_open : "0"
/// user_level : null
/// today_income : null
/// user_address : "raipura mahadev ghat 1"
/// user_profile : null
/// user_country : null
/// user_state : null
/// user_cities : null
/// user_image : null
/// grade_rank : null
/// city : "raipur"
/// Kyc_pan_card_name : null
/// Kyc_bank_account_number : null
/// Kyc_bank_ifsc_code : null
/// Kyc_bank_name : null
/// Kyc_holder_name : null
/// Kyc_phonepay_number : null
/// Kyc_paytm_number : null
/// Kyc_googlepay_number : null
/// user_wallet : "0"
/// reward_wallet : null
/// membership_started_time : null
/// membership_activate_time : null
/// user_memebership_started : null
/// user_memebership_expired : null
/// user_id_active_status : "0"
/// user_suspended_status : "0"
/// is_register : "1"
/// otp : null
/// del_status : "0"
/// last_login : null
/// last_login_ip : null
/// created_at : "2024-05-23 23:43:01"
/// updated_by : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    dynamic userId,
    dynamic mainUserId,
    dynamic userName,
    dynamic userUsername,
    dynamic userEmail,
    dynamic userPassword,
    dynamic txtPass,
    dynamic userNumber,
    dynamic gender,
    dynamic firebaseLink,
    dynamic firebaseText,
    dynamic deviceType,
    dynamic deviceId,
    dynamic userNumberCode,
    dynamic userAlternativeNumber,
    dynamic userDirectId,
    dynamic latitude,
    dynamic longitude,
    dynamic businessType,
    dynamic userPackage,
    dynamic userPackageAll,
    dynamic userPackageSum,
    dynamic userBotbuyTotal,
    dynamic investmentLimit,
    dynamic currentRoiPercentage,
    dynamic daysLeft,
    dynamic userLevelOpen,
    dynamic userLevel,
    dynamic todayIncome,
    dynamic userAddress,
    dynamic userProfile,
    dynamic userCountry,
    dynamic userState,
    dynamic userCities,
    dynamic userImage,
    dynamic gradeRank,
    dynamic city,
    dynamic kycPanCardName,
    dynamic kycBankAccountNumber,
    dynamic kycBankIfscCode,
    dynamic kycBankName,
    dynamic kycHolderName,
    dynamic kycPhonepayNumber,
    dynamic kycPaytmNumber,
    dynamic kycGooglepayNumber,
    dynamic userWallet,
    dynamic rewardWallet,
    dynamic membershipStartedTime,
    dynamic membershipActivateTime,
    dynamic userMemebershipStarted,
    dynamic userMemebershipExpired,
    dynamic userIdActiveStatus,
    dynamic userSuspendedStatus,
    dynamic isRegister,
    dynamic otp,
    dynamic delStatus,
    dynamic lastLogin,
    dynamic lastLoginIp,
    dynamic createdAt,
    dynamic updatedBy,
  }) {
    _userId = userId;
    _mainUserId = mainUserId;
    _userName = userName;
    _userUsername = userUsername;
    _userEmail = userEmail;
    _userPassword = userPassword;
    _txtPass = txtPass;
    _userNumber = userNumber;
    _gender = gender;
    _firebaseLink = firebaseLink;
    _firebaseText = firebaseText;
    _deviceType = deviceType;
    _deviceId = deviceId;
    _userNumberCode = userNumberCode;
    _userAlternativeNumber = userAlternativeNumber;
    _userDirectId = userDirectId;
    _latitude = latitude;
    _longitude = longitude;
    _businessType = businessType;
    _userPackage = userPackage;
    _userPackageAll = userPackageAll;
    _userPackageSum = userPackageSum;
    _userBotbuyTotal = userBotbuyTotal;
    _investmentLimit = investmentLimit;
    _currentRoiPercentage = currentRoiPercentage;
    _daysLeft = daysLeft;
    _userLevelOpen = userLevelOpen;
    _userLevel = userLevel;
    _todayIncome = todayIncome;
    _userAddress = userAddress;
    _userProfile = userProfile;
    _userCountry = userCountry;
    _userState = userState;
    _userCities = userCities;
    _userImage = userImage;
    _gradeRank = gradeRank;
    _city = city;
    _kycPanCardName = kycPanCardName;
    _kycBankAccountNumber = kycBankAccountNumber;
    _kycBankIfscCode = kycBankIfscCode;
    _kycBankName = kycBankName;
    _kycHolderName = kycHolderName;
    _kycPhonepayNumber = kycPhonepayNumber;
    _kycPaytmNumber = kycPaytmNumber;
    _kycGooglepayNumber = kycGooglepayNumber;
    _userWallet = userWallet;
    _rewardWallet = rewardWallet;
    _membershipStartedTime = membershipStartedTime;
    _membershipActivateTime = membershipActivateTime;
    _userMemebershipStarted = userMemebershipStarted;
    _userMemebershipExpired = userMemebershipExpired;
    _userIdActiveStatus = userIdActiveStatus;
    _userSuspendedStatus = userSuspendedStatus;
    _isRegister = isRegister;
    _otp = otp;
    _delStatus = delStatus;
    _lastLogin = lastLogin;
    _lastLoginIp = lastLoginIp;
    _createdAt = createdAt;
    _updatedBy = updatedBy;
  }

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _mainUserId = json['main_user_id'];
    _userName = json['user_name'];
    _userUsername = json['user_username'];
    _userEmail = json['user_email'];
    _userPassword = json['user_password'];
    _txtPass = json['txt_pass'];
    _userNumber = json['user_number'];
    _gender = json['gender'];
    _firebaseLink = json['firebase_link'];
    _firebaseText = json['firebase_text'];
    _deviceType = json['device_type'];
    _deviceId = json['device_id'];
    _userNumberCode = json['user_number_code'];
    _userAlternativeNumber = json['user_alternative_number'];
    _userDirectId = json['user_direct_id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _businessType = json['business_type'];
    _userPackage = json['user_package'];
    _userPackageAll = json['user_package_all'];
    _userPackageSum = json['user_package_sum'];
    _userBotbuyTotal = json['user_botbuy_total'];
    _investmentLimit = json['investment_limit'];
    _currentRoiPercentage = json['current_roi_percentage'];
    _daysLeft = json['days_left'];
    _userLevelOpen = json['user_level_open'];
    _userLevel = json['user_level'];
    _todayIncome = json['today_income'];
    _userAddress = json['user_address'];
    _userProfile = json['user_profile'];
    _userCountry = json['user_country'];
    _userState = json['user_state'];
    _userCities = json['user_cities'];
    _userImage = json['user_image'];
    _gradeRank = json['grade_rank'];
    _city = json['city'];
    _kycPanCardName = json['Kyc_pan_card_name'];
    _kycBankAccountNumber = json['Kyc_bank_account_number'];
    _kycBankIfscCode = json['Kyc_bank_ifsc_code'];
    _kycBankName = json['Kyc_bank_name'];
    _kycHolderName = json['Kyc_holder_name'];
    _kycPhonepayNumber = json['Kyc_phonepay_number'];
    _kycPaytmNumber = json['Kyc_paytm_number'];
    _kycGooglepayNumber = json['Kyc_googlepay_number'];
    _userWallet = json['user_wallet'];
    _rewardWallet = json['reward_wallet'];
    _membershipStartedTime = json['membership_started_time'];
    _membershipActivateTime = json['membership_activate_time'];
    _userMemebershipStarted = json['user_memebership_started'];
    _userMemebershipExpired = json['user_memebership_expired'];
    _userIdActiveStatus = json['user_id_active_status'];
    _userSuspendedStatus = json['user_suspended_status'];
    _isRegister = json['is_register'];
    _otp = json['otp'];
    _delStatus = json['del_status'];
    _lastLogin = json['last_login'];
    _lastLoginIp = json['last_login_ip'];
    _createdAt = json['created_at'];
    _updatedBy = json['updated_by'];
  }

  dynamic _userId;
  dynamic _mainUserId;
  dynamic _userName;
  dynamic _userUsername;
  dynamic _userEmail;
  dynamic _userPassword;
  dynamic _txtPass;
  dynamic _userNumber;
  dynamic _gender;
  dynamic _firebaseLink;
  dynamic _firebaseText;
  dynamic _deviceType;
  dynamic _deviceId;
  dynamic _userNumberCode;
  dynamic _userAlternativeNumber;
  dynamic _userDirectId;
  dynamic _latitude;
  dynamic _longitude;
  dynamic _businessType;
  dynamic _userPackage;
  dynamic _userPackageAll;
  dynamic _userPackageSum;
  dynamic _userBotbuyTotal;
  dynamic _investmentLimit;
  dynamic _currentRoiPercentage;
  dynamic _daysLeft;
  dynamic _userLevelOpen;
  dynamic _userLevel;
  dynamic _todayIncome;
  dynamic _userAddress;
  dynamic _userProfile;
  dynamic _userCountry;
  dynamic _userState;
  dynamic _userCities;
  dynamic _userImage;
  dynamic _gradeRank;
  dynamic _city;
  dynamic _kycPanCardName;
  dynamic _kycBankAccountNumber;
  dynamic _kycBankIfscCode;
  dynamic _kycBankName;
  dynamic _kycHolderName;
  dynamic _kycPhonepayNumber;
  dynamic _kycPaytmNumber;
  dynamic _kycGooglepayNumber;
  dynamic _userWallet;
  dynamic _rewardWallet;
  dynamic _membershipStartedTime;
  dynamic _membershipActivateTime;
  dynamic _userMemebershipStarted;
  dynamic _userMemebershipExpired;
  dynamic _userIdActiveStatus;
  dynamic _userSuspendedStatus;
  dynamic _isRegister;
  dynamic _otp;
  dynamic _delStatus;
  dynamic _lastLogin;
  dynamic _lastLoginIp;
  dynamic _createdAt;
  dynamic _updatedBy;

  Data copyWith({
    dynamic userId,
    dynamic mainUserId,
    dynamic userName,
    dynamic userUsername,
    dynamic userEmail,
    dynamic userPassword,
    dynamic txtPass,
    dynamic userNumber,
    dynamic gender,
    dynamic firebaseLink,
    dynamic firebaseText,
    dynamic deviceType,
    dynamic deviceId,
    dynamic userNumberCode,
    dynamic userAlternativeNumber,
    dynamic userDirectId,
    dynamic latitude,
    dynamic longitude,
    dynamic businessType,
    dynamic userPackage,
    dynamic userPackageAll,
    dynamic userPackageSum,
    dynamic userBotbuyTotal,
    dynamic investmentLimit,
    dynamic currentRoiPercentage,
    dynamic daysLeft,
    dynamic userLevelOpen,
    dynamic userLevel,
    dynamic todayIncome,
    dynamic userAddress,
    dynamic userProfile,
    dynamic userCountry,
    dynamic userState,
    dynamic userCities,
    dynamic userImage,
    dynamic gradeRank,
    dynamic city,
    dynamic kycPanCardName,
    dynamic kycBankAccountNumber,
    dynamic kycBankIfscCode,
    dynamic kycBankName,
    dynamic kycHolderName,
    dynamic kycPhonepayNumber,
    dynamic kycPaytmNumber,
    dynamic kycGooglepayNumber,
    dynamic userWallet,
    dynamic rewardWallet,
    dynamic membershipStartedTime,
    dynamic membershipActivateTime,
    dynamic userMemebershipStarted,
    dynamic userMemebershipExpired,
    dynamic userIdActiveStatus,
    dynamic userSuspendedStatus,
    dynamic isRegister,
    dynamic otp,
    dynamic delStatus,
    dynamic lastLogin,
    dynamic lastLoginIp,
    dynamic createdAt,
    dynamic updatedBy,
  }) =>
      Data(
        userId: userId ?? _userId,
        mainUserId: mainUserId ?? _mainUserId,
        userName: userName ?? _userName,
        userUsername: userUsername ?? _userUsername,
        userEmail: userEmail ?? _userEmail,
        userPassword: userPassword ?? _userPassword,
        txtPass: txtPass ?? _txtPass,
        userNumber: userNumber ?? _userNumber,
        gender: gender ?? _gender,
        firebaseLink: firebaseLink ?? _firebaseLink,
        firebaseText: firebaseText ?? _firebaseText,
        deviceType: deviceType ?? _deviceType,
        deviceId: deviceId ?? _deviceId,
        userNumberCode: userNumberCode ?? _userNumberCode,
        userAlternativeNumber: userAlternativeNumber ?? _userAlternativeNumber,
        userDirectId: userDirectId ?? _userDirectId,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        businessType: businessType ?? _businessType,
        userPackage: userPackage ?? _userPackage,
        userPackageAll: userPackageAll ?? _userPackageAll,
        userPackageSum: userPackageSum ?? _userPackageSum,
        userBotbuyTotal: userBotbuyTotal ?? _userBotbuyTotal,
        investmentLimit: investmentLimit ?? _investmentLimit,
        currentRoiPercentage: currentRoiPercentage ?? _currentRoiPercentage,
        daysLeft: daysLeft ?? _daysLeft,
        userLevelOpen: userLevelOpen ?? _userLevelOpen,
        userLevel: userLevel ?? _userLevel,
        todayIncome: todayIncome ?? _todayIncome,
        userAddress: userAddress ?? _userAddress,
        userProfile: userProfile ?? _userProfile,
        userCountry: userCountry ?? _userCountry,
        userState: userState ?? _userState,
        userCities: userCities ?? _userCities,
        userImage: userImage ?? _userImage,
        gradeRank: gradeRank ?? _gradeRank,
        city: city ?? _city,
        kycPanCardName: kycPanCardName ?? _kycPanCardName,
        kycBankAccountNumber: kycBankAccountNumber ?? _kycBankAccountNumber,
        kycBankIfscCode: kycBankIfscCode ?? _kycBankIfscCode,
        kycBankName: kycBankName ?? _kycBankName,
        kycHolderName: kycHolderName ?? _kycHolderName,
        kycPhonepayNumber: kycPhonepayNumber ?? _kycPhonepayNumber,
        kycPaytmNumber: kycPaytmNumber ?? _kycPaytmNumber,
        kycGooglepayNumber: kycGooglepayNumber ?? _kycGooglepayNumber,
        userWallet: userWallet ?? _userWallet,
        rewardWallet: rewardWallet ?? _rewardWallet,
        membershipStartedTime: membershipStartedTime ?? _membershipStartedTime,
        membershipActivateTime:
            membershipActivateTime ?? _membershipActivateTime,
        userMemebershipStarted:
            userMemebershipStarted ?? _userMemebershipStarted,
        userMemebershipExpired:
            userMemebershipExpired ?? _userMemebershipExpired,
        userIdActiveStatus: userIdActiveStatus ?? _userIdActiveStatus,
        userSuspendedStatus: userSuspendedStatus ?? _userSuspendedStatus,
        isRegister: isRegister ?? _isRegister,
        otp: otp ?? _otp,
        delStatus: delStatus ?? _delStatus,
        lastLogin: lastLogin ?? _lastLogin,
        lastLoginIp: lastLoginIp ?? _lastLoginIp,
        createdAt: createdAt ?? _createdAt,
        updatedBy: updatedBy ?? _updatedBy,
      );

  dynamic get userId => _userId;

  dynamic get mainUserId => _mainUserId;

  dynamic get userName => _userName;

  dynamic get userUsername => _userUsername;

  dynamic get userEmail => _userEmail;

  dynamic get userPassword => _userPassword;

  dynamic get txtPass => _txtPass;

  dynamic get userNumber => _userNumber;

  dynamic get gender => _gender;

  dynamic get firebaseLink => _firebaseLink;

  dynamic get firebaseText => _firebaseText;

  dynamic get deviceType => _deviceType;

  dynamic get deviceId => _deviceId;

  dynamic get userNumberCode => _userNumberCode;

  dynamic get userAlternativeNumber => _userAlternativeNumber;

  dynamic get userDirectId => _userDirectId;

  dynamic get latitude => _latitude;

  dynamic get longitude => _longitude;

  dynamic get businessType => _businessType;

  dynamic get userPackage => _userPackage;

  dynamic get userPackageAll => _userPackageAll;

  dynamic get userPackageSum => _userPackageSum;

  dynamic get userBotbuyTotal => _userBotbuyTotal;

  dynamic get investmentLimit => _investmentLimit;

  dynamic get currentRoiPercentage => _currentRoiPercentage;

  dynamic get daysLeft => _daysLeft;

  dynamic get userLevelOpen => _userLevelOpen;

  dynamic get userLevel => _userLevel;

  dynamic get todayIncome => _todayIncome;

  dynamic get userAddress => _userAddress;

  dynamic get userProfile => _userProfile;

  dynamic get userCountry => _userCountry;

  dynamic get userState => _userState;

  dynamic get userCities => _userCities;

  dynamic get userImage => _userImage;

  dynamic get gradeRank => _gradeRank;

  dynamic get city => _city;

  dynamic get kycPanCardName => _kycPanCardName;

  dynamic get kycBankAccountNumber => _kycBankAccountNumber;

  dynamic get kycBankIfscCode => _kycBankIfscCode;

  dynamic get kycBankName => _kycBankName;

  dynamic get kycHolderName => _kycHolderName;

  dynamic get kycPhonepayNumber => _kycPhonepayNumber;

  dynamic get kycPaytmNumber => _kycPaytmNumber;

  dynamic get kycGooglepayNumber => _kycGooglepayNumber;

  dynamic get userWallet => _userWallet;

  dynamic get rewardWallet => _rewardWallet;

  dynamic get membershipStartedTime => _membershipStartedTime;

  dynamic get membershipActivateTime => _membershipActivateTime;

  dynamic get userMemebershipStarted => _userMemebershipStarted;

  dynamic get userMemebershipExpired => _userMemebershipExpired;

  dynamic get userIdActiveStatus => _userIdActiveStatus;

  dynamic get userSuspendedStatus => _userSuspendedStatus;

  dynamic get isRegister => _isRegister;

  dynamic get otp => _otp;

  dynamic get delStatus => _delStatus;

  dynamic get lastLogin => _lastLogin;

  dynamic get lastLoginIp => _lastLoginIp;

  dynamic get createdAt => _createdAt;

  dynamic get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['main_user_id'] = _mainUserId;
    map['user_name'] = _userName;
    map['user_username'] = _userUsername;
    map['user_email'] = _userEmail;
    map['user_password'] = _userPassword;
    map['txt_pass'] = _txtPass;
    map['user_number'] = _userNumber;
    map['gender'] = _gender;
    map['firebase_link'] = _firebaseLink;
    map['firebase_text'] = _firebaseText;
    map['device_type'] = _deviceType;
    map['device_id'] = _deviceId;
    map['user_number_code'] = _userNumberCode;
    map['user_alternative_number'] = _userAlternativeNumber;
    map['user_direct_id'] = _userDirectId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['business_type'] = _businessType;
    map['user_package'] = _userPackage;
    map['user_package_all'] = _userPackageAll;
    map['user_package_sum'] = _userPackageSum;
    map['user_botbuy_total'] = _userBotbuyTotal;
    map['investment_limit'] = _investmentLimit;
    map['current_roi_percentage'] = _currentRoiPercentage;
    map['days_left'] = _daysLeft;
    map['user_level_open'] = _userLevelOpen;
    map['user_level'] = _userLevel;
    map['today_income'] = _todayIncome;
    map['user_address'] = _userAddress;
    map['user_profile'] = _userProfile;
    map['user_country'] = _userCountry;
    map['user_state'] = _userState;
    map['user_cities'] = _userCities;
    map['user_image'] = _userImage;
    map['grade_rank'] = _gradeRank;
    map['city'] = _city;
    map['Kyc_pan_card_name'] = _kycPanCardName;
    map['Kyc_bank_account_number'] = _kycBankAccountNumber;
    map['Kyc_bank_ifsc_code'] = _kycBankIfscCode;
    map['Kyc_bank_name'] = _kycBankName;
    map['Kyc_holder_name'] = _kycHolderName;
    map['Kyc_phonepay_number'] = _kycPhonepayNumber;
    map['Kyc_paytm_number'] = _kycPaytmNumber;
    map['Kyc_googlepay_number'] = _kycGooglepayNumber;
    map['user_wallet'] = _userWallet;
    map['reward_wallet'] = _rewardWallet;
    map['membership_started_time'] = _membershipStartedTime;
    map['membership_activate_time'] = _membershipActivateTime;
    map['user_memebership_started'] = _userMemebershipStarted;
    map['user_memebership_expired'] = _userMemebershipExpired;
    map['user_id_active_status'] = _userIdActiveStatus;
    map['user_suspended_status'] = _userSuspendedStatus;
    map['is_register'] = _isRegister;
    map['otp'] = _otp;
    map['del_status'] = _delStatus;
    map['last_login'] = _lastLogin;
    map['last_login_ip'] = _lastLoginIp;
    map['created_at'] = _createdAt;
    map['updated_by'] = _updatedBy;
    return map;
  }
}
