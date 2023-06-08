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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/css4jmk.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function(event) {
            getNavbar($('#div4navbar'));
        });

        let latitude;
        let longitude;
        let jason;
        const url = '${pageContext.request.contextPath}';

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
                                    getScreenPercentages(jason.theaters[i], ${date}, function (data){
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
                                        cards[i].querySelector(".card-link").setAttribute("href", url + "/theaterDetail?theaterId=" + jason.theaters[i])
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
            <td><a href="\${url}/movieDetail?movieCd=\${code}">\${movieTitle}</a></td>
            <td>\${percentage}</td>
        </tr>
    `;
        }
    </script>
</head>
<body>

<div id="div4navbar">
</div>

<div class="main-content p-1 my-5 container-fluid container-sm">
    <div>
        <h3>개별 극장 검색</h3>
        <select>
            <option>서울</option>
            <option>경기</option>
            <option>인천</option>
            <option>강원</option>
            <option>충북</option>
            <option>충남</option>
            <option>대전</option>
            <option>경북</option>
            <option>경남</option>
            <option>대구</option>
            <option>울산</option>
            <option>부산</option>
            <option>전북</option>
            <option>전남</option>
            <option>광주</option>
            <option>제주</option>
        </select>
        <button>검색</button>
    </div>
    <div class="container p-1 my-2 border">
        <div class="my-1">
            <h5>${longDate}</h5>의 영화 상영관 점유율입니다.
        </div>
        <div class="card p-3 my-3">
            <div class="card-body row">
                <h4 class="card-title col">#1</h4>
                <div class="inside-text distance">
                </div>
                <p class="card-text">
                <div class="inside-text schedule">
                    <div class="spinner-border"></div>
                </div>
                </p>
                <a href="" class="card-link">극장 상세정보</a>
            </div>
        </div>
        <div class="card p-3 my-3">
            <div class="card-body">
                <h4 class="card-title">#2</h4>
                <div class="inside-text distance">
                </div>
                <p class="card-text">
                <div class="inside-text schedule">
                    <div class="spinner-border"></div>
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
                <div class="inside-text schedule align-content-center">
                    <div class="spinner-border"></div>
                </div>
                </p>
                <a href="#" class="card-link">극장 상세정보</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
