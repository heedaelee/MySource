<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href='fullcalendar-3.9.0/fullcalendar.min.css' rel='stylesheet' />
<link href='fullcalendar-3.9.0/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='fullcalendar-3.9.0/lib/moment.min.js'></script>
<script src='fullcalendar-3.9.0/lib/jquery.min.js'></script>

<script src='fullcalendar-3.9.0/fullcalendar.min.js'></script>
<script src='fullcalendar-3.9.0/locale-all.js'></script>
<script type="text/javascript">
  $(document).ready(function() {
	  var isElemOverDiv = function(draggedItem, dropArea) { 
		  var draggedX = $(draggedItem)[0].offsetX; var b = $(dropArea); 
		  var draggedY = $(draggedItem)[0].offsetY;
		  var limitX = parseInt(b.offset().left) + parseInt(b.outerWidth()); 
		  var limitY = parseInt(b.offset().top) + parseInt(b.outerHeight()); 
		if ( limitY >= parseInt(draggedY) && limitX >= parseInt(draggedX) ) 
		{return true; } 
		return false; }

	function formatDate(enddate){
	  month = '' + (enddate.getMonth() +1),
	  day = '' + enddate.getDate(),
	  year = enddate.getFullYear();
	  if(month.length <2) month = '0' + month;
	  if(day.length <2 ) day = '0' + day;
	  
	  return [year,month,day].join('-');
  }
	 function list(){
	
		 
	  $.ajax(
				{
					type:"post",
					url:"planlist.htm",
					success:function(data){ //{"result":""}
					
					$(data.list).each(function(index,obj){ 
						var eventData;
						 var enddate = new Date(obj.p_Edate);
						  enddate.setDate(enddate.getDate()+1);
						  var dat = formatDate(enddate);
						eventData = {
				     	            title: obj.p_Content,
				     	            start: obj.p_Sdate,
				     	            end: dat,
				     	            id: obj.p_Num 
				     	          };
						$('#calendar').fullCalendar('renderEvent', eventData, true);

					}	
					)
					
					},
		            error : function(error) {
		               swal("일정 등록에 실패하였습니다.","","warning");
		               console.log(error);
		               console.log(error.status);
		            }
				
			})
		
	 }
			var that = this;
			if(!this.todayDate){
				this.todayDate = new Date();
			}
			 list();
			
   $('#calendar').fullCalendar({
      header: {
        left: 'prev,next',
        center: 'title',
        right:'today,month,agendaWeek'
      },
      defaultDate: that.todayDate, 
      locale:'ko',
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectHelper: true,
	  dayClick: function(date, jsEvent, view) { 
		  (async function getFormValues () {
			  var dat = formatDate(date._d);
			  const {value: formValues} = await swal({
			    title: '일정 등록',
			    html:
			      '<div><input type="date"  name="from" id="from" value="'+dat+'"></div>' +
			      '<div><input type="date"  name="to" id="to" placeholder="종료일"></div>' +
			      '<div><input id="swal-input3" class="swal2-input" placeholder="일정"></div>' 
			      ,
			    focusConfirm: false,
			    preConfirm: () => {
			      return [
			        document.getElementById('from').value,
			        document.getElementById('to').value,
			        document.getElementById('swal-input3').value
			      ]
			    }
			  })
			 
			  if (formValues) {
				  var enddate = new Date(formValues[1]);
				  enddate.setDate(enddate.getDate()+1);
				 var dat = formatDate(enddate);
				 
				  var eventData;
				  $.ajax(
							{
								type:"post",
								url:"planreg.htm",
								data:{"p_Sdate" : formValues[0],
									  "p_Edate" : formValues[1],
									  "p_Content" : formValues[2]},
								success:function(data){ //{"result":""}
								console.log(data.planDTO.p_Content)
									 eventData = {
											  title : data.planDTO.p_Content,
											  start : data.planDTO.p_Sdate,
											  end : dat,
											  id : data.planDTO.p_Num
											  
									  }

								console.log(eventData);
									  swal("일정 등록에 성공하였습니다.","","success");									
										 $('#calendar').fullCalendar('renderEvent', eventData, true);
								},
					            error : function(error) {
					               swal("일정 등록에 실패하였습니다.","","warning");
					               console.log(error);
					               console.log(error.status);
					            }
							
						})
				
				  
			  }
			  })
			  ()
			  },
	  eventResize: function(event, delta, revertFunc) {
		var enddate1 = new Date(event.end._i);
		enddate1.setDate(enddate1.getDate()+delta._days-1);
		var date1 = formatDate(enddate1);
		var enddate = new Date(event.end._i);
		enddate.setDate(enddate.getDate()+delta._days);
		var date = formatDate(enddate);
		if(delta._days > 0){
		 $.ajax(
					{
						type:"post",
						url:"planupdate.htm",
						data:{"p_Num": event.id,
							  "p_Sdate" : event.start._i,
							  "p_Edate" : date1,
							  "p_Content" : event.title},
						success:function(data){ //{"result":""}
							$('#calendar').fullCalendar('removeEvents', event.id); 
							 eventData = {
									  title : data.planDTO.p_Content,
									  start : data.planDTO.p_Sdate,
									  end : date,
									  id : data.planDTO.p_Num
									   
							  }

							  swal("일정 수정에 성공하였습니다.","","success");									
								 $('#calendar').fullCalendar('renderEvent', eventData, true);
						},
			            error : function(error) {
			               swal("일정 수정에 실패하였습니다.","","warning");
			               console.log(error);
			               console.log(error.status);
			            }
					
				})
		}else{
			var enddate = new Date(event.end._i);
			enddate.setDate(enddate.getDate()+delta._days-1);
			var date = formatDate(enddate);
			var enddate1 = new Date(event.end._i);
			enddate1.setDate(enddate1.getDate()+delta._days);
			var date1 = formatDate(enddate1);
			 $.ajax(
						{
							type:"post",
							url:"planupdate.htm",
							data:{"p_Num": event.id,
								  "p_Sdate" : event.start._i,
								  "p_Edate" : date,
								  "p_Content" : event.title},
							success:function(data){ //{"result":""}
								$('#calendar').fullCalendar('removeEvents', event.id); 
								 eventData = {
										  title : data.planDTO.p_Content,
										  start : data.planDTO.p_Sdate,
										  end : date1,
										  id : data.planDTO.p_Num
										   
								  }
								  swal("일정 수정에 성공하였습니다.","","success");									
									 $('#calendar').fullCalendar('renderEvent', eventData, true);
							},
				            error : function(error) {
				               swal("일정 수정에 실패하였습니다.","","warning");
				               console.log(error);
				               console.log(error.status);
				            }
						
					})
			
		}
	  },
	  eventClick: function(calEvent, jsEvent, view) {
				  var id = calEvent.id;
				  var enddate = new Date(calEvent.end._i);
				  enddate.setDate(enddate.getDate()-1);
				  var date = formatDate(enddate);
// 				  console.log(dat);
// 				  console.log(calEvent.start._i);
				  (async function getFormValues () {
					  const {value: formValues} = await swal({
					    title: '일정 수정',
					    html:
					      '<div><input type="date"  name="from" id="from" value="'+calEvent.start._i+'"></div>' +
					      '<div><input type="date"  name="to" id="to" value="'+ date +'"></div>' +
					      '<div><input id="swal-input3" class="swal2-input" value="'+calEvent.title+'"></div>' 
					      ,
					    focusConfirm: false,
					    preConfirm: () => {
					      return [
					        document.getElementById('from').value,
					        document.getElementById('to').value,
					        document.getElementById('swal-input3').value
					      ]
					    }
					  })
					 
					  if (formValues) {
						  var enddate = new Date(formValues[1]);
						  enddate.setDate(enddate.getDate()+1);
						 var end = formatDate(enddate);
						 
						  var eventData;
						  $.ajax(
									{
										type:"post",
										url:"planupdate.htm",
										data:{"p_Num": id,
											  "p_Sdate" : formValues[0],
											  "p_Edate" : formValues[1],
											  "p_Content" : formValues[2]},
										success:function(data){ //{"result":""}
											$('#calendar').fullCalendar('removeEvents', id); 
											 eventData = {
													  title : data.planDTO.p_Content,
													  start : data.planDTO.p_Sdate,
													  end : end,
													  id : data.planDTO.p_Num
													  
											  }

										console.log(eventData);
											  swal("일정 수정에 성공하였습니다.","","success");									
												 $('#calendar').fullCalendar('renderEvent', eventData, true);
										},
							            error : function(error) {
							               swal("일정 수정에 실패하였습니다.","","warning");
							               console.log(error);
							               console.log(error.status);
							            }
									
								})
						
						  
					  }
					  })
					  ()
			  },
	  eventDrop: function(event, delta, revertFunc, jsEvent, ui, view) {
		 var startdate = new Date(event.start._i);
		  startdate.setDate(startdate.getDate()+delta._days);
		  var stdate = formatDate(startdate);
		  var enddate = new Date(event.end._i);
		  enddate.setDate(enddate.getDate()+delta._days-1);
		  var endate = formatDate(enddate);
		  var enddate1 = new Date(event.end._i);
		  enddate1.setDate(enddate1.getDate()+delta._days);
		  var endate1 = formatDate(enddate1);
		 $.ajax(
					{
						type:"post",
						url:"planupdate.htm",
						data:{"p_Num": event.id,
							  "p_Sdate" : stdate,
							  "p_Edate" : endate,
							  "p_Content" : event.title},
						success:function(data){ //{"result":""}
							$('#calendar').fullCalendar('removeEvents', event.id); 
							 eventData = {
									  title : data.planDTO.p_Content,
									  start : data.planDTO.p_Sdate,
									  end : endate1,
									  id : data.planDTO.p_Num
									  
							  }
							  swal("일정 수정에 성공하였습니다.","","success");									
								 $('#calendar').fullCalendar('renderEvent', eventData, true);
						},
			            error : function(error) {
			               swal("일정 수정에 실패하였습니다.","","warning");
			               console.log(error);
			               console.log(error.status);
			            }
					
				})
	  },
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      eventDragStop: function(event, jsEvent, ui, view) { 
					if (isElemOverDiv(jsEvent, $('#delete-events'))) {
						  $.ajax(
									{
										type:"post",
										url:"plandel.htm",
										data:{"p_Num" : event.id},
										success:function(data){ //{"result":""}
										if(data == "success"){
											  swal("일정 삭제에 성공하였습니다.","","success");
								    		
											  
										}else{
											  swal("일정 삭제에 실패하였습니다.","","warning");									
														
										}
										},
							            error : function(error) {
							               swal("일정 삭제에 실패하였습니다.","","warning");
							               console.log(error);
							               console.log(error.status);
							            }
									
								})
						$('#calendar').fullCalendar('removeEvents', event.id); 
					} 
					
				
				}

      });
    	
      
    });


</script>
<div class="content-wrapper1">
	<div class="col-lg-8 col-md-8 mx-auto text-center ">
	<h1 class="my-md-4">여행 일정<br><small class="text-muted my-md-4">날짜를 클릭하면 여행 일정을 추가하실 수 있습니다.</small></h1>
	 <div class="auth-form-light text-center p-5 card d-table-cell align-middle">
<!-- 	<h1>여행 일정</h1> -->
		
	 	<div id='calendar'></div>
	 	<div id="delete-events" class="trash float-right"><img src="images/trashcan.jpg" class="trash"></div>
	 
	 </div>
  </div>
</div>