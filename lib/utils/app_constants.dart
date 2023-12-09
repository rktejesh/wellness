import 'dart:core';

class AppConstants {
  static const String APP_NAME = 'Wellness';
  static const double APP_VERSION = 1.6;
  // static const String THEME = '6ammart_theme';

  static const String domain = "https://www.glamcode.in/";
  static const String base_url = "https://www.glamcode.in/api";
//    static const String base_url = "http://18.217.118.237:8081/api"

  static const String home = "$base_url/home";
  static const String apiGetPackageById = "$base_url/service";
  // static const String apiBlog = "${base_url}/blogs";
  static const String apiBlog = "https://glamcode.in/blog/wp-json/wp/v2/posts";
  static const String apiCategory = "$base_url/category";
  static const String apiLogin = "$base_url/send-otp-code";
  static const String apiOtpVerify = "$base_url/verify-otp-phone";
  static const String updateProfile = "$base_url/profile/";
  static const String gallery = "$base_url/gallery";
  static const String bookings = "$base_url/bookings/";
  static const String aboutdetails = "$base_url/pages/about";
  static const String privacydetails = "$base_url/pages/privacy";
  static const String termsDetails = "$base_url/pages/terms";
  static const String addonDetails = "$base_url/addons";
  static const String editProfile = "$base_url/profile/"; //{id}
  static const String slotDetails = "$base_url/booking-slots/"; //{id}

  static const String addOrUpdateProduct = "$base_url/add-or-update-product";
  static const String deleteProduct = "$base_url/delete-cart-product";
  static const String updateCoupon = "$base_url/update-coupon";
  static const String applyCoupon = "$base_url/apply-coupon";
  static const String makePayment =
      "$base_url/make-payment"; //params ?bookingId=470&userId=575

  static const String searchQuery = "$base_url/search?search_term=";
  static const String addAddress = "$base_url/add-address";
  static const String setPrimaryAddress = "$base_url/set-primary-address";
  static const String getAddressDetails = "$base_url/address-details";
  static const String deleteAddress = "$base_url/delete-address";
  static const String updateAddress = "$base_url/update-address";
  static const String myCart = "$base_url/mycart";

  static const String getLocations = "$base_url/location";
  static const String getMainCategories = "$base_url/main-categories";
  static const String getCategories = "$base_url/categorys";
  static const String getPreferredPackages = "$base_url/preferred-pack";
  static const String getCouponsList = "$base_url/couponslist";
  static const String bookingData = "$base_url/booking-data";
  static const String payments = "$base_url/payments";
  static const String bookService = "$base_url/bookservice";
  static const String getExtraFees = "$base_url/extrafees";
  static const String bookingDetails = "$base_url/bookingDetails";
  static const String bookingDataFull = "$base_url/booking-datafull";

  static const String appkeyid =
      r"Qswde@#$@ESCDdreghreiue#%$#^fkjhdhR$$#hvjkdhkdf%^$$#hdgjdf";
  static const String getanydatacall = "$base_url/getanydatacall";

  static const String postcancelreschedule = "$base_url/cancelreschedule";

  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String MODULE_ID = 'moduleId';
  static const String LOCALIZATION_KEY = 'X-localization';
}
