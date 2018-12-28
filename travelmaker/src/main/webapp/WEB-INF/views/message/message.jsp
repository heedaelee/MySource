<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Tabs - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="//cdn.datatables.net/select/1.2.1/css/select.dataTables.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.all.min.js"></script>
<!--   <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script> -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.11/dist/sweetalert2.min.css">
  
  <link rel="stylesheet" href="css/style.css"/>
  
  <style type="text/css">
  #tabs{height: 96vh;}
  body{
  font-size: 14px;
  }
  td{
  text-align: center;
  font-size: 14px;
  }
  table tr td:nth-child(1){
  font-size: 16px;
  }
  table{
  width: 100%
  }
  
  #myTable3_filter{
  text-align: center;
  float: none;
  }
  
  .dt-buttons{display: inline;}
  .d1{width: 5% }
  .d2{width: 10% }
  .d3{width: 55% }
  .d4{width: 30% }
  
  myTable3 th{
  width: 45%
  }
  
  </style>
  <script src="vendors/js/vendor.bundle.base.js"></script>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
  <script src="//cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
  <script src="//cdn.datatables.net/select/1.2.1/js/dataTables.select.min.js"></script>
  <script>

  
  $(document).ready( function () {
	    var table = $('#myTable').DataTable({
	    	dom: 'Bfrtp',
	    	 
	    	"ordering": false,
	    	"paging": true,
	    	"searching": true,
	    	 "language": {
	             "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"
	         },
	    	info : false,
	    	 ajax : {
                 "url":"ms_list.htm",
                 "type":"POST"
	    	},
	    	  "columnDefs":[
	          	{"orderable":false, "targets":0, "width":"5%", className:'select-checkbox'},
	          	{"orderable":false, "targets":1, "visible": false},
	          	{"orderable":false, "targets":2, "width":"10%", className:'dt-center'},
	          	{"orderable":false, "targets":3, "width":"55%", className:'dt-center'},
	          	{"orderable":false, "targets":4, "width":"30%", className:'dt-center'},
	          	{"orderable":false, "targets":5, "visible": false}
	          	],
	          	select: {
	                style: 'os',
	                selector: 'td:first-child'
	              },
	    	columns : [
	    		{defaultContent:''},
	    		{data:"N_NUM"},
	    		{data:"M_SEMAIL"},
	    		{data:"N_CONTENT"},
	    		{data:"M_REGDATE"},
	    		{data:"N_STATUS"}
	    	],
	    	buttons: [
	             {
	                 text: '삭제',
	                 className: 'btn btn-gradient-primary btn-sm delete',
	             }
	         ]
	    });
	    
	   
	    
	    var table2 =  $('#myTable2').DataTable({
	    	dom: 'Bfrtp',
	    	"ordering": false,
	    	"paging": true,
	    	"searching": true,
	    	 "language": {
	             "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"
	         },
		    	info : false,
		    	 ajax : {
	                 "url":"ms_Slist.htm",
	                 "type":"POST",
		    	},
		    	  "columnDefs":[
		          	{"orderable":false, "targets":0, "width":"5%", className:'select-checkbox d1'},
		          	{"orderable":false, "targets":1, "visible": false},
		          	{"orderable":false, "targets":2, "width":"10%", className:'dt-center d2'},
		          	{"orderable":false, "targets":3, "width":"55%", className:'dt-center d3'},
		          	{"orderable":false, "targets":4, "width":"30%", className:'dt-center d4'},
		          	{"orderable":false, "targets":5, "visible": false}
		          	],
		          	select: {
		                style: 'os',
		                selector: 'td:first-child'
		              },
		    	columns : [
		    		{defaultContent:''},
		    		{data:"N_NUM"},
		    		{data:"M_REMAIL"},
		    		{data:"N_CONTENT"},
		    		{data:"M_REGDATE"},
		    		{data:"N_STATUS"}
		    	],
		    	buttons: [
		             {
		                 text: '삭제',
		                 className: 'btn btn-gradient-primary btn-sm delete',
		             }
		         ]
	    });
	    
	    $('#myTable3').DataTable({
	    	"ordering": false,
	    	"paging": true,
	    	"searching": true,
	    	 "language": {
	             "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Korean.json"
	         },
	         info : false,
	         "bLengthChange": false,
	         ajax : {
                 "url":"ms_Flist.htm",
                 "type":"POST",
	    	},
	    	"columnDefs":[
	    		{"orderable":false, "targets":0, "width":"10%"},
	          	{"orderable":false, "targets":1, "width":"45%", "data": "m_Image", 
	          		"render": function ( data, type, row, meta ) {
	                return '<img height="50px" width="50px" src="image/member/'+data+'"/>';
	            }},
	    		{"orderable":false, "targets":2, "width":"45%"}
	          	],
	    	columns : [
	    		{defaultContent:'<input type="radio" name="radio">'},
	    		{data:'m_Image'},
	    		{data:"m_Nickname"},
	    		
	    	]

	    });
		
	    $( "#tabs" ).tabs();
	    
	    
	    $(document).on("click", ".delete", function(){
	    	var tblData = table.rows('.selected').data();
	    	var tblData2 = table2.rows('.selected').data();
	    	console.log(tblData);
	    	console.log('data2'+tblData2);
		    	  alert(table.rows('.selected').data());
		    	  var num = new Array();
		    		  $.each(tblData, function(i, val) {
			    		  console.log("??"+tblData[i].N_NUM);
			    		  num.push(tblData[i].N_NUM);
		    		  });
		    	  
		    		  $.each(tblData2, function(i, val) {
			    		  console.log("??"+tblData2[i].N_NUM);
			    		  num.push(tblData2[i].N_NUM);
		    	  	});
		    		  console.log(num);
		    		  if(num!=''){
		    			  swal({
		    				  title: "정말로 삭제하시겠습니까?",
		    				  text: "",
		    				  type: "warning",
		    				  showCancelButton: true,
		    				  confirmButtonColor: "#3085d6",
		    				  confirmButtonText: "삭제",
		    				  confirmButtonColor : "#d33",
		    				  cancelButtonText: "취소",
		    				}).then((result) => { 
		    				  if (result.value) {
		    					  $.ajax({
						    	        url:"message_delete.htm",
						    	        type:'POST',
						    	        dataType : 'text',
						    	        data: {'num':num},
						    	        success:function(data){
						    	        	swal("삭제 완료 되었습니다")
						    	        	.then((value) => {
						    	        		location.href="message_list.htm"
						    	        	});
						    	        }
						    	    })
		    					}
		    					else {
		    					    swal("취소", "", "error");
		    					  }
		    				});
		    		  }
		    		  else{
		    			  swal("Error!", "선택해주세요!", "error");	
		    			  return;
		    		  }
		    		  
		    	 
	    	})
	    
	    $('#choice').click(function(){
	    	 var rowData = new Array(); 
	         var tdArr = new Array();
	         var radio = $("input[name=radio]:checked");

	             // checkbox.parent() : checkbox의 부모는 <td>이다.
	             // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
	             var tr = radio.parent().parent();
	             var td = tr.children();
	                     
	             console.log("클릭한 Row의 모든 데이터 : "+tr.text());
	             
	             var nick = td.eq(2).text();
	             console.log("닉네임 : "+td.eq(2).text());
	             
	             $("input[name=m_Remail]").val(td.eq(2).text());
	             
	    })
	    	
	    	
	    $('#submit').click(function(event){
	    	var m_Nickname = $("input[name=m_Remail]").val()
	    	var n_Content = $("#n_Content").val()
	    	
	    	console.log('닉네임'+m_Nickname)
	    	  $.ajax({
	    	        url:"message_insert.htm",
	    	        type:'POST',
	    	        dataType :'json',
	    	        data: {'m_Nickname':m_Nickname,
	    	        		'n_Content':n_Content},
	    	        success:function(data){
	    	        	swal("메시지를 보냈습니다")
	    	        	.then((value) => {
	    	        		/* location.href="message_list.htm" */ 
	    	        		$('#link').trigger('click');//강제 클릭 이벤트
	    	        		table2.ajax.reload();//datatable reload.
	    	        	});
	    	        }
	    	    })
	    		});
	    


	});
  </script>
