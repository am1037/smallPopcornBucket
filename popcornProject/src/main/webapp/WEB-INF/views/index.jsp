<%--
  Created by IntelliJ IDEA.
  User: 정민기
  Date: 2023-06-03
  Time: 오전 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                },
                function(error) {
                    console.log("Error occurred. Error code: " + error.code);
                }
            );
        } else {
            console.log("Geolocation is not supported by this browser.");
        }

        $(document).ready(function(){
            $("#ImBtn").click(function(){
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
            });
        });
    </script>
</head>
<body>

<button id="ImBtn">Try It</button>
<div id="demo"></div>

</body>
</html>
