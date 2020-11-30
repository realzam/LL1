import 'package:ll1/src/produccion.dart';
import './list_api.dart';

class GLC {
  List<String> _terminal = List();
  List<String> _noTerminal = List();
  String _inicial;
  List<Produccion> _produccion = List();

  bool esInicial(String terminal) => _inicial == terminal[0];

  List<Produccion> obtenerProducciondesDeT(String t) {
    List<Produccion> tProducciones = List();
    for (Produccion produccion in _produccion) {
      if (produccion.cabeza == t[0]) tProducciones.add(produccion);
    }
    return tProducciones;
  }

  List<Produccion> obtenerProduccionesUsanT(String t) {
    List<Produccion> producciondesUsaT = List();
    for (Produccion produccion in _produccion) {
      if (produccion.cuerpo.contains(t[0])) producciondesUsaT.add(produccion);
    }
    return producciondesUsaT;
  }

  void agregarProduccion(Produccion produccion) {
    RegExp noTerminalRegex = RegExp(r'[a-z]|E');
    if (_produccion.isEmpty) _inicial = produccion.cabeza;
    if (!_noTerminal.contains(produccion.cabeza))
      _noTerminal.add(produccion.cabeza);
    List<String> terminales_produccion = noTerminalRegex
        .allMatches(produccion.cuerpo)
        .map((nt) => nt[0])
        .toList();
    _terminal.combineUnique(terminales_produccion);
    _produccion.add(produccion);
  }

  List<String> get terminal => _terminal;

  List<String> get noTerminal => _noTerminal;

  String get inicial => _inicial;

  List<Produccion> get produccion => _produccion;

  @override
  String toString() {
    String cadena = '';
    for (Produccion produccion in _produccion) {
      cadena += produccion.toString() + '\n';
    }
    return cadena;
  }
}
