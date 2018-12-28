<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function(){

	var tr;
	var pk;
	
	$('.flist').click(function(){
		nick = $(this).parent().parent().children().children().children().eq(2).text();
		console.log(nick);
	});
	
	$('#fcancel').click(function(){
		$.ajax({
			type : 'post',
			url : 'joinus/friendcancel.htm',
			data : {"m_Email2" : nick},
			success : function(data){
				console.log(data);
				location.href="friendlist.htm"
			}
		});
	});
	
	$('#faccept').click(function(){
		$.ajax({
			type : 'post',
			url : 'joinus/friendaccept.htm',
			data : {"m_Email" : nick},
			success : function(data){
				console.log(data);
				location.href="friendlist.htm"
			}
		});
	});
	
	$('#fremove').click(function(){
		$.ajax({
			type : 'post',
			url : 'joinus/friendcancel1.htm',
			data : {"m_Email" : nick},
			success : function(data){
				console.log(data);
				location.href="friendlist.htm"
			}
		});
	});
	
	$('#fdelete').click(function(){
		$.ajax({
			type : 'post',
			url : 'joinus/frienddelete.htm',
			data : {"m_Email2" : nick},
			success : function(data){
				console.log(data);
				location.href="friendlist.htm"
			}
		});
	});

});
</script>
<div class="main-panel ">
	<div class="content-wrapper1">
		<div class="col-lg-6 col-md-8 text-center m-auto">
			<div class="auth-form-light p-5 d-table-cell align-middle card">
				<h1 class="my-md-4">친구 목록</h1>
				<c:choose>
				<c:when test="${empty member}">
				<hr>
				<h3 class="my-md-4">현재 친구로 등록된 회원이 없습니다!<br><small class="text-muted">회원 검색에서<br> 다른 회원을 찾아서 친구로 등록해보세요!</small></h3>
				</c:when>
				<c:otherwise>
				<table class="table table-basic">
					<c:forEach items="${member}" var="mem">
						
							<tr>
							<c:choose>
							<c:when test="${mem.f_Status==3}">
								<td>
									<div class="nav-profile-image">
										<img src="image/member/${mem.m_Image}" onerror="this.src='image/member/unknown.jpg'"/>
										<div class="nav-profile-text d-flex flex-column">
											<span class="font-weight-bold mb-2">${mem.m_Nickname}</span>
										</div>
										<span class="invisible">${mem.m_Email}</span>
									</div>
								</td>
								<td><span class="text-muted">님이<br>친구 요청을<br>보내셨습니다</span></td>
								<td><button id="faccept" class="btn btn-sm btn-outline-info flist">요청 수락</button></td>
								<td><button id="fremove" class="btn btn-sm btn-outline-danger flist">요청 거절</button></td>
							</c:when>
							
							<c:when test="${mem.f_Status==2}">
								<td>
									<div class="nav-profile-image">
										<img src="image/member/${mem.m_Image}" onerror="this.src='image/member/unknown.jpg'"/>
										<div class="nav-profile-text d-flex flex-column">
											<span class="font-weight-bold mb-2">${mem.m_Nickname}</span>
										</div>
										<span class="invisible">${mem.m_Email}</span>
									</div>
								</td>
								<td><button class="btn btn-sm btn-outline-success flist">대화하기</button></td>
								<td><button class="btn btn-sm btn-outline-warning flist">쪽지 보내기</button></td>
								<td><button id="fdelete" class="btn btn-sm btn-outline-secondary flist">친구 삭제</button></td>
							</c:when>
							
							<c:when test="${mem.f_Status==1}">
								<td>
									<div class="nav-profile-image">
										<img src="image/member/${mem.m_Image}" onerror="this.src='image/member/unknown.jpg'"/>
										<div class="nav-profile-text d-flex flex-column">
											<span class="font-weight-bold mb-2">${mem.m_Nickname}</span>
										</div>
										<span class="invisible">${mem.m_Email}</span>
									</div>
								</td>
								<td><span class="text-muted">님에게<br>친구 요청을<br>보냈습니다</span></td>
								<td><button id="fcancel" class="btn btn-sm btn-outline-danger flist">요청 취소</button></td>
							</c:when>
							</c:choose>
							</tr>
						
					</c:forEach>
				</table>
				</c:otherwise>
				</c:choose>
			</div>
		</div>	
	</div>


 		 </div>
<!-- main-panel ends -->

