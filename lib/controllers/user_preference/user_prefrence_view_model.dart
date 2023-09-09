import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/login_model.dart';

class UserPreference {
  Future<bool> saveUser(LoginModel responseModel) async {
    print('Saving user...');

    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString('token', responseModel.data!.bearerToken ?? '');
    sp.setInt('user', responseModel.data!.user!);
    sp.setBool('isLogin', responseModel.isLogin ?? false);
    print('User saved.');
    return true;
  }


  Future<LoginModel> getUser() async {
    print('Getting user...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    int? user = sp.getInt('user');
    bool? isLogin = sp.getBool('isLogin');
    print('User got.');
    return LoginModel(
      data: Data(bearerToken: token,user:user,),
      isLogin: isLogin,
    );
  }

  Future<bool> removeUser() async {
    print('Removing user...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    print('User removed.');
    return true;
  }
}
