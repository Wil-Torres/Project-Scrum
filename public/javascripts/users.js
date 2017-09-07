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

module.exports = userModel;