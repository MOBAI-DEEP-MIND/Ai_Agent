class AppSecrets {
  // routes  of backend
  static const String baseUrl = 'http://192.168.62.84:8000/api/v1';
  static const String booksEndPoint = '$baseUrl/book/';
  static const String recommendedbooksEndPoint = '$baseUrl/book-recommendation/';
  static const String categoriesEndPoint = '$baseUrl/categories/';
  static const String searchEndpoint = '$baseUrl/search/';
  static const String signUpEndpoint='$baseUrl/signup/';
  static const String signInEndpoint='$baseUrl/login/';
  static const String searchIA='$baseUrl/query/';

  static const String addBookCart='$baseUrl/busket/';

  static const String getBookCart='$baseUrl/busket/';
  
}
