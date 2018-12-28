<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <script src="http://code.jquery.com/jquery-2.2.4.js"></script>
	<script type="text/javascript">
	  $(function(){
   	   $('#m_Pwd5').keyup(function(){
   			if($('#m_Pwd4').val()==$('#m_Pwd5').val()){
   				$('.pwcheck1').empty();
   				$('.pwcheck').empty();
   	    		$('.pwcheck1').append("비밀번호가 일치합니다.")
   	    	}
   	    	else{
   	    		$('.pwcheck').empty();
   	    		$('.pwcheck1').empty();
   				$('.pwcheck').append("비밀번호가 일치하지 않습니다.")
   	    	}
   	    });	
  
	  //프로필사진 변경
		$('#profilech').click(function(){
	    var form = $('#form1')[0];
		console.log(form);
		var formData = new FormData(form);
		console.log(formData);
		$.ajax(
				{
					type:"post",
					url:"profilech.htm",
					data:formData,
					processData: false,
	                contentType: false,
					success:function(data){ //{"result":""}
					console.log(data);
						if(data=="success"){
							location.href="mypage.htm";
// 							swal("프로필사진 변경 성공.","", "success");
						}else{
							swal("프로필사진 변경 실패.","", "warning");								
						}
		            	},
		            error : function(error) {
		               swal("실패하였습니다.","","warning");
		               console.log(error);
		               console.log(error.status);
		            }
				
			})
		})
		
		//닉네임변경
		$('#nickch').click(function(){
		$.ajax(
				{
					type:"post",
					url:"nickch.htm",
					data:{"m_Nickname":$('#m_Nickname').val(),
						  "m_Email":$('#nickEmail').val()},
					success:function(data){ //{"result":""}
					console.log(data);
						if(data=="success"){
							location.href="mypage.htm";
// 							swal("닉네임 변경 성공.","", "success");
						}else if(data=="admin"){
							location.href="adminpage.htm";
						}else{
							swal("닉네임 변경 실패.","", "warning");								
						}
		            	},
		            error : function(error) {
		               swal("실패하였습니다.","","warning");
		               console.log(error);
		               console.log(error.status);
		            }
				
			})
		})
		
		
		//비밀번호 변경
		$('#passchange').click(function(){
			if($('#m_Pwd4').val()!=$('#m_Pwd5').val()){
				swal("비밀번호가 일치하지않습니다.","","warning")
			}else{
			$.ajax({
	            type : 'post',
	            url : 'joinus/passchange.htm',
	            data : {"m_Email":$('#passEmail').val(),
	            		"m_Pwd":$('#m_Pwd4').val()},
	            dataType:"json",
	            success : function(data) {
	            	if(data.result=="fail"){
	            		$('.pwcheck1').empty();
	        			$('.pwcheck').empty();
						swal("비밀번호변경 성공하였습니다.","", "success");
					}else{
						swal("비밀번호변경 실패.","", "warning");								
					}
	            	},
	            error : function(error) {
	               swal("실패하였습니다.");
	               console.log(error);
	               console.log(error.status);
	            }
			
		})
			}
		})
		
		//회원탈퇴
		$('#delete').click(function(){
			$.ajax(
					{
						type:"post",
						url:"getpass.htm",
						data:{"m_Email":$('#nickEmail').val(),
							  "m_Pwd":$('#m_Pwd6').val()},
						success:function(data){ //{"result":""}
						console.log(data);
						if(data=="success"){	
						$.ajax(
								{
									type:"post",
									url:"delete.htm",
									data:{"m_Email":$('#nickEmail').val()},
									success:function(data){ //{"result":""}
									console.log(data);
										if(data=="success"){
											location.href="delpage.htm"
											
//				 							swal("닉네임 변경 성공.","", "success");
										}else{
											swal("회원탈퇴실패.","", "warning");								
										}
						            	},
						            error : function(error) {
						               swal("실패하였습니다.","","warning");
						               console.log(error);
						               console.log(error.status);
						            }
								
							})
						}else{
						swal("회원탈퇴 실패","","warning");	
						}
						}
						,
			            error : function(error) {
			               swal("탈퇴 실패하였습니다.","","warning");
			               console.log(error);
			               console.log(error.status);
			            }
				})
			})
		  });    
	  
	</script>
	
	 <!-- partial -->
      <div class="main-panel">
			
        <div class="content-wrapper1">
			
         <div class="col-lg-4 col-md-8 mx-auto text-center ">
        
           <div class="auth-form-light p-5 d-table-cell align-middle card">
            <h1 class="my-md-4">내 정보 수정</h1>
          	  <div class="gird-margin">
