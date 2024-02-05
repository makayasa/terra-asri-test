void main(args) {
  const words = [
    'mAlAyAlaM',
    'A man, a plan, a canal: Panama',
    'Sir, I demand, I am a maid named Iris',
    'Dammit I’m Mad',
    'Satire: Veritas',
    'Dr Awkward & Olson in Oslo',
  ];
  for (var word in words) {
    // final ispalindrom2 = palindrom2('');
    print(isPalindrom(word));
    print(isPalindrom2(word));
  }
  decodeEmoji("I'm feeling 🤔 about the upcoming ✈️ trip. Will we see ️🗺 landmarks?");
  decodeEmoji('🥷🏼! 🎊 for the 🥷🏼 birthday surprise! ☄️ to the party place!');

  final res = calculateDiagonalSum(211);
  print(res);

  calcSelfNumber();
  findSelfNumbersSum();
}

int calculateDiagonalSum(int size) {
  List<List<int>> matrix = List.generate(size, (index) => List<int>.filled(size, 0));

  int currentValue = size * size;
  int startRow = 0, endRow = size - 1;
  int startCol = 0, endCol = size - 1;
  var temp = 0;

  while (startRow <= endRow && startCol <= endCol) {
    // Penuhi baris dari kiri ke kanan
    for (int i = endCol; i >= startCol; i--) {
      matrix[startRow][i] = currentValue--;
    }
    startRow++;

    // Penuhi kolom dari atas ke bawah
    for (int i = startRow; i <= endRow; i++) {
      matrix[i][startCol] = currentValue--;
    }
    startCol++;

    // Penuhi baris dari kanan ke kiri
    for (int i = startCol; i <= endCol; i++) {
      matrix[endRow][i] = currentValue--;
    }
    endRow--;

    // Penuhi kolom dari bawah ke atas
    for (int i = endRow; i >= startRow; i--) {
      matrix[i][endCol] = currentValue--;
    }
    endCol--;
  }
  for (int i = 0; i < size; i++) {
    temp += matrix[i][i];
    temp += matrix[i][(size - 1) - i];
  }
  return temp - 1;
}

bool isPalindrom(String word) {
  RegExp specialCharactersRegex = RegExp(r'[^a-zA-Z0-9]');

  word = word.replaceAll(specialCharactersRegex, '').toLowerCase();
  final temp = word.split('');
  final reversed = temp.reversed.toList().join();
  return reversed == word;

  return true;
}

bool isPalindrom2(String word) {
  RegExp specialCharactersRegex = RegExp(r'[^a-zA-Z0-9]');

  word = word.replaceAll(specialCharactersRegex, '').toLowerCase();
  final split = word.split('');
  for (var i = 0; i < split.length; i++) {
    if (!(split[i] == split[(split.length - 1) - i])) {
      return false;
    }
  }
  return true;
}

int d(int number) {
  var temp = number;
  String sNumber = number.toString();
  final splitted = sNumber.split('');
  for (var n in splitted) {
    temp += int.parse(n);
  }
  return temp;
}

void calcSelfNumber() {
  final stopwatch = Stopwatch()..start();
  const limit = 100000;
  Map<String, List<int>> generators = {};

  for (var i = 1; i < limit; i++) {
    final int gen = d(i);
    if (!generators.containsKey('$gen')) {
      generators['$gen'] = [];
    }
    generators['$gen']!.add(i);
  }

  int selNum = 0;
  for (var i = 1; i < limit; i++) {
    if (!generators.containsKey('$i')) {
      selNum++;
    }
  }
  stopwatch.stop();
  print('Ada total $selNum self-numbers');
  print('execution time : ${stopwatch.elapsed}');
}

int d2(int n) {
  int sum = n;
  while (n > 0) {
    sum += n % 10;
    n ~/= 10;
  }
  return sum;
}

void findSelfNumbersSum() {
  final stopwatch = Stopwatch()..start();
  const limit = 100000;
  Set<int> generators = Set();
  int selfNumbersSum = 0;
  for (int i = 1; i < limit; i++) {
    int generator = d(i);
    if (!generators.contains(generator)) {
      generators.add(generator);
    }
  }
  for (int i = 1; i < limit; i++) {
    if (!generators.contains(i)) {
      selfNumbersSum++;
    }
  }
  stopwatch.stop();
  print('Ada total $selfNumbersSum self-numbers');
  print('execution time : ${stopwatch.elapsed}');
}

String decodeEmoji(String word) {
  RegExp specialCharactersRegex = RegExp(r'[!@#\$%^*()]');
  Map<dynamic, dynamic> basicEncoding = {
    '🍔': 'burger',
    '🍟': 'fries',
    '🍕': 'pizza',
    '✈️': 'airplane',
    '🛳': 'cruise ship',
    '🗺': 'map',
    '😄': 'happy',
    '🥹': 'sad',
    '🤔': 'thinking',
  };
  Map<dynamic, dynamic> advancedEncoding = {
    '🐝': 'bee',
    '🤖': 'think',
    '🎊': 'celebration',
    '🥷🏼': 'keep it secret',
    '☄️': 'blast off',
    '🧑‍🍳+🍴': 'chef cooks a dish',
    '🚵‍♀️+🎊': 'win a race',
  };
  final splitted = word.split(' ');
  var temp = '';

  for (var e in splitted) {
    final s = e.split('');
    var indexSpecialCharacter = -1;
    for (var i = 0; i < s.length; i++) {
      if (specialCharactersRegex.hasMatch(s[i])) {
        indexSpecialCharacter = i;
        break;
      }
    }
    var specialCharacter = '';
    if (indexSpecialCharacter != -1) {
      specialCharacter = s.removeAt(indexSpecialCharacter);
    }
    var a = basicEncoding[s.join()]?.trim() ?? advancedEncoding[s.join()]?.trim() ?? s.join().trim();
    a += specialCharacter;
    temp += '$a ';
  }
  print(temp);
  return temp;
}
