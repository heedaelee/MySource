<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
	
<link rel="stylesheet" href="css/style.css"/>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
		<link rel="stylesheet" href="vendors/iconfonts/mdi/css/materialdesignicons.min.css"/>
  		<link rel="stylesheet" href="vendors/css/vendor.bundle.base.css"/>
  		<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	  <script src="vendors/js/vendor.bundle.base.js"></script> 
 <script src="vendors/js/vendor.bundle.addons.js"></script>
 
  <style>
#atag:link {
	text-decoration: none;
	color: #646464;
}
</style>

<!-- 채팅 -->

<script type="text/javascript">
var m_Nickname;
	function popupOpen(roomno,roomname) {
		m_Nickname=roomname;
		console.log(m_Nickname);
		console.log(roomno);
		
		var popUrl = "chat.htm?select="+roomno+"&roomname="+m_Nickname+""; //팝업창에 출력될 페이지 URL
		var popOption = "width=370, height=700, resizable=no, scrollbars=no, status=no;"; //팝업창 옵션(optoin)
		var html="";
		html ="<div class='dropdown-divider'></div>";
	 	html += "<a class='dropdown-item preview-item'>";
	 	html += "<div class='preview-thumbnail' id='friendimage'>";
	    html += "<img src='image/member/"+image+"' alt='image' class='profile-pic'>";
 	    html += "</div>"
   		html += "<div class='preview-item-content d-flex align-items-start flex-column justify-content-center'>";
		html += "<h6 class='dialog preview-subject ellipsis mb-1 font-weight-normal'>친구가 대화를 보냈습니다.<button type='button' onClick='javascript:popupOpen(1,"+'"'+nickname+'"'+")' name='fchat' class='mabu btn btn-gradient-primary btn-sm' m_Email='"+email+"'>대화입장</button></h6>"; 	                   
   		html += "</div></a>"
	    $("#friendl").append(html);
// 		$("#"+roomno+"").empty(); //채팅방 입장시 해당 방 옆에 떠있던 push이미지를 없애주는 코드
		
		//팝업창 띄우기 (주소, 팝업창 이름, 팝업 설정 옵션)
		window.open(popUrl, "", popOption);
	}
	
	var wsocket;
	//nickname은 login.htm으로 실행된 MainController로그인 처리 함수에서 dto.getUserId값을 nickname에 담아준것 
	var nickname="${dto.m_Nickname}";
	var image="${dto.m_Image}";
	var email="${dto.m_Email}";
	console.log(nickname);
	//웹소켓에 연결되는 부분
	function connect() {
		//웹소켓 생성 
		wsocket = new WebSocket("ws://"+document.domain+":8090/travelmaker/logon.htm");
								/* "ws://192.168.0.137:8090/bit/login"); */
		wsocket.onmessage = onMessage;
	}
	
	function onMessage(evt) {
		console.log(evt);
		var data = evt.data;
		console.log("data" + data);
		appendMessage(data);
	}
	
	function appendMessage(msg) {
		console.log(nickname);
		$("#"+msg+"").empty();
		$("#"+msg+"").prop('className', 'count-symbol bg-danger');
		$("#friendl").empty();
		
		var html="";
		html ="<div class='dropdown-divider'></div>";
	 	html += "<a class='dropdown-item preview-item'>";
	 	html += "<div class='preview-thumbnail' id='friendimage'>";
	    html += "<img src='image/member/"+image+"' alt='image' class='profile-pic'>";
 	    html += "</div>"
   		html += "<div class='preview-item-content d-flex align-items-start flex-column justify-content-center'>";
		html += "<h6 class='dialog preview-subject ellipsis mb-1 font-weight-normal'>친구가 대화를 보냈습니다.<button type='button' onClick='javascript:popupOpen(1,"+'"'+nickname+'"'+")' name='fchat' class='mabu btn btn-gradient-primary btn-sm' m_Email='"+email+"'>대화입장</button></h6>"; 	                   
   		html += "</div></a>"
	    $("#friendl").append(html);
		}
		
	$(document).ready(function() {
		connect();
	});
	
	
</script>
  <script type="text/javascript">
  
  
