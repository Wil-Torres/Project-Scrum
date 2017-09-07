var express = require('express');
var UserModel = require('../models/users');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Iniciando Proyecto SCRUM', subtitle: 'Pagina en Construnccion'});
})
.get('/create', function(req, res){
  res.render("new", {
    title: "Formulario para crear un nuevo usuario"
  });
})
.get('/users', function(req, res, next) {
  let info = {};
  UserModel.getUsers(function(error, data){
    res.json(200, data);
  })
  //res.render('users', { title: 'Iniciando seccion de usuarios', subtitle: 'Pagina en Construnccion'});
})
.get('/users/:id', function(req, res, next){
  var id = req.params.id;
  if(!isNaN(id)){
    UserModel.getUser(id, function(error, data){
      if(typeof data !== 'undefined' && data.length > 0){
        res.json(200, data);
      }else{
        res.json(404, {'msg':'No Existe'});
      }
    });
  }else{
    res.json(500, {'msg': 'Error'});
  }
})
.post("/users", function(req, res){
  UserModel.insertUser(req.body, function(error, data){
    if(data && data.insertId){
      res.redirect('/users/' + data.insertId);
    }else{
      res.json(500, {'msg': 'Error al insertar'});
    }
  });
});

console.log(router)
module.exports = router;
