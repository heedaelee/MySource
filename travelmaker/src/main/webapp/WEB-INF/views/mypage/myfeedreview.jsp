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
			<p><h1 class="text-center my-md-5">내 글 목록</h1><p>
			
		  <div class="col-lg-8 m-auto">
              <div class="card">
                <div class="card-body">
					<a href="myfeedgowith.htm?m_Email=${dto.m_Email}" class="btn btn-outline-primary btn-sm font-weight-bold">함께가기</a>
					&nbsp;&nbsp;&nbsp;
					<a href="myfeedreview.htm?m_Email=${dto.m_Email}" class="btn btn-outline-primary1 btn-sm font-weight-bold" >리 뷰</a>
					<hr><h3 class="text-center">여행리뷰</h3><hr><br><br>
				<c:choose>
				<c:when test="${empty review}">
				<h3>등록된 리뷰 게시물이 없습니다!<br><br>리뷰 페이지에서 리뷰를 등록해보세요!</h3>
				</c:when>
				<c:otherwise>
				<table class="table table-basic">
                    <thead>
                      <tr>
                        <th>No</th>
                        <th>제 목</th>
                        <th>작성일</th>
                      </tr>
                    </thead>
	                <tbody>
	                <c:forEach var="g" items="${review}">
						<tr>
							<td align="left" >${g.t_Num}</td>
							<td align="left" ><img class="flag" src="image/flag/${g.t_Country}.svg"><a href="myreviewdetail.htm?t_Num=${g.t_Num}">${g.t_Title}</a></td>
							<td align="left" name="g_Regdate">${g.t_Regdate}</td>
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