<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
<link rel="stylesheet" href="css/style.css" />
<style type="text/css">
.pagination {
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem;
	justify-content: center;
}

.pagination>li {
	display: inline
}

.pagination>li>a, .pagination>li>span {
	position: relative;
	float: left;
	padding: 6px 12px;
	margin-left: -1px;
	line-height: 1.42857143;
	color: #337ab7;
	text-decoration: none;
	background-color: #fff;
	
}

.pagination>li:first-child>a, .pagination>li:first-child>span {
	margin-left: 0;
	border-top-left-radius: 4px;
	border-bottom-left-radius: 4px
}

.pagination>li:last-child>a, .pagination>li:last-child>span {
	border-top-right-radius: 4px;
	border-bottom-right-radius: 4px
}

.pagination>li>a:focus, .pagination>li>a:hover, .pagination>li>span:focus,
	.pagination>li>span:hover {
	color: #23527c;
	background-color: #eee;
/* 	border-color: #ddd */
}

.pagination>.active>a, .pagination>.active>a:focus, .pagination>.active>a:hover,
	.pagination>.active>span, .pagination>.active>span:focus, .pagination>.active>span:hover
	{
	z-index: 2;
	color: #fff;
	cursor: default;
	background-color: #337ab7;
/* 	border-color: #337ab7 */
}

.pagination>.disabled>a, .pagination>.disabled>a:focus, .pagination>.disabled>a:hover,
	.pagination>.disabled>span, .pagination>.disabled>span:focus,
	.pagination>.disabled>span:hover {
	color: #777;
	cursor: not-allowed;
	background-color: #fff;
/* 	border-color: #ddd */
}

.pagination-lg>li>a, .pagination-lg>li>span {
	padding: 10px 16px;
	font-size: 18px
}

.pagination-lg>li:first-child>a, .pagination-lg>li:first-child>span {
	border-top-left-radius: 6px;
	border-bottom-left-radius: 6px
}

.pagination-lg>li:last-child>a, .pagination-lg>li:last-child>span {
	border-top-right-radius: 6px;
	border-bottom-right-radius: 6px
}

.pagination-sm>li>a, .pagination-sm>li>span {
	padding: 5px 10px;
	font-size: 12px
}

.pagination-sm>li:first-child>a, .pagination-sm>li:first-child>span {
	border-top-left-radius: 3px;
	border-bottom-left-radius: 3px
}

.pagination-sm>li:last-child>a, .pagination-sm>li:last-child>span {
	border-top-right-radius: 3px;
	border-bottom-right-radius: 3px
}

.pager {
	padding-left: 0;
	margin: 20px 0;
	text-align: center;
	list-style: none
}

.pager li {
	display: inline
}

.pager li>a, .pager li>span {
	display: inline-block;
	padding: 5px 14px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 15px
}

.pager li>a:focus, .pager li>a:hover {
	text-decoration: none;
	background-color: #eee
}

.pager .next>a, .pager .next>span {
	float: right
}

.pager .previous>a, .pager .previous>span {
	float: left
}

.pager .disabled>a, .pager .disabled>a:focus, .pager .disabled>a:hover,
	.pager .disabled>span {
	color: #777;
	cursor: not-allowed;
	background-color: #fff
}

#listCount {
	position: relative;
	float: left;
	padding: 6px 12px;
	margin-left: -1px;
	line-height: 1.42857143;
	color: #337ab7;
	text-decoration: none;
	background-color: #fff;
/* 	border: 1px solid #ddd */
}

#listCount {
	float: right
}

.card .card-body {
	padding: 2.0rem 2.0rem;
}
</style>

