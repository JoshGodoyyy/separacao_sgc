import 'package:sgc/app/data/repositories/generica.dart';

class ImpressaoUtils {
  String processarCorpo(String? conteudo, List<Generica> listaCampos) {
    String corpo = (conteudo == null || conteudo.isEmpty) ? "" : conteudo;

    List<String> camposRepasse = [];

    RegExp pattern = RegExp(r'\[([^\[\]]+)\]');
    Iterable<RegExpMatch> matches = pattern.allMatches(corpo);

    for (var match in matches) {
      camposRepasse.add(match.group(1) ?? "");
    }

    for (String campoRepasse in camposRepasse) {
      String resultadoRepasse = campoRepasse.replaceAll("|", "");

      String parametros = "";

      if (resultadoRepasse.contains(",")) {
        parametros = resultadoRepasse.substring(
          resultadoRepasse.indexOf(",") + 1,
        );
        resultadoRepasse = resultadoRepasse.replaceFirst(
          ",$parametros",
          "",
        );
      }

      for (var campoAtual in listaCampos) {
        resultadoRepasse = resultadoRepasse.replaceAll(
          campoAtual.id!,
          campoAtual.descricao ?? '',
        );
      }

      if (parametros.isNotEmpty) {
        String direcao = parametros[parametros.length - 2];
        String preenchimento = parametros[parametros.length - 1];
        String tamanho =
            parametros.replaceAll(direcao, "").replaceAll(preenchimento, "");

        int tamanhoInt = int.tryParse(tamanho) ?? 0;

        String formatado;
        if (direcao == "D") {
          formatado = resultadoRepasse.padRight(tamanhoInt, preenchimento);
        } else if (direcao == "E") {
          formatado = resultadoRepasse.padLeft(tamanhoInt, preenchimento);
        } else {
          formatado = _padSpace(resultadoRepasse, tamanhoInt, preenchimento);
        }

        corpo = corpo.replaceAll(
          "[$campoRepasse]",
          formatado.substring(0, tamanhoInt),
        );
      } else {
        corpo = corpo.replaceAll("[$campoRepasse]", resultadoRepasse);
      }
    }

    return corpo;
  }

  String _padSpace(String texto, int tamanho, String preenchimento) {
    if (texto.length >= tamanho) {
      return texto;
    }

    int espacos = tamanho - texto.length;
    int esquerda = espacos ~/ 2;
    int direita = espacos - esquerda;

    return preenchimento * esquerda + texto + preenchimento * direita;
  }
}
