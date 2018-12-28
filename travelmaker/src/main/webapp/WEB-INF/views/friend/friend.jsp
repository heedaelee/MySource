<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title"/></title>
<link rel="shortcut icon" href="images/logo-mini.jpg" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="vendors/iconfonts/mdi/css/materialdesignicons.min.css"/>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.all.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.min.css">
 
<script>
  $( function() {
	  var array=new Array();
// 	  var list="";
	  $.ajax({
		  type : 'post',
          url : 'memberlist.htm',
          success : function(data) {
          		console.log(data.list);
          		$.each(data.list,function(index,obj){
          			
          			array.push(obj.m_Nickname);
          			
          		})
          		console.log(array);
          }
		  
	  })
    var availableTags = array;
    $( "#friend" ).autocomplete({
      source: availableTags
    });
  } );
  $(document).ready(function(){
	
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
		    										 window.close(); 
		    							       		  window.opener.location.href="index.htm?fdel";
		    									}else{
		    										 window.close(); 
		    							       		  window.opener.location.href="index.htm?faildel";
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
  		    				        	 window.close(); 
  		    				       		  window.opener.location.href="index.htm?fa";
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
		    				        		 window.close(); 
		    					       		  window.opener.location.href="index.htm?friend";
		    				        	}else{
		    				        		 window.close(); 
		    					       		  window.opener.location.href="index.htm?fail";
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
	  
  })
  </script>
</head>
<body>
 
<div class="ui-widget text-center">
  	<h1 class="friendbtn">친구 검색  </h1>
  	<div class="friendbtn input-group-prepend bg-transparent text-center">
  	<input id="friend" class="text-center" placeholder="닉네임을 입력해주세요.">
			<button type="button" class="text-center input-group-text mdi mdi-magnify bg-transparent" id="searchfriend"></button>
		</div>
</div>
 
 
</body>
</html>