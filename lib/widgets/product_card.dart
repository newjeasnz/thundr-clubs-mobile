import 'package:thundr_clubs/screens/productlist_form.dart';
import 'package:flutter/material.dart';
import 'package:thundr_clubs/screens/menu.dart';

class ItemCard extends StatelessWidget{
  final ItemHomePage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context){
    Color buttonColor;
    if(item.name == 'All Products'){
      buttonColor = Colors.blue;
    } else if(item.name == 'My Products'){
      buttonColor = Colors.green;
    } else if(item.name == "Create Products"){
      buttonColor = Colors.red;
    } else{
      buttonColor = Theme.of(context).colorScheme.primary;
    }


    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text("Kamu telah menekan tombol ${item.name}"))
          );

          if (item.name == "Create Products") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductFormPage(),
                ),
              );
            }
        },
        child: Container (
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            )
          )
        )
      )  
    );
  }
}
