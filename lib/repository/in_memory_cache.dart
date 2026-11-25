class InMemoryCache<T extends Object> {
  T? _value;
  Future<T>? _pending;
  var _hasValue = false;
  var _generation = 0;

  Future<T> get(Future<T> Function() load, {bool refresh = false}) {
    if (refresh) {
      _generation++;
      _value = null;
      _hasValue = false;
      _pending = null;
    } // esvazia o cache e descarta chamadas em andamento

    if (_hasValue) return Future<T>.value(_value!); // vê se tem um valor pronto e retona o valor
    if (_pending case final pending?) return pending; // vê se tem uma chamada em andamento e se tiver retorna a mesma chamada para n widgets que precisar ao mesmo tempo

    final generation = _generation; // guarda a versão no momento da requisição
    late final Future<T> request;
    request = load()
        .then((value) {
          if (_generation == generation) {
            _value = value;
            _hasValue = true;
          }
          return value;
        }) // quando a função load() termina com sucesso verifica se não houve refresh = true
        .whenComplete(() {
          if (_generation == generation && identical(_pending, request)) {
            _pending = null;
          } // quando a função load() termina limpa pendências
        });
    _pending = request; // recebe a pedência para futuras verificações
    return request;
  }
}
