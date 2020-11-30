class Produccion {
  final String _cabeza;
  final String _cuerpo;

  Produccion(this._cabeza, this._cuerpo) {
    if (this._cabeza == 'E')
      throw Exception('E no puede ser un simbolo terminal');
  }
  bool produceEpsilon() => _cuerpo == 'E';
  String get cabeza => this._cabeza[0];
  String get cuerpo => this._cuerpo;
  @override
  String toString() => '$_cabeza->$_cuerpo';
}
