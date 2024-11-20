import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/controllers/ecole_controller.dart';
import 'package:my_school_rim/tools/functions/show_snackbar.dart';
import 'package:my_school_rim/views/pages/controlleur_page.dart';
import 'package:my_school_rim/views/pages/enseignant_page.dart';
import 'package:my_school_rim/views/pages/lesseneur_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/comptable_controller.dart';
import 'controllers/comptes_controller.dart';
import 'controllers/controlleur_controller.dart';
import 'controllers/correspondant_controller.dart';
import 'controllers/creer_compte_controller.dart';
import 'controllers/enseignant_controller.dart';
import 'controllers/etudiant_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/lesseneur_coltroller.dart';
import 'controllers/login_controller.dart';
import 'controllers/notifications_controller.dart';
import 'controllers/profiles_controller.dart';
import 'controllers/version_activate_controller.dart';
import 'controllers/version_distribue_controller.dart';
import 'controllers/version_install_controller.dart';
import 'tools/constants/expression.dart';
import 'views/pages/comptable_page.dart';
import 'views/pages/correspondant_page.dart';
import 'views/pages/start_page.dart';

// 15/02/2024

SharedPreferences? mySharedPreferences;

String? myToken;

var fbm = FirebaseMessaging.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((event) {
    showNotification(
      titleText: '${event.notification!.title}',
      messageText: '${event.notification!.body}',
    );
  });
  mySharedPreferences = await SharedPreferences.getInstance();
  await fbm.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  fbm.getToken().then((value) {
    myToken = value;
    print('Token $value');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
      locale: const Locale('ar', ''), // Set the default locale to Arabic
      debugShowCheckedModeBanner: false,
      //locale: Get.deviceLocale,
      //translations: MyTranslation(),
      theme: ThemeData(
        fontFamily: 'AmiriR',
      ),
      initialBinding: MyBinding(),
      //initialRoute: RooteConstants.startRoot,
      getPages: [
        GetPage(name: "/", page: () => const StartPage()),
        GetPage(name: rootPageCorrespondant, page: () => CorrespondantPage()),
        GetPage(name: rootPageComptable, page: () => ComptablePage()),
        GetPage(name: rootPageControlleur, page: () => ControlleurPage()),
        GetPage(name: rootPageEnseignant, page: () => EnseignantPage()),
        GetPage(name: rootPageLesseneur, page: () => LesseneurPage()),
      ],
    );
  }
}

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => CreerCompteController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ComptesController(), fenix: true);
    Get.lazyPut(() => VersionInstallController(), fenix: true);
    Get.lazyPut(() => VersionActivateController(), fenix: true);
    Get.lazyPut(() => VersionDistributionController(), fenix: true);
    Get.lazyPut(() => EcoleController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ProfilesController(), fenix: true);
    Get.lazyPut(() => CorrespondantController(), fenix: true);
    Get.lazyPut(() => ComptableController(), fenix: true);
    Get.lazyPut(() => ControlleurController(), fenix: true);
    Get.lazyPut(() => EnseignantController(), fenix: true);
    Get.lazyPut(() => LesseneurController(), fenix: true);
    Get.lazyPut(() => EtudiantController(), fenix: true);
  }
}
