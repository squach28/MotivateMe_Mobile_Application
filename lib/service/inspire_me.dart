import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify.dart';
import 'dart:math';

class InspireMeService {
  Future<String> inspireMe() async {
    Random random = Random();
    try {
      var picture = random.nextInt(4);
      GetUrlResult result = await Amplify.Storage.getUrl(key: picture.toString());
      return result.url;
    } on StorageException catch (e) {
      print(e.message);
    }
  }
}
