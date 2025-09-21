void main(){
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
  print(halogens);

  var names1 = <String>{};
  Set<String> names2 = {}; // This works, too.

  names1.add('Muhammad Rafi Rajendra');
  names1.add('2341720158');

  names2.addAll(['Muhammad Rafi Rajendra', '2341720158']);

  print(names1);
  print(names2);
}