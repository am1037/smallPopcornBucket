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
    </script>
</head>
<body>

<div id="div4navbar">
</div>
<div class="main-content p-1 my-5 container-fluid container-sm">
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