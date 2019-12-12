// SPDX-License-Identifier: Apache-2.0

'use strict';

var app = angular.module('application', []);

// Angular Controller
app.controller('appController', function($scope, appFactory){

	$("#success_holder").hide();
	$("#success_create").hide();
	$("#error_holder").hide();
	$("#error_query").hide();
	
	$scope.queryAllItems = function(){

		["vetter", "enterprise", "telephonenumber", "tnprovider"].forEach(function (itemType) {
			appFactory.queryAllItems(itemType, function(data){
				var array = [];
				for (var i = 0; i < data.length; i++){
					parseInt(data[i].Key);
					data[i].Record.Key = parseInt(data[i].Key);
					array.push(data[i].Record);
				}
				array.sort(function(a, b) {
					return parseFloat(a.Key) - parseFloat(b.Key);
				});
				$scope[itemType] = array;
			});
		});
	};

	$scope.recordEnterprise = function(){

		appFactory.recordEnterprise($scope.enterprise, function(data){
			$("#success_create").show();
		});
	};

});

// Angular Factory
app.factory('appFactory', function($http){
	
	var factory = {};

    factory.queryAllItems = function(itemType, callback){

    	$http.get(`/get_all_items/${itemType}`).success(function(output){
			callback(output)
		});
	}

	factory.recordEnterprise = function(data, callback){

		var enterprise = data.id + "-" + data['name'] + "-" + data['publicKey'];

    	$http.get('/add_enterprise/'+enterprise).success(function(output){
			callback(output)
		});
	}


	return factory;
});


