class Urls {

//////////===================== App Based Url ================////////////////    
  static const String _baseUrl = 'https://foodsflow.netlify.app';

//////////// =============== Register Url =========================//////////////
  static get regiterUrl => Uri.parse("https://foodsflow.netlify.app/api/auth/register");

// ========================== LoginUrl ==========================================////////////
  
  static get loginUrl => Uri.parse("https://foodsflow.netlify.app/api/auth/login");

}