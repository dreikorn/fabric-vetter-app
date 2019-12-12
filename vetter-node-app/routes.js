//SPDX-License-Identifier: Apache-2.0

var vetters = require('./controller.js');

module.exports = function(app){

  app.get('/add_enterprise/:enterprise', function(req, res){
    vetters.add_enterprise(req, res);
  });
  app.get('/get_all_items/:item_type', function(req, res){
    vetters.get_all_items(req, res);
  });
}
