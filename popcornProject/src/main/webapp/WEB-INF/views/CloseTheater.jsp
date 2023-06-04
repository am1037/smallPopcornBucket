<%--
  Created by IntelliJ IDEA.
  User: 정민기
  Date: 2023-06-04
  Time: 오후 1:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src=${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js></script>

</head>
<body>
    <div id="demo">

    </div>
    <script>
        let latitude;
        let longitude;
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    latitude = position.coords.latitude;
                    longitude = position.coords.longitude;
                    console.log("Latitude: " + latitude);
                    console.log("Longitude: " + longitude);
                    $.ajax({
                        url: "calcDistance",
                        data: {
                            "latitude": latitude,
                            "longitude": longitude
                        },
                        type: "GET",
                        success: function(data){
                            console.log("성공");
                            console.log(data);
                            $('#demo').html(data);
                        },
                        error: function(xhr, status, err){
                            console.log("에러발생");
                        }
                    });
                },
                function(error) {
                    console.log("Error occurred. Error code: " + error.code);
                }
            );
        } else {
            console.log("Geolocation is not supported by this browser.");
        }
    </script>
</body>
</html>
