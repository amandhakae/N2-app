import os
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import cm
from reportlab.platypus import SimpleDocTemplate, Paragraph, Image, Spacer, PageBreak, Preformatted, Table, TableStyle
from reportlab.lib import colors
from PIL import Image as PI

D = os.path.dirname(os.path.abspath(__file__))
C = os.path.join(D, 'capturas')
ss = getSampleStyleSheet()
H1 = ss['Heading1']; H2 = ss['Heading2']
B = ParagraphStyle('b', parent=ss['BodyText'], fontSize=10.5, leading=15)
CAP = ParagraphStyle('c', parent=B, fontSize=9, textColor=colors.HexColor('#444444'))
CODE = ParagraphStyle('code', fontName='Courier', fontSize=8.5, leading=11, backColor=colors.HexColor('#f1f1f1'), borderPadding=4)
WARN = ParagraphStyle('w', parent=B, backColor=colors.HexColor('#fff3cd'), borderColor=colors.HexColor('#e0b100'), borderWidth=1, borderPadding=6)

def img(name, h=11*cm):
    p = os.path.join(C, name); w0, h0 = PI.open(p).size
    return Image(p, width=h*w0/h0, height=h)

def two(a, b, h=8.2*cm):
    t = Table([[img(a, h), img(b, h)]]); t.setStyle(TableStyle([('ALIGN', (0,0), (-1,-1), 'CENTER')])); return t

