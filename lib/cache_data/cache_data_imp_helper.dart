 import 'package:hotelcollection/cache_data/cache_data_helper.dart';
import 'package:hotelcollection/main.dart';
import 'package:hotelcollection/utils/data/data_helper.dart';

class CacheDataImpHelper implements CacheDataHelper{
  @override
  String getEmail() {

    if (prefs.containsKey(DataHelper.EMAIL_KEY)) {
      return  prefs.getString(DataHelper.EMAIL_KEY)?? "";
    }else
      {
        return "";
      }


  }

  @override
  String getPassword() {
    if (prefs.containsKey(DataHelper.PASSWORD_KEY)) {
      return  prefs.getString(DataHelper.PASSWORD_KEY)?? "";
    }else
    {
      return "";
    }

  }

  @override
  void setEmail(String email) {
    prefs.setString(DataHelper.EMAIL_KEY, email);

  }

  @override
  void setPassword(String password) {
    prefs.setString(DataHelper.PASSWORD_KEY, password);

  }

  @override
  String getUserType() {
    if (prefs.containsKey(DataHelper.USER_TYPE_KEY)) {
      return  prefs.getString(DataHelper.USER_TYPE_KEY)?? "";
    }else
    {
      return "";
    }

  }

  @override
  void setUserType(String userType) {
    prefs.setString(DataHelper.USER_TYPE_KEY, userType);
  }

  @override
  String getHotelCode() {
    if (prefs.containsKey(DataHelper.Hotel_Code_KEY)) {
      return  prefs.getString(DataHelper.Hotel_Code_KEY)?? "";
    }else
    {
      return "";
    }
  }

  @override
  void setHotelCode(String hotelcode) {
    prefs.setString(DataHelper.Hotel_Code_KEY, hotelcode);
  }



}