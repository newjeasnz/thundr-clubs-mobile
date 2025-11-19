import 'package:flutter/material.dart';
// import drawer widget
import 'package:thundr_clubs/widgets/left_drawer.dart';
import 'package:thundr_clubs/widgets/product_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = 'Jessica Tandra';
  final String npm = '2406355445';
  final String kelas = 'B';

  final List<ItemHomePage> items = [
    ItemHomePage('All Products', Icons.shopping_bag_outlined),
    ItemHomePage('My Products', Icons.inventory_2_outlined),
    ItemHomePage('Create Products', Icons.add_circle_outline),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thundr Clubs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: LeftDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 16.0),

            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to Thundr Clubs!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0 
                      ),
                    ),
                  ),

                  GridView.count(
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,

                    children: items.map((ItemHomePage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text (
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomePage{
  final String name;
  final IconData icon;

  ItemHomePage(this.name, this.icon);
}
