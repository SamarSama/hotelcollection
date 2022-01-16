
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotelcollection/cache_data/cache_data_imp_helper.dart';
import 'package:hotelcollection/ui/customerdata.dart';
import 'package:hotelcollection/utils/data/data_helper.dart';
CacheDataImpHelper cacheDataImpHelper=CacheDataImpHelper();


class Logoin{
  void UserLogin(String email,String Password) async{
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: Password
    );
    cacheDataImpHelper.setUserType(DataHelper.USER_TYPE);
    cacheDataImpHelper.setEmail(email);
    cacheDataImpHelper.setPassword(Password);
  //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CustomerData()));
  }
}