<%--             	 		<c:choose>						 --%>
<%-- 							<c:when test="<%=session.getAttribute(\"social\").equals(\"true\")%>"> --%>
<%-- 								 <img class="img" src="${dto.m_Image}" onerror="this.src='image/member/unknown.jpg'"> --%>
								 
<%-- 							</c:when> --%>
<%-- 							<c:when test="<%=session.getAttribute(\"social\").equals(\"false\")%>"> --%>
								<img class="img" src="image/member/${dto.m_Image}" onerror="this.src='image/member/unknown.jpg'"/>
<%-- 							</c:when> --%>
<%-- 					    </c:choose> --%>
             </div>
            <br>
            <h4 class="card-title my-md-4">${dto.m_Nickname}&nbsp; 님</h4>
            <button class="btn btn-block btn-outline-danger btn-lg font-weight-medium auth-form-btn" data-toggle="modal" data-target="#profileUpdate">프로필사진 변경</button>
            <button class="btn btn-block btn-outline-primary btn-lg font-weight-medium auth-form-btn" data-toggle="modal" data-target="#passwordUpdate">비밀번호 변경</button>
            <button class="btn btn-block btn-outline-success btn-lg font-weight-medium auth-form-btn" data-toggle="modal" data-target="#nicknameUpdate">닉네임 변경</button>
			<button class="btn btn-block btn-outline-secondary btn-lg font-weight-medium auth-form-btn" data-toggle="modal" data-target="#memberOut">회원 탈퇴</button>
          </div>
         </div>


        <!-- content-wrapper ends -->
        
        <!-- partial -->
      </div>

      <!-- Modal Profile -->
 		 <div class="modal fade" id="profileUpdate" role="dialog">
 		 <div class="modal-dialog">

 		 <!-- Modal Profile content-->
		      <div class="modal-content">
		       <form id="form1" class="forms-sample" method="post">
		        <div class="modal-header">
		          <h4 class="modal-title">프로필사진 변경</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
					<input type="hidden" name="m_Email" value="${dto.m_Email}">
		        </div>
		        <div class="modal-body">
		          <p>변경할 사진을 선택해주세요.</p>
		           <div class="form-group">
                      <label>File upload</label>
                      <input type="file" name="file" class="file-upload-default">
                      <div class="input-group col-xs-12">
                        <input type="text" class="form-control file-upload-info" name="m_Image" disabled placeholder="Upload Image">
                        <span class="input-group-append">
                          <button class="file-upload-browse btn btn-gradient-primary" type="button">Upload</button>
                        </span>
                      </div>
                    </div>
		        </div>
		        <div class="modal-footer">
		           <button type="button" id="profilech" class="btn btn-gradient-primary mr-2" data-dismiss="modal">변경</button>
                   <button class="btn btn-light" data-dismiss="modal">취소</button>
		        </div>
		      </form>
		      </div>	      

 		 </div>
 		 </div>

 		<!-- Modal Password -->
 		 <div class="modal fade" id="passwordUpdate" role="dialog">
 		 <div class="modal-dialog">

 		 <!-- Modal Password content-->
		      <div class="modal-content">
		       	<form  method="post">
		        <div class="modal-header">
		          <h4 class="modal-title">비밀번호 변경</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
				  <input type="hidden" id="passEmail" name="m_Email" value="${dto.m_Email}">              
		        </div>
		        <div class="modal-body">
		        <div class="form-group">
		        <label>비밀번호</label>
                <input type="password" class="form-control" id="m_Pwd4" name="m_Pwd" placeholder="PASSWORD를 입력해주세요.">
              </div>
              <div class="form-group">
                <label>변경할 비밀번호</label>
                <input type="password" class="form-control" id="m_Pwd5" name="m_Pwd1" placeholder="PASSWORD를 확인해주세요.">
                <span class="pwcheck"></span>
                <span class="pwcheck1"></span>
              </div>
		        </div>
		        <div class="modal-footer">
		          <button type="button" id="passchange" class="btn btn-gradient-primary mr-2" data-dismiss="modal">변경</button>
                   <button class="btn btn-light" data-dismiss="modal">취소</button>
		        </div>
		        </form>
		      </div>

 		 </div>
 		 </div>

 		 <!-- Modal Nickname -->
 		 <div class="modal fade" id="nicknameUpdate" role="dialog">
 		 <div class="modal-dialog">

 		 <!-- Modal Nickname content-->
		      <div class="modal-content">
		        <div class="modal-header">
		          <h4 class="modal-title">닉네임 변경</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>

		        </div>
		        <div class="modal-body">
		        
		          <div class="form-group">
                      <label>Nickname</label>
                       <input type="hidden" id="nickEmail" name="m_Email" value="${dto.m_Email}">      
                      <input type="text" class="form-control md-6" id="m_Nickname" name="m_Nickname" placeholder="변경할 NICKNAME을 입력해주세요.">
                    </div>
		        </div>
		        <div class="modal-footer">
		         <button type="button" id="nickch" class="btn btn-gradient-primary mr-2" data-dismiss="modal">변경</button>
                   <button class="btn btn-light" data-dismiss="modal">취소</button>
		        </div>
		      </div>
 		 </div>
 		 </div>
 		 
 		 
 		 
 		  <!-- Modal 회원탈퇴 -->
 		 <div class="modal fade" id="memberOut" role="dialog">
 		 <div class="modal-dialog">

 		 <!-- Modal 회원탈퇴 content-->
		      <div class="modal-content">
		       	<form  method="post">
		        <div class="modal-header">
		          <h4 class="modal-title">회원 탈퇴</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>         
		        </div>
		        <div class="modal-body">
		        <div class="form-group">
		        <label>비밀번호</label>
                <input type="password" class="form-control" id="m_Pwd6" name="m_Pwd" placeholder="PASSWORD를 입력해주세요.">
              </div>
              
		        </div>
		        <div class="modal-footer">
		          <button type="button" id="delete" class="btn btn-gradient-primary mr-2" data-dismiss="modal">회원탈퇴</button>
                   <button class="btn btn-light" data-dismiss="modal">취소</button>
		        </div>
		        </form>
		      </div>

 		 </div>
 		 </div>
 		 
 		 
	</div>
      <!-- main-panel ends -->
       <!-- page-body-wrapper ends -->
