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
//= require jquery3
//= require rails-ujs
//= require activestorage
//= require jquery-ui
//= require turbolinks
//= require_tree .

//= require popper
//= require bootstrap-sprockets

var DELAY_SPEED = 100;//文字が流れる速さ
var FADE_SPEED = 500;//表示のアニメーション時間
var str = [];
$(document).ready(function(){
    $('.fadein > span').each(function(i){//セレクタで指定した要素すべて
        $(this).css('opacity','1');//行を不透明にする
        str[i] = $(this).text();//元のテキストをコピーし
        $(this).text('');//テキストを消す
        var no = i;
        var self = this;
        var interval = setInterval(function(){//50ミリ秒毎にチェック
            if(no == 0 || $('.fadein > span').eq(no - 1).children('span:last').css('opacity') == 1){//最初の行または前の行が全文字表示された時
                clearInterval(interval);//チェックを停止
                for (var j = 0; j < str[no].length; j++) {
                    $(self).append('<span>'+str[no].substr(j, 1)+'</span>');//1文字ずつ<span>を付けて
                    $(self).children('span:last').delay(DELAY_SPEED * j).animate({opacity:'1'}, FADE_SPEED);//時間差でフェードインさせる
                }
            }
        }, 50);
    });

    $(function (){
        $("#modal_confirm").on("click", function(){
          var acontent_value = $("#content1").val();
          var bcontent_value = $("#content2").val();
          var ccontent_value = $("#content3").val();
          var dcontent_value = $("#content4").val();
          $("#modal_content1").text(acontent_value);
          $("#modal_content2").text(bcontent_value);
          if(ccontent_value == true){
            $("#modal_content3").text("trueの時の文章");
          } else {
            $("#modal_content3").text("falseの時の文章");
          }
          $("#modal_content4").text(dcontent_value);
        });
      });

});



//  // hide #back-top first
//  $("#back-top").hide();
//  // fade in #back-top
//      $(window).scroll(function () {
//          if ($(this).scrollTop() > 500) {
//              $('#back-top').fadeIn();
//          } else {
//              $('#back-top').stop(true, true).fadeOut();
//          }
//  });

//  // scroll body to 0px on click
//  $('#back-top a').click(function () {
//     $('body,html').animate({
//         scrollTop: 0
//     }, 500);
//     return false;
// });