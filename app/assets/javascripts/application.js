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
          // console.log('button が押されたよ')
          var a_content_value = $("#content1").val();
          var b_content_value = $("#contact_category option:selected").val();
          var c_content_value = $("#content3:checked").val();
          var d_content_value = $("#content4").val();
          console.log(a_content_value, b_content_value, c_content_value, d_content_value)

          $("#modal_content1").text(a_content_value);
          if(b_content_value.to_i == 0){
            $("#modal_content2").text("スレッド・レスについて");
          } else if(b_content_value.to_i == 1) {
            $("#modal_content2").text("Hobby/等アプリについて");
          } else {
            $("#modal_content2").text("その他");
          }
          if(c_content_value == 1){
            $("#modal_content3").text("返信希望");
          } else {
            $("#modal_content3").text("返信不要");
          }
          $("#modal_content4").text(d_content_value);
        });
      });

      // $('#anchor_point').each(function() {
      //   //文字列を置換し変数に格納
      //   var anchor = $(this).text().replace(/\>\>\s*([0-9]{1,4}), '<a href="#$1">&gt;&gt;$1</a>');
      //   //上記で格納した文字列で上書き
      //   $(this).text(anchor);
      // });

      $(function(){
        // モーダルウィンドウが開くときの処理    
        $(".modalOpen").click(function(){
            var navClass = $(this).attr("class"),
                href = $(this).attr("href");
                $(href).fadeIn();
            $(this).addClass("open");
            return false;
        });
        // モーダルウィンドウが閉じるときの処理    
        $(".modalClose").click(function(){
            $(this).parents(".modal").fadeOut();
            $(".modalOpen").removeClass("open");
            return false;
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

//レスフォームの横に配置、一番上までジャンプするボタン
$('.to-top').click(function(){
  $('body,html').animate({scrollTop:0},700);
  return false;
  });

//スレタイ横に配置、一番下までジャンプ