<!--   	<link rel="stylesheet" href="css/style.css"/> -->
<!-- 		<link rel="stylesheet" href="vendors/iconfonts/mdi/css/materialdesignicons.min.css"/> -->
<!--   		<link rel="stylesheet" href="vendors/css/vendor.bundle.base.css"/> -->
<!--   		  <script src="vendors/js/vendor.bundle.base.js"></script> -->
<!--   <script src="vendors/js/vendor.bundle.addons.js"></script> -->
<!--   <script src="js/off-canvas.js"></script> -->
<!--   <script src="js/misc.js"></script> -->
<!--   <!-- endinject -->
<!--   <!-- Custom js for this page --> 
<!--   <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
<!--   <script src="js/dashboard.js"></script> -->
<!--   <script src="js/file-upload.js"></script> -->
<!-- <!--   		endinject --> 
<!-- <!--   		inject:css --> 

<!-- <!--   		endinject --> 
<!--   		<link rel="shortcut icon" href="images/logo-mini.jpg" /> -->
  <!-- container-scroller -->

  <!-- plugins:js -->
<!--   <script src="vendors/js/vendor.bundle.base.js"></script> -->
<!--   <script src="vendors/js/vendor.bundle.addons.js"></script> -->
<!--   <!-- endinject -->
<!--   <!-- Plugin js for this page-->
<!--   <!-- End plugin js for this page-->
<!--   <!-- inject:js --> 
<!--   <script src="js/off-canvas.js"></script> -->
<!--   <script src="js/misc.js"></script> -->
<!--   <!-- endinject --> 
<!--   <!-- Custom js for this page--> 
<!--   <script src="js/dashboard.js"></script> -->
<!--   <script src="js/file-upload.js"></script> -->
<!--   <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
  <!-- End custom js for this page-->