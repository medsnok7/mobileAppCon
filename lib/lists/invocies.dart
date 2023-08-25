import 'package:mobileappconcorde/lists/products.dart';

class Supplier {
  final String name;
  final String address;
  final String paymentInfo;

  Supplier(this.name, this.address, this.paymentInfo);
}

class Customer {
  final String name;
  final String address;

  Customer(this.name, this.address);
}

class InvoiceInfo {
  final DateTime date;
  final DateTime dueDate;
  final String description;
  final String number;

  InvoiceInfo(this.date, this.dueDate, this.description, this.number);
}

class Invoice {
  static int _id = 0;
  int id;
  final Supplier supplier;
  final Customer customer;
  final InvoiceInfo info;
  final List items;
  final String name;



  Invoice(this.supplier, this.customer, this.info, this.items, this.name)
      : id = ++_id;

  double totalCost() {
    return items.fold(
      0,
      ((previousValue, element) {
        return previousValue + element.unitPrice * element.quantity;
      }),
    );
  }
}

List<Invoice> invoices = [
  Invoice(
    Supplier("Mohamed", "tunis street km7", "IBAN"),
    Customer("ala", "ain street km2"),
    InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 7)),
        "imma send this to u", "${DateTime.now().year}--9999"),
    products,
    "sell of clothes",
  ),
  Invoice(
      Supplier("cristian", "manzel chaker street km7", "WISE"),
      Customer("jade", "ain street km2"),
      InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 15)),
          "konnichiwa ogenki desu ka", "${DateTime.now().year}--9999"),
      products,
      "sell of food"),
  Invoice(
      Supplier("reyna", "ariana city", "CASH"),
      Customer("sova", "haven street km2"),
      InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 10)),
          "Hello world", "${DateTime.now().year}--9999"),
      products,
      "sell of weapons"),
  Invoice(
    Supplier("Mohamed", "tunis street km7", "IBAN"),
    Customer("ala", "ain street km2"),
    InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 7)),
        "imma send this to u", "${DateTime.now().year}--9999"),
    products,
    "sell of clothes",
  ),
  Invoice(
      Supplier("cristian", "manzel chaker street km7", "WISE"),
      Customer("jade", "ain street km2"),
      InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 8)),
          "konnichiwa ogenki desu ka", "${DateTime.now().year}--9999"),
      products,
      "sell of food"),
  Invoice(
    Supplier("Mohamed", "tunis street km7", "IBAN"),
    Customer("ala", "ain street km2"),
    InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 7)),
        "imma send this to u", "${DateTime.now().year}--9999"),
    products,
    "sell of clothes",
  ),
  Invoice(
      Supplier("cristian", "manzel chaker street km7", "WISE"),
      Customer("jade", "ain street km2"),
      InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 26)),
          "konnichiwa ogenki desu ka", "${DateTime.now().year}--9999"),
      products,
      "sell of food"),
  Invoice(
    Supplier("Mohamed", "tunis street km7", "IBAN"),
    Customer("ala", "ain street km2"),
    InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 7)),
        "imma send this to u", "${DateTime.now().year}--9999"),
    products,
    "sell of clothes",
  ),
  Invoice(
      Supplier("cristian", "manzel chaker street km7", "WISE"),
      Customer("jade", "ain street km2"),
      InvoiceInfo(DateTime.now(), DateTime.now().add(const Duration(days: 7)),
          "konnichiwa ogenki desu ka", "${DateTime.now().year}--9999"),
      products,
      "sell of food"),
];
