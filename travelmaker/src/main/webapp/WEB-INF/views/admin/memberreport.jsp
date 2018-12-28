<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script> -->
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/0.2.0/Chart.min.js"></script> -->
<script src="http://code.jquery.com/jquery-2.2.4.js"></script>
<script src="utils.js"></script>
<%--ChartJS CDN--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

	<div class="main-panel ">
  		<div class="content-wrapper1">
	    	<p><h1 class=text-left>회원 통계</h1><p>
	  	    	<div class="grid-margin stretch-card">
	  	    		<div style="width: 40%;" class="card">	
                		<div class="card-body">
							<h4>회원 수</h4>
							<div class="panel-body text-center">
<%-- 								<canvas id="bar1"></canvas> --%>
								<canvas id="bar1" width="300" height="100"></canvas>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

<script type="text/javascript">

// $(document).ready(function(){

	//비동기 실행
	/* 
	$.ajax({
		url:"memberreport.htm",
		type:"post",
		dataType: 'json',

		success:function(data){

			alert(data);
		},
		error:function(request,status,error){
        	console.log("code = "+ request.status + " error = " + error); 
		}
	});	
	*/
	
// });
 
//  function functionChart(){

	/* 
	Samples.utils = {
			
		transparentize: function(color, opacity) {
			var alpha = opacity === undefined ? 0.5 : 1 - opacity;
			return Color(color).alpha(alpha).rgbString();
		}	
	}; 
	var utils = Samples.utils;
	 */
	
	var chart = new Array();
	
	<c:forEach items="${report}" var="report">
		chart.push("${report.count}");
		</c:forEach>

		console.log(chart);
		
	var config = {
		
	    type: 'line',
	    data: {
	      labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	      datasets: [
	        {
	          label: ["회원가입 수"],
	          backgroundColor: 'rgb(255, 99, 132)',
	          borderColor: 'rgb(255, 99, 132)',
	          lineTension:0,
	          fill:false,
	          data: [chart[0],chart[1],chart[2],chart[3],chart[4],chart[5],chart[6],chart[7],chart[8],chart[9],chart[10],chart[11]]
	        }]
	    },
	    options:{
	      layout: {
	          
	    	  padding: {
	              left: 10,
	              right: 10,
	              top: 10,
	              bottom: 10
	          }
	      },
	      
	      scales: {
		    	 xAxes: [{
		    		 scaleLabel: {
							display: true,
						}
		    	    /*  
		    	 	ticks: {
		    	       callback: function(value) {
		    	         if (value.length > 6) {
		    	          	return value.substr(0, 6) + '...'; //차트라벨 4글자 이후에 ... 처리
		    	        	} else {
		    	           	return value
		    	        	}
		    	        },
		    	      }
		    	  */
		    	    }],
	    	
		        yAxes: [{
		        	scaleLabel: {
						display: true,
						labelString: '가입자 수'
					},
			         ticks: {
			             stepSize: 10
			         	}
		     	}]
	       },
	       tooltips: {
	    	    enabled: true,
	    	    mode: 'label',
	    	    callbacks: {
	    	      title: function(tooltipItems, data) {
	    	        var idx = tooltipItems[0].index;
	    	        return data.labels[idx];
	    	      }
	    	    }
	    	  },		       
	    }
 	};

 
	window.onload = function() {
		 
		var ctx = document.getElementById('bar1').getContext('2d');
		window.myLine = new Chart(ctx, config);
	};


	
	
// }
	
	
</script>
		