
final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming']
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile']
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design']
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math']
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile']
  },
];

// Part 1 Functions
// Task 1.1
double lateFee(int daysLate, double ratePerDay) =>
    daysLate * ratePerDay;
// Task 1.2
String formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  }

  return '$title by $author';
}
// Task 1.3
Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {
    'title': title,
    'author': author,
    'year': year,
    'copies': copies,
  };
}
// Task 1.4
bool isClassic(int year) => year < 2000;
// Part 2 Functions
// Task 2.1
List<String> transformAll(
    List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}
// Task 2.2
int Function() makeCounter() {
  int count = 0;

  return () {
    count++;
    return count;
  };
}
// Task 2.3
double Function(int) makeFeeCalculator(double rate) {
  return (days) => days * rate;
}
// Task 2.4
int sumDigits(int n) {
  if (n < 10) {
    return n;
  }
  return (n % 10) + sumDigits(n ~/ 10);
}
// Part 3 Functions
// Task 3.4
Map<String, int> buildStock() {
  return {
    for (final book in books)
      book['title'] as String: book['copies'] as int,
  };
}
// Part 4 Generics
// Task 4.1
class Box<T> {
  T value;

  Box(this.value);
}
// Task 4.2
T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) {
    return fallback;
  }

  return items.first;
}
// Task 4.3
class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return '($first, $second)';
  }
}
// Part 5 Exceptions
// Task 5.1
class BookNotFoundException implements Exception {
  final String title;

  BookNotFoundException(this.title);
}
class BookNotAvailableException implements Exception {
  final String title;

  BookNotAvailableException(this.title);
}
// Task 5.2
void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }

  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }

  stock[title] = stock[title]! - 1;
}

// Task 5.4
Map<String, dynamic> findBook(String title) {
  return books.firstWhere(
    (book) => book['title'] == title,
  );
}

// Part 6 Async Functions
// Task 6.1
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(
    Duration(seconds: 1),
  );

  return 'Dart in Action';
}

// Task 6.3
Future<String> fetchBroken() async {
  await Future.delayed(
    Duration(milliseconds: 500),
  );

  throw Exception('Server down');
}

// Main

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}
// Part 1
void part1() {
  print('--- Part 1 ---');

  print('Late fee: ${lateFee(5, 0.5)}');

  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));

  print(
    makeBook(
      title: 'Clean Code',
      author: 'Martin',
    ),
  );

  print(
    makeBook(
      title: 'Algorithms',
      author: 'Knuth',
      year: 1968,
    ),
  );

  print(isClassic(1968));
  print(isClassic(2021));
}

// Part 2

void part2() {
  print('--- Part 2 ---');

  final names = [
    'Dart in Action',
    'Clean Code'
  ];
  final upperCase = transformAll(
    names,
    (name) => name.toUpperCase(),
  );
  print(upperCase);
  final addExclamation = transformAll(
    names,
    (name) => '$name!',
  );
  print(addExclamation);
  final desk1 = makeCounter();
  final desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());
  final studentFee = makeFeeCalculator(0.25);
  final staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');
  print('Sum of digits: ${sumDigits(125)}');
}
// Part 3
void part3() {
  print('--- Part 3 ---');
  // Task 3.1
  final titles = books
      .map((book) => book['title'] as String)
      .toList();
  print('Titles: $titles');
  final available = books
      .where((book) => (book['copies'] as int) > 0)
      .map((book) => book['title'] as String)
      .toList();

  print('Available: $available');
  // Task 3.2
  final totalCopies = books.fold<int>(
    0,
    (sum, book) => sum + (book['copies'] as int),
  );
  print('Total copies: $totalCopies');


  final years = books
      .map((book) => book['year'] as int)
      .toList();

  final oldestYear = years.reduce(
    (oldest, year) {
      if (year < oldest) {
        return year;
      }

      return oldest;
    },
  );
  print('Oldest year: $oldestYear');
  // Task 3.3

  final sortedBooks = [...books];
  sortedBooks.sort(
    (a, b) =>
        (a['year'] as int).compareTo(b['year'] as int),
  );
  final sortedTitles = sortedBooks
      .map((book) => book['title'] as String)
      .toList();
  print('By year: $sortedTitles');
  // Task 3.4
  final stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });
  print(
    'Copies of Unknown: ${stock['Unknown'] ?? 0}',
  );
  // Task 3.5
  final allTags = <String>{
    for (final book in books)
      ...(book['tags'] as List<String>),
  };

  print('All tags: $allTags');
  var a = {
    'Dart in Action',
    'Clean Code',
    'Flutter Basics'
  };
  var b = {
    'Clean Code',
    'Flutter Basics',
    'Algorithms'
  };
  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}
// Part 4
void part4() {
  print('--- Part 4 ---');
  // Task 4.1
  final intBox = Box<int>(5);
  final stringBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');
  // This gives a compile-time error, so it is commented out.
  // intBox.value = 'hello';
  // Task 4.2
  print(
    firstOr(
      ['Dart in Action', 'Clean Code'],
      'none',
    ),
  );
  print(
    firstOr<String>(
      [],
      'z',
    ),
  );
  // Task 4.3
  print(
    Pair('Dart in Action', 3),
  );
}

// Part 5
void part5() {
  print('--- Part 5 ---');
  // Task 5.3
  var stock = buildStock();

  var titles = [
    'Dart in Action',
    'Flutter Basics',
    'Unknown Book'
  ];
  for (final title in titles) {
    try {
      checkOut(stock, title);

      print('Checked out: $title');
    } on BookNotAvailableException {
      print(
        'Sorry: "$title" has no copies left',
      );
    } on BookNotFoundException {
      print(
        'Not found: "$title"',
      );
    } finally {
      print('Transaction logged');
    }
  }
  print(
    'Copies left of Dart in Action: '
    '${stock['Dart in Action']}',
  );
  // Task 5.4
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

// Part 6
Future<void> part6() async {
  print('--- Part 6 ---');
  // Task 6.1
  print('Fetching...');
  final book = await fetchBookOfTheDay();
  print('Book of the day: $book');
  // Task 6.2
  // If await is removed: final result = fetchBookOfTheDay(); print(result); the output will be something similar to: Instance of _Future<String> because the function returns Future<String>.
  // Task 6.3
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}
// Reflection
// 1. When would you choose fold over reduce?
// I would use fold when I need a starting value or when the list can be empty. fold can work with an empty list because it has an initial value.
// 2. What does it mean that a closure "captures" a variable? Which variable was captured in makeCounter?
// A closure can remember and use a variable from the function where it was created. In makeCounter(), the variable captured by the returned function is count.
// 3. Why must on BookNotAvailableException come before a general catch (e)? The specific exception should be handled first. If a general catch comes first, it could catch the exception before the specific handler gets a chance to handle it.
//4. Why does forgetting await still compile, but give the wrong result? An async function returns a Future. Without await, we get the Future object instead of the actual result, so the program can print something like Instance of _Future<String>.
```
