import 'dart:convert';

import 'package:http/http.dart' as httpp;
import 'package:googleapis_auth/auth_io.dart' as auth;

class MyNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "myschoolrim",
      "private_key_id": "a51eccc8de52b2fd4120b55bba6b789c1e33246e",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCfQ6Kg69L37n7n\np3IzkKx6t0ISg5oZK56zCakt5UNY66867qtYy2Mbzl6gxavr6ziirAWSVMcc+AOa\nEw97I5HfmiQiVqY0oGCIr7ICDBwrczgp6WJj3PCIWv2sDdWj3m/oczWLyZ010x2K\nU8loJnUd0O201Pe2qun5uUMiY8y16kGw31hSVWH4NwYzXyEEgogq0oa9P6GwNtyT\nn+sfNohWoXECUfvGtIs4DTQtlXs5i18dYg5lNT3yYCYmlc5ToFqOWDeFGWuCuStY\n2SCV7q7GZ8oW8hfKgzHdP97OQ9AqeWb6PZs5MS5Wd6mxlXfB92rw3MGVrVRS8H4+\nqUQgLOybAgMBAAECggEAIso3gEeDcj1a42ekfrcftj7J5BlzVAQ/SoTVu/zU1VvG\nj20LaP4kzDIsYZpMj+B2IrLJFMoIJL/YqZN4UkHW361gL1AWRnCyJambjO7wSF2G\n60DcCUx+Dosx1p+/B2jTsUdZbwu/l75iOZFL8cBU3QqConnTEsgLDE336E88rJAD\nHKkwV2GdaEvhRITbKfK/43fh36nXF1lMrk0PirqTijY/j0dKNxUVdvENEOszbpvd\nKx29AWUIvzmX66LdK9mQlifETwfUxSyID+I0uPlGBWOrMwESGAIAr6jZaM+DN061\n/ny7RGhKTzF/Fj5+hlEqvujzgaWQsZcok1qF9f8DYQKBgQDXIxwbKMNOR9sv71UA\nYeg736mlCeir2lVE97PiLS9mhVmClrL7g8rk5zCkGcQ0azrcAzumVOaFYsPuGb3+\nOeZUDLTsfpBI7zPkXh+NRm5SiftOn/D+kQHDy990r778ehoewCI0Mz953/xLeNki\nK+ThHsH//+sbsSbyaxaI+BL57QKBgQC9g75JGPDozyoYx69vaMYKYFYQRgyqIx/2\n5FlebPJ9yfP/M8csWhm0+o2quOZxVTrFf6sW5P8SUw4tzLQtZX9vlikBzU98nMvI\nOUWLq/Ouls4t86xjqpcXM+W5ahubtA6leoFe2T8xbp4Evol2wsh8zRpa94TO20x5\n0/JpmuMPpwKBgQCGSAnhAd512+/5yX7a0EGuLXqr4rVxnsOeWqXSxLVTXmRyWDG7\nP5XCrnLz2olW1p9UeEghF9kS5IS69yJZrjYPvCapfo38mCFhp0Y2XgG6TxmnB7na\nixP47CW7pX6mBGiNTQuMXXh/T8kgKnwNEiy4PwSED27mR/qxURotv/nIOQKBgQCw\n1CJS1kDDGbmv0XJyQ5K1z9m96X6bqZaDqeFxZ7qDgFJ4hvmK+q8N3NMevtPWX64s\n5cjf3d/aW0DZny1nRlM37SZqFgXawfqq4jVv84u2FeRfoAP0IxJDhhsNfGIyUDly\nUfIwbAi4uPwcdSSSeYDUYhP7WQTEdn7PFeIUg37l9QKBgQCCwzg9FWIQNgx65im4\nqMNdEjL1HKlTnjieybZaLx0RS6+FDzdL2uuDFjzQfXtV94wiL+7d/pdrDgfwKFCP\nG7+uuuDQbTevXm1L+ho1R808+YCe3h/8tWj0EF4rZWRlxyuserCR0vn+BPK5yVst\nxTA0ZcT2aZtw4fRNoag7pyKCiQ==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "notifications-my-school-rim@myschoolrim.iam.gserviceaccount.com",
      "client_id": "108696257769554585571",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/notifications-my-school-rim%40myschoolrim.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    httpp.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();

    return credentials.accessToken.data;
  }

  static Future<String> sendNotification(
      String deviceToken, String title, String body) async {
    try {
      final String serverAccessTokenKey = await getAccessToken();

      String endpointFirebaseCloudMessaging =
          'https://fcm.googleapis.com/v1/projects/myschoolrim/messages:send';

      final Map<String, dynamic> message = {
        'message': {
          'token': deviceToken,
          'notification': {'title': title, 'body': body},
          'data': {}
        },
        //'priority': 'high',
      };

      final httpp.Response response = await httpp.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessTokenKey',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "NOK";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
