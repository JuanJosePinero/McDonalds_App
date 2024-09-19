class Burger {
  bool? success;
  List<BurgerData>? data;
  String? message;

  Burger({
    this.success,
    this.data,
    this.message,
  });

  // Factory para crear una hamburguesa desde un JSON (respuesta de la API)
  factory Burger.fromJson(Map<String, dynamic>? json){
    if(json == null){
      return Burger(success: false, data: [], message: 'No data');
    }
    
    return Burger(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)?.map((element) {
        return BurgerData.fromJson(element);
      }).toList(),
    );
  }
}

class BurgerData {
  String? id;
  String? name;
  String? description;
  String? image;
  double? price;

  BurgerData({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
  });

  // Factory para crear una hamburguesa desde un JSON (respuesta de la API)
  factory BurgerData.fromJson(Map<String, dynamic> json){
    return BurgerData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
    );
  }
}