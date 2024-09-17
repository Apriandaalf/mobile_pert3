// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart'; // Sesuaikan dengan nama paket Anda

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget); // Cari teks "0"
    expect(find.text('1'), findsNothing);   // Pastikan teks "1" belum ada

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add)); // Tekan tombol ikon '+'
    await tester.pump(); // Render ulang frame

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing); // Pastikan teks "0" sudah hilang
    expect(find.text('1'), findsOneWidget); // Cari teks "1" setelah counter bertambah
  });
}
