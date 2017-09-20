// instanciamos el paquete de mysql
var mysql = require('mysql');
// creamos una conexion a nuestra base de datos
connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '123456',
  database: 'project_scrum'
});
// creamos un objeto para ir almacenando todo lo que necesitamos
var projectModel = {};

projectModel.getProjects = function(callback){
  if(connection){
    connection.query('SELECT * FROM proyectos ORDER BY proyectos_id', function(error, rows){
      if(error){
        throw error;
      }else{
        callback(null, rows);
      }
    });
  }
}

// Obtenermos el Usuario por su id
projectModel.getProject = function(id, callback){
  if(connection){
    var sql = 'SELECT * FROM proyectos WHERE proyectos_id =' + connection.escape(id);
    connection.query(sql, function(error, rows){
      if(error){
        throw error;
      }else{
        callback(null, rows)
      }
    })
  }
};
projectModel.insertUser = function(objeto, callback){
  if(connection){
    connection.query('INSERT INTO proyectos SET ?', objeto, function(error, result){
      if(error){
        throw error;
      }else{
        callback(null, {'insertId' : result.insertId})
      }
    });
  }
}
projectModel.updateUser = function(objeto, callback){
  if(connection){
    let sql = 'UPDATE proyectos SET proyectos_nombre = ' + connection.escape(objeto.nombre) + ',' +
    'proyectos_observaciones = ' + connection.escape(objeto.observacion) + 'WHERE proyectos_id = ' + objeto.id;

    connection.query(sql, function(error, result){
      if(error){
        throw error;
      }else{
        callback(null, {'msg':"success"});
      }
    })
  }
}
projectModel.deleteUser = function(id, callback){
  if(connection){
    let sqlExist = 'SELECT * FROM proyectos WHERE proyectos_id = ' + connection.escape(id);
    connection.query(sqlExist, function(error, row){
      if(row){
        var sql = 'DELETE FROM proyectos WHERE proyectos_id = ' + connection.escape(id);
        connection.query(sql, function(error, result){
          if(error){
            throw error
          }else{
            callback(null, {'msg':'Delete'})
          };
        });
      }else{
        callback(null, {'msg':'Project Not exist'})
      }
    })
  }
};

module.exports = projectModel;