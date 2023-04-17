import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _favoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shoppee'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedVal) {
              setState(() {
                if (selectedVal == FilterOptions.Favorites) {
                  _favoritesOnly = true;
                } else {
                  _favoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              ),
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, data, __) {
              return Badge(
                label: Text(data.itemCount.toString()),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              );
            },
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductGrid(
        showFavs: _favoritesOnly,
      ),
    );
  }
}
