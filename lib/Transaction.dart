class Transaction {
  int id, customerid, amount;
  String type;

  Transaction(this.id, this.customerid, this.amount, this.type);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'customerid': customerid,
      'amount': amount,
      'type': type,
    };
    return map;
  }

  Transaction.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    customerid = map['customerid'];
    amount = map['amount'];
    type = map['type'];
  }
}
