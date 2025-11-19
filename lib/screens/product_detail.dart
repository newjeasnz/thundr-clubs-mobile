import 'package:flutter/material.dart';
import 'package:thundr_clubs/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFFefa041); // warna gold thunder
    final Color textDark = const Color(0xFF2a1f20);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        title: Text(product.name),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: (product.thumbnail ?? '').isNotEmpty
                    ? Image.network(
                        product.thumbnail!,
                        width: double.infinity,
                        height: 280,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholderImage(),
                      )
                    : _placeholderImage(),
              ),

              const SizedBox(height: 20),

              // NAME
              Text(
                product.name.isEmpty ? "No Name" : product.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 8),

              // CATEGORY
              Text(
                product.category.isNotEmpty ? product.category : "Uncategorized",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // PRICE
              Text(
                "Rp ${product.price.toString()}",
                style: TextStyle(
                  fontSize: 26,
                  color: primary,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 24),

              // DESCRIPTION
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 28),

              // ADDED BY
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Added by:",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    product.name ?? "Anonymous",
                    style: TextStyle(
                      fontSize: 14,
                      color: textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ADD TO CART (optional)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: const Center(
        child: Text("No Image Available", style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}