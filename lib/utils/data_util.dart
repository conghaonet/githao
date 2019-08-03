import 'shared_preferences.dart';

class DataUtil {
  static Future clearLoginData() async {
    SpUtil spUtil = await SpUtil.getInstance();
    spUtil.remove(SharedPreferencesKeys.userName);
    spUtil.remove(SharedPreferencesKeys.gitHubAuthorizationBasic);
    spUtil.remove(SharedPreferencesKeys.gitHubAuthorizationToken);
    spUtil.remove(SharedPreferencesKeys.userEntity);
  }
}