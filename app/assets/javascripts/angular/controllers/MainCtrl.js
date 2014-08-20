//use 'strict';

App.controller('MainCtrl', [
	'$scope', '$location', '$http', 'Users', function($scope, $location, $http, Users) {

		loadQuestions = function() {
			$http.get('./questions.json').success(function(data) {
				console.log("hello");
				console.log(data);
				$scope.questions = data;
			}).error(function() {
				console.log('failure');
			});
		};

		loadQuestions();

		$scope.questions = [
    		{ 'body': 'How many platforms (iOS, Android, Mobile Web)?',
				'choices': { '1': 100000, '2': 175000, '3': 225000 } },
			{ 'body': 'Will your app need photo library access?',
				'choices': { 'Yes': 5000, 'No': 0 } },
			{ 'body': 'Will your app need GPS access?',
				'choices': { 'Yes': 5000, 'No': 0 } },
			{ 'body': 'Will your app integrate a legacy system?',
				'choices': { 'Yes': 25000, 'No': 0 } },
			{ 'body': 'What level of security will your app have?',
				'choices': { 'None': 0, 'Bank-like': 25000 } },
			{ 'body': 'Will your app support credit card payment?',
				'choices': { 'Yes': 12000, 'No': 0 } },
			{ 'body': 'Will your app integrate SalesForce CRM?',
				'choices': { 'Yes': 25000, 'No': 0 } },
			{ 'body': 'Will your app function offline?',
				'choices': { 'Yes': 20000, 'No': 0 } },
			{ 'body': 'How many ways will users be able to sign in (Twitter, Facebook, LinkedIn, Google)?',
				'choices': { '1': 5000, '2': 10000, '3': 15000, '4': 20000, 'No sign in': 0 } },
			{ 'body': 'Will your app support an MVP or polished design?',
				'choices': { 'Polished': 50000, 'MVP': 25000 } }
		];

		$scope.user = {
			name: '',
			email: '',
			answers: [],
			newsletter: false,
			report: false,
			estimate: ''
		};

		// Variables determining shown content
		$scope.home = true;
		$scope.survey = false;
		$scope.infoSubmitted = false;
		$scope.showForm = false;
		$scope.finished  = false;
		$scope.emptyForm = false;
		$scope.showEstimate = false;
		$scope.showProgress = false;

		$scope.begin = function() {
				$scope.home = false;
				$scope.survey = true;
				$scope.qCounter = 0;
				$scope.question = $scope.questions[$scope.qCounter].body;
				$scope.yourEstimate = 'Your quote is: $';
				$scope.showProgress = true;
		};


		updateProgressBar = function() {
			var modwidth = 800 / $scope.questions.length;
			$('.progress-number').css('left', function() {
				return parseInt($(this).css('left')) + modwidth;
			});
			$('.progress-bar').css('width', function() {
				return parseInt($('.progress-number').css('left').replace(/px/, "")) + 20 + "px";
			});
		}

		$scope.next = function(choice) {
			var current_state = {"$scope.qCounter": $scope.qCounter}
			history.pushState(current_state, null, $location.href)
			$scope.user.answers[$scope.qCounter] = choice;
			//console.log($scope.user.answers);
			if ($scope.qCounter < $scope.questions.length-1) {
				if ($scope.qCounter > 1) {
					$scope.evalEstimate($scope.user.answers);
				}
				$scope.qCounter += 1;
				$scope.question = $scope.questions[$scope.qCounter].body;
				updateProgressBar();
			} else {
				$scope.qCounter += 1;
				$scope.finished = true;
				$scope.showForm = true;
				$scope.evalEstimate($scope.user.answers);
				$('.progress-bar').css('width', '800px');
				$('.progress-number').css('left', '780px');
			}
		};

		$scope.evalEstimate = function(answersArray) {
			var estimate = 0;
			for (var i=0; i<answersArray.length; i++) {
				estimate += $scope.questions[i].choices[answersArray[i]];
			}

			$scope.user.estimate = estimate.toString();
		};

		$scope.submitUser = function() {
			Users.save($scope.user);
			$scope.infoSubmitted = true;
			$scope.showForm = false;
		};

}]);
