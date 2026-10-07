# Loja de Jogos — catálogo de produtos em Flutter

**Aplicativo:** Loja de Jogos (`catalogo_n2`)
**Integrantes:** _preencher nomes e RA dos integrantes_

Catálogo de jogos de tabuleiro com navegação para detalhes (`Navigator.push/pop`),
transformações de listas com `map()`/`toList()` e histórico do ciclo de vida
(`WidgetsBindingObserver`).

## Como executar
```bash
flutter pub get
flutter run            # com emulador/dispositivo Android conectado
flutter test           # teste de widget (catálogo -> detalhes -> voltar)
```
Requer Flutter 3.x estável (testado com 3.47) .

## Estrutura (`lib/`)
- `models/produto.dart` — classe `Produto` e lista de produtos
- `screens/catalogo_screen.dart` — cards (map/toList, Stack, botão Detalhes)
- `screens/detalhes_screen.dart` — detalhes + `Navigator.pop`
- `screens/transformacoes_screen.dart` — números, palavras e botões de nomes
- `services/lifecycle_log.dart`, `widgets/lifecycle_panel.dart` — histórico do ciclo de vida

## Relatório
`docs/gerar_relatorio.py` gera o PDF (`python3 docs/gerar_relatorio.py`, requer `reportlab`).
Capturas em `docs/capturas/`.
