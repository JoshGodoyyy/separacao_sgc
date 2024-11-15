import 'dart:convert';

class UrlApiModel {
  final String url;
  final String descricao;
  bool padrao;

  UrlApiModel({
    required this.url,
    required this.descricao,
    required this.padrao,
  });

  factory UrlApiModel.fromJson(Map<String, dynamic> json) {
    return UrlApiModel(
      url: json['url'],
      descricao: json['descricao'],
      padrao: json['padrao'],
    );
  }

  static Map<String, dynamic> toMap(UrlApiModel apiModel) => {
        'url': apiModel.url,
        'descricao': apiModel.descricao,
        'padrao': apiModel.padrao,
      };

  static String encode(List<UrlApiModel> urls) => json.encode(
        urls
            .map<Map<String, dynamic>>(
              (url) => UrlApiModel.toMap(url),
            )
            .toList(),
      );

  static List<UrlApiModel> decode(String urls) {
    if (urls == '') return [];

    return (json.decode(urls) as List<dynamic>)
        .map<UrlApiModel>(
          (url) => UrlApiModel.fromJson(url),
        )
        .toList();
  }
}
