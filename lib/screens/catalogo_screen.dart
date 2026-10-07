import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/lifecycle_log.dart';
import '../widgets/lifecycle_panel.dart';
import 'detalhes_screen.dart';
import 'transformacoes_screen.dart';

class CatalogoScreen extends StatelessWidget {
  final LifecycleLog log;
  const CatalogoScreen({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    // map() transforma cada Produto em um card; toList() materializa o Iterable.
    final List<Widget> cards =
        produtos.map((p) => _CardProduto(produto: p, log: log)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Loja de Jogos'), actions: [
        TextButton.icon(
          icon: const Icon(Icons.transform),
          label: const Text('Transformações'),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const TransformacoesScreen())),
        ),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ...cards,
          const SizedBox(height: 8),
          LifecyclePanel(log: log),
        ],
      ),
    );
  }
}

class _CardProduto extends StatelessWidget {
  final Produto produto;
  final LifecycleLog log;
  const _CardProduto({required this.produto, required this.log});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          // Stack: o indicador de quantidade é sobreposto ao ícone do produto.
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(produto.emoji, style: const TextStyle(fontSize: 32)),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor:
                        produto.quantidade == 0 ? Colors.red : Colors.green.shade700,
                    child: Text('${produto.quantidade}',
                        style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(produto.nome, style: Theme.of(context).textTheme.titleMedium),
              Text(produto.precoFormatado),
            ]),
          ),
          FilledButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetalhesScreen(produto: produto, log: log),
              ),
            ),
            child: const Text('Detalhes'),
          ),
        ]),
      ),
    );
  }
}
