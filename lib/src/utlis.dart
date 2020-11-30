import 'dart:io';

import 'package:ll1/src/glc.dart';
import 'package:ll1/src/produccion.dart';
import 'package:ll1/src/tablall1.dart';

class Utils {
  static RegExp noTerminalRegex = RegExp(r'^[A-DF-Z]$');
  static RegExp terminalRegex = RegExp(r'^(E|[a-z])$');
  static GLC cargarGLC(String path) {
    GLC glc = GLC();
    RegExp derivacionRegex = RegExp(r'^[A-DF-Z]->(E|([a-zA-DF-Z])+)$');
    String ext = path.substring(path.lastIndexOf('.'));
    if (ext != '.glc')
      throw Exception('La extensión del archivo ($ext) no es valido');
    List<String> contenido = File(path).readAsLinesSync();

    for (var i = 0; i < contenido.length; i++) {
      String linea = contenido[i].trim();
      if (!derivacionRegex.hasMatch(linea.trim())) {
        throw Exception(
            'Formato del archivo no valido la produccion:${linea} no es valida');
      }
      String cabeza = linea[0];
      String cuerpo = linea.substring(linea.indexOf('->') + 2);
      glc.agregarProduccion(Produccion(cabeza, cuerpo));
    }
    return glc;
  }

  static void guardarTablaLL1(TablaLL1 tabla, String path) {
    Directory(path.substring(0, path.lastIndexOf('/')))
        .createSync(recursive: true);
    File(path).writeAsStringSync(tabla.toString());
  }
}
