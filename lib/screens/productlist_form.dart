import 'package:flutter/material.dart';
import 'package:thundr_clubs/widgets/left_drawer.dart';

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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Product Saved'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Name: $_name"),
                              Text("Price: $_price"),
                              Text("Description: $_description"),
                              Text("Thumbnail: ${_thumbnail.isNotEmpty ? _thumbnail : "-"}"),
                              Text("Category: $_category"),
                              Text("Featured: ${_isFeatured ? "Yes" : "No"}"),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                      _formKey.currentState!.reset();
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