import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_sphere/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar( 
        centerTitle: true,
        title: Text('Cart',style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),),
      ),

          body: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context,index){
              final cartItem = cart[index];

            return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
                child: Image.asset(cartItem['imageUrl'] as String,
                width: 50,
                  height: 50,
                  fit: BoxFit.cover,
              ),
            ),

            trailing: IconButton(
               onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                   builder: (context){
                    return AlertDialog(
                     title: Text(
                          'Delete Product',
                        style: Theme.of(context).textTheme.titleMedium ,),
                        content: Text('Are you sure you want to remove this product from your cart?'),
                        actions: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      },
                       child:const Text('No',
                       style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                           ),
                         ),
                       ),
                      TextButton(onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                          .removeProduct(cartItem);
                         Navigator.of(context).pop();
                      },
                       child: const Text('Yes',
                       style: TextStyle(
                         color: Colors.red,
                         fontWeight: FontWeight.bold,
                         fontSize: 17 
                           ),
                         ),
                        )
                      ],
                     );
                   }
                 );
               },
               icon: const Icon(
                Icons.delete,
                color: Colors.red,
                ),
               ),

              title: Text(
                    cartItem['title'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                 subtitle: 
                   Text('Size ${cartItem['size']}'
                 ),
                 subtitleTextStyle:
                  TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                );
            
            }
         )
    );
  }
}