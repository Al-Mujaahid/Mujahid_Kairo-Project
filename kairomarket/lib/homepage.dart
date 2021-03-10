import 'package:flutter/material.dart';
import 'package:kairomarket/AllOurProductsPage/DisplayProductsPage/display_products_page.dart';
import 'package:kairomarket/AllOurProductsPage/ProductsListPage/products_list_provider.dart';
import 'package:kairomarket/utils/action_message_page.dart';
import 'package:kairomarket/AllOurProductsPage/DisplayProductsPage/display_products_page.dart';
import 'package:kairomarket/AllOurProductsPage/ProductsListPage/products_list_provider.dart';
import 'package:kairomarket/utils/action_message_page.dart';
import 'package:kairomarket/AllOurProductsPage/DisplayProductsPage/display_products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kairomarket/AllOurProductsPage/models/product.model.dart';
import 'AllOurProductsPage/UserProductsListPage/user_products_list_page.dart';
import 'DB_Products.dart';
import 'Search/search_home.dart';
import 'Search/search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 122,
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 30),
              child: Consumer<ProductsListProvider>(
                builder: (context, value, child) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'KairoMarket',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            IconButton(
                                icon: Icon(Icons.refresh),
                                color: Colors.white,
                                onPressed: () => value.initialize()),
                          ],
                        ),

                        ////////TAB BAR IS ADDED HERE////////
                        TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(Icons.shopping_cart_sharp),
                              text: "Trends",
                            ),
                            Tab(
                                icon: Icon(Icons.add_shopping_cart),
                                text: "My Products"),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )),
        ),
        body: TabBarView(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Consumer<ProductsListProvider>(
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        ActionMessagePage(
                          actionState: value.getActionState,
                        ),
                        if (value.productListToDsplay.length == 0 &&
                            !value.isLoading()) ...[
                          Text('No product to display')
                        ],
                        ...value.productListToDsplay.take(20).map((e) {
                          return Container(
                              child: ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return Container(
                                    child: DisplayProductPage(products: e),
                                  );
                                },
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('${e.image}'),
                            ),
                            title: Text('${e.product_name}'),
                            subtitle: Text('${e.description}'),
                            trailing: Icon(Icons.view_list),
                          ));
                        })
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(child: UserProductsListPage())
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SearchHome();
            }));
          },
          tooltip: 'Search Products',
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