$(document).ready(function(){
	
	/*친구신청 걸은사람*/
	$.ajax({
        type : 'post',
        url : 'joinus/friendlist.htm',
        success : function(data) {
				if(data.friendlist =="fail"){
				}else{
					$.each(data.friendlist,function(index,obj){
       					if(obj.f_Status==1){
       					 	
       						var html="";
       						html ="<div class='dropdown-divider'></div>";
       					 	html += "<a class='dropdown-item preview-item'>";
       					 	html += "<div class='preview-thumbnail' id='friendimage'>";
       					    html += "<img src='image/member/"+obj.m_Image+"' alt='image' class='profile-pic'>";
       	              	    html += "</div>"
       	                	html += "<div class='preview-item-content d-flex align-items-start flex-column justify-content-center'>";
      						html += "<h6 class='preview-subject ellipsis mb-1 font-weight-normal'>"+obj.m_Nickname+"<button type='button' name='fcancel' class='mabu btn btn-gradient-primary btn-sm' m_Email='"+obj.m_Email+"'>친구 취소</button></h6>"; 	                   
       	                	html += "</div></a>"
       	                  
       					}else if(obj.f_Status==3){
       						var html="";
       						html ="<div class='dropdown-divider'></div>";
       					 	html += "<a class='dropdown-item preview-item'>";
       					 	html += "<div class='preview-thumbnail' id='friendimage'>";
       					    html += "<img src='image/member/"+obj.m_Image+"' alt='image' class='profile-pic'>";
       	              	    html += "</div>"
       	                	html += "<div class='preview-item-content d-flex align-items-start flex-column justify-content-center'>";
      						html += "<h6 class='preview-subject ellipsis mb-1 font-weight-normal'>"+obj.m_Nickname+"<button type='button' name='faccept' class='mabu btn btn-gradient-primary btn-sm' m_Email='"+obj.m_Email+"'>수락</button><button type='button' name='fremove' class='mabu btn btn-gradient-primary btn-sm' m_Email='"+obj.m_Email+"'>거절</button></h6>"; 	                   
       	                	html += "</div></a>"
       						
       					}else if (obj.f_Status==2){
//        						var rannum = generateRandom(0, 1000);
           						var html="";
           						html ="<div class='dropdown-divider'></div>";
           					 	html += "<a class='dropdown-item preview-item'>";
           					 	html += "<div class='preview-thumbnail' id='friendimage'>";
           					    html += "<img src='image/member/"+obj.m_Image+"' alt='image' class='profile-pic'>";
           	              	    html += "</div>"
           	                	html += "<div class='preview-item-content d-flex align-items-start flex-column justify-content-center'>";
          						html += '<h6 class="preview-subject ellipsis mb-1 font-weight-normal">'+obj.m_Nickname+'<button type="button" name="fmessage" class="mabu btn btn-gradient-primary btn-sm" m_Email="'+obj.m_Email+'">쪽지</button><button type="button" onClick="javascript:popupOpen(1,'+"'"+obj.m_Nickname+"'"+')" name="fchat" class="mabu btn btn-gradient-primary btn-sm" m_Email="'+obj.m_Email+'">대화</button></h6>'; 	                   
           	                	html += "</div></a>"
           					}
       				 $('#friendl').append(html);
       					})
       				} 
        }
        })
	$(document).on("click","button[name='fcancel']",function(){
		$.ajax({
	        type : 'post',
	        url : 'joinus/friendcancel.htm',
	        data : {"m_Email2" : $(this).attr('m_Email')},
	        success : function(data) {
	        	location.href="index.htm?fc";
	        }
		})
	})
	
	$(document).on("click","button[name='fremove']",function(){
		$.ajax({
	        type : 'post',
	        url : 'joinus/friendcancel1.htm',
	        data : {"m_Email" : $(this).attr('m_Email')},
	        success : function(data) {
	        	location.href="index.htm?fr";
	        }
		})
		
	})
	$(document).on("click","button[name='faccept']",function(){
		$.ajax({
	        type : 'post',
	        url : 'joinus/friendaccept.htm',
	        data : {"m_Email" : $(this).attr('m_Email')},
	        success : function(data) {
	        	location.href="index.htm?fa";
	        }
		})
		
	})
	/*친구 찾기*/
	$('#searchfriend').click(function(){
		$.ajax({
	          type : 'post',
	          url : 'joinus/friendsearch.htm',
	          data : {"m_Nickname":$('#friend').val()},
	          success : function(data) {
	        	  console.log(data);
	        	  if(data.login=="fail"){
	        		  swal("로그인 후 이용해주세요.","","warning");
	      	        		  
	        	  }
	        	  if(data.fail=="fail"){
	        		  swal("찾으시는 회원이 존재하지 않습니다.","","warning");
	        	  }
	        	  if(data.friend !=null){
	        	  var m_Email = data.friend.m_Email;
	        	 
	        	  if(data.friend.f_Status==2){
	            	  swal({
		    			  title: "닉네임 : " +data.friend.m_Nickname,
		    			  text: "이메일 : " +data.friend.m_Email,
		    			  showCancelButton: true,
		    			  imageUrl:"image/member/"+data.friend.m_Image,
		    			  imageWidth: 100,
		    			  imageHeight: 100,
		    			  imageClass:"friend",
		    			  animation:false,
		    			  confirmButtonColor: "#3085d6",
		    			  confirmButtonText: "친구 삭제",
		    			  cancelButtonColor : "#d33",
		    			  cancelButtonText: "취소",
		    			}).then((result) => { 
		    			
		    			  if (result.value) {
		    					$.ajax(
		    							{
		    								type:"post",
		    								url:"joinus/friendcancel1.htm",
		    								dataType:"json",
		    								data:{"m_Email" : m_Email},
		    								success:function(data){ //{"result":""}
		    									if(data.result=="fail"){
		    										location.href="index.htm?fdel"
		    									}else{
		    										location.href="index.htm?faildel"
		    									}
		    								}
		    							}	
		    						);
		    			  } else {
		    			    swal("취소", "", "error");
		    			  }
		    			});
	        	  }else if (data.friend.f_Status==1){
	        		  $.ajax({
	        	          type : 'post',
	        	          url : 'joinus/friendsearch.htm',
	        	          data : {"m_Nickname":$('#friend').val()},
	        	          success : function(data) {
	        	        	  swal({
	    		    			  title: "닉네임 : " +data.friend.m_Nickname,
	    		    			  text: "이메일 : " +m_Email,
	    		    			  showCancelButton: true,
	    		    			  imageUrl:"image/member/"+data.friend.m_Image,
	    		    			  imageWidth: 100,
	    		    			  imageHeight: 100,
	    		    			  imageClass:"friend",
	    		    			  animation:false,
	    		    			  confirmButtonColor: "#3085d6",
	    		    			  confirmButtonText: "요청중",
	    		    			  cancelButtonColor : "#d33",
	    		    			  cancelButtonText: "취소",
	    		    			}).then((result) => { 
	    		    			
	    		    			  if (result.value) {
	    		    				swal("친구요청중입니다.","수락할때까지 기다려주세요.","warning");
	    		    			  } else {
	    		    			    swal("취소", "", "error");
	    		    			  }
	    		    			}); 
	        	          }
	        		  })
	        	        
	        		 
	          }else if (data.friend.f_Status==3){
	        	  $.ajax({
        	          type : 'post',
        	          url : 'joinus/friendsearch.htm',
        	          data : {"m_Nickname":$('#friend').val()},
        	          success : function(data) {
        	        	  swal({
    		    			  title: "닉네임 : " +data.friend.m_Nickname,
    		    			  text: "이메일 : " +m_Email,
    		    			  showCancelButton: true,
    		    			  imageUrl:"image/member/"+data.friend.m_Image,
    		    			  imageWidth: 100,
    		    			  imageHeight: 100,
    		    			  imageClass:"friend",
    		    			  animation:false,
    		    			  confirmButtonColor: "#3085d6",
    		    			  confirmButtonText: "수락",
    		    			  cancelButtonColor : "#d33",
    		    			  cancelButtonText: "취소",
    		    			}).then((result) => { 
    		    			
    		    			  if (result.value) {
    		    				  $.ajax({
    		    				        type : 'post',
    		    				        url : 'joinus/friendaccept.htm',
    		    				        data : {"m_Email" : m_Email},
    		    				        success : function(data) {
    		    				        	location.href="index.htm?fa";
    		    				        }
    		    					})
    		    			  } else {
    		    			    swal("취소", "", "error");
    		    			  }
    		    			}); 
        	          }
        		  })
        	        
	          }else{	 
	        	  $.ajax({
    	          type : 'post',
    	          url : 'joinus/friendsearch.htm',
    	          data : {"m_Nickname":$('#friend').val()},
    	          success : function(data) {
    	        	  swal({
		    			  title: "닉네임 : " +data.friend.m_Nickname,
		    			  text: "이메일 : " +m_Email,
		    			  showCancelButton: true,
		    			  imageUrl:"image/member/"+data.friend.m_Image,
		    			  imageWidth: 100,
		    			  imageHeight: 100,
		    			  imageClass:"friend",
		    			  animation:false,
		    			  confirmButtonColor: "#3085d6",
		    			  confirmButtonText: "친구추가",
		    			  cancelButtonColor : "#d33",
		    			  cancelButtonText: "취소",
		    			}).then((result) => { 
		    			
		    			  if (result.value) {
		    				  $.ajax({
		    				        type : 'post',
		    				        url : 'joinus/friendinsert.htm',
		    				        data : {"m_Email2" : m_Email},
		    				        success : function(data) {
		    				        	if(data.result == "fail"){
		    				        		location.href="index.htm?friend";
		    				        	}else{
		    				        		location.href="index.htm?fail";
		    				        	}
		    				        }
		    					})
		    			  } else {
		    			    swal("취소", "", "error");
		    			  }
		    			}); 
    	          }
    		  })
	        	  
	        	  
	          }
	        	  }
	          }
		
	})
	})
	/*로그인처리*/
	$('#login').click(function(){
		$.ajax({
	          type : 'post',
	          url : 'joinus/blacklistcheck.htm',
	          data : {"m_Email":$('#Login_Email').val()},
	          success : function(data) {
	        	 console.log(data.result);
	        	 if(data.result =="success"){
	        		 $.ajax({
                         type : 'post',
                         url : 'getpass.htm',
                         data :{"m_Email":$('#Login_Email').val(),
                       	  	    "m_Pwd" : $('#Login_Pwd').val()},
                         success : function(data){
                        	 if(data=="fail"){
                        		 location.href="index.htm?error";
                        	 }							  
                        	 else{
                        		 $.ajax({
                                     type : 'post',
                                     url : 'login',/*security  서블릿 탐  */
                                     data :{"m_Email":$('#Login_Email').val(),
                                   	  	    "m_Pwd" : $('#Login_Pwd').val()},
                                     success : function(){	  
                                   	  location.href="index.htm";
                                     }
                                     });
                        	 }
                         }
                         });	
	        	 }
	        	 else{
	        		 swal("블랙리스트로 등록되어있어 로그인이 불가합니다.","","warning");
	        	 }
	          
	          
	          }
	          })
	})
	
 /*아이디 저장*/
 var userInputId = getCookie("userInputId");
 $('#Login_Email').val(userInputId);
 
 if($('#Login_Email').val() !=""){
	   $('#idSave').attr("checked",true);
 }
 $('#idSave').change(function(){
	   if($('#idSave').is(":checked")){
		   var userInputId = $('#Login_Email').val();
	 	   setCookie("userInputId", userInputId, 7);
	   } else{
		   deleteCookie("userInputId");
	   }
 });
 $("#Login_Email").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
     if($("#idSave").is(":checked")){ // ID 저장하기를 체크한 상태라면,
         var userInputId = $("#Login_Email").val();
         setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
     }
 });
});
/*메시지*/
function popupCenter(w,h){
	   var xPos = (window.screen.width / 2) - (w / 2); 
	   var yPos = (window.screen.height / 2) - (h / 2);
	   window.open('message_list.htm',"","width="+w+",height="+h+", left="+xPos+", top="+yPos+", toolbars=no, resizable=no, scrollbars=no");
	}
	
