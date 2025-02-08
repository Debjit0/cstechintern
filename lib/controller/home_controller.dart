import 'package:cstechintern/model/home_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var homeData = Rxn<HomeModel>();
  var selectedIndex = 0.obs; // Track selected tab

  @override
  void onInit() {
    fetchHomeData();
    super.onInit();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchHomeData() async {
    try {
      final response = await http.get(Uri.parse("http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];
        homeData.value = HomeModel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }
}

