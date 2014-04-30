//use 'strict';

App.controller('MainCtrl', [
	'$scope', 'Users', function($scope, Users) {

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

		$scope.submitUser = function() {
			Users.save($scope.user);
			$scope.evalEstimate($scope.answerVals);
			$scope.infoSubmitted = true;
			$scope.showForm = false;
		};

}]);
