


import 'package:finalproject/Models/User.dart';
import 'package:mysql1/mysql1.dart';

var _conn;
void main(){
  showUsers();
  insertUser(User());
}


// for(int i=0; i<100; 1++)

Future<void> showUsers() async {
  var settings = new ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      db: 'rabab12'
  );
  _conn = await MySqlConnection.connect(settings);
  // Query the database using a parameterized query
  var results = await _conn.query(
    'select * from users',);
  for (var row in results) {
    print('userID: ${row[0]}, password: ${row[1]} name: ${row[2]},email: ${row[3]}');
  }
}


Future<void> insertUser(password,name,email) async {
  var settings = new ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      db: 'rabab12'
  );
  var conn = await MySqlConnection.connect(settings);

  var result = await conn.query(
      'insert into users (password, name,email) values (?, ?, ?)',
      ['Bob', '123', 'momo']);
  print('Inserted row id=${result.insertId}');



  //////////

/*
  // Query the database using a parameterized query
  var results = await conn.query(
      'select * from users where userID = ?', [6]);  // [result.insertId]
  for (var row in results) {
    print('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
  }

  // Update some data
  await conn.query('update users set firstName=? where userID=?', ['Bob', 5]);

  // Query again database using a parameterized query
  var results2 = await conn.query(
      'select * from users where userID = ?', [result.insertId]);
  for (var row in results2) {
    print('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
  }*/

  // Finally, close the connection
  await conn.close();

}



