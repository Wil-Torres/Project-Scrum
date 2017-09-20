var express = require('express');
var router = express.Router();
var projectModel = require('../models/proyectos');

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
})
.get('/projects', function(req, res, next) {
  console.log('ento al get de proyectos')
  projectModel.getProjects(function(error, data){
    res.json(200, data);
  })
  //res.render('users', { title: 'Iniciando seccion de usuarios', subtitle: 'Pagina en Construnccion'});
})
.get('/projects/:id', function(req, res, next) {
  var id = req.params.id;
  if(!isNaN(id)){
    projectModel.getProject(id, function(error, data){
      if(typeof data !== 'undefined' && data.length > 0){
        res.json(200, data);
      }else{
        res.json(404, {'msg':'No Existe'});
      }
    });
  }else{
    res.json(500, {'msg': 'Error'});
  }
});

module.exports = router;
