import 'package:get/get.dart';


class Banner {
  final String imageUrl;

  Banner({required this.imageUrl});
}

class Category {
  final String image;

  Category({required this.image});
}

class DrawerImages {
  final String drawerImage;
  final String label;

  DrawerImages({required this.label,required this.drawerImage});
}


class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  ///---VARIABLE-----
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final banners = <Banner>[].obs; // Dummy banner list
  final drawerImages = <DrawerImages>[].obs; // Dummy banner list
  final featuredCategories = <Category>[].obs; // Dummy category list


  @override
  void onInit() {
    super.onInit();
    _loadDummyBanners();
    _loadDummyCategories();
    loadDrawerDummyImages();
  }

  /// LOAD DRAWER DUMMY IMAGES ////
  void loadDrawerDummyImages() {
    isLoading.value = true;

    // Simulate a network call with a delay
    Future.delayed(Duration(seconds: 1), () {
      drawerImages.value = [
        DrawerImages(drawerImage: 'assets/images/images/img_2.png',label: 'How to Buy'),
        DrawerImages(drawerImage: 'assets/images/images/img_3.png',label:'How to Sell'),
        DrawerImages(drawerImage: 'assets/images/images/img_4.png',label:'Oru Guide'),
        DrawerImages(drawerImage: 'assets/images/images/img_5.png',label:"About Us"),
        DrawerImages(drawerImage: 'assets/images/images/img_6.png',label:"Privacy Policy"),
        DrawerImages(drawerImage: 'assets/images/images/img_7.png',label:"FAQs"),
      ];
      isLoading.value = false;
    });
  }





  /// LOAD DUMMY BANNERS
  void _loadDummyBanners() {
    isLoading.value = true;

    // Simulate a network call with a delay
    Future.delayed(Duration(seconds: 1), () {
      banners.value = [
        Banner(imageUrl: 'assets/images/banners/img.png'),
        Banner(imageUrl: 'assets/images/banners/img_1.png'),
        Banner(imageUrl: 'assets/images/banners/img_2.png'),
        Banner(imageUrl: 'assets/images/banners/img_3.png'),
        Banner(imageUrl: 'assets/images/banners/img_5.png'),
      ];
      isLoading.value = false;
    });
  }




  /// LOAD DUMMY CATEGORIES
  void _loadDummyCategories() {
    isLoading.value = true;

    // Simulate a network call with a delay
    Future.delayed(Duration(seconds: 1), () {
      featuredCategories.value = [
        Category(image: 'assets/icons/categories/img.png'),
        Category(image: 'assets/icons/categories/img_1.png'),
        Category(image: 'assets/icons/categories/img_2.png'),
        Category(image: 'assets/icons/categories/img_3.png'),
        Category(image: 'assets/icons/categories/img_4.png'),
        Category(image: 'assets/icons/categories/img_5.png'),
        Category(image: 'assets/icons/categories/img_6.png'),
        Category(image: 'assets/icons/categories/img_7.png'),
        Category(image: 'assets/icons/categories/img_8.png'),
        Category(image: 'assets/icons/categories/img_9.png'),
        Category(image: 'assets/icons/categories/img_10.png'),
        Category(image: 'assets/icons/categories/img_11.png'),
        Category(image: 'assets/icons/categories/img_12.png'),
        Category(image: 'assets/icons/categories/img_13.png'),
        Category(image: 'assets/icons/categories/img_14.png'),
        Category(image: 'assets/icons/categories/img_15.png'),
      ];
      isLoading.value = false;
    });
  }


  /// UPDATE PAGE NAVIGATION DOTS
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
}