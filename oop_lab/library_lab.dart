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

  static int created = 0;

  LibraryItem(this.title, this.year) {
    created++;
  }

  static int capFee(int fee) {
    return fee > feeCap ? feeCap : fee;
  }

  String describe() => '$title ($year)';

  int lateFee(int days);
}

mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }

    renewals++;
    return true;
  }
}

class Book extends LibraryItem with Renewable implements Borrowable {
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

class Dvd extends LibraryItem with Renewable {
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

enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) {
    return fee - (fee * discountPercent ~/ 100);
  }
}

class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine other) => Fine(amount + other.amount);

  bool operator >(Fine other) => amount > other.amount;

  @override
  bool operator ==(Object other) => other is Fine && other.amount == amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}

extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials =>
      split(' ').where((word) => word.isNotEmpty).map((word) => word[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) {
    return fold(0, (sum, item) => sum + item.lateFee(days));
  }
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
  final Book book = mainBook();
  int successfulRenewals = 0;
  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      successfulRenewals++;
    }
  }

  print(
    'Step 5: renewed $successfulRenewals of '
    '$renewAttempts attempts (limit $renewLimit)',
  );
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  // A mixin adds reusable behavior without changing the
  // superclass. Only Book and Dvd need renewal behavior.
}

void step6() {
  final MemberType type = MemberType.values[seed % 3];
  final int bookFee = mainBook().lateFee(daysLate);

  print(
    'Step 6: member type = ${type.name} (index ${type.index})',
  );
  print('Step 6: max loans = ${type.maxLoans}');
  print(
    'Step 6: book fee $bookFee -> '
    '${type.applyDiscount(bookFee)} after discount',
  );

  // Enum values prevent invalid member-type strings.
}

void step7() {
  final MemberType type = MemberType.values[seed % 3];
  final int bookFee = mainBook().lateFee(daysLate);
  final int discountedFee = type.applyDiscount(bookFee);

  final String title = titles[u];
  final List<LibraryItem> shelf = [
    mainBook(),
    mainMagazine(),
    mainDvd(),
  ];

  print('Step 7: ${discountedFee.rs}');
  print('Step 7: initials of "$title" = ${title.initials}');
  print(
    'Step 7: shelf fee for $daysLate days = '
    '${shelf.totalLateFee(daysLate).rs}',
  );
}

void step8() {
  final Fine bookFine = Fine(mainBook().lateFee(daysLate));
  final Fine magazineFine = Fine(mainMagazine().lateFee(daysLate));

  final Fine totalFine = bookFine + magazineFine;

  print('Step 8: $bookFine + $magazineFine = $totalFine');
  print('Step 8: first bigger? ${bookFine > magazineFine}');
  print(
    'Step 8: equal copies? '
    '${bookFine == Fine(bookFine.amount)}',
  );

  final Set<Fine> fines = {
    bookFine,
    Fine(bookFine.amount),
    magazineFine,
  };

  print('Step 8: set size = ${fines.length}');
}

List<LibraryItem> buildShelf() {
  final List<LibraryItem> shelf = [];

  for (int k = 0; k < shelfSize; k++) {
    final int index = (u + k) % 10;

    if (k % 3 == 0) {
      shelf.add(
        Book(titles[index], yearOf(index), 100 + 3 * seed),
      );
    } else if (k % 3 == 1) {
      shelf.add(
        Magazine(
          titles[index],
          yearOf(index),
          1 + (t + k) % 12,
        ),
      );
    } else {
      shelf.add(
        Dvd(titles[index], yearOf(index), 90 + seed % 40),
      );
    }
  }

  return shelf;
}

void step9() {
  LibraryItem.created = 0;

  // Create one shelf, then another to check the counter.
  buildShelf();
  final List<LibraryItem> shelf = buildShelf();

  print('Step 9: items created = ${LibraryItem.created}');

  final int fee = shelf.first.lateFee(daysBig);
  final int cappedFee = LibraryItem.capFee(fee);

  print('Step 9: capped fee = $cappedFee (cap $feeCap)');

  print(
    'Step 9: const copies identical? '
    '${identical(const Fine(10), const Fine(10))}',
  );

  print(
    'Step 9: new copies identical? '
    '${identical(Fine(10), Fine(10))}',
  );
}

class Member {
  final String name;
  final MemberType type;

  Member(this.name, this.type);

  Fine feeFor(LibraryItem item, int days) {
    final int originalFee = item.lateFee(days);
    final int limitedFee = LibraryItem.capFee(originalFee);
    final int finalFee = type.applyDiscount(limitedFee);

    return Fine(finalFee);
  }
}

void step10() {
  final List<LibraryItem> shelf = buildShelf();

  final Member member = Member(
    'S$seed',
    MemberType.values[seed % 3],
  );

  final Fine totalFine = shelf.fold(
    Fine(0),
    (total, item) => total + member.feeFor(item, daysLate),
  );

  final int borrowableCount = shelf.where((item) => item is Borrowable).length;

  final int renewableCount = shelf.where((item) => item is Renewable).length;

  print(
    'Step 10: ${shelf.length} items, '
    '$borrowableCount borrowable, $renewableCount renewable',
  );

  print(
    'Step 10: ${member.name} (${member.type.name}) owes $totalFine',
  );

  print('Step 10: over the cap? ${totalFine > Fine(feeCap)}');
}
