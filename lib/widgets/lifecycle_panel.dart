import 'package:flutter/material.dart';
import '../services/lifecycle_log.dart';

/// Mostra o histórico de estados do ciclo de vida, na ordem em que ocorreram.
class LifecyclePanel extends StatelessWidget {
  final LifecycleLog log;
  const LifecyclePanel({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: log,
      builder: (context, _) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Histórico do ciclo de vida (${log.registros.length})',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...log.registros.map((r) => Text(
                      '${r.ordem}. ${r.horaFormatada}  →  ${r.estado}  (${r.origem})',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
