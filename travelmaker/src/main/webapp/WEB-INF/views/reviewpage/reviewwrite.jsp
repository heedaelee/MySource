<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

  $(function(){
	  $('#treg').click(function(){
		  	if($('#t_Title').val() === ""){
		  		swal("게시글 제목을 입력해주세요.","","warning");
		  		$('#t_Title').focus();
		  	}
		  	else if($('#t_Content').val() === ""){
		  		swal("게시글 내용을 입력해주세요.","","warning");
		  		$('#t_Content').focus();	
		  	}else{
		  		var form = $('#travel')[0];
		  		console.log(form);
		  		var formData = new FormData(form);
		  		$.ajax(
							{
								type:"post",
								url:"reviewwritereg.htm",
								data:formData,
								processData: false,
				                contentType: false,
								success:function(data){ //{"result":""}
								console.log(data);
									if(data=="success"){
										location.href="reviewlist.htm?insert";
									}else{
										swal("게시글 등록에 실패하였습니다.","", "warning");								
									}
					            	},
					            error : function(error) {
					               swal("게시글 등록에 실패하였습니다.","","warning");
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


	<!-- <main role="main"> -->
	<div class="container-scroller">
		<div class="container-fluid page-body-wrapper">
			<div class="content-wrapper2">
			<div class="row col-11">
					<div class="container">
						<h1 class="jumbotron-heading text-center">여행리뷰 작성</h1>
						<p class="lead text-muted text-center">나누고 싶은 여행 이야기</p>
					</div>
			</div>
			<div class="row">
				<form id="travel" class="col-11" method="post">
					<table class="col-11">
							<tr>
								<th class="text-center">제목:</th>
								<td><input type="text" id="t_Title" placeholder="제목을 입력하세요. "
									name="t_Title" class="form-control border-0"/></td>
							</tr>
							<tr>
								<th class="text-center">첨부파일: </th>
								<td>
								<div class="form-group">
								<input type="file" id="file" name="file"
										class="file-upload-default">
									<div class="input-group col-xs-12">
										<input type="text" class="text-center form-control file-upload-info bg-transparent border-0 "
											name="t_Image" id="t_Image" disabled placeholder="메인사진을 넣어주세요."> <span
											class="input-group-append">
											<button class="file-upload-browse btn btn-gradient-primary"
												type="button">Upload</button>
										</span>
									</div>
								</div>
								<div class="form-group">
								<input type="file" id="files" name="files"
										class="file-upload-default1" multiple>
									<div class="input-group col-xs-12">
										<input type="text" class="text-center form-control file-upload-info bg-transparent border-0 "
											name="ti_Image" id="ti_Image" disabled placeholder="리뷰사진을 넣어주세요."> <span
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
							<td><input type="text" id="pac-input" name="t_Local" class="controls form-control border-0" placeholder="여행지역을 입력해주세요.">
								<input type="hidden" name="t_Latitude" id="lat">
								<input type="hidden" name="t_Longitude" id="lng">
							</td>
							</tr>
							<tr>
							<th class="text-center">여행국가: </th>
							<td>
<!-- 							<p> -->
							<input type="text" id="t_Country" name="t_Country" class="col-4 controls form-control border-0" placeholder="여행국가">
<!-- 								<img class="flag" src="image/flag/abkhazia.svg">  -->
<!-- 							</p> -->
							</td>
							</tr>
							<tr>
								<th class="text-center">내용:</th>
								<td colspan="3"><textarea cols="50" rows="5" placeholder="내용을 입력하세요. "
										 class="form-control" id="t_Content" name="t_Content"></textarea>
								</td>
							
							</tr>
					</table>
				</form>
							<p class="col-11 text-center">
							<button type="button" id="treg" class="btn btn-gradient-primary btn-fw">등록</button>
								<button type="button" id="gb" class="btn btn-gradient-primary btn-fw">취소</button> 
							</p>
			</div>
		</div>
	</div>
</div>
	<!--     </main> -->
