import 'glc.dart';
import 'primero.dart';
import 'siguiente.dart';
import 'tablall1.dart';
import 'produccion.dart';

class LL1 {
  static List<String> primero(String alfa, GLC glc) {
    Primero primero = _primero(Primero(alfa), glc);
    return primero.resultado;
  }

  static Primero _primero(Primero alfa, GLC glc) {
    if (!alfa.soyMiPropioHijo()) {
      switch (alfa.tipoPrimero) {
        case TipoPrimero.terminal: /* regla 1 */
          alfa.establecerResultadoCalculado([alfa.alfa]);
          break;

        case TipoPrimero.noTerminal: /* regla 2 */
          List<Produccion> produccionesDeT =
              glc.obtenerProducciondesDeT(alfa.alfa);
          for (Produccion produccion in produccionesDeT) {
            Primero hijoDeAlfa = Primero(produccion.cuerpo);
            alfa.agregarHijo(hijoDeAlfa);
            _primero(hijoDeAlfa, glc);
          }
          break;

        case TipoPrimero.alfa: /* regla 3 */
          for (var i = 0; i < alfa.alfa.length; i++) {
            Primero hijoDeAlfa = Primero(alfa.alfa[i]);
            alfa.agregarHijo(hijoDeAlfa);
            _primero(hijoDeAlfa, glc);
            if (!hijoDeAlfa.resultado.contains('E')) break;
          }
          break;
      }
    }
    return alfa;
  }

  static List<String> siguiente(String alfa, GLC glc) {
    Siguiente primero = _siguiente(Siguiente(alfa), glc);
    return primero.resultado;
  }

  static Siguiente _siguiente(Siguiente siguiente, GLC glc) {
    if (glc.esInicial(siguiente.noTerminal)) siguiente.agregarPrimero(['\$']);
    List<Produccion> produccionesUsanT =
        glc.obtenerProduccionesUsanT(siguiente.noTerminal);

    for (Produccion produccion in produccionesUsanT) {
      if (produccion.cuerpo.indexOf(siguiente.noTerminal) ==
          produccion.cuerpo.lastIndexOf(siguiente.noTerminal)) {
        List<String> alfaBeta = produccion.cuerpo.split(siguiente.noTerminal);
        String beta = alfaBeta[1];
        if (beta.isEmpty) {
          Siguiente hijoSiguiente = Siguiente(produccion.cabeza);
          siguiente.agregargarHijo(hijoSiguiente);
          if (hijoSiguiente.soyMiPropioHijo()) return siguiente;
          _siguiente(hijoSiguiente, glc);
        } else {
          List<String> primero = LL1.primero(beta, glc);
          siguiente.agregarPrimero(primero);
          if (primero.contains('E')) {
            Siguiente hijoSiguiente = Siguiente(produccion.cabeza);
            siguiente.agregargarHijo(hijoSiguiente);
            if (hijoSiguiente.soyMiPropioHijo()) return siguiente;
            _siguiente(hijoSiguiente, glc);
          }
        }
      } else {
        //si el no terminal aparece mas de una vez en la produccion ej. Q->SS
        String betai = produccion.cuerpo;
        while (betai.indexOf(siguiente.noTerminal) !=
            betai.lastIndexOf(siguiente.noTerminal)) {
          betai = betai.substring(betai.indexOf(siguiente.noTerminal) + 1);
          List<String> primero = LL1.primero(betai, glc);
          siguiente.agregarPrimero(primero);
        }
        Siguiente hijoSiguiente = Siguiente(produccion.cabeza);
        siguiente.agregargarHijo(hijoSiguiente);
      }
    }
    return siguiente;
  }

  static TablaLL1 construirTablaLL1(GLC glc) {
    TablaLL1 tabla = TablaLL1(glc);
    int i = 1;
    for (Produccion produccion in glc.produccion) {
      List<String> primeroA = primero(produccion.cuerpo, glc);
      tabla.agregarCruce(produccion.cabeza, primeroA, i);
      if (primeroA.contains('E')) {
        List<String> siguienteB = siguiente(produccion.cabeza, glc);
        tabla.agregarCruce(produccion.cabeza, siguienteB, i);
      }
      i++;
    }
    return tabla;
  }
}
