//use 'strict';

App.controller('MainCtrl', [
	'$scope', 'Users', function($scope, Users) {

		$scope.questions = [
			{ 'body': 'What kind of app do you want to build?',
				'choices': { 'iOS': 50000, 'Android': 30000, 'Mobile Web': 30000 } },
			{ 'body': 'Have you already started development?',
				'choices': { 'No': 0, 'Yes': -10000 } },
			{ 'body': 'What is your timeframe?',
				'choices': { '3 months': 10000, '4 months': 20000, '5 months': 30000 } },
			{ 'body': 'Which devices will support your app?',
				'choices': { 'Phone': 5000, 'Tablet': 5000, 'Both': 12000 } },
			{ 'body': 'Will your app work offline?',
				'choices': { 'No': 0, 'Yes': 5000 } },
			{ 'body': 'Will your app support credit card payment?',
				'choices': { 'Yes': 7000, 'No': 0 } },
			{ 'body': 'How will users sign on?',
				'choices': { 'No Login': 0, 'Username/Password': 7000, 'Social Network Profile': 10000, 'Active Directory': 7000 } },
			{ 'body': 'How many third party APIs will your app use?',
				'choices': { '1-3': 4000, '3+': 6000, 'None': 0 } }
		];

		$scope.user = {
			name: '',
			email: '',
			answers: []
		};

		// Variables determining shown content
		$scope.home = true;
		$scope.survey = false;
		$scope.infoSubmitted = false;
		$scope.showForm = false;
		$scope.finished  = false;
		$scope.emptyForm = false;

		$scope.begin = function() {
				$scope.home = false;
				$scope.survey = true;
				$scope.qCounter = 0;
				$scope.question = $scope.questions[$scope.qCounter].body;
				$scope.yourEstimate = 'Your quote is: $';
		};



		$scope.next = function() {
			if ($scope.qCounter < $scope.questions.length-1) {
				$scope.qCounter += 1;
				$scope.question = $scope.questions[$scope.qCounter].body;
			} else {
				$scope.finished = true;
				$scope.showForm = true;
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
			console.log("Answers: " + $scope.user.answers);
			Users.save($scope.user);
			$scope.evalEstimate($scope.user.answers);
			$scope.infoSubmitted = true;
			$scope.showForm = false;
		};

}]);
