import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wren/main.dart';
import 'package:wren/src/screenshots.dart';

/// How the screenshot run tells the app which scene to draw.
///
/// This exists because of a specific run: on 17 August 2026 all sixty-four
/// screenshots came out as the "no scene called" screen with an **empty** name.
/// `simctl launch` is documented to pass `SIMCTL_CHILD_WREN_SCENE` through to the
/// app with the prefix stripped, it was passed correctly, and it arrived as
/// nothing. Thirty-one minutes of runner time produced sixty-four copies of one
/// failure, and the screen said only that a scene was missing — true, and not
/// enough to act on.
///
/// So there are two routes now, and the failure screen names both and reports
/// what each held. What is tested here is the part a test can reach: the file
/// route works when the environment route is empty, and the diagnosis survives
/// to the screen.
void main() {
  final sceneFile = File(
    '${Directory.systemTemp.path}${Platform.pathSeparator}$sceneFileName',
  );

  setUp(() {
    if (sceneFile.existsSync()) sceneFile.deleteSync();
  });
  tearDown(() {
    if (sceneFile.existsSync()) sceneFile.deleteSync();
  });

  test('the file route names the scene when the environment does not', () {
    // The exact condition of the failed run: nothing in the environment.
    expect(Platform.environment['WREN_SCENE'], isNull);

    sceneFile.writeAsStringSync('03-correct-a-place');
    final request = SceneRequest.resolve();

    expect(request.name, '03-correct-a-place');
    expect(sceneFor(request.name), isNotNull);
  });

  test('trailing whitespace does not become part of the scene name', () {
    // A file written by a shell would carry a newline, and '01-the-list\n'
    // matches no scene — which would look exactly like the original bug.
    sceneFile.writeAsStringSync('01-the-list\n');
    expect(SceneRequest.resolve().name, '01-the-list');
  });

  test('with no route at all, every route is still reported', () {
    final request = SceneRequest.resolve();
    expect(request.name, isEmpty);
    // Both routes accounted for, plus the count that separates "dart:io saw no
    // environment" from "this one variable was not passed".
    expect(request.sources.map((s) => s.$1), [
      'env WREN_SCENE',
      contains(sceneFileName),
      'env vars visible',
    ]);
    expect(request.sources.first.$2, 'not set');
    expect(request.logLine, contains('WREN-SHOTS'));
  });

  testWidgets('the failure screen carries the diagnosis', (tester) async {
    const request = SceneRequest(
      name: '',
      sources: [('env WREN_SCENE', 'not set'), ('file /tmp/x', 'not set')],
    );
    await tester.pumpWidget(WrenApp(home: UnknownScene.from(request)));
    await tester.pumpAndSettle();

    // The point of the screen: the routes are on it, so the artifact alone says
    // which mechanism failed.
    expect(find.text('no scene was named'), findsOne);
    expect(find.textContaining('env WREN_SCENE'), findsOne);
    expect(find.textContaining('file /tmp/x'), findsOne);
    expect(tester.takeException(), isNull);
  });
}
