<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_U0kuj_fDFGJKNPjnUP_LKJJ3md0V-pc&libraries=places&callback=initAutocomplete" async defer></script>
  <script>
  //구글맵 api
      function initAutocomplete() {

        var input = document.getElementById('pac-input');
        var searchBox = new google.maps.places.SearchBox(input);
        searchBox.addListener('places_changed', function() {
          var places = searchBox.getPlaces();
          if (places.length == 0) {
            return;
          }
          // For each place, get the icon, name and location.
          var bounds = new google.maps.LatLngBounds();
          
          places.forEach(function(place) {
        	  document.getElementById("lat").value = place.geometry.location.lat();
        	  document.getElementById("lng").value = place.geometry.location.lng();
//         	  console.log(place.formatted_address.substr(0,index));
// 			  console.log(document.ElementByClassName("country-name"));
        	 
        			  for (var i=0; i<place.address_components.length; i++)
        				  {if(place.address_components[i].types[0]=="country")
        				country= place.address_components[i];			  
        				  }
        	  document.getElementById("t_Country").value = country.long_name;
            if (!place.geometry) {
              console.log("Returned place contains no geometry");
              return;
            }
          });
        });
      }
  
//datepicker api
//   $( function() {
//     var dateFormat = "mm/dd/yy",
//       from = $( "#from" )
//         .datepicker({
//           defaultDate: "+1w",
//           changeMonth: true,
//           numberOfMonths: 1
//         })
//         .on( "change", function() {
//           to.datepicker( "option", "minDate", getDate( this ) );
//         }),
//       to = $( "#to" ).datepicker({
//         defaultDate: "+1w",
//         changeMonth: true,
//         numberOfMonths: 1
//       })
//       .on( "change", function() {
//         from.datepicker( "option", "maxDate", getDate( this ) );
//       });
 
//     function getDate( element ) {
//       var date;
//       try {
//         date = $.datepicker.parseDate( dateFormat, element.value );
//       } catch( error ) {
//         date = null;
//       }
 
//       return date;
//     }
//   } );
  $(function(){
	  $('#update').click(function(){
		  	if($('#t_Title').val() === ""){
		  		swal("게시글 제목을 입력해주세요.","","warning");
		  		$('#t_Title').focus();
		  	}
		  	else if($('#t_Content').val() === ""){
		  		swal("게시글 내용을 입력해주세요.","","warning");
		  		$('#t_Content').focus();	
		  	}else{
		  		var form = $('#travelup')[0];
		  		console.log(form.files.value);
		  		var formData = new FormData(form);
		  		$.ajax(
							{
								type:"post",
								url:"reviewupdatereg.htm",
								data:formData,
								processData: false,
				                contentType: false,
								success:function(data){ //{"result":""}
								console.log(data);
									if(data=="success"){
										location.href="reviewlist.htm?update";
									}else{
										swal("게시글 수정에 실패하였습니다.","", "warning");								
									}
					            	},
					            error : function(error) {
					               swal("게시글 수정에 실패하였습니다.","","warning");
					               console.log(error);
					               console.log(error.status);
					            }
							
						})
						}
		  		
		  		
		  	})
	  
	  $('#selectbox').change(function(){
		  console.log($('#selectbox').val());
	  })
  $('#gb').click(function() {
	  history.back();
  }
  )})
  
  
  </script>

<!--   일단 보류, 2차구현시 summernote
  <script type="text/javascript">
$(document).ready(function() {
	  $('#summernote').summernote({height : 100});
	});
