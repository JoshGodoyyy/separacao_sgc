class VersaoApp {
  num? id;
  num? major;
  num? minor;
  num? patch;

  VersaoApp(
    this.id,
    this.major,
    this.minor,
    this.patch,
  );

  VersaoApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    major = json['major'];
    minor = json['minor'];
    patch = json['patch'];
  }
}
