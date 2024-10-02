class UserModel {
  final String uid;
  final String name;
  final String email;
  

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    
  });
  

  

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,

  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
     
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      
    );
  }
}