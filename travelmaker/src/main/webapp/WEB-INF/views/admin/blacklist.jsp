<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<script type="text/javascript">

$(document).ready(function(){
	$('.deleteblack').click(function(){
		
		var bk = $(this).parent().parent().children().first().text();
		var tr = $(this).parent().parent();
		
		swal({
			  title: "블랙리스트 해제 하시겠습니까?",
			  text: "",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonColor: "#3085d6",
			  confirmButtonText: "삭제",
			  confirmButtonColor : "#d33",
			  cancelButtonText: "취소",
			}).then((result) => { 
			
			  if (result.value) {
				$.ajax(
						{
						type:"post",
						url: "deleteblack.htm",
						dataType:"json",
						data:{"b_Num" : bk},
						success:function(data){
							
							if(data){
						        // 삭제 버튼을 누른 row 제거
						        tr.remove();
						      }
						    },
						    error: function( err ){
						      console.log(err)
						},
					}	
				);
		  } else {
		    swal("취소", "", "error");
		  }
		});
	})
});


</script>
	
<c:if test="${param.success!=null}">
	<script>
		swal("블랙리스트 추가 성공","","success")
	</script>
</c:if>
	 <!-- partial -->
      <div class="main-panel ">
        <div class="content-wrapper1">
		<p><h1 class=text-left>블랙리스트</h1><p>
		  <div class="col-lg-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
					<div class="form-group">
			        	<div class="input-group">
	                    	<div class="input-group">
		                    <select id="selectbox" class="searchb bg-transparent">
		                    	<option id="email" value="m_Email">이메일</option>
		                    </select>
	                        <input id="search_input" type="text" class="form-control col-6" placeholder="이메일을 입력해주세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
	                        <div class="input-group-append">
	                        <button id="search_btn" class="btn btn-sm btn-gradient-primary" type="button">검 색</button>
	                      </div>
	                   </div>
	                </div>
	              <c:choose>
	             <c:when test="${empty black}">
	             	<h3 class="my-md-4">블랙리스트로 등록된 회원이 없습니다.<br><small class="text-muted my-md-4">회원 관리 메뉴에서 블랙리스트를 등록하실 수 있습니다.</small></h3>
	             </c:when>
	              <c:otherwise>
                  <table id="table-striped" class="table table-striped">
                    <thead>
                      <tr>
                        <th>No</th>
                        <th>이메일</th>
                        <th>사 유</th>
                      </tr>
                    </thead>
                <c:forEach var="b" items="${black}">
					<tr>
                      	<td>${b.b_Num}</td>
						<td align="left">${b.m_Email}</td>
						<td align="left">${b.b_Reason}</td>
						<td><button type="button" class="btn btn-gradient-primary btn-sm deleteblack"> 해  제 </button></td>
<!-- 						<td><button type="button" class="btn btn-gradient-primary btn-sm deleteblack"> 해  제 </button></td> -->
					</tr>
				</c:forEach>
                  </table>
                   </c:otherwise>
                </c:choose>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
          
			
<!-- 보더테이블 ------------------------------------------------------------------------------> 	
     <!-- Modal Nickname -->
 		 <div class="modal fade" id="delete" role="dialog">
 		 <div class="modal-dialog">
 		 <!-- Modal Nickname content-->
		      <div class="modal-content">
		      <form method="post">
		        <div class="modal-header">
		          <h2 class="modal-title">블랙리스트 해제</h2>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
					<h4>블랙리스트에서 해제하시겠습니까?</h4>
		        </div>
		        <div class="modal-footer" style="margin:auto;">
		           <button type="button" id="memberDelete" class="btn btn-gradient-primary mr-2" data-dismiss="modal">삭 제</button>
                   <button class="btn btn-light" data-dismiss="modal">취 소</button>
		        </div>
		        </form>
		      </div>
 		 </div>
 		 </div>
    

