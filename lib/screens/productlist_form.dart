import 'package:flutter/material.dart';
import 'package:thundr_clubs/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:thundr_clubs/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = "";
  String _category = "apparel";
  bool _isFeatured = false;

  final List<String> _categories = [
    'apparel',
    'shoes',
    'football',
    'accessories',
    'equipment',
    'goalkeeper gear',
    'collectibles',
  ];
  
  @override
  Widget build(BuildContext context){
    final request = context.watch<CookieRequest>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // === NAME ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (value) => _name = value,
                validator: (value) =>
                    (value == null || value.isEmpty) ? "Name cannot be empty!" : null,
              ),
              const SizedBox(height: 16),

              // === PRICE ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _price = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return "Price cannot be empty!";
                  if (int.tryParse(value) == null) return "Price must be a number!";
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === DESCRIPTION ===
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (value) => _description = value,
                validator: (value) =>
                    (value == null || value.isEmpty) ? "Description cannot be empty!" : null,
              ),
              const SizedBox(height: 16),

              // === THUMBNAIL ===
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Thumbnail URL (optional)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (value) => _thumbnail = value,
              ),
              const SizedBox(height: 16),

              // === CATEGORY ===
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                initialValue: _category,
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              const SizedBox(height: 16),

              // === FEATURED ===
              SwitchListTile(
                title: const Text("Feature this product"),
                value: _isFeatured,
                onChanged: (value) => setState(() => _isFeatured = value),
                activeTrackColor: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),

              // === SAVE BUTTON ===
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                        "https://jessica-tandra-thundrclubs.pbp.cs.ui.ac.id/create-flutter/",
                        jsonEncode({
                          "name": _name,
                          "price": _price,
                          "description": _description,
                          "thumbnail": _thumbnail,
                          "category": _category,
                          "is_featured": _isFeatured,
                        }),
                      );

                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("New Product successfully saved!")),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Something went wrong, please try again."),
                            ),
                          );
                        }
                      }
                    }
                  },

                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}