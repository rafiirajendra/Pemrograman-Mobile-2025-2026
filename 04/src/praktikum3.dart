void main() {
  var gifts = {
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 1
  };

  var nobleGases = {
    2: 'helium',
    10: 'neon',
    18: 2,
  };

  gifts['nama'] = 'Rafi Rajendra'; 
  gifts['nim'] = '2341720158';   

  nobleGases[99] = 'Rafi Rajendra'; 
  nobleGases[100] = '2341720158'; 

  print(gifts);
  print(nobleGases);

  var mhs1 = Map<String, String>();
  mhs1['nama'] = 'Rafi Rajendra'; 
  mhs1['nim'] = '2341720158';   

  var mhs2 = Map<int, String>();
  mhs2[99] = 'Rafi Rajendra'; 
  mhs2[100] = '2341720158'; 
}