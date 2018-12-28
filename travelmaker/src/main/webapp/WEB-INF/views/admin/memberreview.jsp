<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	document.getElementById('myfeedbtn').className = 'nav-item active';
});

</script>
</head>
<body>
	<div class="main-panel ">
        <div class="content-wrapper1">
			<p><h1 class="text-center my-md-5">회원 글 목록<br><br><small class="text-muted">${dto2.m_Nickname}&nbsp;님이 작성한 글</small></h1><p>
			
		  <div class="col-lg-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
					<a href="memberfeed.htm?m_Email=${dto2.m_Email}" class="btn btn-outline-primary btn-sm font-weight-bold">함께가기</a>
					&nbsp;&nbsp;&nbsp;
					<a href="" class="btn btn-outline-primary1 btn-sm font-weight-bold">리 뷰</a><br><br>
				<c:choose>
				<c:when test="${empty review}">
					<h3 class="my-md-3">회원이 등록한 리뷰 글이 없습니다.</h3>
				</c:when>
				<c:otherwise>
				<table class="table table-striped">
                    <thead>
                      <tr>
                        <th class="font-weight-bold">글번호</th>
                        <th class="font-weight-bold">제 목</th>
                        <th class="font-weight-bold">작성일</th>
                      </tr>
                    </thead>
		            <tbody>
		                <c:forEach var="r" items="${review}">
							<tr>
								<td align="left" name="t_Num">${r.t_Num}</td>
								<td align="left" name=t_Title><a href="memberreviewdetail.htm?t_Num=${r.t_Num}&?m_Email=${r.m_Email}">${r.t_Title}</a></td>
								<td align="left" name="t_Regdate">${r.t_Regdate}</td>
							</tr>
						</c:forEach>
		             </tbody>
               </table>
               </c:otherwise>
               </c:choose>
           </div>
         </div>
       </div>
     </div>
 </div>
</body>
</html>