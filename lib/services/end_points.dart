class EndPoints {
  static const String baseUrl = "https://marchaindisersbackend.onrender.com/api/";


  // Auth
  static const String login = "auth/login";
  static const String signup = "auth/signup";
  static const String forgotPassword = "auth/forgotPassword";
  static const String verifyResetCode = "auth/verifyResetCode"; // ✅ FIXED
  static const String changePassword = "auth/changePassword";

  // Main resources
  static const String users = "users";
  static const String markets = "markets";
  static const String branches = "branches";
  static const String tasks = "tasks";
  static const String products = "products";
  static const String rtv = "rtv";
  static const String planogram = "planogram";
}
