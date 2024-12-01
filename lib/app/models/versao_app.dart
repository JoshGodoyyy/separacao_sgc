class VersaoApp {
  num? id;
  num? major;
  num? minor;
  num? patch;
  String? url;

  VersaoApp(
    this.id,
    this.major,
    this.minor,
    this.patch,
    this.url,
  );

  VersaoApp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    major = json['major'];
    minor = json['minor'];
    patch = json['patch'];
    url = json['url'];
  }
}
