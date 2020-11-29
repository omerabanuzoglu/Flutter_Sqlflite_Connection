import 'package:flutter/material.dart';
import 'package:sqlflite_Project/data/dbHelper.dart';
import 'package:sqlflite_Project/models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var dpHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ürün Ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Açıklaması"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Birim Fiyatı"),
      controller: txtUnitPrice,
    );
  }

  Widget buildSaveButton() {
    return FlatButton(
      child: Text("Ekle"),
      onPressed: () {
        addProduct();
      },
    );
  }

  void addProduct() async {
    var result = await dpHelper.insert(Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text)));
    Navigator.pop(context, true);
  }
}
