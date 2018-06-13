

class Cart {
  String id;
  int qty;

  Cart(this.id, this.qty);

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        qty = json['qty'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'qty': qty,
  };
}