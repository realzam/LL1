import 'package:ll1/src/utlis.dart';
import 'list_api.dart';

enum TipoPrimero { terminal, noTerminal, alfa }

class Primero {
  String _alfa;
  TipoPrimero _tipoPrimero;
  Primero _padre;
  List<Primero> _hijos = List();
  List<String> _resultado = List();

  Primero(this._alfa) {
    if (Utils.noTerminalRegex.hasMatch(this._alfa))
      _tipoPrimero = TipoPrimero.noTerminal;
    else if (Utils.terminalRegex.hasMatch(this._alfa))
      _tipoPrimero = TipoPrimero.terminal;
    else
      _tipoPrimero = TipoPrimero.alfa;
  }
  String get alfa => this._alfa;

  TipoPrimero get tipoPrimero => this._tipoPrimero;

  List<String> get resultado {
    if (_hijos.isNotEmpty) {
      bool todoTienenEpsilon = true;
      bool produscoEpsilon = false;
      List<String> res = List();
      for (var hijo in _hijos) {
        if (hijo.resultado.length == 1 && hijo.resultado.contains('E'))
          produscoEpsilon = true;
        else if (hijo.resultado.contains('E')) {
          List<String> temporal = List.from(hijo.resultado);
          temporal.remove('E');
          res.combineUnique(temporal);
        } else {
          todoTienenEpsilon = false;
          res.combineUnique(hijo.resultado);
        }
      }
      if (todoTienenEpsilon || produscoEpsilon) res.add('E');
      this._resultado = res;
    }
    return _resultado;
  }

  void _setPadre(Primero padre) => this._padre = padre;

  List<String> _padres() {
    List<String> padres = List();
    if (this._padre != null) {
      padres.combineUnique(_padre._padres());
      padres.add(_padre.alfa);
    }
    return padres;
  }

  void agregarHijo(Primero hijo) {
    hijo._setPadre(this);
    _hijos.add(hijo);
  }

  void establecerResultadoCalculado(List<String> resultado) {
    _resultado = resultado;
  }

  bool soyMiPropioHijo() {
    List<String> padres = _padres();
    return padres.contains(alfa);
  }
}
