import 'package:ll1/ll1.dart';
import 'package:ll1/src/glc.dart';
import 'package:ll1/src/ll1.dart';

void main() {
  GLC glc = Utils.cargarGLC(
      '/home/sergio/Escritorio/compiladores/practicas/ll1/glc/test.glc');
  GLC glc2 = Utils.cargarGLC(
      '/home/sergio/Escritorio/compiladores/practicas/ll1/glc/test2.glc');
  GLC glc3 = Utils.cargarGLC(
      '/home/sergio/Escritorio/compiladores/practicas/ll1/glc/test3.glc');
  GLC glc4 = Utils.cargarGLC(
      '/home/sergio/Escritorio/compiladores/practicas/ll1/glc/test4.glc');
  GLC glc5 = Utils.cargarGLC(
      '/home/sergio/Escritorio/compiladores/practicas/ll1/glc/test5.glc');
  GLC glc6 = Utils.cargarGLC(
      '/home/sergio/Escritorio/compiladores/practicas/ll1/glc/test6.glc');
  GLC glc7 = Utils.cargarGLC(
      '/home/sergio/Escritorio/compiladores/practicas/ll1/glc/test7.glc');
  TablaLL1 tabla = LL1.construirTablaLL1(glc);
  TablaLL1 tabla2 = LL1.construirTablaLL1(glc2);
  TablaLL1 tabla3 = LL1.construirTablaLL1(glc3);
  TablaLL1 tabla4 = LL1.construirTablaLL1(glc4);
  TablaLL1 tabla5 = LL1.construirTablaLL1(glc5);
  TablaLL1 tabla6 = LL1.construirTablaLL1(glc6);
  TablaLL1 tabla7 = LL1.construirTablaLL1(glc7);
  print(tabla);
  print(tabla2);
  print(tabla3);
  print(tabla4);
  print(tabla5);
  print(tabla6);
  print(tabla7);
  Utils.guardarTablaLL1(tabla, './tablas/tablaa.txt');
}
