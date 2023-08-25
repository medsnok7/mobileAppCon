import '../DBHelper/db_helper.dart';
import '../packages/cart_exports.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter = 0;
  int get counter => _counter;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getCartData() async {
    _cart = db.getCartList();
    return _cart;
  }

  Future<int> removeItemFromCart(int id) async {
    DBHelper cartHelper = DBHelper();
    return await cartHelper.removeFromCart(id);
  }

  Future<int> removeAllFromCart() async {
    DBHelper cartHelper = DBHelper();
    return await cartHelper.removeAllCart();
  }

  Future<int> updateCartList(Cart cart) async {
    DBHelper cartHelper = DBHelper();
    return await cartHelper.updateCartList(cart);
  }

  void _setPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('item_price', _counter);
    pref.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _counter = pref.getInt('item_price') ?? 0;
    _totalPrice = pref.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCount() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCount() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCount() {
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice += productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice -= productPrice;

    _setPrefItems();
    notifyListeners();
  }

  double getTotalprice() {
    _getPrefItems();
    return _totalPrice;
  }

  void initTotalPrice() {
    _totalPrice = 0.0;
    _setPrefItems();
    notifyListeners();
  }

  void initCounter() {
    _counter = 0;
    _setPrefItems();
    notifyListeners();
  }
}
