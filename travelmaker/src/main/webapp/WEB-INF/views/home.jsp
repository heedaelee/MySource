<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
<style>
.absol {
	position: absolute;
	transform: translate(5%, -130%);
	font-size: 1rem;
	color: white;
	z-index: 2;
	text-align: left;
}

.fa-venus {
	color: red;
}

.fa-mars {
	color: blue;
}

.absol2 {
	position: absolute;
	transform: translate(5%, -250%);
	font-size: 1rem;
	color: #1a7ad9;
	z-index: 2;
	text-align: left;
}

.mainimage {
	position: relative;
	background-size: cover;
}

.content-wrapper1 {
	padding-top: 00px;
	padding-left: 0px;
	padding-right: 0px;
}

.card-img {
	height: 170px;
	width: 348px;
	display: block;
}

.second {
	height: 200px;
}

.travel {
	margin: 0 auto;
}

h3 {
	font-weight: bold;
	font-size: 18px;
	text-align: center;
	color: #1a7ad9;
	padding-top: 30px;
}

.clear {
	clear: both;
}

.card {
	border: 1px solid #dfdfdf;
	padding-left: 0px;
	padding-right: 0px;
}

.card-body {
	padding: 1rem 1rem !important;
}

.card-title {
	color: #6F6F6F !important;
}

.card-text {
	color: #6F6F6F !important;
	margin-top: 4px !important;
	font-weight: 100;
}

#columns {
	column-width: 350px;
	/* column-count:3; */
	column-gap: 15px;
}

#columns figure {
	display: inline-block;
	border: 1px solid rgba(0, 0, 0, 0.2);
	margin: 0;
	margin-bottom: 15px;
	padding: 10px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);;
}

#columns figure img {
	width: 100%;
}

#columns figure figcaption {
	border-top: 1px solid rgba(0, 0, 0, 0.2);
	padding: 10px;
	margin-top: 11px;
}
</style>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>


<!--ytplayer -->
<link href="css/jquery.mb.YTPlayer.css" media="all" rel="stylesheet"
	type="text/css">

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="js/jquery.mb.YTPlayer.js">
	
</script>
<script>
	$(function() {
		$("#bgndVideo").YTPlayer();
	});
