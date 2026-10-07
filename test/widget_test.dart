import 'package:flutter_test/flutter_test.dart';
import 'package:catalogo_n2/main.dart';
import 'package:catalogo_n2/services/lifecycle_log.dart';

void main() {
  testWidgets('catálogo e detalhes', (tester) async {
    await tester.pumpWidget(CatalogoApp(log: LifecycleLog()));
    expect(find.text('Catan'), findsOneWidget);
    await tester.tap(find.text('Detalhes').at(1));
    await tester.pumpAndSettle();
    expect(find.textContaining('Ticket to Ride'), findsWidgets);
    await tester.tap(find.text('Voltar ao catálogo'));
    await tester.pumpAndSettle();
    expect(find.text('Catan'), findsOneWidget);
  });
}
