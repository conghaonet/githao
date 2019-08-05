class SharedPreferencesKeys {
  /// boolean
  /// 用于欢迎页面. 只有第一次访问才会显示. 或者手动将这个值设为false
  static String showWelcome = 'loginWelcone';
  /// json 
  /// 用于存放搜索页的搜索数据.
  /// [{
  ///  name: 'name'
  ///  
  /// }]
  static String searchHistory = 'searchHistory';

  static String userName = 'userName';
  static String gitHubAuthorizationBasic = 'gitHubAuthorizationBasic';
  static String gitHubAuthorizationToken = 'gitHubAuthorizationToken';
  static String userEntity = 'userEntity';
  static String themeIndex = 'themeIndex';
//  static String loginTimeMilliseconds = "loginTimeMilliseconds";
}