</head>
<body>
 
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">받은쪽지함</a></li>
    <li><a id="link" href="#tabs-2">보낸쪽지함</a></li>
    <li><a href="#tabs-3">쪽지쓰기</a></li>
  </ul>
  <div id="tabs-1">
    <table id="myTable" >
    	<thead>
	        <tr>
	            <th></th>
	            <th></th>
	            <th>보낸이</th>
	            <th>제목</th>
	            <th>받은날짜</th>
	            <th></th>
	        </tr>
        </thead>
         
    </table>
  </div>
  <div id="tabs-2">
    <table id="myTable2" >
    	<thead>
	        <tr>
	            <th></th>
	            <th></th>
	            <th>받는이</th>
	            <th>제목</th>
	            <th>받은날짜</th>
	            <th></th>
	        </tr>
        </thead>
        
    </table>
  </div>
  <div id="tabs-3">
	  	<div style="text-align: center">
		    <div>
		    	<strong><span>받는사람 &nbsp;</span></strong>
		    	<input type="checkbox"><label>내게쓰기</label> <input name="m_Remail" id="m_Remail" type="text" size="30" disabled="disabled" >
		    	<button  class="btn btn-gradient-primary btn-sm " data-toggle="modal" data-target="#fr_list">친구찾기</button>
		    </div>
			<div>
				<textarea name="n_Content" id="n_Content" rows="15" cols="63" style="margin-top: 5px;"></textarea>
			</div>
			<div style="text-align: center;">
				<button id="submit"class="btn btn-gradient-primary btn-sm" >보내기</button>
				<button type="reset" class="btn btn-gradient-primary btn-sm">초기화</button>
				 
			</div>
		</div>
	</div>
 
 
</body>


<!-- 모달 -->
<div class="modal fade" id="fr_list" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>

			</div>
			<div class="modal-body">
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body text-center">
							<h2 class="card-title">친구들</h2>
								 <table id="myTable3" >
							    	<thead>
								        <tr>
								            <th></th>
								            <th>프로필 사진</th>
								            <th>닉네임</th>
								        </tr>
							        </thead>
							         <tbody>
								            <tr>
								                <td></td>
								                <td>희대</td>
								                <td>쪽지 1</td>
								            </tr>
							    	</tbody>
							    </table>
							    
								<button type="button" id="choice" class="btn btn-gradient-primary btn-sm " data-dismiss="modal" style="margin-top: 20px"
									>선택완료</button>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

</html>