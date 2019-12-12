//SPDX-License-Identifier: Apache-2.0

var vetters = require('./controller.js');

module.exports = function(app){

  app.get('/get_tuna/:id', function(req, res){
    vetters.get_tuna(req, res);
  });
  app.get('/add_tuna/:tuna', function(req, res){
    vetters.add_tuna(req, res);
  });
  app.get('/get_all_items/:item_type', function(req, res){
    vetters.get_all_items(req, res);
  });
  app.get('/change_holder/:holder', function(req, res){
    vetters.change_holder(req, res);
  });
}
