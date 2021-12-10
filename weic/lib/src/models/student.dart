class Student {
  String? name;
  String? email;
  String? password;

  Student({this.name, this.email, this.password});

  @override
  String toString() {
    return 'Student{name: $name, email: $email, password: $password}';
  }
}