</script>
<div class="container-fluid page-body-wrapper">

	<!-- partial -->
	<div class="main-panel col-md-12">
		<div class="content-wrapper1">
			<div class="row">
				<div class="col-12">
					<div id=video style="width: 100%; height: 480px; margin: 0 auto;">
					</div>
				</div>
			</div>


			<!--ytn플레이어  -->
			<div id="bgndVideo" class="player"
				data-property="{videoURL:'https://www.youtube.com/watch?v=wFyzZFpLeBk&t=121s',optimizeDisplay : true,containment:'#video',autoPlay:true,
													showControls: true, mute:true, startAt:49,stopAt:155, opacity:1, loop:true,showControls :false,showYTLogo :true,addRaster :false,anchor : 'center, center'
													}"></div>

			<div class="album py-5 bg-light">
				<div class="container">

					<div class="row">


						<div class="travel col-md-12 text-center" style="margin-top: 15px">
							<br>
							<h2>
								<strong>Travelmaker와 여행을 시작하세요!</strong>
							</h2>
							<br> <br>

						</div>
						<div class="row ">
							<div class="col-md-4 stretch-card grid-margin">
								<div class="card-img-holder">
									<a href="gowith_list.htm"> <img
										src="images/main/gowith.jpg" class="card-img"
										alt="circle-image" />
										<h3>함께가기</h3>
										<p class="card-text">같이 가고픈 사람을 찾아 즐거운 여행을 떠나보세요</p>
									</a>
								</div>
							</div>
							<div class="col-md-4 stretch-card grid-margin">
								<div class="card-img-holder">
									<a href="reviewlist.htm"> <img src="images/main/review.jpg"
										class="card-img" alt="circle-image" />
										<h3>여행리뷰</h3>
										<p class="card-text">사람들의 다양한 여행지에 대한 리뷰를 보고 나만의 여행을 그려보세요</p>
									</a>
								</div>
							</div>

							<div class="col-md-4 stretch-card grid-margin">
								<div class="card-img-holder">
									<se:authorize access="isAuthenticated()">
										<a href="schedule.htm">
									</se:authorize>
									<se:authorize access="isAnonymous()">
										<a href="index.htm?login">
									</se:authorize>
									<img src="images/main/plan.jpg" class="card-img"
										alt="circle-image" />
									<h3>여행일정</h3>
									<p class="card-text">캘린더를 활용하여 여행 일정을 계획해보세요</p>
									</a>
								</div>
							</div>
						</div>
					</div>
					<hr>

					<div class="row">
						<div class="travel col-md-12 text-center" style="margin-top: 60px">
							<h2>
								<strong>인기 여행 리뷰</strong>
							</h2>
							<p class="text-muted">다양한 여행지를 찾아보세요</p>
							<br>
						</div>

						<div id="columns">
							<c:forEach items="${list}" var="r">

								<figure>
									<a href="reviewdetail.htm?t_Num=${r.t_Num}">
										<div>
											<img class="mainimage" src="image/review/main/${r.t_Image}">
											<span class="absol">${r.t_Title}</span>
										</div>
										<figcaption>
											<!--         <span class="card-text">가족여행</span> -->
											<span style="color: gray; float: right"><i
												class="far fa-thumbs-up">${r.t_Status}</i>&nbsp;<i
												class="far fa-eye">${r.t_Hit}</i></span>
											<div class="clear"></div>
											<div class="card-text">${r.t_Country}</div>
											<div class="clear"></div>
											<div class="card-text" style="color: gray;">
												<i class="far fa-user"></i>${r.m_Nickname}</div>
										</figcaption>
									</a>
								</figure>

							</c:forEach>
						</div>
						<div class=" card mx-auto grid-margin;" style="margin-top: 20px">
							<div class="card-body" style="padding: 10px !important;">
								<p class="card-text">
									<a href="reviewlist.htm">인기글 더 보기</a>
								</p>
							</div>
						</div>
					</div>

					<br>
					<hr>
					<br>
					<div class="row">


						<div class="travel col-md-12 text-center" style="margin-top: 50px">
							<h2>
								<strong>함께가기</strong>
							</h2>
							<p class="text-muted">같이 가고픈 사람을 찾아 즐거운 여행을 떠나보세요</p>
							<br>

						</div>


						<div id="columns">
							<c:forEach items="${glist}" var="r">

								<figure>
									<a href="gowith_detail.htm?g_Num=${r.g_Num}">
										<div>
											<img class="mainimage" src="image/gowith/${r.gi_image}">
											<span class="absol2">${r.g_Sdate} ~ ${r.g_Edate}</span> <span
												class="absol">${r.g_Title}</span>
										</div>
										<figcaption>
											<!-- 											<span class="card-text">가족여행</span> -->
											<span style="color: gray; float: right"><i
												class="fas fa-users">${r.g_Speople}/${r.g_Epeople}</i> <i
												class="far fa-eye">${r.g_Hit}</i></span>
											<div class="clear"></div>
											<div class="card-text">
												<c:if test="${r.g_Gender eq 'man'}">
													<i class="fas fa-mars fa-1x icon-blue"></i>
												</c:if>
												<c:if test="${r.g_Gender eq 'woman'}">
													<i class="fas fa-venus fa-1x"></i>
												</c:if>
												<c:if test="${r.g_Gender eq 'all'}">
													<i class="fas fa-venus-mars fa-1x "></i>
												</c:if>

											</div>
											<div class="clear"></div>
											<div class="card-text" style="color: gray;">
												<i class="far fa-user"></i>${r.m_Nickname}</div>
										</figcaption>
									</a>
								</figure>

							</c:forEach>

						</div>
						<div class=" card mx-auto grid-margin;" style="margin-top: 20px">
							<div class="card-body" style="padding: 10px !important;">
								<p class="card-text">
									<a href="gowith_list.htm">함께가기 더 보기</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- content-wrapper ends -->
				<!-- partial:partials/_footer.html -->
			</div>
			<!-- partial -->
		</div>
		<!-- main-panel ends -->
	</div>
	<!-- container-scroller -->