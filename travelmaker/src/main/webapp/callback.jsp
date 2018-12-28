<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
$('.kk').click(function(){
	window.opener.close();
})
  var naver_id_login = new naver_id_login("pxIKdTfaUoc6gmJwiy4Q", "http://localhost:8090/travelmaker/callback.jsp");
  // 접근 토큰 값 출력
  // alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	alert(naver_id_login.getProfileData('gender'));
	alert(naver_id_login.getProfileData('email'));
	  $.ajax({
    	  type:'post',
    	  url:'joinus/navercheck.htm',
    	  data : {"m_Email":naver_id_login.getProfileData('email')},
    	  dataType:"json",
    	  success:function(data){

    		  if(data.data =="success"){
    			  $.ajax({
                      type : 'post',
                      url : 'login',
                      data :{"m_Email":naver_id_login.getProfileData('email'),
                    	  	 "m_Pwd" : naver_id_login.getProfileData('id')},
                      success : function(){
                    	  window.close(); 
			       		  window.opener.location.href="index.htm";
                    		  
                      }
                      });
    		  }else{
    				  $.ajax({
    			  				type : 'post',
    			  				url : 'joinus/naverjoin.htm',
          		  				data : {"m_Email":naver_id_login.getProfileData('email'),
        	  	 		 				"m_Pwd":naver_id_login.getProfileData('id'),
        	  	  		  				"m_Nickname":naver_id_login.getProfileData('nickname'),
        	  	 		  				"m_Gender":naver_id_login.getProfileData('gender'),
        	    		  				"m_Image":naver_id_login.getProfileData('profile_image'),
      	  				  				},
        		  				dataType:"json",
       	 	   	  				success : function(data) {
       				 					console.log(data);
       				 				 $.ajax({
       			                      type : 'post',
       			                      url : 'login',
       			                      data :{"m_Email":data.m_Email,
       			                    	  	 "m_Pwd" : data.m_Pwd},
       			                      success : function(){
       			                    	  window.close(); 
       						       		  window.opener.location.href="index.htm";
       			                    		  
       			                      }
       			                      });
					       		
       		 
       	 		 				},
         			 			error : function(error) {
		           			  swal("실패하였습니다.","","warning");
        		   			  console.log(error);
            				 console.log(error.status);
         		 }
			})
    		  }
    		  }
  })
	  }
</script>
</body>
</html>