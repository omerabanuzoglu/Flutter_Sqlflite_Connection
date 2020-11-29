import 'package:sqlflite_Project/data/dbHelper.dart';
import 'package:sqlflite_Project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:sqlflite_Project/screens/product_Detail.dart';
import 'package:sqlflite_Project/screens/product_add.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _productListState();
  }
}

class _productListState extends State {
  var dphelper = DbHelper();
  List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            goToProductAdd();
          },
          child: Icon(Icons.add),
          tooltip: "Yeni Ürün Ekle"),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              color: Colors.cyan,
              elevation: 2.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text("P"),
                ),
                title: Text(this.products[position].name),
                subtitle: Text(this.products[position].description),
                onTap: () {
                  goToDetail(this.products[position]);
                },
              ));
        });
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));

    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  void getProducts() async {
    var productsFuture = DbHelper().getProducts();
    productsFuture.then((data) {
      this.products = data;
      productCount = data.length;
    });
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }
}
