<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<!-- title 영역 -->
		<title><tiles:insertAttribute name="title" /></title>
	<link rel="shortcut icon" href="images/logo-mini.jpg" />
	</head>
	<body>
	  <div class="container-scroller">
		<!-- Header  영역 -->
		<tiles:insertAttribute name="header" />
		<div class="container-fluid page-body-wrapper">
		<!-- Sidebar 영역 -->
		<tiles:insertAttribute name="sidebar"/>
		<!-- Main 영역 -->
		
			<!-- Content 영역 -->
			<tiles:insertAttribute name="content" />
		</div>
	  </div>
		<!-- Footer 영역  -->
		<tiles:insertAttribute name="footer" />
	
	</body>
</html>