function popupfriend(w,h){
	   var xPos = (window.screen.width / 2) - (w / 2); 
	   var yPos = (window.screen.height / 2) - (h / 2);
	   window.open('friendsearch.htm',"","width="+w+",height="+h+", left="+xPos+", top="+yPos+", toolbars=no, resizable=no, scrollbars=no");
	}
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	
	$(function(){

	//시큐리티 회원가입 이메일 인증번호
	$('#authority').click(function(){	
		var a = document.getElementsByName("authornum")[0];
		a.setAttribute('type','text');
		var b = document.getElementsByName("authorbutton")[0];
		b.setAttribute('type','button');
		$('#author').empty();
		$('#author').append("Authority");
		$.ajax({
          type : 'post',
          url : 'mail.htm',
          data : {mailto:$('#m_Email').val()},
          success : function(data) {
        	  console.log(data);
          	mailtoNum=data;
          	$('#authorbutton').click(function(){
          		if(mailtoNum==$('#authornum').val()){
          			console.log(mailtoNum);
          			$('#submit').removeAttr('disabled');
          			swal("인증번호가 일치합니다!","", "success");
          		}else{
          			swal("인증번호가 일치하지 않습니다!","", "warning");
          			$('#authornum').val("");
          		}
          	});
          },
          error : function(error) {
             swal("실패하였습니다.");
             console.log(error);
             console.log(error.status);
          }
		
	})
	})
	//시큐리티 비밀번호 재설정 인증번호
	$('#authority1').click(function(){	
// 		var a = document.getElementsByName("authornum")[1];
// 		a.setAttribute('type','text');
// 		var b = document.getElementsByName("authorbutton")[1];
// 		b.setAttribute('type','button');
// 		$('#author1').empty();
// 		$('#author1').append("Authority");
		$.ajax({
          type : 'post',
          url : 'pwd.htm',
          data : {mailto:$('#m_Emailpass').val()},
          success : function(data) {
        	  swal("임시 비밀번호메일을 보냈습니다.","","success");
          },
          error : function(error) {
             swal("실패하였습니다.");
             console.log(error);
             console.log(error.status);
          }
		
	})
	})
	//회원가입 유효성 검사 비밀번호
  $('#m_Pwd1').keyup(function(){
		if($('#m_Pwd').val()==$('#m_Pwd1').val()){
			$('.pwcheck1').empty();
			$('.pwcheck').empty();
  		$('.pwcheck1').append("비밀번호가 일치합니다.")
  	}
  	else{
  		$('.pwcheck').empty();
  		$('.pwcheck1').empty();
			$('.pwcheck').append("비밀번호가 일치하지 않습니다.")
  	}
  })	
  //비밀번호 재설정 검사 비밀번호
    $('#m_Pwd3').keyup(function(){
		if($('#m_Pwd2').val()==$('#m_Pwd3').val()){
			$('.pwcheck1').empty();
			$('.pwcheck').empty();
  		$('.pwcheck1').append("비밀번호가 일치합니다.")
  	}
  	else{
  		$('.pwcheck').empty();
  		$('.pwcheck1').empty();
			$('.pwcheck').append("비밀번호가 일치하지 않습니다.")
  	}
  })	
  //이메일 유효성 검사
	$('#idcheck').click(function(){
		if($('#m_Email').val() === ""){
			swal("ID를 입력해주세요!","", "warning");
			$('#m_Email').focus();
		}else{
			$.ajax(
					{
						type:"get",
						url:"joinus/idcheck.htm",
						dataType:"json",
						data:{"m_Email" : $('#m_Email').val()},
						success:function(data){ //{"result":""}
							console.log(data);
							if(data.result=="fail"){
								swal("사용불가능한아이디입니다.","", "warning");
								$('#m_Email').focus();
								$('#m_Email').val("");
							}else{
								swal("사용가능한 아이디 입니다.","", "success");								
								$('#m_Pwd').focus();
								
							}
						}
					}	
				);
		}
		
	});
  //비밀번호 재설정 이메일 유효성
	$('#idcheck1').click(function(){
		if($('#m_Emailpass').val() === ""){
			swal("ID를 입력해주세요!","", "warning");
			$('#m_Emailpass').focus();
		}else{
			$.ajax(
					{
						type:"get",
						url:"joinus/idcheck.htm",
						dataType:"json",
						data:{"m_Email" : $('#m_Emailpass').val()},
						success:function(data){ //{"result":""}
							console.log(data);
							if(data.result=="fail"){
								swal("가입되어있는아이디입니다.","", "success");
								$('#authority1').removeAttr('disabled');
							}else{
								swal("가입된아이디가 아닙니다.","", "warning");								
								$('#m_Emailpass').focus();
								$('#m_Emailpass').val("");
							}
						}
					}	
				);
		}
		
	});
  

  //회원가입 유효성
  $('#submit').click(function(){
  	if($('#m_Email').val() === ""){
  		swal("아이디를 입력해주세요.","","warning");
  		$('#m_Email').focus();
  	}
  	else if($('#m_Pwd').val() === ""){
  		swal("비밀번호를 입력해주세요.","","warning");
  	    		
  	}else if($('#m_Pwd1').val() === ""){
  		swal("비밀번호확인을 해주세요.","","warning");
  	    		
  	}else if($('#m_Nickname').val() === ""){
  		swal("닉네임을 입력해주세요.","","warning");
  	    		
  	}else if($('#m_Pwd').val()!=$('#m_Pwd1').val()){
  		swal("비밀번호가 일치하지 않습니다..","","warning");
  	}else{
  		var form = $('#form')[0];
  		var formData = new FormData(form);
  		$.ajax(
					{
						type:"post",
						url:"joinus/join.htm",
						data:formData,
						processData: false,
		                contentType: false,
						success:function(data){ //{"result":""}
						console.log(data);
							if(data=="success"){
								$('.pwcheck1').empty();
								$('.pwcheck').empty();
								swal("회원가입성공.","", "success");
							}else{
								swal("회원가입실패.","", "warning");								
							}
			            	},
			            error : function(error) {
			               swal("실패하였습니다.","","warning");
			               console.log(error);
			               console.log(error.status);
			            }
					
				})
				}
  		
  		
  	})
  
  
});

  
 $(function(){
  /*카카오톡 로그인  */ 
  Kakao.init('def7b68fa446b7b14c7f07255ccc5caf');
  
  // 카카오 로그인 버튼을 생성합니다.
  Kakao.Auth.createLoginButton({
    container: '#kakao-login-btn',
    success: function(authObj) {
        // 로그인 성공시, API를 호출합니다.
        Kakao.API.request({
          url: '/v2/user/me',
          success: function(res) {
        	  alert(res.kakao_account.gender);
        	  alert(res.kakao_account.email);
        	  alert(res.properties.nickname);
        	  alert(res.kakao_account.gender);
        	  alert(res.properties.profile_image);
        	  
          $.ajax({
        	  type:'post',
        	  url:'joinus/kakaocheck.htm',
        	  data : {"m_Email":res.kakao_account.email},
        	  dataType:"json",
        	  success:function(data){
        		  console.log(data);
        		  if(data.data =="success"){
        			  $.ajax({
                          type : 'post',
                          url : 'login',
                          data :{"m_Email":res.kakao_account.email,
                        	  	 "m_Pwd" : res.id},
                          success : function(){
                        	  location.href="index.htm";
                        		  
                          }
                          });
        		  }else{
        			  $.ajax({
        		             type : 'post',
        		             url : 'joinus/kakaojoin.htm',
        		             data : {"m_Email":res.kakao_account.email,
        		            		 "m_Pwd": res.id,
        		           	  	  	 "m_Nickname":res.properties.nickname,
        		           	  	  	 "m_Gender":res.kakao_account.gender,
        		           	      	 "m_Image":res.properties.profile_image,
        		         	  	  	},
        		             dataType:"json",
        		          	 success : function(data) {
        		          			
        		          		  $.ajax({
        		                      type : 'post',
        		                      url : 'login',
        		                      data :{"m_Email":data.m_Email,
        		                    	  	 "m_Pwd" : data.m_Pwd},
        		                      success : function(){
        		                    	  location.href="index.htm";
        		                    		  
        		                      }
        		                      });
//        		 			          		  location.href="index.htm";
        		          	 }	
        		          	  ,
        		             error : function(error) {
        		                swal("실패하였습니다.","","warning");
        		                console.log(error);
        		                console.log(error.status);
        		             }
        		   	})
        			  
        		  }
        	  }
          
          })
      
          },
          fail: function(error) {
            alert(JSON.stringify(error));
          }
        });
      },
      fail: function(err) {
        alert(JSON.stringify(err));
      }
    });
 })
 
 
  </script>
  
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <!-- End plugin js for this page -->
  <script src="js/off-canvas.js"></script>
  <script src="js/misc.js"></script>
  <script src="js/dashboard.js"></script>
  <script src="js/file-upload.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.all.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.min.css">
  <link rel="shortcut icon" href="images/logo-mini.jpg" />


