<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="fileUploadForm" action="fileUpload" method="post" enctype="multipart/form-data">
        <input type="file" id="fileUpload" name="fileUpload"/><br/><br/>
        <input type="file" id="fileUpload2" name="fileUpload2"/><br/><br/>
        <input type="button" value="버튼 한개 씩 전송" onClick="fileSubmit();">
    </form>
    
    <form id="MultiUpload" action="" method="post" enctype="multipart/form-data">
        <input multiple="multiple" type="file" id="file" name="file" /><br/><br/>
        <input type="button" value="버튼 한개만 전송" onClick="fileSubmit2();">
    </form>
 
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
    function fileSubmit() {
    	var form = $("#fileUploadForm")[0];
        var formData = new FormData(form);
        $.ajax({
            type : 'post',
            url : 'fileUpload.do',
            data : formData,
            processData : false,
            contentType : false,
            success : function(html) {
                alert("파일 업로드하였습니다.");
            },
            error : function(error) {
                alert("파일 업로드에 실패하였습니다.");
                console.log(error);
                console.log(error.status);
            }
        });
    }
    function fileSubmit2() {
    	var form = $("#MultiUpload")[0];
        var formData = new FormData(form);
        $.ajax({
            type : 'post',
            url : 'MultiUpload.do',
            data : formData,
            processData : false,
            contentType : false,
            success : function(html) {
                alert("파일 업로드하였습니다.");
            },
            error : function(error) {
                alert("파일 업로드에 실패하였습니다.");
                console.log(error);
                console.log(error.status);
            }
        });
    }
</script>

</body>
</html>