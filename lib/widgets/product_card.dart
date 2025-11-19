import 'package:thundr_clubs/screens/product_entry_list.dart';
import 'package:thundr_clubs/screens/productlist_form.dart';
import 'package:flutter/material.dart';
import 'package:thundr_clubs/screens/menu.dart';
import 'package:thundr_clubs/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget{
  final ItemHomePage item;
  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context){
    final request = context.watch<CookieRequest>();
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
        onTap: () async{
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
          else if (item.name == "All Products") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductEntryListPage(isUserProduct: false)
                  ),
            );
          }

          else if (item.name == "My Products") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductEntryListPage(isUserProduct: true)
                  ),
            );
          }
          else if (item.name == "Logout") {
              // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
              // If you using chrome,  use URL http://localhost:8000
              
              final response = await request.logout(
                  "http://jessica-tandra-thundrclubs.pbp.cs.ui.ac.id/auth/logout/");
              String message = response["message"];
              if (context.mounted) {
                  if (response['status']) {
                      String uname = response["username"];
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$message See you again, $uname."),
                      ));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                  } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(message),
                          ),
                      );
                  }
              }
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
