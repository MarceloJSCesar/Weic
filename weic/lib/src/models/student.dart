class Student {
  String? id;
  String? name;
  String? email;
  String? password;
  String? schoolName;

  Student({
    this.id,
    this.name,
    this.email,
    this.password,
    this.schoolName,
  });

  @override
  String toString() {
    return 'Student{id: $id, name: $name, email: $email, password: $password, schoolName: $schoolName}';
  }
}
