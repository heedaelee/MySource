<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
<link rel="stylesheet" href="css/style.css" />
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

#gpeoplenumber{
height: calc(2.25rem + 2px); 
text-align: center;
}

.table th{
WORD-BREAK: keep-all;
}

</style>
<script>
	$(function() {
		var dateFormat = "yy-mm-dd", from = $("#from").datepicker({
			showButtonPanel : true,
			dateFormat : 'yy-mm-dd',
			minDate : 0
		}).on("change", function() {
			to.datepicker("option", "minDate", getDate(this));
		}), to = $("#to").datepicker({
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
		
		$('#filebutton').change(function(){
			var html=""
			$('.fileList').empty();
			$.each( event.target.files, function(index, file){
				console.log(URL.createObjectURL(event.target.files[index]));
				var url =URL.createObjectURL(event.target.files[index]);
	         	html += '<div class="col-md-3" style="display: inline-block; ">';
	            html += '<img class="card-img-top" style="width:220px; height:220px;" src="'+url+'">';
	            html += '<a href="#" id="removeImg">╳</a>';
	            html += '</div>';
	            $('.fileList').html(html);  
				});
	        });
	
			  
		$('#form1').submit(function(){			  
			var g_Num=${dto1.g_Num}
			  var g_speople = ${dto1.g_Speople}
			  var g_epeople = $('#g_Epeople').val();
			var g_epeople = $('#g_Epeople').val();
			
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
		  	    		
		  	}else if(isNaN(g_epeople)){
		  		swal("인원을 입력해주세요.","문자나 공백은 불가합니다","warning");
		  		return false;
		  		
		  	}else if(parseInt(g_speople) > parseInt(g_epeople)){
		  		alert(parseInt(g_epeople))
		  		swal("이미 참여한 인원이"+g_speople+"명 입니다","","warning");
		  		return false;
		  		
		  	}else if(parseInt(g_speople) == parseInt(g_epeople)){
		  		$('#g_Status').val('N');
		  	    		
		  	}else if(parseInt(g_speople) < parseInt(g_epeople)){
		  		$('#g_Status').val('Y');
		  	    		
		  	}else if($('#g_Content').val()===""){
		  		swal("내용을 입력해주세요.","","warning");
		  		return false;
		  	}else{
		  		var form = $('#form1')[0];
		  		
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
				<form action="gowith_update.htm" method="post" id="form1" encType="multipart/form-data">
					<table class="table table-bordered border-0">
						<tbody>
							<tr>
								<th>제목:</th>
								<td colspan="3"><input type="text"
									placeholder="제목을 입력하세요. " class="form-control" name="g_Title" id="g_Title" value="${dto1.g_Title}" /></td>
							</tr>
							<tr>
								<th>첨부파일:
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td class="text-left" colspan="3" >
								<button type="button" class="replace">파일 업로드</button>  <!-- button tag 추가 -->
								<input multiple="multiple" accept="image/*" type="file" name="file" id="filebutton" /> <!-- onchange="loadFile(event)"  --> 
							</tr>
							<tr>
								<th>세부계획:</th>
								<td><div class="cal" style="text-align: center">
										<label for="">일정</label><br> 
											<input
											class="write_start_date" type="text" placeholder="여행 가는날 선택"
											id="from" name="g_Sdate" value="${dto1.g_Sdate}">&nbsp; <span
											style="font-size: 1.5rem; color: dimgray"> <i
											class="fas fa-angle-right"></i>
										</span> &nbsp;<input class="write_end_date" type="text"
											placeholder="마치고 오는날 선택" id="to" name="g_Edate" value="${dto1.g_Edate}">
										<hr id="aa">
									</div></td>
								<td style="width: 200px; word-break: break-all">
									<div class="cal" style="text-align: center">

										<label for="">성별</label> 
										
										<select name="g_Gender" id="g_Gender" class="form-control">
											<option value="all" <c:if test="${dto1.g_Gender eq 'all'}">selected </c:if> >혼성</option>
											<option value="man"	<c:if test="${dto1.g_Gender eq 'man'}">selected </c:if> >남자끼리</option>
											<option value="woman" <c:if test="${dto1.g_Gender eq 'woman'}">selected </c:if>>여자끼리</option>
										</select>

										<hr id="aa">
									</div>
								</td>
								<td style="width: 200px; word-break: break-all"><div
										class="cal" style="text-align: center">
										<label for="">인원</label>
											<div class="input-group " id="gpeoplenumber">
													<div class="input-group-append">
														<span class="input-group-text">${dto1.g_Speople} /</span>
													</div>
													<input type="text" class="form-control" name="g_Epeople" id="g_Epeople" value="${dto1.g_Epeople}">
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
									<c:if test="${!empty dto1.gi_Images}">
										<c:forEach items="${dto1.gi_Images}" var="r">
		                	  			 <div class="col-md-3" style="display: inline-block">
							           		<img class="card-img-top" style="width:220px; height:220px;" src="image/gowith/${r}">
							             	<a href="#" id="removeImg">╳</a>
							            </div>
	                	   				</c:forEach>
									</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="3"><textarea cols="50" rows="5"
										placeholder="내용을 입력하세요. " name="g_Content" id="g_Content"
										class="form-control">${dto1.g_Content}</textarea></td>
							</tr>
							<tr>
								<td colspan="3" style="text-align: center">
								<input type="submit" value="등록" class="pull-right btn btn-gradient-primary" /> 
									<input type="reset" value="초기화" class="pull-left btn btn-gradient-primary" /> 
									<input type="button" value="목록으로 " class="pull-right btn btn-gradient-primary" onclick="javascript:location.href='gowith_list.htm'" /> 
									<input type="hidden" name="m_Email" value="<%=session.getAttribute("m_Email")%>">
									 <input type="hidden" name="g_Num" value="${dto1.g_Num}">
									<input type="hidden" name="g_Hit" value=1> --%>
									<input type="hidden" id="g_Status"  name="g_Status" value="${dto1.g_Status}">
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