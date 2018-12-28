<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" >
<link rel="stylesheet" href="css/style.css"/>

<!--  <link rel="stylesheet" href="/resources/demos/style.css">-->
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <style>

.fa-venus{
color: red;}
.fa-mars{
color: blue;}
</style>
   
<script>
$(document).ready(function(){
	 document.getElementById('myfeedbtn').className = 'nav-item active ';
  $( function() {
	//Date Picker[날짜 유효성]
    var dateFormat = "yy/mm/dd",
      from = $( "#from" ).datepicker({
          showButtonPanel : true,
          dateFormat : 'yy/mm/dd',
          minDate: 0})
          .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
        showButtonPanel : true,
        dateFormat : 'yy/mm/dd',})
        .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
      return date;
    }
    
    var g_Num = "${dto1.g_Num}"; //게시물 No
    var writerEmail="${dto1.m_Email}"//글쓴이 메일
    var userEmail="${m_Email}"//유저 메일
    var m_Gender =""; //글쓴이 성별
    var g_Gender = "${dto1.g_Gender}" //참여 글 제한 성별
    /*게시물 삭제 */
    $("#deletegowith").click(function(){
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
			    		url:"deleteGo.htm",
			    		dateType:"json",
			    		data:{"g_Num" : g_Num},
			    		success : function(data){
			    			if (data=="success"){
			    				location.href="gowith_list.htm"	
			    			}
			    		}
			    	});
				}
				else {
				    swal("취소", "", "error");
				  }
			});
	});
    
   
    /*지원신청 추가 */
    $("#application").click(function() {
    	var html="";
    	var html2="";
		if(writerEmail === userEmail){
			swal("이미 참여중입니다","","warning")
			return false;
		}
		else if(""== userEmail){
			swal("로그인 해주세요","","warning")
			return false;
		}
		else if($("#application").val()==='참여하기') {
			$.ajax({
				type:"post",
				url:"genderCheck.htm",
				data:{"m_Email":userEmail
				},
			success:function(data){
				m_Gender= data.m_Gender
				/* 체크 alert('유저성별'+m_Gender+' '+'성별제한'+g_Gender); */
				if(g_Gender!='all' && g_Gender != m_Gender){
					swal("성별 제한을 확인하십시오.","","warning");
					return false;
				}
				else{
					$.ajax({
						type:"post",
						url:"application.htm",
						dataType:"json",
						data:{"num":g_Num,
							  "m_Email":userEmail	
							},
						success:function(data){
							//체크 console.log(data); 모델 객체 안에 있음.
							var appList = data.appList //모델 객체에서 applist 배열을 꺼냄, list라 배열로 받음, 객체가 안니라.
							html='<h3 style="margin=0px;line-height: 14px;">같이갈 회원</h3><div id="acc"></div>'
							$("#accordion").append(html);
							$(appList).each(function(index, obj){ //applist 배열을 사용하니 index, obj
								console.log(index + ' '+obj.M_EMAIL);//object이니 key로 value 꺼내자!!
								html2 += '<p><img class="flag rounded-circle" src="image/member/'+obj.M_IMAGE+'">'
								html2 += '<span>&nbsp;&nbsp;'+obj.M_NICKNAME+'<span></p>'
							}); 
							$("#acc").append(html2);
							$( "#accordion" ).accordion({
								 active: false,//아코디언 처음에 닫기
								 collapsible: true
							    });
							}
						});
						$("#application").val('참여취소');
						swal("참여 되었습니다.","","success");
					}
				}
				});
			}
		//지원 버튼이 참여취소 버튼일때 
		else if($("#application").val()==='참여취소') {
			swal({
				  title: "참여 취소하시겠습니까?",
				  type: "warning",
				  showCancelButton: true,
				  confirmButtonClass: "btn-danger",
				  confirmButtonText: "확인",
				  cancelButtonText: "취소",
				  closeOnConfirm: true,
				  closeOnCancel: false
				}, 
				function(isConfirm) {
					if (isConfirm) {
						$.ajax({
							type:"post",
							url:"cancel.htm",
							dataType:"json",
							data:{"num":g_Num,
								  "m_Email":userEmail	
								 }
						});
						$("#application").val('참여하기');
						swal("취소 되었습니다.","","success");
						$("#accordion").empty();
						location.href="gowith_detail.htm?g_Num="+g_Num 
					}else {
					    swal("취소", "", "error");
					  }
				}
				);
		}
    });
    
    //리플 1차 등록
    $('#reply').click(function(){
		$.ajax( 
				{
					type:"post",
					url:"go_replyreg.htm",
					dataType:"json",
					data:{"j_Comment" : $('#content').val(),
						  "g_Num" : g_Num},
					success:function(data){
						console.log(data); 
						$('#reple').empty();
						$(data).each(function(index,obj){ 
							console.log(obj.reply)
							$(obj.reply).each(function(index,obj){
								console.log(obj.j_Order);
								$('#content').val("");
								var first_reple ="";
								first_reple = '<tr class="border-top border-bottom"><td class="regdate text-left">'
									if(obj.j_Parent != 0){first_reple +='ㄴ'}
								first_reple +='<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td>'
								first_reple+= '<td>'+obj.j_Comment+'</td><td class="regdate">'+obj.j_Regdate+'</td>'
								first_reple += '<td class="mabu1">'
									if(obj.j_Parent == 0){
										first_reple +='<button name="reply_reply" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>'
									}
									if(obj.m_Email===userEmail){
									first_reple += '<button name="reply_update" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button>'
									first_reple += '<button name="redel" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td></tr>';
									}
								$('#reple').append(first_reple)
							})
						})
					}
				}	
			);
 	})
 	
     /* 정의 : 리플의 '댓글' 버튼 누를시 작동
    	기능 : 리플의 '댓글' 아래 row 생성, input 필드, 수정, 삭제, 등록 버튼도 같이 생성 */
     $(document).on("click","button[name='reply_reply']",function(){
 		$('.rere').empty();//부모부모뒤에. 부모부모=첫째 댓글 tr
 		var secondReply ="";
 		secondReply ='<tr class="maau border-top border-bottom rere">'
 		secondReply +='<td></td><td><input class="form-control reple1" type="text" id="rere"></td>'
 		secondReply +='<td></td><td><button class="mabu btn btn-gradient-primary btn-sm" j_Num="'+$(this).attr("j_Num")+'" name="re_re">등록</button>'
 		secondReply +='<button class="mabu btn btn-gradient-primary btn-sm" name="cancel">취소</button></td></tr>'
 		$(this).parent().parent().after(secondReply);
 		$(this).parent().empty();
 	 })
 	
 	 /* 정의 : 대댓글 등록시 작동
    	기능 : 등록, 취소 버튼 생성. 클릭 대댓글 ajax로 추가 */
 	$(document).on("click","button[name='re_re']",function(){
 		console.log($(this).attr("j_Num"));
 		$.ajax({
 			type:"post",
 			url:"go_rerereg.htm",
 			dataType:"json",
 			data:{"j_Comment":$('#rere').val(),
 				  "j_Parent":$(this).attr("j_Num"),
 				  "g_Num":$('#g_Num').text()},
 				success:function(data){
 				console.log(data); 
				$('#reple').empty();
				$(data).each(function(index,obj){
					console.log(obj.reply)
					$(obj.reply).each(function(index,obj){
						console.log(obj.j_Comment);
						$('#content').val("");
						var second_reple ="";
						second_reple = '<tr class="border-top border-bottom"><td class="regdate text-left">'
							if(obj.j_Parent != 0){second_reple +='ㄴ'}
						second_reple +='<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td>'
						second_reple+= '<td>'+obj.j_Comment+'</td><td class="regdate">'+obj.j_Regdate+'</td>'
						second_reple += '<td class="mabu1">'
							if(obj.j_Parent == 0){
								second_reple +='<button name="reply_reply" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>'
							}
							if(obj.m_Email===userEmail){
							second_reple += '<button name="reply_update" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button>'
							second_reple += '<button name="redel" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td></tr>';
							}
						$('#reple').append(second_reple)
						})
					})
	 			}
 			})
 		})
 	/* 정의 : 첫번째 댓글 수정 버튼 클릭시 작동
	      기능 : row의 2번째 td 삭제후 td, input, 수정, 취소 버튼,삽입 후 삭제버튼 remove */
 	$(document).on("click","button[name='reply_update']",function(){
 		var first_repleUpdate =""		
 		$(this).parent().parent().children().first().next().remove();//2번째 td 선택하기
 		$(this).parent().parent().children().first().after('<td><input type="text" class="form-control reple1" id="reup"></td>');
 		first_repleUpdate ='<td><button j_Num="'+$(this).attr("j_Num")+'"name="reup" class="mabu btn btn-gradient-primary btn-sm">수정</button>'
 		first_repleUpdate +='<button name="cancel" class="mabu btn btn-gradient-primary btn-sm">취소</button></td>'
 		$(this).parent().parent().children().first().next().next().after(first_repleUpdate);
 		$(this).parent().parent().children().first().next().next().next().next().remove();
 	})
 	
 	/* 정의 : 대댓글 수정 버튼 클릭시 작동
  	     기능 : 대댓글 insert 이후 똑같이 뿌리기 */
 	$(document).on("click","button[name='reup']",function(){
 		$.ajax(
				{
					type:"post",
					url:"go_replyupdate.htm",
					dataType:"json",
					data:{"g_Num":$('#g_Num').text(),
						  "j_Num" : $(this).attr("j_Num"),
						  "j_Comment":$('#reup').val()},
					success:function(data){ 
						console.log(data); 
						$('#reple').empty();
						$(data).each(function(index,obj){ 
							console.log(obj.reply)
							$(obj.reply).each(function(index,obj){
								console.log(obj.j_Order);
								$('#content').val("");
								var second_reple ="";
								second_reple = '<tr class="border-top border-bottom"><td class="regdate text-left">'
									if(obj.j_Parent != 0){second_reple +='ㄴ'}
								second_reple +='<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td>'
								second_reple+= '<td>'+obj.j_Comment+'</td><td class="regdate">'+obj.j_Regdate+'</td>'
								second_reple += '<td class="mabu1">'
									if(obj.j_Parent == 0){
										second_reple +='<button name="reply_reply" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>'
									}
									if(obj.m_Email===userEmail){
									second_reple += '<button name="reply_update" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button>'
									second_reple += '<button name="redel" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td></tr>';
									}
								$('#reple').append(second_reple)
							})
							
						})
					}
				}	
			);
 	})
 	 /* 정의 : 댓글,대댓글 취소 버튼 클릭시 작동
    	기능 : #reple empty 시키고 리스트 뿌려줌 */
 	$(document).on("click","button[name='cancel']",function(){
 		$.ajax(
				{
					type:"post",
					url:"go_replylist.htm",
					dataType:"json",
					data:{"g_Num" : $('#g_Num').text()},
					success:function(data){ //{"result":""}
						console.log(data); 
						$('#reple').empty();
						$(data).each(function(index,obj){ 
							console.log(obj.reply)
							$(obj.reply).each(function(index,obj){
								console.log(obj.j_Order);
								$('#content').val("");
								var second_reple ="";
								second_reple = '<tr class="border-top border-bottom"><td class="regdate text-left">'
									if(obj.j_Parent != 0){second_reple +='ㄴ'}
								second_reple +='<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td>'
								second_reple+= '<td>'+obj.j_Comment+'</td><td class="regdate">'+obj.j_Regdate+'</td>'
								second_reple += '<td class="mabu1">'
									if(obj.j_Parent == 0){
										second_reple +='<button name="reply_reply" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>'
									}
									if(obj.m_Email===userEmail){
									second_reple += '<button name="reply_update" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button>'
									second_reple += '<button name="redel" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td></tr>';
									}
								$('#reple').append(second_reple)
							})
						})
					}
				}	
			);
 	})
 	/* 정의 : 댓글,대댓글 삭제 버튼 클릭시 작동
    	기능 : 댓글 삭제 처리 후 #reple empty 시키고 리스트 뿌려줌 */
 	$(document).on("click","button[name='redel']",function(){
 		var j_Num = $(this).attr('j_Num');
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
				  console.log($("button[name=redel]").attr('j_Num'));
					$.ajax(
							{
								type:"post",
								url:"go_replydelete.htm",
								dataType:"json",
								data:{"g_Num" : $('#g_Num').text(),
									  "j_Num" : j_Num},
								success:function(data){ //{"result":""}
									$('#reple').empty();
									$(data).each(function(index,obj){ 
										console.log(obj.reply)
										$(obj.reply).each(function(index,obj){
											console.log(obj.j_Order);
											$('#content').val("");
											var second_reple ="";
											second_reple = '<tr class="border-top border-bottom"><td class="regdate text-left">'
												if(obj.j_Parent != 0){second_reple +='ㄴ'}
											second_reple +='<img class="flag rounded-circle" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</td>'
											second_reple+= '<td>'+obj.j_Comment+'</td><td class="regdate">'+obj.j_Regdate+'</td>'
											second_reple += '<td class="mabu1">'
												if(obj.j_Parent == 0){
													second_reple +='<button name="reply_reply" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">댓글</button>'
												}
												if(obj.m_Email===userEmail){
												second_reple += '<button name="reply_update" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">수정</button>'
												second_reple += '<button name="redel" j_Num="'+obj.j_Num+'" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td></tr>';
												}
											$('#reple').append(second_reple)
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
  });
  
  function loadApp() {
	  	var html2=""
	  	var g_Num = "${dto1.g_Num}";
		var writerEmail="${dto1.m_Email}"
		var userEmail="${m_Email}"
	  $.ajax({
			type:"post",
			url:"appselect.htm",
			dataType:"json",
			data:{"num":g_Num
				},
			success:function(data){
				console.log(data); //모델 객체 안에 있음.
				var appList = data.appList //모델 객체에서 applist 배열을 꺼냄, list라 배열로 받음, 객체가 안니라.
				html='<button class="btn btn-link btn-sm" style="margin=0px;line-height: 14px;font-weight:bold">같이갈 회원</button><div id="acc"></div>'
				$("#accordion").append(html);
				 $(appList).each(function(index, obj){ //applist 배열을 사용하니 index, obj
					console.log(index + ' '+obj.M_EMAIL);//object이니 key로 value 꺼내자!!
					html2 += '<p><img class="flag rounded-circle" src="image/member/'+obj.M_IMAGE+'">'
					 html2 += '<span>&nbsp;&nbsp;'+obj.M_NICKNAME+'<span></p>'
				}); 
				$("#acc").append(html2); 
				$( "#accordion" ).accordion({
					 active: false,//아코디언 처음에 닫기
				      collapsible: true
				    });
			}
		});
	}
});
</script>
</head>
    <!-- <main role="main"> -->
     <div class="main-panel" >
	<div class="container-scroller">
      <div class="page-body-wrapper">
       
		<div class="content-wrapper2 ">  
	           <div class="page-header">
	           <div class="container text-center">
	           		<img class="profile" src="image/member/${dto1.m_Image}">
		          <h3 class="jumbo">${dto1.m_Nickname}   
			          <c:if test="${dto1.m_Gender eq 'man'}">
			           <i class="fas fa-mars fa-1x"></i>
			          </c:if>
			          <c:if test="${dto1.m_Gender eq 'woman'}">
			           <i class="fas fa-venus fa-2x"></i>
			          </c:if>
		          </h3>
		        <div><div class="figure lead text-muted text-small float-left">글번호 : <span id="g_Num">${dto1.g_Num}</span></div><div class="figure lead text-muted text-small float-right">작성일 : ${dto1.g_Regdate}, 조회수 : ${dto1.g_Hit}</div>
     			 </div>
		        
	           </div>   
	      	</div>
      <div class="album py-5 bg-light">
      <div class="container">
      <form action="" method="post" encType="multiplart/form-data" name="">
		<h1 class="text-center textbig" id="t_Title">${dto1.g_Title}</h1>
		<!--날짜 데이터 포맷 변경  -->
   		<fmt:parseDate value="${dto1.g_Sdate}" var="postdate" pattern="yyyy-MM-dd" />
        <fmt:parseDate value="${dto1.g_Edate}" var="postdate1" pattern="yyyy-MM-dd" />
		<fmt:formatDate value="${postdate}" var="daydate" pattern="yyyy.MM.dd" />
		<fmt:formatDate value="${postdate1}" var="daydate1" pattern="yyyy.MM.dd" />
		<fmt:parseNumber value="${postdate.time/(1000*60*60*24)}" var="numberdate" integerOnly="true" />
		<fmt:parseNumber value="${postdate1.time/(1000*60*60*24)}" var="numberdate1" integerOnly="true" />
		<fmt:formatNumber value="1" type="number" var="one"/>
			
    	<div class="img1 textmargin text-center">일정 : ${daydate} ~ ${daydate1}</div>
    	<div class="img1 textmargin text-center">${numberdate1-numberdate}박 ${numberdate1-numberdate+one}일</div>
	    	<c:if test="${!empty dto1.g_Local}">
	        <div class="img1 textmargin text-center">대표 여행지 : ${dto1.g_Local} ${dto1.g_Local1} </div>
	        </c:if>	
        <div class="img1 textmargin text-center">참여인원 : ${dto1.g_Speople}/${dto1.g_Epeople} </div>
        <div class="img1 textmargin text-center">참여가능 성별 :  
            <c:if test="${dto1.g_Gender eq 'man'}">
            	<i class="fas fa-mars fa-1x icon-blue"></i>
            </c:if>
            <c:if test="${dto1.g_Gender eq 'woman'}">
            	<i class="fas fa-venus fa-1x"></i>
            </c:if>
            <c:if test="${dto1.g_Gender eq 'all'}">
            	<i class="fas fa-venus-mars fa-1x "></i>
            </c:if>
            <br>
       </div>
       <div class="img1 textmargin text-center">
         <c:set var="flag" value ="true"/>
	      <!--m_Email이 로그인 한사람, app.M_Email 참가신청 한사람  -->
	      <!--for-each돌려서 if를 쓰고 조건이 맞으면 stop 시키고 싶다.
	      	상황:1.지원자 리스트의 email과 로그인 유저 email이 일치하면 -> 참여취소 & list 출력
	      		2-1지원자 리스트의 email과 로그인 유저 email이 불일치하면 -> 참여하기 출력
	      -->
	     <c:forEach items="${dto1.applist}" var="app">
		 	<c:if test="${flag eq true}">
		    	<c:if test="${app.M_EMAIL eq m_Email}"> 
		        	<input type="button"  value="참여취소" id="application"  class="pull-right btn btn-gradient-primary btn-sm"/>
		            <script>loadApp();</script>
		         	<c:set var="flag" value="false"/> 
	            </c:if>
		        <c:if test="${app.M_EMAIL ne m_Email}">
			        <c:if test="${dto1.g_Status eq 'Y'}">
			        	<input type="button"  value="참여하기" id="application" class="pull-right btn btn-gradient-primary btn-sm"/>
			        	<c:set var="flag" value="false"/> 
			        </c:if>
			        <c:if test="${dto1.g_Status ne 'Y'}">
				        <input type="button"  value="마감"  class="pull-right btn btn-gradient-primary btn-sm"/>
				        <!--  플레그값 세팅 -->
				        <c:set var="flag" value="false"/>
			        </c:if>
		         </c:if>
		       </c:if>
	          </c:forEach>
                 	<div id="accordion" class="d-inline-block position-absolute btn-sm" style="padding: 0px;">
                 	</div>
                 </div>
                	   <div id="test"> 
                	  	 	<c:forEach items="${dto1.gi_Images}" var="r">
                	  			 <img class="img img1" src="image/gowith/${r}">
                	   		</c:forEach>        
              			</div>
              			<div class="img1">${dto1.g_Content}</div>
           </form>
			           		<div class="text-center img1">
			            <div class="text-right">
				            <c:if test="${m_Email eq dto1.m_Email}">
						    <a href="gowith_update.htm?g_Num=${dto1.g_Num}">
						    	<button type="button" class="btn btn-gradient-primary btn-sm">수정</button>
						    </a>
					            <button type="button" id="deletegowith" class="btn btn-gradient-primary btn-sm">삭제</button>
				            </c:if>
			          </div>
			            </div>
			             <div class="text-center input-group">
			                 <input type="text" placeholder="내용을 입력하세요. " id="content" name="j_Comment" class="form-control align-middle" >
			                 <input type="button" id="reply" value="댓글달기" class="btn btn-gradient-primary btn-fw"/>
			            	</div>
						<table class="col-12 reple text-center" id="reple">
								<c:forEach items="${reply}" var="re">
										<tr class="border-top border-bottom">
											<td class="regdate text-left">
											<c:if test="${re.j_Parent != 0}">ㄴ</c:if><img class="flag rounded-circle" src="image/member/${re.m_Image}">${re.m_Nickname}</td><td class="rco">${re.j_Comment}</td><td class="regdate">${re.j_Regdate}</td><td class="mabu1">
											<c:if test="${re.j_Parent ==0}">
											<button name="reply_reply" j_Num="${re.j_Num}" class="mabu btn btn-gradient-primary btn-sm">댓글</button>
											</c:if>
											<c:if test="${m_Email eq re.m_Email}">
												<button name="reply_update" j_Num="${re.j_Num}" class="mabu btn btn-gradient-primary btn-sm">수정</button><button name="redel" j_Num="${re.j_Num}" class="mabu btn btn-gradient-primary btn-sm">삭제</button></td>
											</c:if>
									  	</tr>
								</c:forEach>
						</table>
			</div>
        </div>
  		 </div>     
       </div>
       </div>  
	</div>
<!--     </main> -->



<!--
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>-->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> -->


</html>