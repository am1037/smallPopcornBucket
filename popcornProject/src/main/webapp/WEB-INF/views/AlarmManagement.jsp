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

        let lineId = '${lineId}';
        let parsed;
        getAlarmList(lineId, function (data){
            parsed = JSON.parse(data);
            for(let i of parsed){
                fetchData(i.movieCd, i.theater_id, $('.card-field'));
                //$('.card-field').append(constructAlarmCard(i));
                //$('.card-field').append(constructAlarmCard(theaterData.theater_name, movieData.my_title, value))
            }
        });

        async function fetchData(movieCd, theater_id, element) {
            try {
                const movieInfoPromise = new Promise((resolve, reject) => {
                    getMovieInfo(movieCd, resolve);
                });

                const theaterInfoPromise = new Promise((resolve, reject) => {
                    getTheaterInfo(theater_id, resolve);
                });

                const [movieInfo, theaterInfo] = await Promise.all([movieInfoPromise, theaterInfoPromise]);

                let theaterData = JSON.parse(theaterInfo);
                let movieData = JSON.parse(movieInfo);
                let value = theater_id+"_"+theaterData.theater_company+"_"+movieCd;
                element.append(constructAlarmCard(theaterData.theater_name, movieData.my_title, value))
                let btn = document.querySelector('#delete_'+value);
                btn.addEventListener('click', function (){
                    let company = this.id.split('_')[2];
                    console.log(company);
                    $.ajax({
                        url: 'alarm/deleteAlarm',
                        type: 'GET',
                        data: {
                            lineId: lineId,
                            theaterId: theater_id,
                            movieId: movieCd,
                            theaterCompany: company
                        },
                        success: function (data) {
                            console.log(data);
                            document.querySelector('#delete_'+value).parentElement.parentElement.parentElement.remove();
                            //location.reload();
                        },
                        error: function (request, status, error) {
                            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                        }
                    })
                })
            } catch (error) {
                // Handle any errors that occurred
                console.error('Error:', error);
            }
        }

        function getAlarmList(lineId, callback){
            $.ajax({
                url: 'alarm/getAlarmList',
                type: 'GET',
                data: {
                    lineId: lineId
                },
                success: function (data) {
                    callback(data);
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });
        }

        function getMovieInfo(movieCd, callback){
            $.ajax({
                url: 'getMovieInfos',
                type: 'GET',
                data: {
                    movieId: movieCd
                },
                success: function (data) {
                    callback(data);
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            })
        }

        function getTheaterInfo(theater_id, callback){
            $.ajax({
                url: 'getTheaterInfos',
                type: 'GET',
                data: {
                    theaterId: theater_id
                },
                success: function (data) {
                    callback(data);
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            })
        }

        function getTheater(keyword, callback){
            $.ajax({
                url: 'getTheaterByKeyword',
                type: 'GET',
                data: {
                    keyword: keyword,
                    pageNumber: 1,
                    pageSize: 5
                },
                success: function (data) {
                    callback(data);
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            })
        }

        // value : theaterId_theaterCompany_movieId
        function constructAlarmCard(theaterName, movieName, value){
            let str = `
            <div class="card p-3 my-3 \${value}">
                <div class="card-body row">
                    <div class="col"><p>\${theaterName}</p><p>\${movieName}</p></div>
                    <div class="col text-end"><button class="btn btn-danger" id="delete_\${value}">삭제</button></div>
                </div>
            </div>
            `;
            return str;
        }

    </script>
</head>
<body>

<div id="div4navbar">
</div>

<div class="main-content p-4 my-3 container-fluid container-sm">
    <div class="container p-1 my-1 border card-creation-field row">
        <div class="card p-3 my-3">
            <div class="card-body row">
                <div id="cutting-board p-3" class="row align-items-center">
                    <div class="col-8">
                        <div class="row">
                            <input id="cutting-board-theater-name" value="극장" disabled>
                        </div>
                        <div class="row">
                            <input id="cutting-board-movie-name" value="영화" disabled>
                        </div>
                        <script>
                            let cuttingBoardTheaterName = document.querySelector('#cutting-board-theater-name');
                            let cuttingBoardMovieName = document.querySelector('#cutting-board-movie-name');
                            let cuttingBoardTheaterId = null;
                            let cuttingBoardMovieId = null;
                        </script>
                    </div>
                    <div class="col-4">
                        <button id="btn-insert" class="btn btn-primary">입력</button>
                    </div>
                </div>
            </div>
            <div class="card-body row">
                <div class="col">
<%--                    <div class="row">--%>
<%--                        자주 가는 극장--%>
<%--                    </div>--%>
<%--                    <div class="row">--%>
<%--                        근처의 극장--%>
<%--                    </div>--%>
                    <div id="div-search_region" class="row">
                        <div class="row align-items-center d-flex align-items-baseline">
                            <div class="col">
                                <label for="search_region">극장 검색</label><br><input id="search_region" placeholder="ex)서울, 용인, 죽전.."><button class="btn btn-primary" id="btn-search_region">검색</button>
                                <div id="search_result">
                                    <div id="search_result_page"></div>
                                    <div id="search_result_bar"></div>
                                </div>
                            </div>
                            <div class="col">
                                <label for="on-screen-list">영화 목록</label><br>
                                <select class="form-select" id="on-screen-list">
                                </select>
                            </div>
                        </div>
                        <script>
                            let theater_id; // number_company

                            let keyword = document.querySelector('#search_region').value;
                            document.querySelector('#btn-search_region').addEventListener('click', function (){
                                keyword = document.querySelector('#search_region').value;
                                if(keyword === ""){
                                    alert("DB가 아파해요!");
                                }else {
                                    getTheater(document.querySelector('#search_region').value, function (data) {
                                        let parsed = JSON.parse(data);
                                        console.log(parsed);
                                        document.querySelector('#search_result_bar').innerHTML = toPagination(parsed);
                                        pageFunction(1);
                                    })
                                }
                            })

                            function toPagination(parsed){
                                let str = `<ul class="pagination">`;
                                for (let i = 1; i < 1+parsed.totalPageNumber; i++) {
                                    str += `<li class="page-item"><a class="page-link" href="#" onclick='pageFunction(`+i+`)'>`+ i +`</a></li>`;
                                }
                                str += `</ul>`;
                                return str;
                            }

                            function pageFunction(i){
                                pageRequest(i, function (data){
                                    let parsed = JSON.parse(data);
                                    console.log(parsed);
                                    console.log(parsed.list.length);
                                    let str = '<table class="table table-hover"><tbody>';
                                    for (let i = 0; i < parsed.list.length; i++) {
                                        str += "<tr><td class='theater-name table-hover' value="+ parsed.list[i].theater_id+"_"+parsed.list[i].theater_company +">"+parsed.list[i].theater_name+"</td></tr>";
                                    }
                                    str += '</tbody></table>';
                                    document.querySelector('#search_result_page').innerHTML = str;
                                    let theaterNames = document.querySelectorAll('.theater-name');
                                    for (let i of theaterNames) {
                                        i.addEventListener('click', function (){
                                            theater_id = i.getAttribute('value');
                                            cuttingBoardTheaterName.value = i.innerHTML;
                                            cuttingBoardTheaterId = theater_id;
                                            console.log(theater_id);
                                            getOnScreenMovieList(theater_id, function (data){
                                                let parsedData = JSON.parse(data);
                                                console.log(parsedData);
                                                document.querySelector('#on-screen-list').innerHTML = "";
                                                for(let i in parsedData){
                                                    let option = document.createElement('option');
                                                    option.value = i;
                                                    option.innerHTML = parsedData[i];
                                                    document.querySelector('#on-screen-list').appendChild(option);
                                                }
                                            });
                                        })
                                    }
                                })
                            }

                            function getOnScreenMovieList(theater_id, callback){
                                $.ajax({
                                    url: 'getOnScreenMovieList',
                                    type: 'GET',
                                    data: {
                                        theaterId: theater_id
                                    },
                                    success: function (data) {
                                        callback(data);
                                    },
                                    error: function (request, status, error) {
                                        console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                                    }
                                })
                            }

                            function pageRequest(i, callback){
                                $.ajax({
                                    url: 'getTheaterByKeyword',
                                    type: 'GET',
                                    data: {
                                        keyword: keyword,
                                        pageNumber: i,
                                        pageSize: 5
                                    },
                                    success: function (data) {
                                        callback(data);
                                    },
                                    error: function (request, status, error) {
                                        console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                                    }
                                })
                            }

                            document.querySelector('#btn-insert').addEventListener('click', function (){
                                console.log(cuttingBoardTheaterId);
                                console.log(cuttingBoardMovieId);
                                console.log(lineId);
                                $.ajax({
                                    url: 'alarm/insertAlarm',
                                    type: 'GET',
                                    data: {
                                        theaterId: cuttingBoardTheaterId,
                                        movieId: cuttingBoardMovieId,
                                        lineId: lineId
                                    },
                                    success: function (data) {
                                        console.log(data);
                                        // value : theaterId_theaterCompany_movieId
                                        let value = cuttingBoardTheaterId + "_" + cuttingBoardMovieId;
                                        $('.card-field').append(constructAlarmCard(cuttingBoardTheaterName.value, cuttingBoardMovieName.value, value))
                                        let btn = document.querySelector('#delete_'+value);
                                        btn.addEventListener('click', function (){
                                            let company = this.id.split('_')[2];
                                            let theaterId = this.id.split('_')[1];
                                            console.log(company);
                                            console.log(theaterId);
                                            $.ajax({
                                                url: 'alarm/deleteAlarm',
                                                type: 'GET',
                                                data: {
                                                    lineId: lineId,
                                                    theaterId: theaterId,
                                                    movieId: cuttingBoardMovieId,
                                                    theaterCompany: company
                                                },
                                                success: function (data) {
                                                    console.log(data);
                                                    document.querySelector('#delete_'+value).parentElement.parentElement.parentElement.remove();
                                                    //location.reload();
                                                },
                                                error: function (request, status, error) {
                                                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                                                }
                                            })
                                        })
                                    },
                                    error: function (request, status, error) {
                                        console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                                    }
                                })
                            })

                            document.querySelector('#on-screen-list').addEventListener('change', function (){
                                cuttingBoardMovieName.value = document.querySelector('#on-screen-list').options[document.querySelector('#on-screen-list').selectedIndex].text;
                                cuttingBoardMovieId = document.querySelector('#on-screen-list').value;
                                console.log(cuttingBoardMovieId);
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container p-1 my-1 border card-field row">
    </div>
</div>
<%--<div class="main-content p-1 my-1 container-fluid container-sm">--%>
<%--    <div class="container p-1 my-1 border card-field">--%>
<%--    </div>--%>
<%--</div>--%>

</body>
</html>