<nav
	class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
	
	<div class="navbar-menu-wrapper d-flex align-items-stretch col-lg-12">
	
	<div
		class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
		<a class="navbar-brand brand-logo" href="index.htm"><img
			src="images/logo.png" alt="logo" /></a> <a
			class="navbar-brand brand-logo-mini" href="index.htm"><img
			src="images/logo-mini.jpg" alt="logo" /></a>
	</div>
		   <ul class="navbar-nav">
				<li class="nav-item nav-logout d-lg-block"><a class="nav-link"
					href="gowith_list.htm"><button type="button" id="gowith" class="btn btn-link btn-fw">함께가기</button>
					</a>
 
				</li>
		
				<li class="nav-item nav-logout d-lg-block"><a class="nav-link"
					href="reviewlist.htm"><button type="button" id="review" class="btn btn-link btn-fw">리뷰</button>
					</a>
				</li> 
				<li class="nav-item nav-logout d-lg-block"><a class="nav-link"
					href="#"><button type="button" onClick="popupfriend(450,450)" class="btn btn-link btn-fw">친구찾기</button>
					</a>
 
				</li> 

			</ul>
			<ul class="navbar-nav navbar-nav-right">
			<c:if test="${param.error != null}">
				<script type="text/javascript">
					swal("아이디혹은 비밀번호가 틀립니다.다시 로그인해주세요.","","warning");
				</script>
			</c:if>	
			<c:if test="${param.login != null}">
				<script type="text/javascript">
					swal("로그인을 하셔야 이용하실 수 있습니다.","","warning");
				</script>
			</c:if>	
			<c:if test="${param.friend != null}">
				<script type="text/javascript">
					swal("친구추가에 성공하였습니다.","친구가 수락할때까지 잠시만 기다려주세요.","success");
				</script>
			</c:if>
			<c:if test="${param.fail != null}">
				<script type="text/javascript">
					swal("친구추가에 실패하였습니다.","","warning");
				</script>
			</c:if>	
			<c:if test="${param.fc != null}">
				<script type="text/javascript">
					swal("친구신청을 취소하였습니다.","","success");
				</script>
			</c:if>	
			<c:if test="${param.fr != null}">
				<script type="text/javascript">
					swal("친구거절을 성공하였습니다.","","success");
				</script>
			</c:if>	
			<c:if test="${param.fdel != null}">
				<script type="text/javascript">
					swal("친구삭제를 성공하였습니다.","","success");
				</script>
			</c:if>	
			<c:if test="${param.faildel != null}">
				<script type="text/javascript">
					swal("친구삭제를 실패하였습니다.","","success");
				</script>
			</c:if>	
			<c:if test="${param.fa != null}">
				<script type="text/javascript">
					swal("친구를 수락하였습니다.","","success");
				</script>
			</c:if>	
		<se:authorize access="isAuthenticated()">
		<li class="nav-item dropdown">
            <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
              <i class="mdi mdi-email-outline"></i>
              <span class="count-symbol bg-warning"></span>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">
              <h6 class="p-3 mb-0">Messages</h6>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                    <img src="images/faces/face4.jpg" alt="image" class="profile-pic">
                </div>
					
                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                  <h6 class="preview-subject ellipsis mb-1 font-weight-normal" onClick="popupCenter(600,630)" style="cursor: pointer;">Mark send you a message</h6> 
                  <p class="text-gray mb-0">
                    1 Minutes ago
                  </p>
                </div>
				              
              </a>
             
              <div class="dropdown-divider"></div>
              <h6 class="p-3 mb-0 text-center">4 new messages</h6>
            </div>
          </li>
			 <li class="nav-item dropdown">
            <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
              <i class="fas fa-user-friends"></i>
              <span id="1"></span>
            </a>
            <div id="friendl" class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">
              <h6 class="p-3 mb-0">친구목록</h6>
            </div>
          </li>
				<li class="nav-item nav-profile">
						<se:authorize access="hasRole('ROLE_ADMIN')">
						<a class="nav-link" href="adminpage.htm" aria-expanded="false">
						</se:authorize>
						<se:authorize access="!hasRole('ROLE_ADMIN')">
						<a class="nav-link" href="mypage.htm" aria-expanded="false">
						</se:authorize>
						<div class="nav-profile-img">	
						<c:choose>						
							<c:when test="${dto.m_Social==1}">
								 <img src="${dto.m_Image}" onerror="this.src='image/member/unknown.jpg'">
							</c:when>
							<c:otherwise>
									<img src="image/member/${dto.m_Image}" onerror="this.src='image/member/unknown.jpg'">
							</c:otherwise>
					    </c:choose>
					    
							   <span class="availability-status online"></span>
						</div>
						<div class="nav-profile-text">
							<p class="mb-1">${dto.m_Nickname}</p>
						</div>
						
						</a>
					
					</li>
					</se:authorize>
			<se:authorize access="isAuthenticated()">
				<li class="nav-item nav-logout d-lg-block"><a class="nav-link"
					href="logout.htm"> <i class="mdi mdi-logout"></i>
				</a></li>
			</se:authorize>
			
			<se:authorize access="isAnonymous()">
				<li class="nav-item nav-logout d-lg-block"><a class="nav-link"
					data-toggle="modal" data-target="#signIn"> <i
						class="mdi mdi-login"></i>
				</a></li>
				<li class="nav-item nav-logout d-lg-block"><a class="nav-link"
					data-toggle="modal" data-target="#signUp"> <i
						class="mdi mdi-account"></i>
				</a></li>
			</se:authorize>

		</ul>
			<c:if test="${tile!=null}">
				<button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          		<span class="mdi mdi-menu"></span>
        		</button>
			</c:if>
   		<!--         <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas"> -->
		<!--           <span class="mdi mdi-menu"></span> -->
		<!--         </button> -->
	</div>
