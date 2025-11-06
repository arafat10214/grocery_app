class UserModel {

 final String name;
 final String email;

////////////===================== COnstractor ================//////////////

 UserModel({
  required this.name,
  required this.email,
 });

////////==================== Factory Constractor =================/////////////////

factory UserModel.fromJson(Map<String ,dynamic> json){
 return UserModel(
  name: json['name'], 
  email: json['email'],
  );
}

///// ================ Modify With Tojson() ===================//////
Map<String,dynamic> toJson(){
  return{'name' : name, 'email' : email};
}

} 
