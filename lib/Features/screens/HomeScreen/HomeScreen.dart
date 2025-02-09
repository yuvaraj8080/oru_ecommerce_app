import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_ecommerce_app/Features/controllers/homeController/ProdcutController.dart';
import 'package:oru_ecommerce_app/Features/screens/HomeScreen/widgets/TProductCardVertical.dart';
import 'package:oru_ecommerce_app/Features/screens/HomeScreen/widgets/brand_home_category.dart';
import 'package:oru_ecommerce_app/Features/screens/HomeScreen/widgets/home_categories.dart';
import 'package:oru_ecommerce_app/Features/screens/HomeScreen/widgets/promo_slider.dart';
import 'package:oru_ecommerce_app/utils/constants/image_string.dart';
import 'package:oru_ecommerce_app/utils/validators/validator.dart';
import '../../../common/shimmers/vertical_productShimmer.dart';
import '../../../common/widgets.Login_Signup/appBar/appbar.dart';
import '../../../common/widgets.Login_Signup/layout/TExpanstionTileFAQ.dart';
import '../../../common/widgets.Login_Signup/layout/TRounded_ListView.dart';
import '../../../common/widgets.Login_Signup/layout/grid_layout.dart';
import '../../../utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    List<String> names = ["Sell Used Phone", "Buy Used Phone", "Compare Price", "My Profile", "My Listing", "Services", "Register your Store", "Get the App"];

    return Scaffold(
      appBar: TAppBar(
        leadingIcon: Icons.list,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(TImages.oruApp, width: 50),
            Row(
              children: [
                Text("India ", style: Theme.of(context).textTheme.bodyMedium),
                Icon(Icons.location_on_outlined)
              ],
            ),
          ],
        ),
        actions: [
          Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: TColors.homeButtonColor,
            ),
            child: Center(child: Text("Login")),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  // controller: controller.mobileNumber,
                  validator: (value) => TValidator.validateEmptyText("Name", value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: TColors.homeButtonColor,
                    hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    hintText: 'Search phone with make, model..',
                    suffixIcon: Icon(Icons.mic_none_outlined),
                  ),
                ),
                const SizedBox(height: 16),

                TScrollableListView(names: names),

              ],
            ),
          ),
          // This is the scrollable part
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // PROMO BANNER SLIDER
                    const SizedBox(height: 16),
                    TPromoSlider(),

                    // WHATS ON YOUR MIND
                    const SizedBox(height: 16),
                    Text("What's on your mind?", style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),

                    THomeCategories(),

                    // TOP BRANDS
                    const SizedBox(height:28),
                    Text("Top Brands", style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 10),
                    TBrandHomeCategory(),

                    // FETCHED PRODUCT HERE
                    const SizedBox(height:28),
                    Text("Best Deal in India", style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 10),

                    Obx(() {
                      if (productController.isLoading.value) {
                        return const TVerticalProductShimmer();
                      }
                      if (productController.products.isEmpty) {
                        return Center(child: Text("NO Data Found!", style: Theme.of(context).textTheme.bodyLarge));
                      }
                      return TGridLayout(
                        itemBuilder: (_, index) => TProductCardVertical(
                          product: productController.products[index],
                        ),
                        itemCount: productController.products.length,
                      );
                    }),

                    // FAQ SECTION THROUGH API
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Frequently Asked Questions", style: Theme.of(context).textTheme.titleMedium),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Obx(() {
                      if (productController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (productController.FastList.isEmpty) {
                        return Center(child: Text("No FAQs available"));
                      }
                      return TExpansionTileFAQ(productController: productController);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}