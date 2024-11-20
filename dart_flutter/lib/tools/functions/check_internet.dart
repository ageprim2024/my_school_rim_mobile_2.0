
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

Future<bool> checkInternetConnectivity() async {
  try {
    final response = await http.head(Uri.parse('http://www.google.com'));
    return response.statusCode == 200;
  } catch (e) {
    return false; // Request failed, hence no internet
  }
}

Future<bool> checkInternetConnectivity2() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}