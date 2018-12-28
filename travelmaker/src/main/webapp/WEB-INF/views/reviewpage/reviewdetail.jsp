<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAoEy_g_fM4DTjGlPnSKmn0SdQqF7mpfRc"></script>
<script type="text/javascript">
 $(document).ready(function(){
	$('#deletereview').click(function(){
		swal({
			  title: "정말로 삭제하시겠습니까?",
			  text: "",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  confirmButtonText: "삭제",
			  confirmButtonColor : "#d33",
			  cancelButtonText: "취소",
			}).then((result) => { 
			
			  if (result.value) {
					$.ajax(
							{
								type:"post",
								url:"deletereview.htm",
								dataType:"json",
								data:{"t_Num" : $('#t_Num').text()},
								success:function(data){ //{"result":""}
									
								}
							}	
						);
					location.href="reviewlist.htm?delete"
			  } else {
			    swal("취소", "", "error");
			  }
			});
	});
		
	
	
	$('#reply').click(function(){
		$.ajax(
				{
					type:"post",
					url:"replyreg.htm",
					dataType:"json",
					data:{"r_Comment" : $('#content').val(),
						  "t_Num" : $('#t_Num').text()},
					success:function(data){ //{"result":""}
						console.log(data); 
						$('#reple').empty();
						$(data).each(function(index,obj){ 
							console.log(obj.reply)
							$(obj.reply).each(function(index,obj){
								console.log(obj.r_Order);
								$('#content').val("");
								if(obj.r_Parent != 0){
									if(obj.m_Email == $('#writeman').val()){
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_update" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');
									}
									else{
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1">');
																		
									}
								}else{
									if(obj.m_Email == $('#writeman').val()){
									$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button><button name="reply_update" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');
									}else{
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>');
											
									}
								}
							})
							
						})
					}
				}	
			);
 	})
 	 $(document).on("click","button[name='reply_reply']",function(){
 			console.log($(this).attr("r_Num"));
 			console.log($(this).attr("r_Order"));
 			$('.rere').empty();
 			$(this).parent().parent().after('<tr class="maau border-top border-bottom rere"><td></td><td><input class="form-control reple1" type="text" id="rere"></td><td></td><td><button class="mabu btn btn-gradient-primary btn-sm" r_Num="'+$(this).attr("r_Num")+'" name="re_re">등록</button><button class="mabu btn btn-gradient-primary btn-sm" name="cancel">취소</button></td></tr>');
 			$(this).parent().empty();
 	 })
 	$(document).on("click","button[name='re_re']",function(){
 		console.log($(this).attr("r_Num"));
 		$.ajax({
 			type:"post",
 			url:"rerereg.htm",
 			dataType:"json",
 			data:{"r_Comment":$('#rere').val(),
 				  "r_Parent":$(this).attr("r_Num"),
 				  "t_Num":$('#t_Num').text()},
 			success:function(data){
 				console.log(data); 
				$('#reple').empty();
				$(data).each(function(index,obj){
					console.log(obj.reply)
					$(obj.reply).each(function(index,obj){
						console.log(obj.r_Comment);
						
						$('#content').val("");
						if(obj.r_Parent != 0){
							if(obj.m_Email == $('#writeman').val()){
						$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_update" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');
							}else{
								$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1">');
										
							}
						}else{
							if(obj.m_Email == $('#writeman').val()){
						$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button><button r_Num="'+obj.r_Num+'" name="reply_update" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');
					
							}else{
								$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>');
								
						}
						}
					})
					
				})
 			}
 		})
 	}) 
 	$(document).on("click","button[name='reply_update']",function(){
//  		$(this).parent().parent().children()[1].empty();
			console.log($(this).attr("r_Num"));
 		$(this).parent().parent().children().first().next().remove();
 		$(this).parent().parent().children().first().after('<td><input type="text" class="form-control reple1" id="reup"></td>');
 		$(this).parent().parent().children().first().next().next().after('<td><button r_Num="'+$(this).attr("r_Num")+'" name="reup" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="cancel" class="mabu btn btn-gradient-primary btn-sm">취소</button></td>');
 		$(this).parent().parent().children().first().next().next().next().next().remove();
//  		$(this).parent().parent().children().first().after('<input type="text" class="form-control reple1" id="reup">');
		
 		//  		$(this).parent().parent().children()[1].after('<input type="text" class="form-control reple1" id="reup">');
//  		$(this).parent().parent().children()[1].append('<input type="text" class="form-control reple1" id="reup">');
 		
 		
 		
 	})
 	
 	$(document).on("click","button[name='reup']",function(){
 		console.log($(this).attr("r_Num"));
 		$.ajax(
				{
					type:"post",
					url:"replyupdate.htm",
					dataType:"json",
					data:{"t_Num":$('#t_Num').text(),
						  "r_Num" : $(this).attr("r_Num"),
						  "r_Comment":$('#reup').val()},
					success:function(data){ //{"result":""}
						console.log(data); 
						$('#reple').empty();
						$(data).each(function(index,obj){ 
							console.log(obj.reply)
							$(obj.reply).each(function(index,obj){
								console.log(obj.r_Order);
								$('#content').val("");
								if(obj.r_Parent != 0){
									if(obj.m_Email == $('#writeman').val()){
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_update" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');				
									}else{
									$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1">');
									}
									}else{
									if(obj.m_Email == $('#writeman').val()){
									$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button><button r_Num="'+obj.r_Num+'" name="reply_update" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');
									}
									else{
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>');
										
									}
								}
							})
							
						})
					}
				}	
			);
 	})
 	$(document).on("click","button[name='cancel']",function(){
 		$.ajax(
				{
					type:"post",
					url:"replylist.htm",
					dataType:"json",
					data:{"t_Num" : $('#t_Num').text()},
					success:function(data){ //{"result":""}
						console.log(data); 
						$('#reple').empty();
						$(data).each(function(index,obj){ 
							console.log(obj.reply)
							$(obj.reply).each(function(index,obj){
								console.log(obj.r_Order);
								$('#content').val("");
								if(obj.r_Parent != 0){
									if(obj.m_Email == $('#writeman').val()){
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_update" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');			
									}else{
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1">');
									}
									}else{
										if(obj.m_Email == $('#writeman').val()){
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button><button r_Num="'+obj.r_Num+'" name="reply_update" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');
									}else{
										$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>');	
									}
								}
							})
							
						})
					}
				}	
			);
 	})
 	
 	$(document).on("click","button[name='redel']",function(){
 		var r_num = $(this).attr('r_Num');
 		swal({
			  title: "정말로 삭제하시겠습니까?",
			  text: "",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonClass: "btn-danger",
			  confirmButtonText: "삭제",
			  cancelButtonText: "취소",
			  closeOnConfirm: true,
			  closeOnCancel: false
			}, 
			function(isConfirm) {
			  if (isConfirm) {
				  console.log($("button[name=redel]").attr('r_Num'));
					$.ajax(
							{
								type:"post",
								url:"replydelete.htm",
								dataType:"json",
								data:{"t_Num" : $('#t_Num').text(),
									  "r_Num" : r_num},
								success:function(data){ //{"result":""}
									$('#reple').empty();
									$(data).each(function(index,obj){ 
										console.log(obj.reply)
										$(obj.reply).each(function(index,obj){
											console.log(obj.r_Order);
											$('#content').val("");
											if(obj.r_Parent != 0){
												if(obj.m_Email == $('#writeman').val()){
											$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_update" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');
												}else{
													$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left">ㄴ<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1">');			
												}
											}else{
												if(obj.m_Email == $('#writeman').val()){
												$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button><button r_Num="'+obj.r_Num+'" name="reply_update" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>');
												}else{
													$('#reple').append('<tr class="border-top border-bottom"><td class="regdate text-left"><img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td><td>'+obj.r_Comment+'</td><td class="regdate">'+obj.r_Regdate+'</td><td class="mabu1"><button name="reply_reply" r_Num="'+obj.r_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>');
													
												}					
											}
										})
										
									})
								}
							}	
						);
			  } else {
			    swal("취소", "", "error");
			  }
			});

			
 	})
 	$(document).on("click","button[name='like']",function(){
 		
 		$(this).fadeOut();
		$(this).fadeIn();
// 		console.log($(this).attr('class'));
 		if($(this).attr('class')=='bg-transparent border-0 hearticon mdi mdi-heart'){
 			$(this).attr('class','bg-transparent border-0 hearticon mdi mdi-heart-outline');
//  			$(this).fadeIn();
			
 			$.ajax(
 					{
 						type:"post",
 						url:"unlike.htm",
 						dataType:"json",
 						data:{"t_Num" : $('#t_Num').text()},
 						success:function(data){ //{"result":""}
 								$('#likecount').text(data.likecount);
 							
 							}
 					}	
 				);
 		}
 		else
 		{
		
 			$(this).attr('class','bg-transparent border-0 hearticon mdi mdi-heart');
 			$.ajax(
 					{
 						type:"post",
 						url:"like.htm",
 						dataType:"json",
 						data:{"t_Num" : $('#t_Num').text()},
 						success:function(data){ //{"result":""}
 							$('#likecount').text(data.likecount);
 						}
 					}	
 				);
 			
 		}
 			
 		
 	})
 	
 
	
 });

</script>
   <!--<script> 데이터 피커
    $(function() {
      $("#datepicker").datepicker({
        showButtonPanel : true,
        dateFormat : 'yy/mm/dd',
          minDate: 0
      });
    });
  </script>
     <script>
  $( function() {
    $( "#datepicker1" ).datepicker({
        showButtonPanel : true,
        dateFormat : 'yy/mm/dd',
          minDate: 0
      });
    });
  </script>-->
 <script>

//googleMap    
google.maps.event.addDomListener(window, 'load', initialize);

	function initialize() {
	  var mapProp = {
			    center:new google.maps.LatLng($('#lati').val(), $('#long').val()),
			    zoom:11,
			    mapTypeId:google.maps.MapTypeId.Terrain
			  };
	var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
	
	var marker = new google.maps.Marker({ //마커 설정
      map : map,
      position : map.getCenter(), //마커 위치
      
  });

  google.maps.event.addDomListener(window, "resize", function() { //리사이즈에 따른 마커 위치
      var center = map.getCenter();
      google.maps.event.trigger(map, "resize");
      map.setCenter(center); 
  });
	
	}

	
</script>
  <!--data picker 시작일 종료일 유효성 포함-->
 
<!-- <main role="main"> -->

<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
   
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">

      <!-- partial -->
      <div class="main-panel col-md-12" >
<div class="content-wrapper2">
<input type="hidden" id="writeman" value="${sessionScope.m_Email}">
    	 <div class="page-header">
    	<div class="container text-center">
    	  <img class="profile" src="image/member/${list.m_Image}">
          <h3 class="jumbo">${list.m_Nickname}</h3>
          <div><div class="figure lead text-muted text-small float-left">글번호 : <span id="t_Num">${list.t_Num}</span></div><div class="figure lead text-muted text-small float-right">작성일 : ${list.t_Regdate}, 조회수 : ${list.t_Hit}, 좋아요 : <span id="likecount">${likecount}</span></div>
      </div>
        </div>
        </div>
	<div class="album py-5 bg-light">
    	<div class="container">
    		<form method="post" encType="multiplart/form-data">
    			<h1 class="text-center textbig" id="t_Title">${list.t_Title}</h1>
    			<div class="img1 textmargin text-center">여행 국가 : ${list.t_Country}<img class="flag" src="image/flag/${list.t_Country}.svg"></div>
    			<div class="img1 textmargin text-center">
    			지 역 : ${list.t_Local}</div>
    			<div class="text-center">
    				<div id="googleMap"></div>
    				<input type="hidden" id="lati" value="${list.t_Latitude}">
    				<input type="hidden" id="long" value="${list.t_Longitude}">
    			</div> 		 
                	   <div id="test"> 
                	  	 	<c:forEach items="${image}" var="r">
                	  			 <img class="img img1" src="image/review/${r.ti_Image}">
                	   		</c:forEach>        
              			</div>
              			<div class="img1"> ${list.t_Content}</div>
            </form>
            <div class="text-center img1">
            <div>
       		
<!--             <i class="hearticon mdi mdi-heart"></i> -->
			<c:if test="${like == 1}">
           	    <button name="like" id="like" class="bg-transparent border-0 hearticon mdi mdi-heart"></button>
            </c:if>
            <c:if test="${like == 0}">
            	<button name="like" id="like" class="bg-transparent border-0 hearticon mdi mdi-heart-outline"></button>
            </c:if>
            </div>
            <se:authorize access="isAuthenticated()">
            <div class="text-right">
           
            	<c:choose>
						<c:when test="${list.m_Email ==sessionScope.m_Email}">
            	<a href="reviewUpdate.htm?t_Num=${list.t_Num}"><button type="button" class="btn btn-gradient-primary btn-sm">수정</button></a>
           		 <button type="button" id="deletereview" class="btn btn-gradient-primary btn-sm">삭제</button>
            </c:when>
            </c:choose>
          </div>
            </div>
             <div class="text-center input-group">
                 <input type="text" placeholder="내용을 입력하세요. " id="content" name="r_Comment" class="form-control align-middle" >
                 <input type="button" id="reply" value="댓글달기" class="btn btn-gradient-primary btn-fw"/>
            	</div>
			<table class="col-12 reple text-center" id="reple">
					<c:forEach items="${reply}" var="re">
							<tr class="border-top border-bottom">
								<td class="regdate text-left">
								<c:if test="${re.r_Parent != 0}">
									ㄴ
								</c:if>
								<img class="flag rounded-circle" src="image/member/${re.m_Image}">${re.m_Nickname}</td><td class="rco">${re.r_Comment}</td><td class="regdate">${re.r_Regdate}</td><td class="mabu1">
								<c:if test="${re.r_Parent ==0}">
								<button name="reply_reply" r_Num="${re.r_Num}" class="mabu btn btn-gradient-primary btn-sm">댓글</button>
								</c:if>
								<c:choose>
								<c:when test="${re.m_Email ==sessionScope.m_Email}">
								<button name="reply_update" r_Num="${re.r_Num}" class="mabu btn btn-gradient-primary btn-sm">수정</button>
								<button name="redel" r_Num="${re.r_Num}" class="mabu btn btn-gradient-primary btn-sm">삭제</button>
								</c:when>
						  		</c:choose>
								</td>
						  	</tr>
					</c:forEach>
				 
			</table>
			</se:authorize>
			</div>
			
			
        </div>
          
</div>
</div>
</div>
</div>

<!--     </main> -->

