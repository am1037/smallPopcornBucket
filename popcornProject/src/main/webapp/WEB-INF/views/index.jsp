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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        let latitude;
        let longitude;
        let jason;
        const url = '${pageContext.request.contextPath}';

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
                                    cards[i].querySelector(".card-title").innerHTML = jason.theatersName[i];
                                    getScreenPercentages(jason.theaters[i], "20230607", function (data){
                                        let titleMap = data.movieTitleMap;
                                        let percentageMap = data.screensPercentageMap;
                                        let order = data.order;

                                        cards[i].querySelector(".distance").innerHTML = "거리 : "+ jason.distances[i].toFixed(3) + "km"

                                        let content = `<table class="table-bordered container-fluid">
                                                            <th>영화 제목</th><th>상영관 점유율</th>
                                                        </thead><tbody>`;
                                        for(let i of order){
                                            //titleMap[i] + " : " + (100*percentageMap[i]).toFixed(2) + "%<br>";
                                            content += toTableRow(titleMap[i], (100*percentageMap[i]).toFixed(2) + "%", url, i);
                                        }
                                        content += "</tbody></table>";
                                        cards[i].querySelector(".schedule").innerHTML = content;
                                    })
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
                    callback(JSON.parse(data))
                },
                error: function(xhr, status, err){
                    console.log("에러발생");
                }
            })
        }

        function toTableRow(movieTitle, percentage, url, code) {
            return `
        <tr>
            <td><a href="\${url}/movieDetail?id=\${code}">\${movieTitle}</a></td>
            <td>\${percentage}</td>
        </tr>
    `;
        }
    </script>
</head>
<body>

<div id="div4navbar">
</div>

<div class="main-content container-fluid container-sm">
    <div class="container p-5 my-5 border">
        <div class="card p-3 my-3">
            <div class="card-body">
                <h4 class="card-title">#1</h4>
                <div class="inside-text distance">
                </div>
                <p class="card-text">
                    <div class="inside-text schedule">

                    </div>
                </p>
                <a href="#" class="card-link">극장 상세정보</a>
            </div>
        </div>
        <div class="card p-3 my-3">
            <div class="card-body">
                <h4 class="card-title">#2</h4>
                <div class="inside-text distance">
                </div>
                    <p class="card-text">
                        <div class="inside-text schedule">

                        </div>
                    </p>
                <a href="#" class="card-link">극장 상세정보</a>
            </div>
        </div>
        <div class="card p-3 my-3">
            <div class="card-body">
                <h4 class="card-title">#3</h4>
                <div class="inside-text distance">
                </div>
                    <p class="card-text">
                        <div class="inside-text schedule">

                        </div>
                    </p>
                <a href="#" class="card-link">극장 상세정보</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
