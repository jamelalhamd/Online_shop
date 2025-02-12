import 'package:shopping/modal/itemmodal.dart';
import 'package:shopping/service_akutz/api.dart';

class Allcategoreitems {
  Future<List<Producktmodal>> getallitems({required String link}) async {
    List<Producktmodal> items = [];

    try {
      // Await the response from the API
      var data = await Api().get(link: link);

      if (data is List) {
        // Check if data is a valid list
        for (var item in data) {
          items.add(Producktmodal.fromJson(item));
        }
      } else {
        throw Exception(
            "Expected a List from API, but got ${data.runtimeType}");
      }
    } catch (e) {
      print("Error fetching items: ${e.toString()}");
      throw Exception("Error fetching items: ${e.toString()}");
    }

    return items;
  }
}
