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
            console.log(parsed)
            for(let i of parsed){
                $('.card-field').append(constructAlarmCard(i));
            }
        });

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

        function constructAlarmCard(alarm){
            let str = `
            <div class="card p-3 my-3">
                <div class="card-body row">
                    \${alarm.theater_id} \${alarm.movieCd}
                </div>
            </div>
            `;
            return str;
        }
    </script>
</head>
<body>

<%--<div class="card p-3 my-3">--%>
<%--    <div class="card-body row">--%>
<%--        <h4 class="card-title col">#1</h4>--%>
<%--        <div class="inside-text distance">--%>
<%--        </div>--%>
<%--        <p class="card-text">--%>
<%--        <div class="inside-text schedule">--%>
<%--            <div class="spinner-border"></div>--%>
<%--        </div>--%>
<%--        </p>--%>
<%--        <a href="" class="card-link">극장 상세정보</a>--%>
<%--    </div>--%>
<%--</div>--%>

<div id="div4navbar">
</div>

<div class="main-content p-1 my-5 container-fluid container-sm">
    <div class="container p-1 my-2 border card-creation-field">
    </div>
</div>
<div class="main-content p-1 my-5 container-fluid container-sm">
    <div class="container p-1 my-2 border card-field">
    </div>
</div>

</body>
</html>