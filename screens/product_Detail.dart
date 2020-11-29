import 'package:flutter/material.dart';
import 'package:sqlflite_Project/data/dbHelper.dart';
import 'package:sqlflite_Project/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options{delete,update};

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayı: ${product.name}"),
        actions: <Widget>[
          PopupMenuButton <Options>(
            onSelected: selectProcess,
                        itemBuilder: (BuildContext context)=><PopupMenuEntry<Options>>[
                          PopupMenuItem<Options>(
                            value: Options.delete,
                            child: Text("Sil"),
                          ),
                          PopupMenuItem<Options>(
                            value: Options.update,
                            child: Text("Güncelle"),
                          )
                        ], 
                        )
                    ],
                  ),
                  body: buildProductDetail(),
            
                );
              }
            
              buildProductDetail() {}
            
              void selectProcess(Options options) async{
                switch(options){
                  case Options.delete:
                    await dbHelper.delete(product.id);
                    Navigator.pop(context, true);
                    break;
                  default:
                }
  }
}
