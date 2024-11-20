
import 'package:encrypt/encrypt.dart' as encrypt;

final keyEncryption = encrypt.Key.fromUtf8('4107417122625538');
final initVectorEncryption = encrypt.IV.fromUtf8('sararihamenacher');
final encrypter =
    encrypt.Encrypter(encrypt.AES(keyEncryption, mode: encrypt.AESMode.cbc));

String myDecrypter(String value) {
  return encrypter.decrypt(encrypt.Encrypted.fromBase64(value),
      iv: initVectorEncryption);
}

String myEecrypter(String value) {
  return encrypter.encrypt(value, iv: initVectorEncryption).base64;
}

