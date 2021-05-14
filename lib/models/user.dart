class Users {
   String id;
   String email;
   String userRole;

   Users({this.id, this.email, this.userRole});

  Users.fromJson(Map<String, dynamic>data){
       id = data['id'];
        email = data['email'];
        userRole = data['role'];
  }
}