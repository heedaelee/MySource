<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<div class="container-scroller">
 <div class="container-fluid page-body-wrapper">
 <div class="main-panel col-md-12" >
<div class="content-wrapper1">

			<c:if test="${param.email == null}">
				<script type="text/javascript">
					swal("회원탈퇴가 정상적으로 진행되었습니다","다시 이용하시려면 회원가입을 해주세요.","success");
				</script>
			</c:if>	
				
			
			<h1>Travel Maker</h1>
			<h2>그동안 페이지를 이용해주셔서 감사합니다.</h2>
			<button type="button" class="btn btn-block btn-gradient-primary" id="goma">메인으로가기</button>
		</div>
		</div>
</div>
</div>
<script type="text/javascript">
$('#goma').click(function(){
	location.href = "logout";
})
	
</script>
