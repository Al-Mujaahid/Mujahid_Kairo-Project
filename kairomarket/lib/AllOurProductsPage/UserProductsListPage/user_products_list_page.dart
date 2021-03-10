import 'package:kairomarket/AllOurProductsPage/DisplayUserProductPage/user_display_products_page.dart';
import 'package:kairomarket/AllOurProductsPage/UserProductsListPage/user_products_list_provider.dart';
import 'package:kairomarket/utils/action_message_page.dart';
import 'package:kairomarket/AllOurProductsPage/DisplayUserProductPage/user_display_products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kairomarket/AllOurProductsPage/models/user_product_model.dart';

class UserProductsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Consumer<UserProductsListProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                ActionMessagePage(
                  actionState: value.getActionState,
                ),
                if (value.userproductListToDsplay.length == 0 &&
                    !value.isLoading()) ...[
                  Text('Failed to load your products')
                ],
                ...value.userproductListToDsplay.take(20).map((b) {
                  return Container(
                      child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Container(
                            child: UserDisplayProductPage(userproducts: b),
                          );
                        },
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('${b.image}'),
                    ),
                    title: Text('${b.product_name}'),
                    subtitle: Text('${b.description}'),
                    trailing: Icon(Icons.view_list),
                  ));
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
