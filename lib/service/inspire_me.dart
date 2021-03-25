import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify.dart';

class InspireMeService {
  Future<String> inspireMe() async {
    try {
      GetUrlResult result = await Amplify.Storage.getUrl(key: "b62b063.png");
      return result.url;
    } on StorageException catch (e) {
      print(e.message);
    }
  }
}
