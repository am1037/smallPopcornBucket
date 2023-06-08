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
    </script>
</head>
<body>

<div id="div4navbar">
</div>
<div class="main-content p-1 my-5 container-fluid container-sm">
    <div class="container p-1 my-2 border">
        <div class="card p-3 my-3">
            <div class="card-body row">
                <div class="inside-text distance">
                </div>
                <p class="card-text">
                    <div class="inside-text schedule">
                        <form action="sampleLogin">
                            <label for="sampleId">ID : </label><input id="sampleId" name="sampleId" value="apple">
                            <button type="submit">sample login</button>
                        </form>
                    </div>
                </p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
