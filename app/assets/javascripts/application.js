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

$(document).on('turbolinks:load',function(){

	// サイドバーを画面いっぱいに表示
	hsize = $(window).height();
	$("#sideber").css("height", hsize + "px");
	$(window).resize(function () {
		hsize = $(window).height();
		$("#sideber").css("height", hsize + "px");
	});

	// サイドバーのカテゴリーをアコーディオン表示
	$('.category-menu').click(function() {
		if($('.category-item').hasClass('open')) { 
			$('.category-item').removeClass('open');
			$('.category-item').slideUp();
			$(this).find('span').text('＋');
		}else{
			$('.category-item').addClass('open');
			$('.category-item').slideDown();
			$(this).find('span').text('−');
		}
	});
});