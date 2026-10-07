import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/lifecycle_log.dart';
import '../widgets/lifecycle_panel.dart';

class DetalhesScreen extends StatelessWidget {
  final Produto produto;
  final LifecycleLog log;
  const DetalhesScreen({super.key, required this.produto, required this.log});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(produto.nome)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(child: Text(produto.emoji, style: const TextStyle(fontSize: 72))),
          Text(produto.nome, style: t.headlineMedium),
          const SizedBox(height: 8),
          Text('Descrição: ${produto.descricao}'),
          const SizedBox(height: 8),
          Text('Preço: ${produto.precoFormatado}', style: t.titleMedium),
          Text('Quantidade disponível: ${produto.quantidade}', style: t.titleMedium),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            icon: const Icon(Icons.arrow_back),
            label: const Text('Voltar ao catálogo'),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
          LifecyclePanel(log: log),
        ],
      ),
    );
  }
}
