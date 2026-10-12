const String rollNo = '04072313012';

final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;
final int feePerDay = 5 + t;
final int daysLate = 3 + (t + u) % 6;
final int daysBig = 10 + u;
final int feeCap = 150 + 10 * t;
final int renewLimit = 1 + t % 3;
final int renewAttempts = 2 + u;
final int shelfSize = 3 + u % 4;

abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  int lateFee(int days);
}

class Book extends LibraryItem implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) {
    return days * feePerDay;
  }

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) {
    return days * (feePerDay ~/ 2);
  }
}

Magazine mainMagazine() {
  final int index = (u + 1) % 10;

  return Magazine(
    titles[index],
    yearOf(index),
    1 + (t + u) % 12,
  );
}

class Dvd extends LibraryItem {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) {
    return days * feePerDay * 2;
  }
}

Dvd mainDvd() {
  final int index = (u + 2) % 10;

  return Dvd(
    titles[index],
    yearOf(index),
    90 + seed % 40,
  );
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  Book b = mainBook();
  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // item is a LibraryItem variable, so I cannot access
  // pages through it. The pages field belongs to Book.
}

void step2() {
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // Without @override, a misspelled method name such as
  // descibe() would not replace the inherited describe().
  // With @override, Dart reports the mistake.
}

void step3() {
  final Book book = mainBook();
  final Magazine magazine = mainMagazine();
  final Dvd dvd = mainDvd();

  print(
    'Step 3: Book late fee for $daysLate days = '
    '${book.lateFee(daysLate)}',
  );

  print(
    'Step 3: Magazine late fee for $daysLate days = '
    '${magazine.lateFee(daysLate)}',
  );

  print(
    'Step 3: Dvd late fee for $daysLate days = '
    '${dvd.lateFee(daysLate)}',
  );

  // An abstract class cannot be instantiated directly.
  // Its concrete subclasses must implement lateFee().
}

void step4() {
  final Book book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  final List<LibraryItem> items = [
    book,
    mainMagazine(),
    mainDvd(),
  ];

  for (final item in items) {
    print(
      'Step 4: ${item.runtimeType} borrowable? '
      '${item is Borrowable}',
    );
  }

  // implements provides a contract, not inherited method bodies.
  // extends Borrowable would require extending that class instead
  // of LibraryItem, which is not the inheritance we want.
}

void step5() {
  print('--- Step 5 ---');
}

void step6() {
  print('--- Step 6 ---');
}

void step7() {
  print('--- Step 7 ---');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
