// instanciamos el paquete de mysql
var mysql = require('mysql');
// creamos una conexion a nuestra base de datos
connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '123456',
  database: 'pruebas'
});
// creamos un objeto para ir almacenando todo lo que necesitamos
var userModel = {};

// obtenemos todos los usuarios
userModel.getUsers = function(callback){
  if(connection){
    connection.query('Select * from users order by id', function(error, rows){
      if(error){
        throw error;
      }else{
        callback(null, rows);
      }
    });
  }
}

// Obtenermos el Usuario por su id
userModel.getUser = function(id, callback){
  if(connection){
    var sql = 'select * from users where id =' + connection.escape(id);
    connection.query(sql, function(error, rows){
      if(error){
        throw error;
      }else{
        callback(null, rows)
      }
    })
  }
};
userModel.insertUser = function(objeto, callback){
  if(connection){
    connection.query('insert into users set ?', objeto, function(error, result){
      if(error){
        throw error;
      }else{
        callback(null, {'insertId' : result.insertId})
      }
    });
  }
}
userModel.updateUser = function(objeto, callback){
  if(connection){
    let sql = 'UPDATE users SET username = ' + connection.escape(objeto.username) + ',' +
    'email = ' + connection.escape(objeto.email) + 'where id = ' + objeto.id;

    connection.query(sql, function(error, result){
      if(error){
        throw error;
      }else{
        callback(null, {'msg':"success"});
      }
    })
  }
}
userModel.deleteUser = function(id, callback){
  if(connection){
    let sqlExist = 'SELECT * FROM users where id = ' + connection.escape(id);
    connection.query(sqlExist, function(error, row){
      if(row){
        var sql = 'DELETE FROM users WHERE id = ' + connection.escape(id);
        connection.query(sql, function(error, result){
          if(error){
            throw error
          }else{
            callback(null, {'msg':'Delete'})
          };
        });
      }else{
        callback(null, {'msg':'User Not exist'})
      }
    })
  }
};

module.exports = userModel;