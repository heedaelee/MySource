<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
	<ul class="nav">
		<li class="nav-item nav-profile"><a
			href="mypage.htm?m_Email=${dto.m_Email}" class="nav-link">
				<div class="nav-profile-image">
<%-- 					<c:choose> --%>
<%-- 						<c:when --%>
<%-- 							test="<%=session.getAttribute(\"social\").equals(\"true\")%>"> --%>
<%-- 							<img src="${dto.m_Image}" --%>
<!-- 								onerror="this.src='image/member/unknown.jpg'"> -->

<%-- 						</c:when> --%>
<%-- 						<c:when --%>
<%-- 							test="<%=session.getAttribute(\"social\").equals(\"false\")%>"> --%>
							<img src="image/member/${dto.m_Image}"
								onerror="this.src='image/member/unknown.jpg'" />
<%-- 						</c:when> --%>
<%-- 					</c:choose> --%>
					<span class="login-status online"></span>
					<!--change to offline or busy as needed-->
				</div>
				<div class="nav-profile-text d-flex flex-column">

					<span class="font-weight-bold mb-2">${dto.m_Nickname}</span>
					<!--                 <span class="text-secondary text-small">Project Manager</span> -->
				</div> <i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
		</a></li>
		<li class="nav-item"><a class="nav-link"
			href="mypage.htm?m_Email=${dto.m_Email}"> <span
				class="menu-title">내 정보 수정</span> <i
				class="mdi mdi-account-card-details menu-icon"></i>
		</a></li>
		<li class="nav-item"><a class="nav-link"
			href="schedule.htm?m_Email=${dto.m_Email}"> <span
				class="menu-title">여행 일정</span> <i
				class="mdi mdi-calendar-text menu-icon"></i>
		</a> <!-- <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">Buttons</a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/ui-features/typography.html">Typography</a></li>
              </ul>
            </div> --></li>
		<li class="nav-item"><a class="nav-link"
			href="friendlist.htm?m_Email=${dto.m_Email}"> <span
				class="menu-title">친구 목록</span> <i
				class="mdi mdi-account-multiple menu-icon"></i>
		</a></li>
		<li class="nav-item"><a class="nav-link"
			href="visited.htm?m_Email=${dto.m_Email}"> <span
				class="menu-title">방문한 여행지</span> <i
				class="mdi mdi-crosshairs-gps menu-icon"></i>
		</a></li>
		<li id="myfeedbtn" class="nav-item"><a class="nav-link"
			href="myfeedgowith.htm?m_Email=${dto.m_Email}"> <span
				class="menu-title">내 글 목록</span> <i
				class="mdi mdi-file-document menu-icon"></i>
		</a></li>
		<!-- <li class="nav-item">
            <a class="nav-link" href="pages/charts/chartjs.html">
              <span class="menu-title">Charts</span>
              <i class="mdi mdi-chart-bar menu-icon"></i>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="pages/tables/basic-table.html">
              <span class="menu-title">Tables</span>
              <i class="mdi mdi-table-large menu-icon"></i>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#general-pages" aria-expanded="false" aria-controls="general-pages">
              <span class="menu-title">Sample Pages</span>
              <i class="menu-arrow"></i>
              <i class="mdi mdi-medical-bag menu-icon"></i>
            </a>
            <div class="collapse" id="general-pages">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="pages/samples/blank-page.html"> Blank Page </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/login.html"> Login </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/register.html"> Register </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/error-404.html"> 404 </a></li>
                <li class="nav-item"> <a class="nav-link" href="pages/samples/error-500.html"> 500 </a></li>
              </ul>
              </div>
          </li>
          <li class="nav-item sidebar-actions">
            <span class="nav-link">
              <div class="border-bottom">
                <h6 class="font-weight-normal mb-3">Projects</h6>                
              </div>
              <button class="btn btn-block btn-lg btn-gradient-primary mt-4">+ Add a project</button>
              <div class="mt-4">
                <div class="border-bottom">
                  <p class="text-secondary">Categories</p>                  
                </div>
                <ul class="gradient-bullet-list mt-4">
                  <li>Free</li>
                  <li>Pro</li>
                </ul>
              </div>
            </span>
          </li> -->
	</ul>
</nav>