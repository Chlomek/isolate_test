import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isolate_test/main.dart';
import 'package:isolate_test/prime_counter.dart';

void main() {
  group('testy prvočísel', () {
    test('1. Správně ověří prvočísla', () {
      expect(isPrime(1), isFalse);
      expect(isPrime(2), isTrue);
      expect(isPrime(3), isTrue);
      expect(isPrime(4), isFalse);
      expect(isPrime(17), isTrue);
      expect(isPrime(100), isFalse);
    });

    test('2. Spočítá správný počet prvočísel pro malý limit', () {
      final result = countPrimes(maxLimit: 10);
      expect(result.count, equals(4));
      expect(result.elapsed.inMilliseconds, greaterThanOrEqualTo(0));
    });
  });

  group('Widget testy', () {
    testWidgets('3. Zobrazí tlačítka a indikátor animace', (WidgetTester tester) async {
      await tester.pumpWidget(const MainApp());

      expect(find.text('UI vlákno'), findsOneWidget);
      expect(find.text('Isolate'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}