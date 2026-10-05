// lab3.dart - Campus Cafe Order System
// Name: Muhammad Ilyas
// Roll no: 12

const String rollNo = '12';
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];

int priceOf(int i) => 100 + 7 * i + 3 * t;

final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// Step 1
class Dish {
  late String name;
  late int price;
}
// Step 2 and Step 3
class MenuItem {
  String name;
  int price;
  // Constructor using this shorthand.
  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }
  // Named constructor for free items.
  MenuItem.free(this.name) : price = 0;
  // Named constructor that creates an item from text.
  MenuItem.fromString(String text)
      : name = text.split(':')[0],
        price = int.parse(text.split(':')[1]);
  @override
  String toString() => '$name (Rs $price)';
}

// Step 4
class OrderLog {
  static OrderLog? _instance;

  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    _instance ??= OrderLog._internal();
    return _instance!;
  }

  void add(String msg) => entries.add(msg);
}
// Step 5 and Step 6
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;
  OrderLine(this.item, this.qty)
      : total = item.price * qty,
        tax = (item.price * qty) * taxPercent ~/ 100,
        assert(qty > 0, 'qty must be positive');
  // Getter for the complete amount including tax.
  int get grand => total + tax;
  // Checks whether this is a big order.
  bool get isBigOrder => grand > bigOrderLimit;
  // Gives a simple label for the order line.
  String get label => '${item.name} x$qty';
}
// Step 7
class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}

// Step 10
class Coupon {
  static final Map<String, Coupon> _cache = {};

  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
      : minSpend = percent * 70,
        assert(percent >= 1 && percent <= 50);

  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(
      code,
      () => Coupon(code, couponPercent),
    );
  }

  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }

    return 0;
  }
}
// Main order used in multiple steps
OrderLine mainOrder() {
  return OrderLine(
    MenuItem(menu[u], priceOf(u)),
    2 + (t + u) % 5,
  );
}

// Step 8
List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}
// Step 9
List<OrderLine> buildReceipt() {
  List<MenuItem> items = buildMenu();

  return [
    for (int k = 0; k < 3; k++)
      OrderLine(
        items[k],
        1 + (t + k) % 4,
      ),
  ];
}
// main
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
// Step 1: Classes and Objects
void step1() {
  print('--- Step 1 ---');

  Dish item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  Dish item2 = Dish();
  int secondIndex = (u + 1) % 10;

  item2.name = menu[secondIndex];
  item2.price = priceOf(secondIndex);

  // Give the second item a small discount.
  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}
// Step 2: Constructors
void step2() {
  print('--- Step 2 ---');
  MenuItem a = MenuItem(menu[u], priceOf(u));
  MenuItem b = MenuItem('Test Special', 15 * u); 
  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: ${b.name} Rs ${b.price}'); 
  // price cannot be final here because the constructor may change the price when it is below priceFloor.
}
// Step 3: Named Constructors
void step3() {
  print('--- Step 3 ---'); 
  MenuItem freebie = MenuItem.free('Water'); 
  int index = (u + 2) % 10;
  MenuItem parsed =
      MenuItem.fromString('${menu[index]}:${priceOf(index)}');

  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print(
    'Step 3: floor=$priceFloor, free price=${freebie.price}',
  );

  // The floor logic is only inside the main constructor. MenuItem.free has its own initialization, so it does not run the main constructor body.
}

// Step 4: Factory Constructor 
void step4() {
  print('--- Step 4 ---');
  OrderLog log1 = OrderLog();
  OrderLog log2 = OrderLog();
  for (int i = 1; i <= u + 2; i++) {
    String message = 'order #${100 * t + i}';
    if (i % 2 == 1) {
      log1.add(message);
    } else {
      log2.add(message);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');

  // The underscore makes these private to this Dart library.
  // The private constructor stops normal outside construction.
}

// Step 5: Initializer Lists and Assertions

void step5() {
  print('--- Step 5 ---');

  OrderLine line = mainOrder();

  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }

  // An initializer list runs before the constructor body.It cannot use another field such as total because that field has not been initialized yet. The constructor parameters should be used to calculate the values.
}
// Step 6: Getters
void step6() {
  print('--- Step 6 ---');
  OrderLine line = mainOrder();
  print('Step 6: grand=${line.grand}');
  print(
    'Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)',
  );
  print('Step 6: label=${line.label}');

  // A getter has no setter, so line.grand = 5 would not be allowed.
  // A setter would have to be added if we wanted to assign to grand.
}

// Step 7: Setters

void step7() {
  print('--- Step 7 ---');

  StudentCard card = StudentCard('S$seed');
  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');
  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');
  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');
  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');
  // Instead of silently clamping an invalid value, a setter could throw an exception or show an error message.
}

// Step 8: Menu

void step8() {
  print('--- Step 8 ---');

  List<MenuItem> items = buildMenu();

  MenuItem priciest = items.reduce(
    (a, b) => a.price > b.price ? a : b,
  );

  int sum = items.fold(
    0,
    (total, item) => total + item.price,
  );

  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

// Step 9: Receipt
void step9() {
  print('--- Step 9 ---');

  List<OrderLine> receipt = buildReceipt();
  int receiptTotal = 0;

  for (OrderLine line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');
    OrderLog().add('receipt: ${line.label}');

    receiptTotal += line.grand;
  }

  print('Step 9: receipt total = $receiptTotal');
  print('Step 9: log size = ${OrderLog().entries.length}');
}

// Step 10: Discount Coupons
void step10() {
  print('--- Step 10 ---');

  String code = 'CAFE${seed.toString().padLeft(2, '0')}';

  Coupon c1 = Coupon.fromCode(code);
  Coupon c2 = Coupon.fromCode(code);
  List<OrderLine> receipt = buildReceipt();
  int receiptAmount = receipt.fold(
    0,
    (sum, line) => sum + line.grand,
  );
  int discount = c1.discountOn(receiptAmount);
  int payable = receiptAmount - discount;
  print(
    'Step 10: $code gives ${c1.percent}% off, '
    'min spend ${c1.minSpend}',
  );
  print('Step 10: cached? ${identical(c1, c2)}');
  print(
    'Step 10: receipt $receiptAmount, '
    'discount $discount, payable $payable',
  );
}

// Wrap-up Questions

// Q1. Animal(this.name, this.type) saves us from writing the assignments this.name = name and this.type = type manually.
// Q2. I would use a named constructor when I want different meaningful ways to create an object. I would use a factory constructor when I may want to return an existing object or control how the object is created.
// Q3. A constructor body assigns fields after the object has started initialization. An initializer list initializes fields before the constructor body runs and is required for final fields that need calculated values.
// Q4. A getter is useful when a value is calculated instead of stored directly. A setter is useful when I want to validate or control a value before storing it.
