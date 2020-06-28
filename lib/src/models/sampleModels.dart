import 'dart:convert';

List<Sample> sampleFromJson(String str) =>
    List<Sample>.from(json.decode(str).map((x) => Sample.fromJson(x)));

String sampleToJson(List<Sample> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sample {
  Sample({
    this.id,
    this.title,
    this.qty,
  });

  int id;
  String title;
  int qty;

  factory Sample.fromJson(Map<String, dynamic> json) =>
      Sample(id: json["id"], title: json["title"], qty: 0);

  Map<String, dynamic> toJson() => {"id": id, "title": title, "qty": qty};
}