</nav>
<!-- 모달 -->
<div class="modal fade" id="signIn" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>

			</div>
			<div class="modal-body">
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
							<h2 class="card-title">로그인</h2>
								<div class="form-group">
									<label>Email</label> <input type="email" id="Login_Email" class="form-control"
										name="m_Email" placeholder="EMAIL을 입력해주세요.">
								</div>
								<div class="form-group">
									<label>Password</label> <input type="password" id="Login_Pwd"
										class="form-control" name="m_Pwd"
										placeholder="PASSWORD를 입력해주세요.">
								</div>
								<!-- 아이디 저장 -->
								<div class="form-check form-check-flat form-check-primary">
									<label class="form-check-label"> <input type="checkbox"
										class="form-check-input" id="idSave">아이디 저장
									</label>
								</div>
									<a data-toggle="modal" data-target="#passChange" data-dismiss="modal">비밀번호 재설정</a>&emsp;|&emsp;<a data-toggle="modal" data-target="#signUp" data-dismiss="modal">회원가입하기
									</a>
								<div class="form-group">
									<a id="kakao-login-btn"></a> 
									<a href="http://developers.kakao.com/logout"></a>
									 <!-- 네이버아이디로로그인 버튼 노출 영역 -->
 									 <div id="naver_id_login"></div>
 									 <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
							<!--네이버 로그인  -->
 									 <script type="text/javascript">
 									 		var naver_id_login = new naver_id_login("pxIKdTfaUoc6gmJwiy4Q", "http://localhost:8090/travelmaker/callback.jsp");
  											var state = naver_id_login.getUniqState();
  											naver_id_login.setButton("green", 3,48);
  											naver_id_login.setDomain("http://localhost:8090");
  											naver_id_login.setState(state);
  											naver_id_login.setPopup();
 										 	naver_id_login.init_naver_id_login();
 									</script>
								</div>
								<button type="button" id="login" class="btn btn-gradient-primary mr-2"
									>로그인</button>
								<button type="reset" class="btn btn-light">초기화</button>
