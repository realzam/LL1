import 'list_api.dart';

class Siguiente {
  String _noTerminal;
  Siguiente _padre;
  List<String> _resultadoDePrimero = List();
  List<Siguiente> _hijos = List();

  Siguiente(this._noTerminal);

  String get noTerminal => this._noTerminal;

  List<String> get resultado {
    List<String> resuldadoSiguiente = List();
    if (_hijos.isNotEmpty) {
      for (Siguiente hijo in _hijos) {
        resuldadoSiguiente.combineUnique(hijo.resultado);
      }
    }
    resuldadoSiguiente.combineUnique(_resultadoDePrimero);
    return resuldadoSiguiente;
  }

  void _agregarPadre(Siguiente padre) => this._padre = padre;

  void agregargarHijo(Siguiente hijo) {
    hijo._agregarPadre(this);
    _hijos.add(hijo);
  }

  void agregarPrimero(List<String> primero) {
    List<String> clone = List.from(primero);
    if (clone.contains('E')) clone.remove('E');
    _resultadoDePrimero.combineUnique(clone);
  }

  List<String> _padres() {
    List<String> padres = List();
    if (this._padre != null) {
      padres.combineUnique(_padre._padres());
      padres.add(_padre.noTerminal);
    }
    return padres;
  }

  bool soyMiPropioHijo() {
    List<String> padres = _padres();
    return padres.contains(this._noTerminal);
  }
}
