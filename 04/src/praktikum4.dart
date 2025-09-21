void main() {
  var list = [1, 2, 3];
  var list2 = [0, ...list];
  print(list);
  print(list2);
  print(list2.length);

  var nimList = [2, 3, 4, 1, 7, 2, 0, 1, 5, 8];
  var nimList2 = [...nimList];
  print(nimList2);

  var promoActive = false;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print(nav);

  var login = 'Manager';
  var nav2 = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
  print('Login : $login + ${nav2}');

  login = 'Admin';
  var nav3 = ['Home', 'Furniture', 'Plants', if (login case 'Admin') 'Orders'];
  print('Login : $login + ${nav3}');

  login = 'User';
  var nav4 = ['Home', 'Furniture', 'Plants', if (login case 'User') 'Profile'];
  print('Login : $login + ${nav4}');

  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');
  print(listOfStrings);
}