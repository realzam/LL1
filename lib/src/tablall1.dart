import 'glc.dart';
import 'list_api.dart';

class TablaLL1 {
  List<String> _columna;
  List<String> _fila;
  List<List<List<int>>> _m = List();

  TablaLL1(GLC glc) {
    this._columna = List.from(glc.terminal);
    this._columna.remove('E');
    this._fila = List.from(glc.noTerminal);
    this._columna.sort();
    this._fila.sort();
    this._columna.add('\$');

    for (int x = 0; x < _fila.length; x++) {
      List<List<int>> fila = List();

      for (var y = 0; y < _columna.length; y++) {
        List<int> celda = List();
        fila.add(celda);
      }
      _m.add(fila);
    }
  }

  List<List<int>> _obtenerColumna(int n) {
    List<List<int>> colum = List();
    for (var i = 0; i < this._fila.length; i++) {
      colum.add(this._m[i][n]);
    }
    return colum;
  }

  void agregarCruce(String noTerminal, List<String> terminal, int numero) {
    int filaTerminal = _fila.indexOf(noTerminal);
    for (String noTerminalAgregar in terminal) {
      if (noTerminalAgregar != 'E') {
        int columnaTerminal = this._columna.indexOf(noTerminalAgregar);
        _m[filaTerminal][columnaTerminal].combineUnique([numero]);
      }
    }
  }

  @override
  String toString() {
    List<int> colmnaCaracters = List();
    for (var i = 0; i < this._columna.length; i++) {
      List<List<int>> column = _obtenerColumna(i);
      int max = this._columna[i].length;
      for (var j = 0; j < this._fila.length; j++) {
        if (max < column[j].join('/').length) max = column[j].join('/').length;
      }
      colmnaCaracters.add(max + 3);
    }

    String tabla = '   ';
    for (var i = 0; i < this._columna.length; i++) {
      String terminal = this._columna[i];
      tabla += terminal + ' ' * (colmnaCaracters[i] - terminal.length);
    }
    tabla += '\n\n';
    for (var i = 0; i < this._fila.length; i++) {
      tabla += this._fila[i] + '  ';
      for (var j = 0; j < this._columna.length; j++) {
        String produccion = _m[i][j].join('/');
        tabla += produccion + ' ' * (colmnaCaracters[j] - produccion.length);
      }
      tabla += '\n\n';
    }
    return tabla;
  }
}
