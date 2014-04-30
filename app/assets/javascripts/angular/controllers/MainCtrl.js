//'use strict';
App.controller('MainCtrl', [
	'$scope', function($scope, $http) {

		$scope.questions = [
			{ 'body': 'What kind of app do you want to build?',
				'choices': { 'iOS': 50000, 'Android': 30000, 'Mobile Web': 30000 } },
			{ 'body': 'Have you already started development?',
				'choices': { 'Yes': -10000, 'No': 0 } },
			{ 'body': 'What is your timeframe?',
				'choices': { '3 months': 10000, '4 months': 20000, '5 months': 30000 } },
		];

		$scope.qCounter = 0;
		$scope.question = $scope.questions[$scope.qCounter].body;
		$scope.answerVals = [];
		$scope.yourEstimate = 'Your quote is: $';

		$scope.user = {
			name: '',
			email: ''
		};

		// Variables determining shown content
		$scope.infoSubmitted = false;
		$scope.showForm = false;
		$scope.finished  = false;
		$scope.emptyForm = false;

		$scope.next = function() {
			if ($scope.qCounter < $scope.questions.length-1) {
				$scope.qCounter += 1;
				$scope.question = $scope.questions[$scope.qCounter].body;
			} else {
				$scope.finished = true;
				$scope.showForm = true;
				//$scope.evalEstimate($scope.answerVals);
			}
		};

		$scope.evalEstimate = function(valueArray) {
			var estimate = 30000;
			for (var i=0; i<valueArray.length; i++) {
				estimate += parseInt(valueArray[i]);
			}

			$scope.yourEstimate = $scope.yourEstimate + estimate.toString();
		};

		$scope.addUser = function() {
			$http.post('/addUser', $scope.user).success(function(res) {
				if (res === "Internal Error") {
					$scope.emptyForm = true;
				} else {
					console.log('success');
					$scope.showForm = false;
					$scope.infoSubmitted = true;
					$scope.evalEstimate($scope.answerVals);
				}
			}).error(function(err){
				console.log('failure');
				console.log(err);
			});

		};
	}]);
