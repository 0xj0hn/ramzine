import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:convert/convert.dart';

class Encryption {
  Future<String> encrypt(String key, String plainText) async {
    key = generateMd5(key);
    String ivString = key.substring(0, key.length ~/ 2);
    List<int> plainTextCodes = utf8.encode(plainText);
    List<int> secretKeyCodes = utf8.encode(key);
    final secretKey = SecretKey(secretKeyCodes);
    final algorithm = AesCbc.with256bits(macAlgorithm: MacAlgorithm.empty);
    final List<int> iv = utf8.encode(ivString);
    final secretBox = await algorithm.encrypt(plainTextCodes,
        secretKey: secretKey, nonce: iv);

    return base64Encode(secretBox.cipherText);
  }

  String generateMd5(String input) {
    return hex.encode(md5.convert(utf8.encode(input)).bytes);
  }

  decrypt(String key, String cipherText) async {
    key = generateMd5(key);
    String ivString = key.substring(0, (key.length / 2).toInt());
    List<int> cipherTextCodes = base64Decode(cipherText);
    List<int> secretKeyCodes = utf8.encode(key);
    SecretKey secretKey = SecretKey(
      secretKeyCodes,
    );
    List<int> iv = utf8.encode(ivString);
    final algorithm = AesCbc.with256bits(macAlgorithm: MacAlgorithm.empty);
    final SecretBox secretBox = SecretBox(
      cipherTextCodes,
      nonce: iv,
      mac: Mac.empty,
    );
    final plainText = await algorithm.decrypt(secretBox, secretKey: secretKey);
    return utf8.decode(plainText);
  }
}
