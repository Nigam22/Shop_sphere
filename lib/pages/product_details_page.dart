import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_sphere/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
    });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  ontap () {
    if (selectedSize != 0){
         Provider.of<CartProvider>(context, listen: false)
                .addProduct(
                   {
                      'id': widget.product['id'],
                      'title': widget.product['title'],
                      'price': widget.product['price'],
                      'imageUrl': widget.product['imageUrl'],
                      'company': widget.product['company'],
                      'size':selectedSize,
                    }
                  );
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Product added to cart',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,),),
                      backgroundColor: Color.fromRGBO(226, 147, 10, 1),
                      duration: Duration(seconds: 2),
                       behavior: SnackBarBehavior.floating, 
                       margin:  EdgeInsets.all(10),
                       shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(10),
                      ),
                     ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a size',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,),),
                      backgroundColor: Color.fromRGBO(226, 147, 10, 1),
                      duration: Duration(seconds: 2),
                       behavior: SnackBarBehavior.floating, 
                       margin:  EdgeInsets.all(10), 
                       shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(10),
                      ),
                     ),
                  );
                }
             } 
             
  @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Details'),
            backgroundColor: Colors.white,
          ),
        body: Column(
          children: [
            Text(widget.product['title'] as String,
            style:Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl'] as String,
            height: 250,
            ),
          ),
          
          const Spacer(flex: 2),
          Container(
            height : 250, 
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 232, 234),
              borderRadius: BorderRadius.circular(40)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${widget.product['price']}',
                style: Theme.of(context).textTheme.titleLarge,
                  ),
    
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.product['sizes'] as List<int>).length,
                  itemBuilder:(context, index){
                    final size = (widget.product ['sizes'] as List<int>)[index];
                
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap:() {
                          setState(() {
                          selectedSize = size;
                          });
                        },

                        child: Chip(
                          label: Text(size.toString()),
                          backgroundColor: selectedSize == size 
                          ? Theme.of(context).colorScheme.primary
                          : null ,
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton.icon(
                onPressed: ontap,
                style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                fixedSize: const Size(350 , 50)
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                label:
                 const Text(
                  'Add To Cart',
                  style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                
                ),
                ),
              )
          ],
        ),
       )
      ],
     ),
    );
  }
}