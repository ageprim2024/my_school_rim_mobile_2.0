import '../constants/expression.dart';

String getCompagneTel(String phoneNumber){
   RegExp chiguitel = RegExp('^([2])');
  RegExp matel = RegExp('^([3])');
  RegExp mauritel = RegExp('^([4])');
  if (chiguitel.hasMatch(phoneNumber) && phoneNumber.length == 8) {
    return etatPhoneNumberCHTL;
  } else if (matel.hasMatch(phoneNumber) && phoneNumber.length == 8) {
    return etatPhoneNumberMTTL;
  } else if (mauritel.hasMatch(phoneNumber) && phoneNumber.length == 8) {
    return etatPhoneNumberMRTL;
  }  else if (phoneNumber.length <= 8) {
    return etatPhoneNumberMNQU;
  } else {
    return etatPhoneNumberINCR;
  }
}