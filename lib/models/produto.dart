/// Representa um produto do catálogo (tema: jogos de tabuleiro).
class Produto {
  final String nome;
  final String descricao;
  final double preco;
  final int quantidade;
  final String emoji;

  const Produto({
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.quantidade,
    required this.emoji,
  });

  String get precoFormatado => 'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';
}

const List<Produto> produtos = [
  Produto(
    nome: 'Catan',
    descricao: 'Jogo de estratégia em que os jogadores colonizam uma ilha, '
        'trocando recursos como madeira, tijolo e trigo.',
    preco: 289.90,
    quantidade: 12,
    emoji: '🏝️',
  ),
  Produto(
    nome: 'Ticket to Ride',
    descricao: 'Construa rotas de trem pelo mapa e conecte cidades antes dos '
        'adversários. Ideal para jogar em família.',
    preco: 319.50,
    quantidade: 5,
    emoji: '🚂',
  ),
  Produto(
    nome: 'Dixit',
    descricao: 'Jogo de cartas ilustradas que estimula a imaginação: dê dicas '
        'criativas sem ser óbvio demais.',
    preco: 199.00,
    quantidade: 0,
    emoji: '🎴',
  ),
  Produto(
    nome: 'Carcassonne',
    descricao: 'Monte o mapa peça por peça, posicionando seguidores em '
        'cidades, estradas e campos.',
    preco: 175.00,
    quantidade: 8,
    emoji: '🏰',
  ),
];
