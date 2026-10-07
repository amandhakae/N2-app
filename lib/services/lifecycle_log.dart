import 'package:flutter/widgets.dart';

/// Registro de um estado do ciclo de vida recebido pelo app.
class RegistroCiclo {
  final int ordem;
  final DateTime hora;
  final String estado;
  final String origem;

  RegistroCiclo(this.ordem, this.hora, this.estado, this.origem);

  String get horaFormatada {
    String d(int n, [int w = 2]) => n.toString().padLeft(w, '0');
    return '${d(hora.hour)}:${d(hora.minute)}:${d(hora.second)}.${d(hora.millisecond, 3)}';
  }
}

/// Observa o ciclo de vida do app (WidgetsBindingObserver) e guarda o histórico.
/// É criado uma única vez em main(), por isso o histórico sobrevive à navegação.
class LifecycleLog extends ChangeNotifier with WidgetsBindingObserver {
  final List<RegistroCiclo> registros = [];

  LifecycleLog() {
    WidgetsBinding.instance.addObserver(this);
    // Estado real informado pelo framework no momento em que o app começa a observar.
    final atual = WidgetsBinding.instance.lifecycleState;
    _add(atual?.name ?? 'sem estado ainda', 'estado inicial');
  }

  void _add(String estado, String origem) {
    registros.add(RegistroCiclo(registros.length + 1, DateTime.now(), estado, origem));
    notifyListeners();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _add(state.name, 'didChangeAppLifecycleState');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