<script>

		function go() {
			 if( $("#searchI").val() == "" ){
				 swal("검색어를 입력해주세요.","","warning");
				 $('#searchI').focus();
		            return;
		        }else{
		            $("input[name=searchFiled]").val($("#searchS").val());
		        }
		        var searchValue = $("#searchI").val();
		        $("input[name=searchValue]").val(searchValue);
		        alert(searchValue);
		         /* $("input[name=index]").val("1"); */ 
		        $("form").submit();
			 }
		
		$(document).ready(function(){
		    $("input[id=searchI]").keydown(function (key) {
		        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
		            go();
		        }
		 
		    });
		    
		    $(".dropdown-toggle").dropdown();
		    
		    	 $("#joinlist").click(function(event){
		    		var html="";
			    	$("input[name=searchFiled]").val('join');
			    	var queryString = $("form[id=frmPaging]").serialize() ;
	
			    	event.preventDefault();
			    	
			    	$.ajax({
			    		type:"post",
			    		url:"joinlist.htm",
			    		 data : queryString,
			             dataType : 'json',
			    		success : function(data){
			    				$("#row1").empty();
			    				$(data).each(function (key, obj) {
									$(obj.list).each(function (index, list) {
										console.log(list);
										console.log(list.g_Num);
										html= '<div class="col-md-4 stretch-card grid-margin"><div class="card-img-holder"><figure class="snip1200">'
										html +='<img class="card-img1" src="image/gowith/'+list.gi_image+'" alt="+circle-image">'
										html +='<figcaption><p class="geth">'+list.g_Content+'</p><div class="heading"><h2>'+list.g_Title+'</h2></div></figcaption>'
										html +='<a href="gowith_detail.htm?g_Num='+list.g_Num+'"></a></figure><br><br>'
										html +='<div class="float-left"><img class="flag" src="image/member/'+list.m_Image+'">'+list.m_Nickname+'</div>'
										html +='<div class="float-right">등록일 :'+list.g_Regdate+	'<div class="text-right">조회수 : '+list.g_Hit+'</div></div>'								  
								   		if(list.g_Status==='N'){
								   			html +='<div class="btn-group  mx-auto"><button type="button" class="btn btn-inverse-secondary my-2" style="margin-left: 110px;">모집완료</button></div></div></div>'
								   		}
								   		else{
								   			html +='<div class="btn-group  mx-auto"><button type="button" class="btn btn-inverse-secondary my-2" style="margin-left: 110px;">모집중</button></div></div></div>'
								   		}
								   		html+='</div>'
								   		$("#row1").append(html);
									})
								})
								
			    			},
			    	 error: function(xhr, status, error){
			                alert(error);
			            }
			    		});
		    	}); 
		    		
		}); 
	
</script>

</head>




