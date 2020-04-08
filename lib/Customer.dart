class Customer {
  int id;
  String name;

  Customer(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  Customer.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}