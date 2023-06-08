<%--
  Created by IntelliJ IDEA.
  User: 정민기
  Date: 2023-06-03
  Time: 오전 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        document.addEventListener("DOMContentLoaded", function(event) {
            getNavbar($('#div4navbar'));
        });
        const movieCd = '${movieCd}'
        let parsed;

        getMoviePercentage(movieCd, function (data) {
            parsed = JSON.parse(data);
            let tableElements = [];
            for(let i of parsed.percentages){
                tableElements.push((100*i).toFixed(1));
            }
            let element = document.querySelector('.whole-percent');
            element.innerHTML = listToTableRow(tableElements);
        })

        getMovieInfos(movieCd, function (data){
            let parsedInfo = JSON.parse(data);
            console.log(parsedInfo)
            document.querySelector('.title').innerHTML = parsedInfo.my_title;

            for(let i of parsedInfo.detail_urls){
                if(i.includes('cgv')){
                    document.querySelector('.cgv-link').setAttribute('href', i)
                }else if(i.includes('lotte')){
                    document.querySelector('.lotte-link').setAttribute('href', i)
                }
            }
            let btns = document.querySelectorAll('.button-link');
            for(let i of btns){
                if(i.getAttribute('href') === ''){
                    //grayscale and disable a tag
                    i.style.filter = 'grayscale(100%)';
                    i.style.pointerEvents = 'none';
                }
            }

            let poster = document.querySelector('.poster');
            let posterUrl = "";
            if(parsedInfo.posters != null){
                posterUrl = parsedInfo.posters[0];
            }
            poster.innerHTML = `<img alt="" src="` + posterUrl + `"onerror="replaceImage(this)" alt="poster" height='220'>`

        })

        function getMoviePercentage(movieCd, callback){
            $.ajax({
                url: '${pageContext.request.contextPath}/calcScreenPercentagesWhole',
                type: 'get',
                data: {
                    movieCd: movieCd
                },
                success: function (data) {
                    callback(data);
                }
            })
        }

        function getMovieInfos(movieCd, callback){
            $.ajax({
                url: '${pageContext.request.contextPath}/getMovieInfos',
                type: 'get',
                data: {
                    movieId: movieCd
                },
                success: function (data) {
                    callback(data);
                    //let element = document.querySelector('.movie-Infos');
                    //element.innerHTML = data;
                }
            })
        }

        function listToTableRow(tableElements){
            let date = new Date();
            let str = `<table class='table table-bordered'>
                          <thead>`

            let today = new Date();
            let dates = [];
            for (let i = -3; i <= 3; i++) {
                date.setDate(today.getDate() + i);
                let formattedDate = (date.getMonth() + 1).toString().padStart(2, '0') + "/" + date.getDate().toString().padStart(2, '0');
                dates.push(formattedDate);
            }
            for(let i in tableElements){
                str += "<th>"+ dates[i] +"</th>"
            }
            str += `</thead><tr>`
            for(let i of tableElements){
                str += `<td>\${i}%</td>`
            }
            str += `</tr></table>`
            return str;
        }

        function replaceImage(image){
            image.src='${pageContext.request.contextPath}/resources/small-no-poster.png';
        }
    </script>
</head>
<body>

<div id="div4navbar">
</div>

<div class="main-content p-1 my-5 container-fluid container-sm">
    <div class="container p-5 my-2 border">
        <div class="card-body row">
            <div class="col">
                <h4 class="title">#1</h4>
                <div class="card-body info">
                    외부링크
                    <table>
                        <tbody>
                        <tr>
                            <td><a href="" class="button-link cgv-link"><img src="${pageContext.request.contextPath}/resources/small_cgv_logo.png" height="30" alt=""></a></td>
                            <td><a href="" class="button-link lotte-link"><img src="${pageContext.request.contextPath}/resources/small_lotte_logo.png" height="30" alt=""></a></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col poster text-end">

            </div>

        </div>
        <div class="card p-3 my-3">
            <h4>전국 기준 상영관 점유율 추이입니다.</h4>
            <div class="card-body whole-percent table-responsive-sm">
                <div class="spinner-border"></div>
            </div>
        </div>
        <div class="card p-3 my-3">
            <div class="card-body">
                <div class="spinner-border"></div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