<body>

	<!-- <main role="main"> -->

		<div class="container-scroller">
		<div class="bg-white pagename text-center" style="margin-top: 60px;"><a href="gowith_list.htm" style="color: black;">함께가기</a>
       	</div>
		<div class="album py-5 bg-light">
			<div class="container">
					<div class="page-header">
		         	  <div>
		              		<div class="btn-group">
							  <button type="button" class="btn btn-outline-primary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							  	정렬 &nbsp;
							  </button>
							  <div class="dropdown-menu">
							    <a class="dropdown-item" href="gowith_list.htm">최신순</a>
							    <a class="dropdown-item" id="joinlist" href="#">모집중만 보기</a>
							  </div>
							</div>
		           		</div>
		           		<div class="search-field d-none d-md-block">
								<div class="input-group">
									<div class="input-group-prepend bg-transparent">
										<select class="input-group-text border-0 mdi mdi-magnify bg-transparent" id="searchS"> 
											<option  class="input-group-text border-0 mdi mdi-magnify bg-transparent" value="ALL">전체검색</option>
											<option class="input-group-text border-0 mdi mdi-magnify bg-transparent" value="a.g_Title">제목</option>
											<option class="input-group-text border-0 mdi mdi-magnify bg-transparent" value="a.g_Content">내용</option>
											<option class="input-group-text border-0 mdi mdi-magnify bg-transparent"value="m.m_Nickname">닉네임</option>
										</select>
								<input type="text" id="searchI" class="form-control bg-transparent border-0" placeholder="Search projects">
									<a onclick="go()"><i  class="input-group-text border-0 mdi mdi-magnify bg-transparent"></i></a>
								</div>
								</div>
						</div>
							<div>
								<a href="gowith_write.htm">
				              		<button class=" btn btn-gradient-primary btn-fw">글작성</button>
				              	</a>
			             	 </div>
		          </div>
				<div class="row" id="row1">
					<c:forEach items="${list}" var="list">
						<div class="col-md-4 stretch-card grid-margin">
							<div class="card-img-holder">
								<figure class="snip1200">
									<img class="card-img1" src="image/gowith/${list.gi_image}"
										alt="circle-image">
									<figcaption>
										<p class="geth">${list.g_Content}</p>
										<div class="heading">
											<h2>${list.g_Title}</h2>
										</div>
									</figcaption>
									<a href="gowith_detail.htm?g_Num=${list.g_Num}"></a>
								</figure>

								<br>
								<br>

								<div class="float-left">
									<img class="flag" src="image/member/${list.m_Image}">
									${list.m_Nickname}
								</div>
								<div class="float-right">
									등록일 : ${list.g_Regdate}
									<div class="text-right">조회수 : ${list.g_Hit}</div>
								</div>
								<c:choose>
									<c:when test="${list.g_Speople eq list.g_Epeople}">
										<div class="btn-group  mx-auto">
											<button type="button" class="btn btn-inverse-secondary my-2"
												style="margin-left: 110px;">모집완료</button>
										</div>
									</c:when>
									<c:otherwise>
										<div class="btn-group  mx-auto">
											<button type="button" class="btn btn-inverse-primary my-2"
												style="margin-left: 110px;">모집중</button>
										</div>
									</c:otherwise>
								</c:choose>
							</div>

						</div>

					</c:forEach>
					<c:if test="${empty list}">
						<div class="col-md-12">
							<p class="lead text-muted text-center">조회된 결과가 없습니다.</p>
						</div>
					</c:if>
				</div>
				<!--페이징 처리-->
									<div class="row">
										<div class="col-md-12">
											<!-- 5. paging view -->
											<ul class="pagination">
												<c:if test="${p.pageStartNum ne 1}">
													<!-- 이전 페이지가 필요한지 아닌지 -->
													<!--맨 첫페이지 이동 -->
													<li><a onclick='pagePre(${p.pageCnt+1},${p.pageCnt});'>&laquo;</a></li>
													<!--이전 페이지 이동 -->
													<li><a onclick='pagePre(${p.pageStartNum},${p.pageCnt});'>&lsaquo;</a></li>
												</c:if>
					
												<!--보여지는 페이지번호 -->
												<c:forEach var='i' begin="${p.pageStartNum}"
													end="${p.pageLastNum}" step="1">
													<li class='pageIndex${i}'><a onclick='pageIndex(${i});'>${i}</a></li>
												</c:forEach>
					
												<c:if test="${p.lastChk}">
													<!--false/true 다음페이지가 필요한지 아닌지  -->
													<!--다음 페이지 이동 -->
													<li><a
														onclick='pageNext(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&rsaquo;</a></li>
													<!--마지막 페이지 이동 -->
													<li><a
														onclick='pageLast(${p.pageStartNum},${p.total},${p.listCnt},${p.pageCnt});'>&raquo;</a></li>
												</c:if>
											</ul>
										
											<form action="gowith_list.htm" method="post" id='frmPaging'>
												<!--출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
												<input type='hidden' name='index' id='index' value='${p.index}'>
												<input type='hidden' name='pageStartNum' id='pageStartNum' value='${p.pageStartNum}'> 
												<input type='hidden'name='listCnt' id='listCnt' value='${p.listCnt}'>
												<input type="hidden" name="searchFiled" value="${p.searchFiled }" /><!-- //검색조건 -->
    											<input type="hidden" name="searchValue" value="${p.searchValue }" /><!-- //검색어 -->
											</form>
										</div>
									</div>
								
							</div>
						</div>
				</div>
	<!-- </main> -->

</body>

   
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--부트4  -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/paging.js"></script>

</html>