class User {
  final String id;
  final String name;
  final int age;
  final int phone;
  final String dept;
  final String imgUrl;
  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.phone,
      required this.dept,
      required this.imgUrl});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'dept': dept,
      'imgUrl': imgUrl,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        age = map['age'],
        phone = map['phone'],
        dept = map['dept'],
        imgUrl = map['imgUrl'];
}
