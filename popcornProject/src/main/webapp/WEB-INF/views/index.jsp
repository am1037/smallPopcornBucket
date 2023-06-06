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
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        let latitude;
        let longitude;
        let jason;

        document.addEventListener("DOMContentLoaded", function(event) {
            getNavbar($('#div4navbar'));
        });

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    latitude = position.coords.latitude;
                    longitude = position.coords.longitude;
                    console.log("Latitude: " + latitude);
                    console.log("Longitude: " + longitude);

                    $.ajax({
                        url: "index_calcDistance",
                        data: {
                            "latitude": latitude,
                            "longitude": longitude,
                        },
                        type: "GET",
                        success: function(data){
                            jason = JSON.parse(data);
                            console.log(jason)
                            let cards = document.querySelectorAll(".card-body");
                            for (let i in cards) {
                                if (cards[i] instanceof HTMLElement) {
                                    console.log(cards[i])
                                }
                            }

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

        function getScreenPercentages(theater_id, theater_date, callback){
            $.ajax({
                url: "calcOrderedPercentages",
                data: {
                    theater_Id: theater_id,
                    theater_date: theater_date
                },
                type: "GET",
                success: function(data){
                    callback(data)
                },
                error: function(xhr, status, err){
                    console.log("에러발생");
                }
            })
        }

    </script>
</head>
<body>

<div id="div4navbar">
    <button onclick="location.href='CloseTheater'">go to CloseTheater</button>
    <button onclick="location.href='CloseTheater'">go to CloseMovie</button>
    <button onclick="location.href='CloseTheater'">go to AlarmManagement</button>
</div>

<div class="main-content">
    <div class="container p-5 my-5 border">
        <div class="card p-3 my-3">
            <div class="card-body">
                <h4 class="card-title">1</h4>
                <p class="card-text">
                    <div class="inside-text">
                        asd
                    </div>
                    <div class="inside-text">

                    </div>
                </p>
                <a href="#" class="card-link">극장 상세정보</a>
            </div>
        </div>
        <div class="card p-3 my-3">
            <div class="card-body">
                <h4 class="card-title">2</h4>
                    <p class="card-text">
                        <div class="inside-text">

                        </div>
                        <div class="inside-text">

                        </div>
                    </p>
                <a href="#" class="card-link">극장 상세정보</a>
            </div>
        </div>
        <div class="card p-3 my-3">
            <div class="card-body">
                <h4 class="card-title">3</h4>
                    <p class="card-text">
                        <div class="inside-text">

                        </div>
                        <div class="inside-text">

                        </div>
                    </p>
                <a href="#" class="card-link">극장 상세정보</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
