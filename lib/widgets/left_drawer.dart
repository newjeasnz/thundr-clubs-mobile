import 'package:flutter/material.dart';
import 'package:thundr_clubs/screens/menu.dart';
import 'package:thundr_clubs/screens/productlist_form.dart';
import 'package:thundr_clubs/screens/product_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Thundr Clubs',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Bring the Energy of Lightning to Your Match!",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home_outlined, color: theme.colorScheme.primary),
            splashColor: theme.colorScheme.primary.withValues(alpha: 0.15),
            title: Text('Home', style: theme.textTheme.bodyLarge),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.post_add, color: theme.colorScheme.primary),
            splashColor: theme.colorScheme.primary.withValues(alpha: 0.15),
            title: Text('Add Product', style: theme.textTheme.bodyLarge),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductFormPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.add_reaction_rounded),
            title: const Text('Product List'),
            onTap: () {
                // Route to product list page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
                );
            },
        ),
        ],
      ),
    );
  }
}