<!-- 							</form> -->
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>
<div class="modal fade" id="signUp" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
							<h2 class="card-title">회원가입</h2>
							<form id="form" class="forms-sample" method="post">
								<div class="form-group">
									<label>Email</label>
									<div class="input-group">
										<input type="email" class="form-control md-6" id="m_Email"
											name="m_Email" placeholder="EMAIL을 입력해주세요."> <input
											type="button" class="btn btn-gradient-primary mr-2"
											id="idcheck" value="중복확인">
									</div>
								</div>
								<div class="form-group">
									<input type="button" class="btn btn-gradient-primary mr-2"
										id="authority" value="이메일인증요청">
								</div>
								<div class="form-group">
									<label id="author"></label>
									<div class="input-group">
										<input type="hidden" class="form-control" id="authornum"
											name="authornum" placeholder="인증번호를 입력해주세요."> <input
											type="hidden" class="btn btn-gradient-primary mr-2"
											id="authorbutton" name="authorbutton" value="인증확인">
									</div>
								</div>
								<div class="form-group">
									<label>Password</label> <input type="password"
										class="form-control" id="m_Pwd" name="m_Pwd"
										placeholder="PASSWORD를 입력해주세요.">
								</div>
								<div class="form-group">
									<label>Confirm Password</label> <input type="password"
										class="form-control" id="m_Pwd1" name="m_Pwd1"
										placeholder="PASSWORD를 확인해주세요."> <span class="pwcheck"></span>
									<span class="pwcheck1"></span>
								</div>
								<div class="form-group">
									<label>Nickname</label> <input type="text" class="form-control"
										name="m_Nickname" placeholder="NICKNAME을 입력해주세요.">
								</div>
								<div class="form-group">
									<label>File upload</label> <input type="file" name="file"
										class="file-upload-default">
									<div class="input-group col-xs-12">
										<input type="text" class="form-control file-upload-info"
											name="m_Image" id="m_Image" disabled placeholder="Upload Image"> <span
											class="input-group-append">
											<button class="file-upload-browse btn btn-gradient-primary"
												type="button">Upload</button>
										</span>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-4 col-form-label">Gender</label>
									<div class="col-xs-4">
										<div class="form-check">
											<label class="form-check-label"> <input type="radio"
												class="form-check-input" name="m_Gender" id="m_GENDER"
												value="man" checked> 남
											</label>
										</div>
									</div>
									<div class="col-xs-4">
										<div class="form-check">
											<label class="form-check-label"> <input type="radio"
												class="form-check-input" name="m_Gender" id="m_GENDER1"
												value="woman"> 여
											</label>
										</div>
									</div>
								</div>
								<button type="button" id="submit" class="btn btn-gradient-primary mr-2" data-dismiss="modal" disabled="disabled" >가입</button>
								<button type="reset" class="btn btn-light">초기화</button>
							</form>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
