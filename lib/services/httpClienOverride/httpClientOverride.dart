import 'dart:io';

class MyHttpOverride extends HttpOverrides{

  @override
  Future<HttpClient> cretehttpClient(SecurityContext context) async {
    return super.createHttpClient(context)
   ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }

}
