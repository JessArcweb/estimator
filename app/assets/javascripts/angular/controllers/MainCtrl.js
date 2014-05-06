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
			{ 'body': 'Which devices will support your app?',
				'choices': { 'Both': 0, 'Phone': 0, 'Tablet': 0 } },
			{ 'body': 'Will your app work offline?',
				'choices': { 'Yes': 0, 'No': 0 } },
			{ 'body': 'Will your app support credit card payment?',
				'choices': { 'Yes': 0, 'No': 0 } },
			{ 'body': 'How will users sign on?',
				'choices': { 'Username/Password': 0, 'Social Network Profile': 0, 'Active Directory': 0 } },
			{ 'body': 'How many third party APIs will your app use?',
				'choices': { '1-3': 0, '3+': 0, 'None': 0 } }
		];

		$scope.answerVals = [];
		$scope.yourEstimate = 'Your quote is: $';

		$scope.begin = function() {
				$scope.home = false;
				$scope.survey = true;
				$scope.qCounter = 0;
				$scope.question = $scope.questions[$scope.qCounter].body;
		};

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

		$scope.evalEstimate = function(answersArray) {
			var estimate = 30000;
			for (var i=0; i<answersArray.length; i++) {
				estimate += $scope.questions[i].choices[answersArray[i]];
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
