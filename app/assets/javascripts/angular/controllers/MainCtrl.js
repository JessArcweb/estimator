//use 'strict';

App.controller('MainCtrl', [
	'$scope', '$location', '$http', 'Users', function($scope, $location, $http, Users) {

		loadQuestions = function() {
			$http.get('./questions.json').success(function(data) {
				//console.log("hello");
				//console.log(data);
				$scope.questions = data;
			}).error(function() {
				console.log('failure');
			});
		};

		loadQuestions();

		$scope.user = {
			name: '',
			email: '',
			answers: [],
			newsletter: false,
			report: false,
			estimate: '0'
		};

		// Variables determining shown content
		init = function() {
			$scope.home = true;
			$scope.survey = false;
			$scope.infoSubmitted = false;
			$scope.showForm = false;
			$scope.finished  = false;
			$scope.emptyForm = false;
			$scope.showEstimate = false;
			$scope.showProgress = false;
		};

		init();

		$scope.begin = function() {
				$scope.home = false;
				$scope.survey = true;
				$scope.qCounter = 0;
				$scope.question = $scope.questions[0];
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

		swapQuestion = function(q_id) {
			$http.get('/questions/next/' + q_id)
				.success(function(data) {
					console.log(data);
				});
		};

		$scope.next = function(choice, q_id) {
			$scope.user.answers.push(choice.option);
			swapQuestion(q_id);
		};

		$scope.next1 = function(choice) {
			//console.log(choice);
			var option = choice.option;
			var value = choice.value;
			//var current_state = {"$scope.qCounter": $scope.qCounter}
			//history.pushState(current_state, null, $location.href)
			$scope.user.answers[$scope.qCounter] = choice.option;
			//console.log($scope.user.answers);
			if ($scope.qCounter < $scope.questions.length-1) {
				$scope.evalEstimate(value);
				$scope.qCounter += 1;
				$scope.question = $scope.questions[$scope.qCounter].body;
				updateProgressBar();
			} else {
				$scope.qCounter += 1;
				$scope.finished = true;
				$scope.showForm = true;
				$scope.evalEstimate(value);
				$('.progress-bar').css('width', '800px');
				$('.progress-number').css('left', '780px');
			}
		};

		$scope.back = function() {
			$scope.qCounter += -1;
			if ($scope.qCounter < 0) {
				init();
			}
			$scope.user.answers.pop();
		};

		$scope.evalEstimate = function(value) {
			var estimate = parseInt($scope.user.estimate);
			console.log(estimate);
			estimate += value;

			$scope.user.estimate = estimate.toString();
		};

		$scope.submitUser = function() {
			Users.save($scope.user);
			$scope.infoSubmitted = true;
			$scope.showForm = false;
		};

}]);