</script> -->


	<!-- <main role="main"> -->
	<div class="container-scroller">
		<div class="container-fluid page-body-wrapper">
			<div class="content-wrapper2">
			<div class="row col-11">
					<div class="container">
						<h1 class="jumbotron-heading text-center">여행리뷰 수정</h1>
						<p class="lead text-muted text-center">나누고 싶은 여행 이야기</p>
					</div>
			</div>
			<div class="row">
				<form id="travelup" class="col-11" method="post">
					<table class="col-11">
							<tr>
								<th class="text-center">제목:
								</th>
								<td>
								<input type="text" id="t_Title" name="t_Title" class="form-control border-0" value="${list.t_Title}">
								</td>
							</tr>
							<tr>
								<th class="text-center">첨부파일: </th>
								<td class="text-center">
								<div class="form-group">
								<input type="file" id="file" name="file"
										class="file-upload-default">
									<div class="input-group col-xs-12">
										<input type="text" class="text-center form-control file-upload-info bg-transparent border-0 "
											name="t_Image" id="t_Image" readonly value="${list.t_Image}"> <span
											class="input-group-append">
											<button class="file-upload-browse btn btn-gradient-primary"
												type="button">Upload</button>
										</span>
									</div>
								</div>
								<div class="form-group">
								<input type="hidden" name="oriImage" value="<c:forEach items="${image}" var="r" varStatus="status">${r.ti_Image}<c:choose><c:when test="${status.last}"></c:when><c:otherwise>,</c:otherwise></c:choose></c:forEach>">
								<input type="file" id="files" name="files"
										class="file-upload-default1" multiple>
									<div class="input-group col-xs-12">
										<input type="text" class="text-center form-control file-upload-info bg-transparent border-0 "
											name="ti_Image" id="ti_Image" value="<c:forEach items="${image}" var="r" varStatus="status">${r.ti_Image}<c:choose><c:when test="${status.last}"></c:when><c:otherwise>,</c:otherwise></c:choose></c:forEach>" readonly placeholder="Upload">
											 <span
											class="input-group-append">
											<button class="file-upload-browse1 btn btn-gradient-primary"
												type="button">Upload</button>
										</span>
									</div>
								</div>
								</td>
							</tr>
							<tr>
							<th class="text-center">여행지역: </th>
							<td><input type="text" id="pac-input" name="t_Local" class="controls form-control border-0" value="${list.t_Local}">
								<input type="hidden" name="t_Latitude" id="lat" value="${list.t_Latitude}">
								<input type="hidden" name="t_Longitude" id="lng" value="${list.t_Longitude}">
							</td>
							</tr>
							<tr>
							<th class="text-center">여행국가: </th>
							<td>
<!-- 							<p> -->
							<input type="text" id="t_Country" name="t_Country" class="col-4 controls form-control border-0" value="${list.t_Country}">
<!-- 								<img class="flag" src="image/flag/abkhazia.svg">  -->
<!-- 							</p> -->
								<input type="hidden" name="t_Num" value="${list.t_Num}">
							</td>
							</tr>
<!-- 							<tr> -->
<!-- 								<th class="text-center">세부계획:</th> -->
<!-- 								<td class="text-center"></td> -->
<!-- <!-- 								<td class="text-center"> --> 
<!-- <!-- 										 	<p><input type="text" class="form-control text-center from border-0 col-4" id="from" name="from" placeholder="출발일"> -->
<!-- <!-- 											<i class="mdi mdi-window-minimize"></i> --> 
<!-- <!-- 											<input type="text" class="form-control text-center from border-0 col-4" id="to" name="to" placeholder="도착일"> -->
<!-- <!-- 										</p> -->
<!-- <!-- 								</td> --> 
<!-- 									
<!-- 									<td style="width: 200px;word-break:break-all"><div class="cal" style="text-align: center"> -->
<!-- 										<label for="">성별</label> -->
<!-- 										<select class="form-control"> -->
<!-- 											<option>혼성<option> -->
<!-- 											<option>남자끼리<option> -->
<!-- 											<option>여자끼리<option> -->
<!-- 										</select> -->
										
<!-- 									</div></td> -->
<!-- 									<td style="width:200px;word-break:break-all"><div class="cal" style="text-align: center" > -->
<!-- 									<label for="">인원</label> -->
<!-- 									<div class="input-group " style="height: calc(2.25rem + 2px);text-align: center;"> -->
<!-- 							                      <input type="text" class="form-control" name="G_EPEOPLE" > -->
<!-- 							                      <div class="input-group-append"> -->
<!-- 							                        <span class="input-group-text">명</span> -->
<!-- 							                      </div> -->
<!-- 							                    </div> -->
<!-- 									</div></td> -->
<!-- 									 -->
<!-- 							</tr> -->
						
							<tr>
								<th class="text-center">내용:</th>
								<td colspan="3"><textarea cols="50" rows="5" 
										 class="form-control" id="t_Content" name="t_Content">${list.t_Content}</textarea>
								</td>
							
							</tr>


							<!--            <tr>
                        <th>비밀번호: </th>
                        <td><input type="password" placeholder="비밀번호를 입력하세요" class="form-control"/></td>
                    </tr>-->
												
					</table>
				</form>
							<p class="col-11 text-center">
							<button type="button" id="update" class="btn btn-gradient-primary btn-fw">수정</button>
								<button type="button" id="gb" class="btn btn-gradient-primary btn-fw">취소</button> 
							</p>
			</div>
		</div>
	</div>
</div>
	<!--     </main> -->
