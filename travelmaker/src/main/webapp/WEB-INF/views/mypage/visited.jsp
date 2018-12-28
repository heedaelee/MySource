<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAoEy_g_fM4DTjGlPnSKmn0SdQqF7mpfRc"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
$(document).ready(function(){
// 	var google =   document.getElementsByClassName("geo")[0].children[0];
// 	console.log(google);
function initialize() {
				$($('.geo')).each(function(index,obj){
						
// 	var arr =[];	
// $($('.googleMap').next()).each(function(index,obj){
// var object = new Object();
// object.geo = obj.defaultValue;
// arr.push(object);
// })
// console.log(arr);
// $(arr).each(function(index,obj){
// })			
				
 			//	console.log(obj.geo); 
				  var mapProp = {	
						    center:new google.maps.LatLng(obj.childNodes[3].value, obj.childNodes[5].value),
						    zoom : 11,
						    mapTypeId: google.maps.MapTypeId.Terrain
						  };
				var map=new google.maps.Map(document.getElementsByClassName("geo")[index].children[0],mapProp);
				
// 				var map=new google.maps.Map(document.getElementByName("googleMap"),mapProp);
				
				var marker = new google.maps.Marker({ //마커 설정
			      map : map,
			      position : map.getCenter(), //마커 위치
			      
			  	});
			
			
			  google.maps.event.addDomListener(window, "resize", function() { //리사이즈에 따른 마커 위치
			      var center = map.getCenter();
			      google.maps.event.trigger(map, "resize");
			      map.setCenter(center); 
			  });
			  
			  google.maps.event.addDomListener( map , "load", null );
				})
				
	
	}

	google.maps.event.addDomListener(window, 'load', initialize);
			
})
		
</script>
<div class="main-panel">
	<div class="content-wrapper1 text-center">

<!-- 			<h1 class="my-md-5">방문한 여행지</h1> -->
			<div class="col-lg-6 col-md-8 mx-auto ">
			  <div class="card table-responsive">
				<h1 class="my-md-4">방문한 여행지<br><small class="text-muted my-md-4">그동안의 여행지를 한눈에 확인하실 수 있습니다</small></h1>
				<c:choose>
					<c:when test="${empty trDto}">
						
						<h3 class="my-md-4">*현재 기록된 여행지가 없습니다.<br><br><small class="text-muted my-md-4">리뷰 글을 작성하시면 여행지가 자동으로 기록됩니다!</small></h3>					
					</c:when>
					<c:otherwise>
					<c:forEach var="tr" items="${trDto}">
					
					  <hr>
						<div class="card-body ">
							<h1 class="textbig my-md-3" id="t_Title">${tr.t_Title}</h1>
							<div class="img1 textmargin text-center my-md-3">여행 국가 : ${tr.t_Country}</div>
			    			<div class="img1 textmargin text-center my-md-3">지 역 : ${tr.t_Local}</div>
							<div class="geo">
							<div id="googleMap"></div>
							 
								<input type="hidden" id="lati" value="${tr.t_Latitude}">
								<input type="hidden" id="long" value="${tr.t_Longitude}">
				    		</div>
						</div>
						<hr>
					
					</c:forEach>
				</c:otherwise>
				</c:choose>
				  </div>
			</div>
		</div>
		<!-- content-wrapper ends -->
	</div>
<!-- main-panel ends -->