s = []
s += [Paragraph('Relatório — Loja de Jogos (catálogo de produtos em Flutter)', H1),
      Paragraph('<b>Aplicativo:</b> Loja de Jogos (catalogo_n2)<br/><b>Integrantes:</b> [preencher nomes e RA dos integrantes]', B),
      Spacer(1, 6),
      Paragraph('<b>Observação sobre o ambiente de teste.</b> Estas capturas foram geradas executando o <i>mesmo código</i> '
                'entregue como Flutter Web em um Chromium (resolução de celular, 412x860), pois o ambiente em que o projeto foi '
                'desenvolvido não possui emulador Android. Os testes de segundo plano com o botão Home do Android '
                '(itens 3 e 4 do enunciado) <b>precisam ser executados e registrados pelo grupo</b> em um dispositivo/emulador; '
                'a seção 6 indica onde inserir essa evidência.', WARN),
      Spacer(1, 8),
      Paragraph('1. O que foi implementado', H2),
      Paragraph('Catálogo de jogos de tabuleiro com quatro produtos (Catan, Ticket to Ride, Dixit e Carcassonne). Cada card mostra '
                'nome, preço, um ícone com o indicador de quantidade sobreposto e o botão <i>Detalhes</i>. Há uma segunda tela com os '
                'dados completos do produto, uma tela <i>Transformações</i> e um histórico do ciclo de vida exibido no catálogo e nos detalhes.', B),
      Paragraph('2. Catálogo e indicadores de quantidade', H2),
      img('01_catalogo.png', 11*cm),
      Paragraph('Figura 1 — Catálogo gerado com map()/toList(). O círculo no canto de cada ícone é o indicador de quantidade '
                '(verde: em estoque; vermelho: Dixit com 0 unidades).', CAP),
      PageBreak(),
      Paragraph('3. Detalhes e navegação', H2),
      two('02_detalhes_catan.png', '03_detalhes_ticket.png'),
      Paragraph('Figuras 2 e 3 — Detalhes de Catan (R$ 289,90, 12 un.) e Ticket to Ride (R$ 319,50, 5 un.). Cada botão carrega o '
                'objeto Produto do seu próprio card, por isso as telas mostram dados diferentes. A navegação foi verificada com Catan e Ticket to Ride '
                'na execução manual e com um teste de widget (flutter test); o mesmo código serve aos demais produtos.', CAP),
      Paragraph('4. Transformações de listas', H2),
      two('05_transformacoes.png', '06_botao_clicado.png'),
      Paragraph('Figura 4 (esq.) — Lista original [1, 2, 3, 4, 5]; lista de strings ("Número 1", ...) obtida com map((n) =&gt; \'Número $n\').toList(); '
                'lista dobrada [2, 4, 6, 8, 10]; as palavras "Flutter", "é", "incrível" convertidas em widgets Text; e os botões Ana, Bruno e Carla. '
                'Figura 5 (dir.) — Após tocar em "Bruno", o texto da tela e um SnackBar identificam o nome do botão.', CAP),
      PageBreak(),
      Paragraph('5. Explicações', H2),
      Paragraph('<b>Classe Produto.</b> Reúne nome, descrição, preço e quantidade (além de um emoji usado como imagem) em campos finais e '
                'construtor const. A lista <font name="Courier">produtos</font> contém os objetos; telas leem apenas atributos do objeto, sem '
                'depender de listas paralelas.', B),
      Paragraph('<b>Envio à tela de detalhes.</b> O botão de cada card é criado dentro do widget daquele produto e passa o próprio objeto no '
                'construtor: <font name="Courier">DetalhesScreen(produto: produto)</font>. Como cada card guarda sua referência, o botão '
                'identifica corretamente o item.', B),
      Preformatted("Navigator.push(context, MaterialPageRoute(\n  builder: (_) => DetalhesScreen(produto: produto, log: log)));\n// ... na tela de detalhes:\nNavigator.pop(context);", CODE),
      Paragraph('<b>push() e pop().</b> push() empilha a nova rota sobre o catálogo (que continua na memória, apenas coberto); pop() remove a rota '
                'do topo e revela o catálogo novamente. O botão "Voltar ao catálogo" e a seta da AppBar chamam pop().', B),
      Paragraph('<b>Stack.</b> Sobrepõe o indicador de quantidade (CircleAvatar em um Positioned) ao quadrado com o ícone do produto, '
                'criando um "selo" sem alterar o layout do restante do card.', B),
      Paragraph('<b>map() e toList().</b> map() transforma cada elemento de uma coleção em outro valor, de forma preguiçosa (retorna um Iterable); '
                'toList() materializa o resultado em List. Aparecem: (a) catálogo — produtos.map(...)→cards; (b) números→strings; '
                '(c) números→dobro; (d) palavras→Text; (e) nomes→ElevatedButton.', B),
      Paragraph('6. Ciclo de vida', H2),
      Paragraph('O histórico é mantido por um LifecycleLog (WidgetsBindingObserver + ChangeNotifier), criado uma única vez em main(); por isso '
                'persiste ao navegar entre catálogo e detalhes (Figuras 2 e 3 mostram o mesmo histórico do catálogo). Nenhum estado é adicionado '
                'manualmente: cada linha vem de didChangeAppLifecycleState, exceto a linha "estado inicial", que apenas lê '
                'WidgetsBinding.instance.lifecycleState quando o observador é registrado.', B),
      img('04_ciclo.png', 7.5*cm),
      Paragraph('Figura 6 — Histórico observado na execução web: (1) estado inicial (o framework ainda não havia informado estado) e '
                '(2) resumed. Nesse ambiente, abrir e fechar os detalhes <b>não gerou nenhum novo registro</b>. A troca de aba do navegador '
                'automatizado também não gerou eventos, portanto não há evidência de paused nesta execução.', CAP),
      Paragraph('[A COMPLETAR PELO GRUPO — Android] Inserir aqui a captura do histórico após: abrir o app; abrir/fechar detalhes; apertar Home; '
                'voltar ao app. Em Android, o esperado é ver algo como inactive → hidden → paused ao sair e hidden → inactive → resumed ao retornar, '
                'mas o que vale é o que aparecer na execução real de vocês; registrem exatamente isso.', WARN),
      Paragraph('<b>Navegar dentro do app x ir ao segundo plano.</b> Abrir a tela de detalhes é uma mudança interna do Navigator: o app continua '
                'visível, em primeiro plano e recebendo eventos, só mudou a rota exibida. Por isso o estado do aplicativo continua resumed e nada é '
                'registrado (como observado). Já o botão Home faz o sistema operacional tirar o app da tela: a Activity deixa de ser visível e '
                'o Flutter é notificado (inactive/hidden/paused). Paused significa "não visível e sem interação com o usuário", o que não ocorre '
                'ao empilhar uma rota dentro do mesmo app.', B)]

SimpleDocTemplate(os.path.join(D, 'Relatorio_Loja_de_Jogos.pdf'), pagesize=A4,
                  leftMargin=2*cm, rightMargin=2*cm, topMargin=1.8*cm, bottomMargin=1.8*cm,
                  title='Relatório — Loja de Jogos').build(s)
