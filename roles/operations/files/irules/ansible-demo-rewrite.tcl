when HTTP_REQUEST {

	if { ( [HTTP::uri] ends_with ".html") or ( [HTTP::uri] ends_with "/")} {
	
	    if { ! [HTTP::cookie exists "visited_maintenance_page"] || [HTTP::cookie value "visited_maintenance_page"] != "true" } {
        
		 	HTTP::respond 200 content {
				<html>
	      			<head>
	      				<!--<meta http-equiv="set-cookie" content="visited_maintenance_page=true; expires=10">-->
	      				<title>Maintenance Page</title>
	      			</head>
	      			<script>
	      				   	var date = new Date();
   							date.setTime(date.getTime()+(30*1000));
   							var expires = "; expires="+date.toGMTString();
   							document.cookie = "visited_maintenance_page=true " + expires;
	      			</script>
	      			<body>
	      			     <center><img src="http://localhost:8080/f5_irules_demo.png"</img></center>
	      			     <br/>
	      			     <h1><center>This site is scheduled for maintenance in the next hour. <br/>
	      			     	<!--Sorry for any inconvenience caused. Please click to <a href="/pageindex_onpremise.html">continue</a></center></h1> -->
	      			     	Sorry for any inconvenience caused. Please click to <a href="/pageindex_alexa.html">continue</a></center></h1>
	      			</body>
	      		</html>
		 	}
		
	    }
	}
}
