class Category {
  String id;
  String name;
  String description;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  Category.fromJson(Map<String, dynamic> data)
    : id = data['idCategory'],
      name = data['strCategory'],
      description = data['strCategoryDescription'],
      image = data['strCategoryThumb'];

  Map<String, dynamic> toJson() => {
    'idCategory': id,
    'strCategory': name,
    'strCategoryDescription': description,
    'strCategoryThumb': image,
  };
}
