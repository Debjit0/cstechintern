import 'package:cstechintern/model/home_model.dart';
import 'package:cstechintern/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cstechintern/controller/home_controller.dart';
import 'package:restart_app/restart_app.dart';

class MainScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<Widget> pages = [
    HomePage(),
    CategoriesPage(),
    DealsPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer), label: "Deals"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          )),
          floatingActionButton: FloatingActionButton(onPressed: (){}, child:Icon(Icons.chat),backgroundColor: const Color.fromARGB(255, 196, 69, 60),),
    );
  }
}

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("DealsDray"),
        actions: [
          IconButton(
              onPressed: () async {
                await StorageService.logout();
                Restart.restartApp();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final data = controller.homeData.value;
        if (data == null) {
          return Center(child: Text("Failed to load data"));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(data.bannerOne),
              SizedBox(height: 10),
              _buildCategoryGrid(data.categories),
              SizedBox(height: 20),
              _buildSection("Products", data.products),
              _buildSection("New Arrivals", data.newArrivals),
              _buildSection("Featured Laptops", data.featuredLaptops,
                  isLaptop: true),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBanner(List<String> banners) {
    return Container(
      height: 150,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          return Image.network(banners[index], fit: BoxFit.cover);
        },
      ),
    );
  }

  Widget _buildCategoryGrid(List<Category> categories) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.network(categories[index].icon, height: 50),
              SizedBox(height: 5),
              Text(categories[index].label,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Product> items,
      {bool isLaptop = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: isLaptop ? 180 : 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                width: isLaptop ? 160 : 130,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Image.network(items[index].icon, height: 100),
                    SizedBox(height: 5),
                    Text(items[index].label,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        maxLines: 2),
                    if (isLaptop && items[index].price != null)
                      Text("\$${items[index].price}",
                          style: TextStyle(color: Colors.red)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("Categories Page", style: TextStyle(fontSize: 18))),
    );
  }
}

class DealsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Deals Page", style: TextStyle(fontSize: 18))),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Cart Page", style: TextStyle(fontSize: 18))),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Profile Page", style: TextStyle(fontSize: 18))),
    );
  }
}
