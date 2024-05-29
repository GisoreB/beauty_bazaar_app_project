import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beauty_bazaar_app/presentation/details_page.dart';
import 'package:beauty_bazaar_app/controller/product_controller.dart';
import 'package:beauty_bazaar_app/utilities/components/product_tile.dart';
import 'package:get/get.dart';


class HomePage extends StatelessWidget {

  final ProductController homeController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromARGB(255, 165, 32, 32),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white,),
                        onPressed: () {}
                    ),

                    const Spacer(flex: 4,),
                    const Text(
                      'Beauty Bazaar App',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                    const Spacer(flex: 1,),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Obx(() =>
            homeController.isLoading.value?
            const Center(child: CircularProgressIndicator()):
            ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              scrollDirection: Axis.vertical,
              itemCount: homeController.productList.length,
              itemBuilder: (context, index) {
                return ProductTile(
                    homeController.productList[index],
                        (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  DetailsPage(homeController.productList[index])),
                      );
                    }
                );
              },
            ),
            ),
          )
        ],
      ),
    );
  }
}