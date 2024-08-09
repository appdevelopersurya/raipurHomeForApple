import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../data/modal/SentOtpResponseModel.dart';

final box = GetStorage();

class GetStorageHelper {
  static setinitialdata() {
    box.writeIfNull('is_logged_raipurHome', false);
    box.writeIfNull('otp_raipurHomes', "");
    box.writeIfNull('cust_id_raipurHomes', "");
    box.writeIfNull('name_raipurHomes', "");
    box.writeIfNull('phone_raipurHomes', "");
    box.writeIfNull('email_raipurHomes', "");
    box.writeIfNull('status_raipurHomes', "");
    box.writeIfNull('access_token_raipurHomes', "");
    box.writeIfNull('address_raipurHomes', "");
    box.writeIfNull('profile_pic_raipurHomes', "");
    box.writeIfNull('gender_raipurHomes', "");
    box.writeIfNull('adhar_raipurHomes', "");
  }

  static setdata(SentOtpResponseModel otpResponseModal) {
    box.write('is_logged_raipurHome', true);
    box.write('cust_id_raipurHomes', otpResponseModal.data?.id);
    box.write('phone', otpResponseModal.data?.number);
    box.write('status', otpResponseModal.data?.status);
    box.write('access_token_raipurHomes', otpResponseModal.data?.token);
    // box.write('device_token_raipurHomes', otpResponseModal.data?[0].deviceToken);

    if (kDebugMode) {
      print('is_logged_raipurHome: ${box.read('is_logged_raipurHome')}');
    }
    if (kDebugMode) {
      print('cust_id_raipurHomes: ${box.read('cust_id_raipurHomes')}');
    }
    if (kDebugMode) {
      if (kDebugMode) {
        print('phone: ${box.read('phone')}');
      }
    }
    if (kDebugMode) {
      print('status: ${box.read('status')}');
    }
    if (kDebugMode) {
      print(
          'access_token_raipurHomes: ${box.read('access_token_raipurHomes')}');
    }
    // Uncomment if you add device_token_raipurHomes writing above
    // print('device_token_raipurHomes: ${box.read('device_token_raipurHomes')}');
  }

  static clearDataIfLogged() {
    box.write('is_logged_raipurHome', false);
    box.write('otp_raipurHomes', "");
    box.write('cust_id_raipurHomes', "");
    box.write('name_raipurHomes', "");
    box.write('phone_raipurHomes', "");
    box.write('email_raipurHomes', "");
    box.write('status_raipurHomes', "");
    box.write('access_token_raipurHomes', "");
    box.write('address_raipurHomes', "");
    box.write('profile_pic_raipurHomes', "");
    box.write('gender_raipurHomes', "");
    box.write('adhar_raipurHomes', "");

    if (kDebugMode) {
      print('All data cleared and is_logged_raipurHome set to false');
    }
  }
}
