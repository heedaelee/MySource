<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	
		<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130866286-1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'UA-130866286-1');
	  
	</script>
		<!-- Facebook Pixel Code -->
	<script>
	  !function(f,b,e,v,n,t,s)
	  {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
	  n.callMethod.apply(n,arguments):n.queue.push(arguments)};
	  if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
	  n.queue=[];t=b.createElement(e);t.async=!0;
	  t.src=v;s=b.getElementsByTagName(e)[0];
	  s.parentNode.insertBefore(t,s)}(window, document,'script',
	  'https://connect.facebook.net/en_US/fbevents.js');
	  fbq('init', '1641181862650201');
	  fbq('track', 'PageView');
	</script>
	
	<noscript><img height="1" width="1" style="display:none"
	  src="https://www.facebook.com/tr?id=1641181862650201&ev=PageView&noscript=1"
	/></noscript>
	<!-- End Facebook Pixel Code -->	
</head>
<body>
<script>
  fbq('track', 'Purchase');
</script>
<script>
  fbq('track', 'Lead');
</script>

<h1>
	Hello world!  s
</h1>

<input type="button" value="결제" id="buy">
</body>
</html>
