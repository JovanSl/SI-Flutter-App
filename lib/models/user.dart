class Users {
  final String id;
  final String email;
  final String userRole;

  const Users({this.id, this.email, this.userRole});

  Users.fromData(Map<String, dynamic>data)
      : id = data['id'],
        email = data['email'],
        userRole = data['role'];
  
    String get userrole { 
      return userRole; 
   } 
}