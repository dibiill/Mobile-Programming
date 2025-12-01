class user {
  final int? id;
  final String username;
  final String password;

  user({this.id, required this.username, required this.password});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  factory user.fromMap(Map<String, dynamic> map){
    return user(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}