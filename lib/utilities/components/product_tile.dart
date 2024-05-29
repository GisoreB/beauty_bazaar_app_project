import 'package:flutter/material.dart';
import 'package:beauty_bazaar_app/data/models/product_model.dart';
import 'package:get/get.dart';


class ProductTile extends StatelessWidget {
  ProductTile(
      this.product,
      this.onTap,
      {super.key}
      );

  final Product product;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(

        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 192,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.network(
                      product.imageLink,
                      loadingBuilder: (BuildContext context, child, loadingProgress) {
                        if(loadingProgress == null){
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (BuildContext context, error, stackTrace) {
                        return Container(
                          child: Center(
                            child: Text("There was an error when loading image.." , style: TextStyle(
                                color: Colors.redAccent[700],
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Obx(() => Container(

                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: const Color.fromARGB(255, 216, 216, 216))
                      ),
                      child: IconButton(
                        icon: product.isFavorite.value
                            ? Icon(Icons.favorite_rounded, color: Colors.green[700],)
                            : Icon(Icons.favorite_border, color: Colors.green[700],),
                        onPressed: () {
                          product.isFavorite.toggle();
                        },
                      ),
                    )),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                maxLines: 2,
                style:
                const TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(product.price + String.fromCharCode(36),
                  style: const TextStyle(fontSize: 32, fontFamily: 'avenir')),
            ],
          ),
        ),
      ),
    );
  }
}