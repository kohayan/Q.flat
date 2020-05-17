// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load',function() {

	// サイドバーを画面いっぱいに表示
	hsize = $(window).height();
	$("#sideber").css("height", hsize + "px");
	$(window).resize(function () {
		hsize = $(window).height();
		$("#sideber").css("height", hsize + "px");
	});

	// サイドバーのカテゴリーをアコーディオン表示
	$('.category-show').click(function() {
		if($('.category-item').hasClass('open')) {
			$('.category-item').removeClass('open');
			$('.category-item').slideUp();
			$(this).find('i').removeClass('fa-angle-up');
			$(this).find('i').addClass('fa-angle-down');
		}else{
			$('.category-item').addClass('open');
			$('.category-item').slideDown();
			$(this).find('i').removeClass('fa-angle-down');
			$(this).find('i').addClass('fa-angle-up');
		}
	});

	// ユーザー詳細画面のタブメニュー
	$('#tab-contents .tab[id != "tab1"]').hide();

	$('#tab-menu a').on('click', function() {
		$("#tab-contents .tab").hide();
		$("#tab-menu .active").removeClass("active");
		$(this).addClass("active");
		$($(this).attr("href")).show();
		return false;
	});

	// ユーザー編集画面の画像プレビュー
	$fileField = $('#file')

	$($fileField).on('change', $fileField, function(e) {
		file = e.target.files[0]
		reader = new FileReader(),
		$preview = $("#img_field");

		reader.onload = (function(file) {
			return function(e) {
				$preview.empty();
				$preview.append($('<img>').attr({
					src: e.target.result,
					width: "100%",
					class: "preview",
					title: file.name
				}));
			};
		})(file);
		reader.readAsDataURL(file);
	});

	// クイズフォームの表示、非表示
	$('#quiz-form-show').click(function() {
		$('.quiz-form-wrapper').fadeIn();
	});

	$('.close-quiz-form').click(function() {
		$('.quiz-form-wrapper').fadeOut();
	});

	// クイズの投稿ボタンの有効、無効の切り替え
	$('.quiz-send').prop("disabled", true);

	$('.quiz-form').on('input', function(){
		//文字数を取得
		var q_cnt = $('.question-area').val().length;
		var a_cnt = $('.answer-area').val().length;
		var e_cnt = $('.explanation-area').val().length;
		//現在の文字数を表示
		$('.question_now_cnt').text(q_cnt);
		$('.answer_now_cnt').text(a_cnt);
		$('.explanation_now_cnt').text(e_cnt);

		// 各項目の文字数によってnow_cntの色を変更
		if(q_cnt > 0 && 501 > q_cnt){
			$('.question_cnt_area').removeClass('cnt_danger');
		}else{
			$('.question_cnt_area').addClass('cnt_danger');
		}
		if(a_cnt > 0 && 201 > a_cnt){
			$('.answer_cnt_area').removeClass('cnt_danger');
		}else{
			$('.answer_cnt_area').addClass('cnt_danger');
		}
		if(501 > e_cnt){
			$('.explanation_cnt_area').removeClass('cnt_danger');
		}else{
			$('.explanation_cnt_area').addClass('cnt_danger');
		}

		// 投稿ボタンの有効、無効の切り替え
		if(!$('.question_cnt_area').hasClass('cnt_danger') && !$('.answer_cnt_area').hasClass('cnt_danger') && !$('.explanation_cnt_area').hasClass('cnt_danger')) {
			$('.quiz-send').prop("disabled", false);
		}else{
			$('.quiz-send').prop("disabled", true);
		}
	});

	// クイズ詳細画面の答え、解説をアコーディオン表示
	$('.answer-show').click(function() {
		if($('.answer').hasClass('open')) {
			$('.answer').removeClass('open');
			$('.answer').slideUp();
			$('.answer-show').text('答えを見る');
		}else{
			$('.answer').addClass('open');
			$('.answer').slideDown();
			$('.answer-show').text('答え');
		}
	});

	$('.explanation-show').click(function() {
		if($('.explanation').hasClass('open')) {
			$('.explanation').removeClass('open');
			$('.explanation').slideUp();
			$('.explanation-show').text('解説を見る');
		}else{
			$('.explanation').addClass('open');
			$('.explanation').slideDown();
			$('.explanation-show').text('解説');
		}
	});

	// クイズへのコメントフォームの表示、非表示
	// $(".comment-form-show").click(function () {
	$(document).on('click', '.comment-form-show', function () {
		$('.comment-form-wrapper').fadeIn();
	});
	// $(".close-comment-form").click(function () {
	$(document).on('click', '.close-comment-form', function () {
		$('.comment-form-wrapper').fadeOut();
	});


	// コメントの送信ボタンの有効、無効の切り替え
	$('.comment-send').prop("disabled", true);

	$('.comment-area').on('input', function(){
		//文字数を取得
		var cnt = $(this).val().length;
		//現在の文字数を表示
		$('.now_cnt').text(cnt);
		if(cnt > 0 && 141 > cnt){
			//1文字以上かつ140文字以内の場合はボタンを有効化＆黒字
			$('.comment-send').prop('disabled', false);
			$('.cnt_area').removeClass('cnt_danger');
		}else{
			//0文字または140文字を超える場合はボタンを無効化＆赤字
			$('.comment-send').prop('disabled', true);
			$('.cnt_area').addClass('cnt_danger');
		}
	});
});