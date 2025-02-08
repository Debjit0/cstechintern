class HomeModel {
  final List<String> bannerOne;
  final List<Category> categories;
  final List<Product> products;
  final List<Product> newArrivals;
  final List<Product> featuredLaptops;

  HomeModel({
    required this.bannerOne,
    required this.categories,
    required this.products,
    required this.newArrivals,
    required this.featuredLaptops,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      bannerOne: List<String>.from(json['banner_one'].map((e) => e['banner'])),
      categories: List<Category>.from(json['category'].map((e) => Category.fromJson(e))),
      products: List<Product>.from(json['products'].map((e) => Product.fromJson(e))),
      newArrivals: List<Product>.from(json['new_arrivals'].map((e) => Product.fromJson(e))),
      featuredLaptops: List<Product>.from(json['featured_laptop'].map((e) => Product.fromJson(e))),
    );
  }
}

class Category {
  final String label;
  final String icon;

  Category({required this.label, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(label: json['label'], icon: json['icon']);
  }
}

class Product {
  final String label;
  final String icon;
  final String? offer;
  final String? price;

  Product({required this.label, required this.icon, this.offer, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      label: json['label'],
      icon: json['icon'],
      offer: json['offer'],
      price: json['price'],
    );
  }
}
