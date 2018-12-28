<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se"
	uri="http://www.springframework.org/security/tags"%>
    <script src="http://code.jquery.com/jquery-2.2.4.js"></script>
      <script src="js/paging.js"></script>
	<script type="text/javascript">
// 	$(function(){
// 	    // 3.페이징 처리할 ajax셋팅
// 		 paging.ajax = ajaxList2;
// 		  ajaxList2();
// 	});
	 
	var ajaxList = function(){    
	    var submitData = {};
	    // 1.페이징시 필요 데이터 셋팅
	    submitData.index = paging.p.index;
	    submitData.pageStartNum = paging.p.pageStartNum;
	    $.ajax({
	        url: 'reviewlike.htm',
	        type: 'post',
	        data: submitData,
	        success : function(obj){
	        	$('.row').empty();
				$(obj).each(function(index,obj){ 
	        	console.log(obj.reviewlist);
				$(obj.reviewlist).each(function(index,obj){
					if(obj.m_Social==0){
					$('#reviewlist').append(' <div class="col-md-4 stretch-card grid-margin"> <div class="card-img-holder"><figure class="snip1200"><img src="image/review/main/'+obj.t_Image+'" class="card-img1" alt="circle-image"/><figcaption><p class="geth">'+obj.t_Content+'</p> <div class="heading"><h2>'+obj.t_Title+'('+obj.recount+')</h2> </div></figcaption><a href="reviewdetail.htm?t_Num='+obj.t_Num+'"></a> </figure> <br><br> <div class="float-left"><img class="flag" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'<img class="flag" src="image/flag/'+obj.t_Country+'.svg"></div><div class="float-right">등록일 : '+obj.t_Regdate+' <div class="text-right">조회수 : '+obj.t_Hit+'</div></div></div></div>')
					}
					else{
						$('#reviewlist').append(' <div class="col-md-4 stretch-card grid-margin"> <div class="card-img-holder"><figure class="snip1200"><img src="image/review/main/'+obj.t_Image+'" class="card-img1" alt="circle-image"/><figcaption><p class="geth">'+obj.t_Content+'</p> <div class="heading"><h2>'+obj.t_Title+'('+obj.recount+')</h2> </div></figcaption><a href="reviewdetail.htm?t_Num='+obj.t_Num+'"></a> </figure> <br><br> <div class="float-left"><img class="flag" src="'+obj.m_Image+'">'+obj.m_Nickname+'<img class="flag" src="image/flag/'+obj.t_Country+'.svg"></div><div class="float-right">등록일 : '+obj.t_Regdate+' <div class="text-right">조회수 : '+obj.t_Hit+'</div></div></div></div>')
							
					}
					})
	            // 2.페이징정보와 화면 ui셋팅
	            paging.p = obj.p;
	            paging.create();
	        });
	    }}
	    );    
	}
	
	var ajaxList1 = function(){    
	    var submitData = {};
	    // 1.페이징시 필요 데이터 셋팅
	    submitData.index = paging.p.index;
	    submitData.pageStartNum = paging.p.pageStartNum;
	    $.ajax({
	        url: 'reviewhit.htm',
	        type: 'post',
	        data: submitData,
	        success : function(obj){
	        	$('.row').empty();
				$(obj).each(function(index,obj){ 
					console.log(obj.reviewlist);
					$(obj.reviewlist).each(function(index,obj){
						if(obj.m_Social==0){
							$('#reviewlist').append(' <div class="col-md-4 stretch-card grid-margin"> <div class="card-img-holder"><figure class="snip1200"><img src="image/review/main/'+obj.t_Image+'" class="card-img1" alt="circle-image"/><figcaption><p class="geth">'+obj.t_Content+'</p> <div class="heading"><h2>'+obj.t_Title+'('+obj.recount+')</h2> </div></figcaption><a href="reviewdetail.htm?t_Num='+obj.t_Num+'"></a> </figure> <br><br> <div class="float-left"><img class="flag" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'<img class="flag" src="image/flag/'+obj.t_Country+'.svg"></div><div class="float-right">등록일 : '+obj.t_Regdate+' <div class="text-right">조회수 : '+obj.t_Hit+'</div></div></div></div>')
							}
							else{
								$('#reviewlist').append(' <div class="col-md-4 stretch-card grid-margin"> <div class="card-img-holder"><figure class="snip1200"><img src="image/review/main/'+obj.t_Image+'" class="card-img1" alt="circle-image"/><figcaption><p class="geth">'+obj.t_Content+'</p> <div class="heading"><h2>'+obj.t_Title+'('+obj.recount+')</h2> </div></figcaption><a href="reviewdetail.htm?t_Num='+obj.t_Num+'"></a> </figure> <br><br> <div class="float-left"><img class="flag" src="'+obj.m_Image+'">'+obj.m_Nickname+'<img class="flag" src="image/flag/'+obj.t_Country+'.svg"></div><div class="float-right">등록일 : '+obj.t_Regdate+' <div class="text-right">조회수 : '+obj.t_Hit+'</div></div></div></div>')
									
							}
						})
					
				
	            // 2.페이징정보와 화면 ui셋팅
	            paging.p = obj.p;
	            paging.create();
	        })
	        }
	    });
	    }
// 	var ajaxList2 = function(){    
// 	    var submitData = {};
// 	    // 1.페이징시 필요 데이터 셋팅
// 	    submitData.index = paging.p.index;
// 	    submitData.pageStartNum = paging.p.pageStartNum;
// 	    $.ajax({
// 	        url: 'reviewlist.htm',
// 	        type: 'post',
// 	        data: submitData,
// 	        success : function(obj){
// 	        	$('.row').empty();
// 				$(obj).each(function(index,obj){ 
// 					console.log(obj.reviewlist);
// 					$(obj.reviewlist).each(function(index,obj){
// 						$('#reviewlist').append(' <div class="col-md-4 stretch-card grid-margin"> <div class="card-img-holder"><figure class="snip1200"><img src="image/review/main/'+obj.t_Image+'" class="card-img1" alt="circle-image"/><figcaption><p class="geth">'+obj.t_Content+'</p> <div class="heading"><h2>'+obj.t_Title+'('+obj.recount+')</h2> </div></figcaption><a href="reviewdetail.htm?t_Num='+obj.t_Num+'"></a> </figure> <br><br> <div class="float-left"><img class="flag" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</div><div class="float-right">등록일 : '+obj.t_Regdate+' <div class="text-right">조회수 : '+obj.t_Hit+'</div></div></div></div>')
// 					})
// 	            // 2.페이징정보와 화면 ui셋팅
// 	            paging.p = obj.p;
// 	            paging.create();
// 	        });
// 	    }}
// 	    );    
// 	}  
	

	$(document).ready(function(){
		 
		
		  $('#like').click(function(){
		    // 3.페이징 처리할 ajax셋팅
		    paging.ajax = ajaxList;
		    ajaxList();
		});
// 		$('#like').click(function(){
// 			$.ajax(
// 					{
// 						type:"post",
// 						url:"reviewlike.htm",
// 						dataType:"json",
// 						success:function(data){ //{"result":""}
// 							$('.row').empty();
// 							$(data).each(function(index,obj){ 
// 								console.log(obj.reviewlist);
// 								$(obj.reviewlist).each(function(index,obj){
// 									$('#reviewlist').append(' <div class="col-md-4 stretch-card grid-margin"> <div class="card-img-holder"><figure class="snip1200"><img src="image/review/main/'+obj.t_Image+'" class="card-img1" alt="circle-image"/><figcaption><p class="geth">'+obj.t_Content+'</p> <div class="heading"><h2>'+obj.t_Title+'('+obj.recount+')</h2> </div></figcaption><a href="reviewdetail.htm?t_Num='+obj.t_Num+'"></a> </figure> <br><br> <div class="float-left"><img class="flag" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</div><div class="float-right">등록일 : '+obj.t_Regdate+' <div class="text-right">조회수 : '+obj.t_Hit+'</div></div></div></div>')
// 								})
								
// 							})
// 						}
// 					}	
// 				);
	 	
			
// 		}) 
		
		
		$('#hit').click(function(){
			 // 3.페이징 처리할 ajax셋팅
		    paging.ajax = ajaxList1;
		    ajaxList1();
// 			$.ajax(
// 					{
// 						type:"post",
// 						url:"reviewhit.htm",
// 						dataType:"json",
// 						success:function(data){ //{"result":""}
// 							$('.row').empty();
// 							$(data).each(function(index,obj){ 
// 								console.log(obj.reviewlist);
// 								$(obj.reviewlist).each(function(index,obj){
// 									$('#reviewlist').append(' <div class="col-md-4 stretch-card grid-margin"> <div class="card-img-holder"><figure class="snip1200"><img src="image/review/main/'+obj.t_Image+'" class="card-img1" alt="circle-image"/><figcaption><p class="geth">'+obj.t_Content+'</p> <div class="heading"><h2>'+obj.t_Title+'('+obj.recount+')</h2> </div></figcaption><a href="reviewdetail.htm?t_Num='+obj.t_Num+'"></a> </figure> <br><br> <div class="float-left"><img class="flag" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'</div><div class="float-right">등록일 : '+obj.t_Regdate+' <div class="text-right">조회수 : '+obj.t_Hit+'</div></div></div></div>')
// 								})
								
// 							})
// 						}
// 					}	
// 				);
	 	
			
		})
		
		$('#searchbut').click(function(){
			$.ajax(
					{
						type:"post",
						url:"reviewsearch.htm",
						dataType:"json",
						data: {"type":$('#search').val(),
							   "search":$('#searchval').val()},
						success:function(data){ //{"result":""}
							$('.row').empty();
							$(data).each(function(index,obj){ 
								console.log(obj.reviewlist);
								$(obj.reviewlist).each(function(index,obj){
									$('#reviewlist').append(' <div class="col-md-4 stretch-card grid-margin"> <div class="card-img-holder"><figure class="snip1200"><img src="image/review/main/'+obj.t_Image+'" class="card-img1" alt="circle-image"/><figcaption><p class="geth">'+obj.t_Content+'</p> <div class="heading"><h2>'+obj.t_Title+'('+obj.recount+')</h2> </div></figcaption><a href="reviewdetail.htm?t_Num='+obj.t_Num+'"></a> </figure> <br><br> <div class="float-left"><img class="flag" src="image/member/'+obj.m_Image+'">'+obj.m_Nickname+'<img class="flag" src="image/flag/'+obj.t_Country+'.svg"></div><div class="float-right">등록일 : '+obj.t_Regdate+' <div class="text-right">조회수 : '+obj.t_Hit+'</div></div></div></div>')
								})
								
							})
						}
					}	
				);
	 	
			
		})
		
	})
</script>
<c:if test="${param.insert != null}">
			
				<script type="text/javascript">
					swal("게시글이 등록되었습니다.","여행 잘다녀오셨나요?","success");
				</script>
</c:if>	
<c:if test="${param.update != null}">
	
				<script type="text/javascript">
					swal("게시글이 수정되었습니다.","","success");
				</script>
</c:if>	
<c:if test="${param.delete != null}">
			
				<script type="text/javascript">
					swal("게시글이 삭제되었습니다.","","success");
				</script>
</c:if>	
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
   
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">

      <!-- partial -->
      <div class="main-panel col-md-12" >
       <div class="bg-white pagename text-center">여행리뷰
         	</div>
        <div class="content-wrapper1">
           <div class="page-header">
         	  <div>
              <button id="hit" class="btn btn-gradient-primary btn-fw">조회순</button>
              &nbsp;&nbsp;&nbsp;
        	  <button id="like" class="btn btn-gradient-primary btn-fw">좋아요순</button>
           		</div>
           		<div class="search-field d-none d-md-block col-4">
					<form class="d-flex align-items-center h-100" action="#">
						<div class="input-group">
							<div class="input-group-prepend bg-transparent">
								<select id="search" class="searchb bg-transparent">
									<option value="t_Title">제목</option>
									<option value="t_Content">내용</option>
									<option value="m_Nickname">닉네임</option>
								</select>
							</div>
						<input type="text" id="searchval" class="form-control bg-transparent"
						placeholder="Search projects">
						<button type="button" id="searchbut" class="btn btn-gradient-primary btn-sm">검색</button>
					</div>
					</form>
				</div>
          		<se:authorize access="hasRole('ROLE_USER')">
          		<div><a href="reviewwrite.htm">
              	<button class=" btn btn-gradient-primary btn-fw">글작성</button>
              </a>
              </div>
              </se:authorize>
          
          </div>
        	
          <div class="row" id="reviewlist">
           <c:if test="${empty reviewlist}">
									<div class="col-md-12">
										<p class="lead text-muted text-center">조회된 결과가 없습니다.</p>
									</div>
		   </c:if>		
            <c:forEach items="${reviewlist}" var="r">
   			
            <div class="col-md-4 stretch-card grid-margin">
              
              <div class="card-img-holder"> 
                   <figure class="snip1200">
                  	<img src="image/review/main/${r.t_Image}" class="card-img1" alt="circle-image"/>
                    <figcaption>
   						 <p class="geth">${r.t_Content}</p>
   						 <div class="heading">
   						 	<h2>${r.t_Title}(${r.recount})</h2>
   						 </div>
    				</figcaption>
          			    <a href="reviewdetail.htm?t_Num=${r.t_Num}"></a> 
            		  </figure>
            
                  <br><br>
                
                 <div class="float-left">
                 <c:choose>						
							<c:when test="${r.m_Social==1}">
							 <img class="flag" src="${r.m_Image}" onerror="this.src='image/member/unknown.jpg'">
							</c:when>
							<c:otherwise>
							 <img class="flag" src="image/member/${r.m_Image}" onerror="this.src='image/member/unknown.jpg'">
							</c:otherwise>
							</c:choose>
                ${r.m_Nickname}<img class="flag" src="image/flag/${r.t_Country}.svg">
                 </div>
       			<div class="float-right">등록일 : ${r.t_Regdate}
                <div class="text-right">조회수 : ${r.t_Hit}</div>
                </div> 
                </div>
				            	
              </div>
         </c:forEach>  
 		 </div>
 		 <!--맨 첫페이지 이동 -->
<!--이전 페이지 이동 -->
<ul class="pagination preBtn"></ul>
<!--페이지번호 -->
<ul class="pagination index"></ul>
<!--다음 페이지 이동 -->
<!--마지막 페이지 이동 -->
<ul class="pagination nextBtn"></ul>
 		 
 							 <div class="row">
										<div class="col-md-12">
											<!-- 5. paging view -->
											<ul class="pagination ">
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
<!-- 											<div> -->
					
<!-- 												<select class='btn btn-primary' id='listCount' name='listCount' -->
<!-- 													onchange='listCnt();'> -->
<!-- 													<option selected disabled>페이지 수</option> -->
<!-- 													<option value='6'>6</option> -->
<!-- 													<option value='9'>9</option> -->
<!-- 													<option value='12'>12</option> -->
<!-- 													<option value='15'>15</option> -->
<!-- 												</select> -->
<!-- 											</div> -->
											<form action="reviewlist.htm" method="post" id='frmPaging'>
												<!--출력할 페이지번호, 출력할 페이지 시작 번호, 출력할 리스트 갯수 -->
												<input type='hidden' name='index' id='index' value='${p.index}'>
												<input type='hidden' name='pageStartNum' id='pageStartNum'
													value='${p.pageStartNum}'> <input type='hidden'
													name='listCnt' id='listCnt' value='${p.listCnt}'>
											</form>
										</div>
									</div>
 
 								
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
   
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
 </div>
  