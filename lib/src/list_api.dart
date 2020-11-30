extension ListApi<E> on List<E> {
  /**
   * Agrega los valores de [list] que no se encuentran en [this]
   */
  void combineUnique(List<E> list) {
    var a_set = this.toSet();
    var b_set = list.toSet();
    var inter = b_set.intersection(a_set);
    var diference = b_set.difference(inter);
    diference.forEach((e) => this.add(e));
  }
}