</div>
<div class="modal fade" id="passChange" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
							<h2 class="card-title">임시비밀번호요청</h2>
							<form action="" class="forms-sample" method="post">
								<div class="form-group">
									<label>Email</label>
									<div class="input-group">
										<input type="email" class="form-control md-6" id="m_Emailpass"
											name="m_Email" placeholder="EMAIL을 입력해주세요.">
											<input
											type="button" class="btn btn-gradient-primary mr-2"
											id="idcheck1" value="아이디여부">
									</div>
								</div>
								<div class="form-group text-center">
									<input type="button" class="btn btn-gradient-primary mr-2"
										id="authority1" value="임시비밀번호이메일전송" disabled="disabled">
								</div>
<!-- 								<div class="form-group"> -->
<!-- 									<label id="author1"></label> -->
<!-- 									<div class="input-group"> -->
<!-- 										<input type="hidden" class="form-control" id="authornum1" -->
<!-- 											name="authornum" placeholder="인증번호를 입력해주세요."> <input -->
<!-- 											type="hidden" class="btn btn-gradient-primary mr-2" -->
<!-- 											id="authorbutton1" name="authorbutton" value="인증확인"> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label>Password</label> <input type="password" -->
<!-- 										class="form-control" id="m_Pwd2" name="m_Pwd" -->
<!-- 										placeholder="PASSWORD를 새로운비밀번호를 입력해주세요."> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label>Confirm Password</label> <input type="password" -->
<!-- 										class="form-control" id="m_Pwd3" name="m_Pwd1" -->
<!-- 										placeholder="PASSWORD를 확인해주세요."> <span class="pwcheck"></span> -->
<!-- 									<span class="pwcheck1"></span> -->
<!-- 								</div> -->
<!-- 								<button id="passch" data-dismiss="modal" class="btn btn-gradient-primary mr-2" disabled="disabled">확인</button> -->
<!-- 								<button type="reset" class="btn btn-light">초기화</button> -->
							</form>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
</div>

