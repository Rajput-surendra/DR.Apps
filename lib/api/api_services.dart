import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://developmentalphawizz.com/dr_booking/app/v1/api/";
  static const String baseUrl1 = "https://developmentalphawizz.com/dr_booking/user/app/v1/api/";
  static const String imageUrl = "https://developmentalphawizz.com/dr_booking/";


  static const String userRegister = baseUrl+'user_register';
  static const String getBooking = baseUrl+'bookings';
  static const String cancleBooking = baseUrl+'cancel_booking';
  static const String deleteBooking = baseUrl+'delete_booking';
  static const String sendOTP = baseUrl+'v_send_otp';
  static const String login = baseUrl+'login';
  static const String getupdateUser = baseUrl+'update_user';
  static const String verifyOtp = baseUrl+'v_verify_otp';
  static const String getSlider = baseUrl + 'get_slider_images';
  static const String getPharmaSlider = baseUrl + 'get_slider';
  static const String getUserProfile = baseUrl+'user_profile';
  static const String getEvents = baseUrl+'get_events';
  static const String getWebinar = baseUrl+'get_webinar';
  static const String getNewType = baseUrl+'get_news_type';
  static const String selectCategory = baseUrl+'select_category';
  static const String getCounting = baseUrl+'get_counting';
  static const String getEditorial = baseUrl+'get_editorial';
  static const String addDoctorNews = baseUrl+'add_doctor_news';
  static const String addDoctorAwreness = baseUrl+'add_awareness';
  static const String addDoctorWebiner = baseUrl+'add_doctor_webinar';
  static const String addDoctorEditorial = baseUrl+'add_doctor_editorial';
  static const String addDoctorEvent = baseUrl+'add_doctor_event';
  static const String getAwareness = baseUrl+'get_awareness';
  static const String getSettings = baseUrl+'get_settings';
  static const String getPharmaCategory = baseUrl+'select_category';
  static const String getPharmaProductsCategory = baseUrl+'pharma_category';
  static const String getPharmaProductsCategoryNew = baseUrl+'get_categories_product';
  static const String getPharmaProducts = baseUrl+'get_products';
  static const String getUserCart = baseUrl+'get_user_cart';
  static const String getPlaceOrderApi = baseUrl+'place_order';
  static const String getRemoveCartApi = baseUrl+'remove_from_cart';
  static const String getManageCartApi = baseUrl+'manage_cart';
  static const String addDoctorWebinar = baseUrl+'add_doctor_webinar';
  static const String addNewWishListApi = baseUrl+'add_news_wishlist';
  static const String getNewsWishListApi = baseUrl+'get_news_wishlist';
  static const String getRemoveWishListApi = baseUrl+'remove_wishlist';
  static const String addProductApi = baseUrl+'add_products';
  static const String getHistoryApi = baseUrl+'get_user_history';
  static const String getHistoryDeleteApi = baseUrl+'delete_data';
  static const String getCompaniesApi = baseUrl+'get_companies';
  static const String getCompaniesDropApi = baseUrl+'get_company';
  static const String getStateApi = baseUrl1+'get_states';
  static const String getCityApi = baseUrl1+'get_cities';
  static const String getPlaceApi = baseUrl1+'get_places';
  static const String getSubsriptionApi = baseUrl+'get_plans';
    static const String getPlanPurchasApi = baseUrl+'plan_purchase_success';
    static const String getCheckSubscriptionApi = baseUrl+'check_subscription';
    static const String getUploadBannerApi = baseUrl+'upload_banner';
    static const String getDeleteDoctorPostApi = baseUrl+'delete_doctor_event';
    static const String getDeleteAwarenessApi = baseUrl+'delete_awareness';
    static const String getUpdateClinicDetailsApi = baseUrl+'update_clinic_details';
    static const String addRequestApi = baseUrl+'add_request';
    static const String getRequestApi = baseUrl+'get_request';
    static const String deleteApi = baseUrl+'account_delete';
    static const String getGraphicApi = baseUrl+'get_free_graphics';
    static const String addWishlistApi = baseUrl+'add_wishlists';
    static const String checkMobileEmail = baseUrl+'check_mobile_email';
    static const String createBrandApi = baseUrl+'create_brand';
    static const String getBrandApi = baseUrl+'get_brands';
    static const String getBrandDetailsPlansApi = baseUrl+'get_brand_details_plans';
    static const String addBrandDetailApi = baseUrl+'add_brand_detail';
    static const String addSliderApi = baseUrl+'get_pharma_ads_plans';
}
