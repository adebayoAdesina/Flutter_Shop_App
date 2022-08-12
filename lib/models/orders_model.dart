import 'package:shop_app/models/cart_item_model.dart';

class OrderItem {
  int? id;
  double? amount;
  List<CartItem>? products;
  DateTime? time;

  OrderItem({
    this.id,
    this.amount,
    this.products,
    this.time,
  });
}
