abstract class AppUrl {
  // static const String baseUrl = "https://stage.raipurhomes.site/"; // For Development only
  static const String baseUrl =
      "https://www.raipurhomes.com/"; // For Production only
  static const String googlePlaceSearchURL =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  static AppUrlEndpoints get authEndPoints => _AuthEndPoints();
}

abstract class AppUrlEndpoints {
  String get register;

  String get login;

  String get otp;

  String get getUserDetails;

  String get updateUserDetails;

  String get getBanner;

  String get postProperty;

  String get getPostProperty;

  String get getTrendingArea;

  String get getFeaturedPropertySell;

  String get getFeaturedPropertyRent;

  String get getSinglePropertyDetails;

  String get getLatestProperty;

  String get getFilterProperty;

  String get getFilterPropertyData;

  String get getAllPropertyList;

  String get getAllPropertyList1;

  String get getSuggestionDataItem;

  String get getFilterTools;

  String get setFavorite;

  String get getBookMarked;

  String get getContactus;

  String get deletePostProperty;

  String get dependencySelect;

  String get exploreView;

  String get getNotifications;

  String get blogView;

  String get blogViewDetails;

  String get ourProjects;

  String get ourProjectsDetails;
}

class _AuthEndPoints implements AppUrlEndpoints {
  @override
  String get register => "api/register_new";

  @override
  String get login => "api/otp-genrate";

  @override
  String get otp => "api/otp-login";

  @override
  String get getUserDetails => "api/get-user-profile";

  @override
  String get updateUserDetails => "api/update-user-profile";

  @override
  String get getBanner => "api/banner";

  @override
  String get postProperty => "api/add-property";

  @override
  String get getPostProperty => "api/get-user-property";

  @override
  String get getTrendingArea => "api/trending-area-raipur";

  @override
  String get getFeaturedPropertySell => "api/featured-property-sale";

  @override
  String get getFeaturedPropertyRent => "api/featured-property-rent";

  @override
  String get getSinglePropertyDetails => "api/view-property-details";

  @override
  String get getLatestProperty => "api/latest-property";

  @override
  String get getFilterProperty => "api/area-property-details";

  @override
  String get getFilterPropertyData => "api/filter-property";

  @override
  String get getAllPropertyList => "api/all-property";

  @override
  String get getAllPropertyList1 => "api/all-property-test";

  @override
  String get getSuggestionDataItem => "api/suggestion-property";

  @override
  String get getFilterTools => "api/get-nav-tools";

  @override
  String get setFavorite => "api/submit-bookmark-property";

  @override
  String get getBookMarked => "api/bookmark-property";

  @override
  String get getContactus => "api/contact-us";

  @override
  String get deletePostProperty => "api/delete-User-Property";

  @override
  String get dependencySelect => "api/dependancy-select";

  @override
  String get exploreView => "api/explore-view";

  @override
  String get getNotifications => "api/getNotifications";

  @override
  String get blogView => "api/our-blog";

  @override
  String get blogViewDetails => "api/blog-details";

  @override
  String get ourProjects => "api/our-projects";

  @override
  String get ourProjectsDetails => "api/our-projects-details";
}
