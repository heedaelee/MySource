<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css" />
<!--  <link rel="stylesheet" href="/resources/demos/style.css">-->
<!--1.12.1를 게시판 땜에 3.2.1로 변환  -->
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!--  포함 summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>


<style type="text/css">

button.replace {    /*button tag 에 원하는 스타일 적용*/
  position: absolute;
  width: 200;
  height: 19px;
  border-radius: 3px;
  font-weight: 20;
  border-color: transparent;
  font-size: 8px;
  background: hotpink;
  color: #fff;
  cursor: pointer;
}

#filebutton {  
  opacity: 0;       /*input type="file" tag 투명하게 처리*/
  position: relative;
}

.table th img, .table td img{
border-radius:0%; }

.card-img-top{
height: 220px; 
width: 220px; 
display: inline;}


</style>
<script>
	$(function() {
		var dateFormat = "yy-mm-dd", 
		from = $("#from").datepicker({
			showButtonPanel : true,
			dateFormat : 'yy-mm-dd',
			minDate : 0
		}).on("change", function() {
			to.datepicker("option", "minDate", getDate(this));
		}), 
		to = $("#to").datepicker({
			showButtonPanel : true,
			dateFormat : 'yy-mm-dd',

		}).on("change", function() {
			from.datepicker("option", "maxDate", getDate(this));
		});

		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
			} catch (error) {
				date = null;
			}

			return date;
		}
		
		//이미지 정보들을 담을 배열
		var sel_files = [];
		$('#filebutton').change(function(){
			var html=""
			
			
			//이미지 정보 초기화
			sel_files=[];
           	
			
			$.each( event.target.files, function(index, files){
				
				
				console.log(URL.createObjectURL(files));
				var url =URL.createObjectURL(files);
	            console.log(files);
	            console.log(index)
	         	html += '<div class="col-md-3" style="display: inline-block; ">'
	            html += '<a href="javascript:void(0);" onclick="deleteImageAction('+index+') id="img_id_'+index+'">'
	            html +=	'<img class="card-img-top" style="width:220px; height:220px;" src="'+url+'" title="click to remove"></a>'
	            html += '</div>';
				
	            
	        	var fileArr = Array.prototype.slice.call(files)
	            sel_files.push(files);
	           	
	            
	            $('.fileList').html(html);  
				});
	        });
		//회원가입 유효성
		  $('#go_submit').submit(function(){
		  	if($('#g_Title').val() === ""){
		  		swal("제목을 입력해주세요.","","warning");
		  		$('#g_Title').focus();
		  		return false;
		  	}
		  	else if($('#from').val() === "" || $('#to').val() === "" ){
		  		swal("일정을 입력해주세요.","","warning");
		  		return false;
		  	    		
		  	}else if($('#g_Gender').val() === ""){
		  		swal("성별을 해주세요.","","warning");
		  		return false;
		  	    		
		  	}else if(isNaN($('#g_Epeople').val())){
		  		swal("인원을 입력해주세요.","","warning");
		  		$('#g_Epeople').focus();
		  		return false;
		  	    		
		  	}else if($('#g_Content').val()===""){
		  		swal("내용을 입력해주세요.","","warning");
		  		$('#g_Content').focus();
		  		return false;
		  	}else{
		  		var form = $('#form')[0];
		  		console.log(form);
		  		var formData = new FormData(form);
		  		console.log(formData);
		  		
		  		return true;
				}
		  	});
		});
</script>





	<div class="container-scroller">


		<div class="container-fluid page-body-wrapper">
			<div class="container d-block text-center">
				<div class="row col-11">
					<div class="container">
						<h1 class="jumbotron-heading text-center">함께가기 작성</h1>
						<p class="lead text-muted text-center">우리 함께 갑시다</p>
					</div>
				</div>
			<div class="row d-block">
				<form action="gowith_upload.htm" method="post" id="go_submit" encType="multipart/form-data">
					<table class="table table-bordered border-0">
						<tbody>
							<tr>
								<th>제목:</th>
								<td colspan="3"><input type="text"
									placeholder="제목을 입력하세요. " class="form-control" name="g_Title" id="g_Title" /></td>
							</tr>
							<tr>
								<th>첨부파일:
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td class="text-left" colspan="3" >
								<button type="button" class="replace">파일 업로드</button>  <!-- button tag 추가 -->
								<input multiple="multiple" accept="image/*" type="file" name="file" id="filebutton" /> 
							</tr>
							<tr>
								<th>세부계획:</th>
								<td><div class="cal" style="text-align: center">
										<label for="">일정</label><br> 
											<input
											class="write_start_date" type="text" placeholder="여행 가는날 선택"
											id="from" name="g_Sdate">&nbsp; <span
											style="font-size: 1.5rem; color: dimgray"> <i
											class="fas fa-angle-right"></i>
										</span> &nbsp;<input class="write_end_date" type="text"
											placeholder="마치고 오는날 선택" id="to" name="g_Edate">
										<hr id="aa">
									</div></td>
								<td style="width: 200px; word-break: break-all">
									<div class="cal" style="text-align: center">

										<label for="">성별</label> <select name="g_Gender" id="g_Gender"
											class="form-control">
											<option value="" selected disabled hidden>선택하세요</option>
											<option value="all">혼성</option>
											<option value="man">남자끼리</option>
											<option value="woman">여자끼리</option>
										</select>

										<hr id="aa">
									</div>
								</td>
								<td style="width: 200px; word-break: break-all"><div
										class="cal" style="text-align: center">
										<label for="">인원</label>
										<div class="input-group "
											style="height: calc(2.25rem + 2px); text-align: center;">
											<input type="text" class="form-control" name="g_Epeople" id="g_Epeople">
											<div class="input-group-append">
												<span class="input-group-text">명</span>
											</div>
										</div>
										<hr id="aa">
									</div></td>
							</tr>
							<tr>
								<th rowspan="2">내용:</th>
								<td colspan="3" style="text-align: center" class="fileList">
									<div class="col-md-3" style="display: inline-block">
								</td>
							</tr>
							<tr>
								<td colspan="3"><textarea cols="50" rows="5"
										placeholder="내용을 입력하세요. " name="g_Content" id="g_Content"
										class="form-control"></textarea></td>
							</tr>
							<tr>
								<td colspan="4" style="text-align: center">
								<input type="submit" value="등록" class="pull-right btn btn-gradient-primary" /> 
									<input type="button" value="초기화" class="pull-left btn btn-gradient-primary" /> 
									<input type="button" value="목록으로 " class="pull-right btn btn-gradient-primary" onclick="javascript:location.href='list.jsp'" /> 
									<input type="hidden" name="m_Email" value="<%=session.getAttribute("m_Email")%>"> 
									<input type="hidden" name="g_Speople" value=0>
									<input type="hidden" name="g_Hit" value=1>
									<input type="hidden" name="g_Status" value='Y'>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			</div>
		</div>

	</div>
	<!--     </main> -->


<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>


</html>