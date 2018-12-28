(function($) {
  'use strict';
  $(function() {
    $('.file-upload-browse').on('click', function() {
      var file = $(this).parent().parent().parent().find('.file-upload-default');
      file.trigger('click');
    });
    $('.file-upload-default').on('change', function() {
      $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i,''));
    });
    
    //리뷰페이지 업로드버튼
    $('.file-upload-browse1').on('click', function() {
        var file = $(this).parent().parent().parent().find('.file-upload-default1');
        file.trigger('click');
      });
      $('.file-upload-default1').on('change', function() {
      	var files = $('#files').get(0).files;
       if(files.length == 1){
      	$(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i,''));
       }else{
      	$('#ti_Image').val("");
        $('#ti_Image').val(" 파일 " +files.length+" 개 ");
        var filename = "";   
         $(files).each(function(index,file){
        	 filename +=  file.name + ",";
        	
        })
        $('#ti_Image').val(filename.substring(0, filename.lastIndexOf(",")));	
        $('#ti_Image').attr("title",filename.substring(0, filename.lastIndexOf(",")));
       }
       });
     
  });
})(jQuery);