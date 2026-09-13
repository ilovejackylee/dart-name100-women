import 'dart:io';

import 'package:name100_women/name100_women.dart';

Future<void> main(List<String> args) async {
  var web = false;
  var printUrl = false;
  var goal = 100;

  for (final arg in args) {
    if (arg == '--web') {
      web = true;
    } else if (arg == '--print-url') {
      printUrl = true;
    } else if (arg == '--help' || arg == '-h') {
      _printHelp();
      return;
    } else if (arg == '--version' || arg == '-v') {
      stdout.writeln('name100_women $packageVersion');
      return;
    } else if (arg.startsWith('--goal=')) {
      goal = int.parse(arg.substring('--goal='.length));
    } else {
      stderr.writeln('Unknown option: $arg');
      _printHelp();
      exitCode = 1;
      return;
    }
  }

  if (printUrl) {
    stdout.writeln(playUrl);
    return;
  }
  if (web) {
    stdout.writeln(playUrl);
    if (Platform.isWindows) {
      await Process.run('cmd', ['/c', 'start', '', playUrl], runInShell: true);
    }
    return;
  }

  await _runPractice(goal);
}

void _printHelp() {
  stdout.writeln('''
Usage: name100_women [options]

  --print-url   Print the Name 100 Women challenge URL
  --web         Print and open the online challenge (Windows)
  --goal=N      Offline practice target (default 100)
  --version     Show version
  --help        Show this help
''');
}

Future<void> _runPractice(int goal) async {
  stdout.writeln('Name 100 Women — offline practice');
  stdout.writeln('Online (Wikidata-checked): $playUrl');
  stdout.writeln();
  stdout.writeln("Type a woman's name and press Enter. Aim for $goal.");
  stdout.writeln('Empty line = finish. Ctrl+C = quit.');
  stdout.writeln();

  final names = <String>[];
  final seen = <String>{};
  final started = DateTime.now();

  while (names.length < goal) {
    stdout.write('[${names.length}/$goal] > ');
    final raw = stdin.readLineSync();
    if (raw == null) break;
    final trimmed = raw.trim();
    if (trimmed.isEmpty) break;
    final key = trimmed.toLowerCase();
    if (seen.contains(key)) {
      stdout.writeln('  (already listed)');
      continue;
    }
    seen.add(key);
    names.add(trimmed);
  }

  final elapsed = DateTime.now().difference(started);
  stdout.writeln();
  stdout.writeln('Named ${names.length} · ${_formatElapsed(elapsed)}');
  if (names.isNotEmpty) {
    stdout.writeln('Your list:');
    for (var i = 0; i < names.length; i++) {
      stdout.writeln('  ${i + 1}. ${names[i]}');
    }
  }
  stdout.writeln();
  stdout.writeln('Play the checked round online → $playUrl');
}

String _formatElapsed(Duration elapsed) {
  final sec = elapsed.inSeconds;
  final mm = sec ~/ 60;
  final ss = sec % 60;
  return mm > 0 ? '$mm:${ss.toString().padLeft(2, '0')}' : '$sec sec';
}
