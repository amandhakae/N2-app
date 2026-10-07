import 'package:flutter/material.dart';

class TransformacoesScreen extends StatefulWidget {
  const TransformacoesScreen({super.key});

  @override
  State<TransformacoesScreen> createState() => _TransformacoesScreenState();
}

class _TransformacoesScreenState extends State<TransformacoesScreen> {
  final List<int> numeros = [1, 2, 3, 4, 5];
  final List<String> palavras = ['Flutter', 'é', 'incrível'];
  final List<String> nomes = ['Ana', 'Bruno', 'Carla'];
  String mensagem = 'Nenhum botão pressionado ainda.';

  @override
  Widget build(BuildContext context) {
    // Números -> Strings (gera objetos String de fato).
    final List<String> comoStrings = numeros.map((n) => 'Número $n').toList();
    // Números -> dobro.
    final List<int> dobrados = numeros.map((n) => n * 2).toList();

    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Transformações')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Números', style: t.titleLarge),
          Text('Lista original: $numeros'),
          Text('Strings (map → String): $comoStrings'),
          Text('Multiplicados por 2: $dobrados'),
          const Divider(height: 32),
          Text('Palavras em widgets Text', style: t.titleLarge),
          Wrap(
            spacing: 8,
            children: palavras
                .map((p) => Text(p, style: const TextStyle(fontSize: 24)))
                .toList(),
          ),
          const Divider(height: 32),
          Text('Nomes em botões', style: t.titleLarge),
          Wrap(
            spacing: 8,
            children: nomes
                .map((nome) => ElevatedButton(
                      onPressed: () {
                        setState(() => mensagem = 'Você pressionou o botão: $nome');
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Botão do nome: $nome')));
                      },
                      child: Text(nome),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          Text(mensagem, style: t.titleMedium),
        ],
      ),
    );
  }
}
