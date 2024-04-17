class ApiRoutes {
  static String preProductionUrl = "https://panel.m2x.in/";
  static String baseUrl = preProductionUrl;

   static String preProductionUrl1 = "http://13.235.49.6:9000/";
  static String baseUrl1 = preProductionUrl1;


  //APIs routes
  static String bannerApi = "${baseUrl1}banners";
  // static String mobileNumberApi = "${baseUrl}api/app-login/";
  // static String verifyOTPApi = "${baseUrl}api/app-otpverify/";
  static String googleApi = "http://13.232.241.24:8080/auth/google";
  static String brandApi = "${baseUrl1}brands";
  static String brandModelApi = "${baseUrl1}models";
  static String topRatedPhones = "${baseUrl1}products?highlight=top";
  static String shopBestPhones = "${baseUrl1}categories";
  static String bannerApiApp = "${baseUrl}banners";
  static String verifyOTPApi1 = "${baseUrl1}api/users/verify-otp";
  static String userRegisterWithEmail = "${baseUrl1}users/register";
  static String userLogin = "${baseUrl1}api/users/login-phone";
  static String userProfile = "${baseUrl1}api/users/my-profile";
  static String userUpdatedProfile = "${baseUrl1}api/users/edit-my-profile";
  static String filterFetchProduct = "${baseUrl1}products";
  static String fetchOneProduct = "${baseUrl1}products";
  static String savedAddress = "${baseUrl1}address";
  static String country = "${baseUrl1}countries";
  static String state = "${baseUrl1}states";
  static String city = "${baseUrl1}cities";
  static String recentSearch = "${baseUrl1}recent_searches";
  static String addWishlist = "${baseUrl1}wishlists";
  static String categoriesFetch = "${baseUrl1}api/categories";
  static String speakersFetch = "${baseUrl1}api/users?role=manager";
  static String trendingVideosApi = "${baseUrl1}api/content/get-content?highlight=trending";
  static String bannersApi = "${baseUrl1}api/content/get-content";
  static String bioApi1 = "${baseUrl1}api/users?id=";
  static String bioApi = "${baseUrl1}api/content/get-content?userID=";
  
  
  
}