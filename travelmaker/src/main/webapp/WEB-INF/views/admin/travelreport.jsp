<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="http://code.jquery.com/jquery-2.2.4.js"></script>
<!-- <script src="utils.js"></script> -->
<%--ChartJS CDN--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

	<div class="main-panel ">
  		<div class="content-wrapper1">
	    	<p><h1 class=text-left>여행지 통계</h1><p>
	  	    	<div class="grid-margin stretch-card">
	  	    		<div style="width: 40%;" class="card">	
                		<div class="card-body">
							<h4>많이 간 여행지</h4>
							<div class="panel-body text-center">
<%-- 								<canvas id="bar1"></canvas> --%>
								<canvas id="bar1" width="400" height="100"></canvas>
							</div><br><br>
						<table style="width:80%" align="center" class="table table-hover">
		                    <thead>
		                      <tr>
		                        <td align="center" width="35%" style="font-size: initial;font-weight: bold;">국 가</td>
		                        <td class="t1" align="left" width="30%" style="font-size: initial;font-weight: bold;">횟 수</td>
		                      </tr>
		                    </thead>
			                <c:forEach var="r" items="${report}">
								<tr align="center">
			                      	<td width="35%" class="flag"><img src="image/flag/${r.country}.svg">&nbsp;&nbsp;${r.country}</td>
									<td align="left" width="30%">${r.t_Country} 회</td>
								</tr>
							</c:forEach>
	                    </table>							
						</div>
					</div>
				</div>
			</div>
		</div>

<script type="text/javascript">
	
	var country = new Array();
	var num = new Array();

	<c:forEach items="${report}" var="report">
		country.push("${report.country}");
	</c:forEach>	
	<c:forEach items="${report}" var="report">
		num.push("${report.t_Country}");
	</c:forEach>	
	console.log(country);
	console.log(num);

	
	var config = {
		
	    type: 'bar',
	    data: {
	      labels: country,
	      datasets: [{
	          label: ["여행 다녀온 수"],
	          backgroundColor: 'rgb(54, 162, 235)',
	          borderColor: 'rgb(54, 162, 235)',
	          data: num
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
		    	    }],
		        yAxes: [{
		        	scaleLabel: {
						display: true,
						labelString: '여행자 수'
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
	

	
	
</script>
		