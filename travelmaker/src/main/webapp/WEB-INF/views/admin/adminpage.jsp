<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>    
<script type="text/javascript">
	//검색 
	$(document).ready(function(){
		console.log($('#search_input').val());
		
		$('#search_btn').click(function(){
			
			if($('#search_input').val() === ""){
		  		swal("검색어를 입력해주세요.","","warning");
		  		$('#search_input').focus();
		  	}else{
				$.ajax({
					url : 'search.htm',
					type : 'get',
					dataType: 'json',
					data : { 'selectbox' : $('#selectbox').val(), 
							'keyword': $('#search_input').val() },  
					success : function(data) {	
							
						$('#table-striped').empty();
						
						var html = "";
	
						html += '<thead>' + '<tr>' + '<th>'+'닉네임'+'</th>'+'<th>'+'이메일'+'</th>' + '</tr>'+'</thead>';
						
						$('#table-striped').append(html);
						
						$(data.search).each(function(index, obj){
							console.log(obj);
	
						var html = "";
						
						html += '<tr>' + '<td align="left">' + '<a href="memberfeed.htm?m_Email='+obj.m_Email+'">' + obj.m_Nickname + '</a>'+'</td>';
						html +=	'<td align="left">' + obj.m_Email + '</td>';
						html += '<td>' + '<a href="mypage.htm?m_Email='+obj.m_Email+'" class="btn btn-gradient-primary btn-sm">' + '수 정' + '</a>'+'</td>';
						html += '<td>' + '<button class="btn btn-gradient-primary btn-sm delete" data-toggle="modal" data-target="#delete">' + '회원삭제' + '</button>'+'</td>';
						html += '<td>' + '<button class="btn btn-gradient-primary btn-sm blacklist" data-toggle="modal" data-target="#blackList">' + '블랙리스트' + '</button>' + '</td>';
						html += '</tr>' 
						
						$('#table-striped').append(html);
					
						});  // foreach 반복문 끝	
					},
					error:function(ErrorMsg){
	 					console.log('Error', ErrorMsg);
	 				}
				});
		  	}
	    });
		
	$(document).on('click','.delete',function(){
			
			var pk = $(this).parent().parent().children().eq(1).text();
			var tr = $(this).parent().parent();
// 			alert(pk);
			
			swal({
				  title: "회원을 삭제 하시겠습니까?",
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
							url: "adminDeleteMember.htm",
							dataType:"json",
							data:{"m_Email" : pk},
							success:function(data){
								
								if(data){
									
							        // 삭제 버튼을 누른 row 제거
							        tr.remove();
							        swal("삭제되었습니다.","","success");
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
		
		
// 	블랙리스트 추가
	var pk;
	var tr;
	
	 $(document).on('click','.blacklist',function(){
		
		tr = $(this).parent().parent();
		pk = tr.children().eq(1).text();
		 
	 });  
	
	$('#blackinsert').click(function(){
		 $.ajax({
			 	type:"post",
				url:"blackcheck.htm",
				data:{ "m_Email" : pk },
				success:function(data){ 
					
					console.log(data);
					if(data == "success"){
						swal("이미 블랙리스트로 등록 된 회원입니다.","","warning");
						$("#close").click();
					}else{
						$.ajax(
								{  
								type:"post",
								url:"blackinsert.htm",
								data:{ "b_Reason" : $('#b_Reason').val(), 
									   "m_Email" : pk },
								success:function(data){ 
								
									console.log(data);
									if(data == "success"){
										location.href="blacklist.htm?success";
										
	//										swal("닉네임 변경 성공.","", "success");
									}else if(data=="admin"){
										location.href="adminpage.htm";
									}else{
										swal("이미 블랙리스트로 등록 된 회원입니다.","", "warning");								
									}
					            	},
						           	error:function(request,status,error){
						           		swal("실패하였습니다.","","warning");
								        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); 
								    }
								});	
							}
							$('#b_Reason').val('');
	         		},
	         		
		           	error:function(request,status,error){
		           		swal("실패하였습니다","","warning");
				        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); 
					}
			});
		});
	})
	</script>
	
	 <!-- partial -->
      <div class="main-panel ">
        <div class="content-wrapper1">
			<p><h1 class=text-left>회원 관리</h1><p>
		  <div class="col-lg-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
					<div class="form-group">
	                    <div class="input-group">
	                    <select id="selectbox" class="searchb bg-transparent">
	                    	<option id="nickname" value="m_Nickname">닉네임</option>
	                    	<option id="email" value="m_Email">이메일</option>
	                    </select>
	                      <input id="search_input" type="text" class="form-control col-6" placeholder="닉네임 또는 이메일을 입력해주세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
	                      <div class="input-group-append">
	                        <button id="search_btn" class="btn btn-sm btn-gradient-primary" type="button">검 색</button>
	                      </div>
	                   </div>
	                </div>					
            <table id="table-striped" class="table table-striped">
                    <thead>
                      <tr>
                        <th>닉네임</th>
                        <th>이메일</th>
                      </tr>
                    </thead>
                <c:forEach var="m" items="${member}">
					<tr>
						<td align="left">
							<a href="memberfeed.htm?m_Email=${m.m_Email}">${m.m_Nickname}</a>
						</td>
						<td align="left" name="m_Email">${m.m_Email}</td>
						<td><input type="hidden" id="nickEmail" name="m_Email" value="${m.m_Email}"></td>
						<td><a href="mypage.htm?m_Email=${m.m_Email}" class="btn btn-gradient-primary btn-sm update">수 정</a></td>
						<td><button class="btn btn-gradient-primary btn-sm delete">회원삭제</button></td>
						<td><button class="btn btn-gradient-primary btn-sm blacklist" data-toggle="modal" data-target="#blackList">블랙리스트</button></td>
					</tr>
				</c:forEach>
           </table>
                </div>
              </div>
            </div>
		   </div>

 		 
		 <!-- Modal 블랙리스트 -->
	 <div class="modal fade" id="blackList" role="dialog">
		 <div class="modal-dialog">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h2 class="modal-title">블랙리스트 등록</h2>
	          <button type="button" id="close" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <div class="modal-body">
	          <div class="form-group">
          		  <h4>등록 사유</h4>
                  <input type="text" class="form-control md-6" id="b_Reason" name="M_Nickname" placeholder="등록사유를 입력해주세요.">
              </div>
	        </div>
	        <div class="modal-footer">
	           <button type="button" id="blackinsert" class="btn btn-gradient-primary mr-2">등 록</button>
               <button class="btn btn-light" data-dismiss="modal">취 소</button>
	        </div>
	      </div>
	 </div>
 </div>
 	 
 	 
 </div>  <!-- End -->
 		 
    
