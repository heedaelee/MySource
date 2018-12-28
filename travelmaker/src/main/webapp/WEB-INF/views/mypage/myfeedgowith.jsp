<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div class="main-panel ">
		<div class="content-wrapper1">
			<p>
			<h1 class="text-center my-md-5">내 글 목록</h1>
			<p>
			<div class="col-lg-8 m-auto">
				<div class="card">
					<div class="card-body">
						<a href="myfeedgowith.htm?m_Email=${dto.m_Email}"
							class="btn btn-outline-primary1 btn-sm font-weight-bold">함께가기</a>
						&nbsp;&nbsp;&nbsp; <a
							href="myfeedreview.htm?m_Email=${dto.m_Email}"
							class="btn btn-outline-primary btn-sm font-weight-bold">리 뷰</a>
						<hr>
						<h3 class="text-center">함께가기</h3>
						<hr>
						<br>
						<br>
						<c:choose>
							<c:when test="${empty go}">
								<h3>
									등록된 함께가기 게시물이 없습니다!<br> <br>함께가기 페이지에서 글을 작성해보세요!
								</h3>
							</c:when>
							<c:otherwise>
								<table class="table table-basic">
									<thead>
										<tr>
											<th>No</th>
											<th>제 목</th>
											<th>성 별</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="g" items="${go}">
											<tr>
												<td align="left" name="g_Num">${g.g_Num}</td>
												<td align="left" name="g_Title"><a
													href="mygowithdetail.htm?g_Num=${g.g_Num}">${g.g_Title}</a></td>
												<td align="left" name="g_Gender">${g.g_Gender}</td>
											</tr>
										</c:forEach>
										</c:otherwise>
										</c:choose>
									</tbody>
								</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>