const String etatPhoneNumberMTTL = 'ماتل';
const String etatPhoneNumberMRTL = 'موريتل';
const String etatPhoneNumberCHTL = 'شينقيتل';
const String etatPhoneNumberMNQU = 'غير مكتمل';
const String etatPhoneNumberINCR = 'غير صحيح';

const String sharedPreferencesID = 'id';
const String sharedPreferencesPhone = 'phone';
const String sharedPreferencesPassword = 'password';
const String sharedPreferencesLogined = 'logined';
const String sharedPreferencesAsk = 'ask';
const String sharedPreferencesAnswer = 'answer';
const String sharedPreferencesDRC = 'drc';
const String sharedPreferencesING = 'ing';
const String sharedPreferencesMyCodes = 'mycodes';

const String mapEmail = 'email';
const String mapPassword = 'password';

const String usersCollection = 'users';
const String userCollectionNom = 'nom'; // String
const String userCollectionPhone = 'phone'; // String
const String userCollectionPassword = 'pssword'; // String
const String userCollectionScoolsCodes = 'schoolscodes'; // map
const String userCollectionSecurityAsk = 'securityask'; // String
const String userCollectionSecurityAnswer = 'securityanswer'; // String
const String userCollectionDRC = 'drc'; // bool
const String userCollectionING = 'ing'; // bool
const String userCollectionToken = 'token'; // String
const String userCollectionTokenNotifications = 'tokennotifications'; // String

const String schoolsCollection = 'schools';
const String schoolCollectionNomEcole = 'nomecole'; // String
const String schoolCollectionPhone = 'phone'; // String
const String schoolCollectionMachines = 'machines'; // map
const String schoolCollectionPossibleM = 'possiblem'; // bool
const String schoolCollectionPossibleT = 'possiblet'; // bool
const String schoolCollectionTokenValid = 'tokenvalid'; // int
const String schoolCollectionTimesRefresh = 'timesrefresh'; // map
const String schoolCollectionTokensCRS = 'tokenscrs'; // map
const String schoolCollectionTokensENS = 'tokensens'; // map
const String schoolCollectionTokensPRT = 'tokensprt'; // map
const String schoolCollectionTokensDRG = 'tokensdrg'; // map
const String schoolCollectionTokensDRL = 'tokensdrl'; // map
const String schoolCollectionTokensCNG = 'tokenscng'; // map
const String schoolCollectionTokensCMP = 'tokenscmp'; // map
const String schoolCollectionTokensPLT = 'tokensplt'; // map
const String schoolCollectionTokensGRD = 'tokensgrd'; // map
const String schoolCollectionTokensATR = 'tokensatr'; // map

const String propreCollection = 'propre';
const String propreCollectionSecret = 'secret'; // String
const String propreCollectionToken = 'token'; // String

const double periodSecond = 1;
const double periodHour = 3600;
const double periodDay = 86400;
const double periodWeek = 604800;
const double periodMonth = 2628000;
const double periodYear = 31557600;

const String periodSecondName = 'ثانية';
const String periodHourName = 'ساعة';
const String periodDayName = 'يوم';
const String periodWeekName = 'اسبوع';
const String periodMonthName = 'شهر';
const String periodYearName = 'سنة';

String devoirJustifier = "غ.م";

String statusInstallation = "installation";
String statusActivation = "activation";
String statusDistrubition = "distrubition";
String statusEcole = "ecole";
String statusEtudiant = "etudiant";
String statusNotes = "notes";
String statusAbsence = "absence";
String statusEnsegnat = "ensegnat";
String statusEmploisEns = "emploisens";
String statusNotifyPay = "notifypay";
String statusNotifyDette = "notifydette";

String keyQRstatus = "status";
String keyQRecoleID = "ecoleID";
String keyQRmachineID = "machineID";
String keyQRstart = "start";
String keyQRend = "end";
String keyQRtoken = "token";
String keyQRusername = "username";
String keyQRfullname = "fullname";
String keyQRecolename = "ecolename";
String keyQRvalidate = "validate";
String keyQRtel = "tel";
String keyQRprofiles = "profiles";
String keyQRclasse = "classe";
String keyQRmatiere = "matiere";
String keyQRmoyenne = "moyenne";
String keyQRexamen = "examen";
String keyQRdate = "date";
String keyQRheure = "heure";
String keyQRclasseid = "classeid";
String keyQRprofile = "profile";
String keyQRmessage = "message";

String keyProfile = "profile";

String typeCRS = "وكيل";
String typeFRS = "مورد";
String typeENS = "مدرس";
String typePRT = "شريك";
String typeDRG = "مدير";
String typeDRL = "مدير دروس";
String typeCNG = "مراقب عام";
String typeCMP = "محاسب";
String typePLT = "بواب";
String typeGRD = "حارس";
String typeATR = "غير مصنفة";

String keyPage = "page";

String rootPageCorrespondant = "/correspondant";
String rootPageFournisseur = "/fournisseur";
String rootPageEnseignant = "/enseignant";
String rootPageLesseneur = "/lesseneur";
String rootPageControlleur = "/controlleur";
String rootPageComptable = "/comptable";

String keyImage = "image";

String notificationStatusKey = 'notifstatus';
String statusHeurePointage = 'statusHeure';




/*
Stack(
        children: [
          const ContainerNormal(
            child: Column(
              children: [],
            ),
          ),
          GetBuilder<HomeController>(
            builder: (controller) => Container(
              child: controller.loading == true
                  ? const ContainerIndicator()
                  : null,
            ),
          )
        ],
      ),
*/