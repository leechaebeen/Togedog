<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Togedog</title>
<!-- 파비콘 적용 -->
<link rel="shortcut icon" href="favicon.ico">
<link rel="icon" href="images/favicon.png">
<script src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/signup.css">
<style type="text/css">
	#content
	{
		color: #787878;
		font-size: 15px;
	}
</style>
</head>
<body>

<c:import url="HeaderMain.jsp"></c:import>

<div id="content">
<div class="container-fluid">
	<div class="row">
		<div class="col-md-4 col-sm-4 col-4"></div>
		<div class="col-md-4 col-sm-4 col-4" style="width: 500px;">
			<br><br><br><br><br>
				<span style="font-size: 20px; font-weight: bold; color: #3F6ABF">
				회원탈퇴가 완료되었습니다.
				</span><br><br>
				<span style="font-weight: bold;">투게도그해서 즐거웠어요. 그리워지면 다시 찾아와주세요!</span>
				<br><br><br>
				<button type="button" class="btn" style="width: 250px; font-size: 15px;"
				onclick="location.href='<%=cp%>/firstmain.action'">메인으로 돌아가기</button>
			<br><br><br><br><br><br>
		</div>
		<div class="col-md-4 col-sm-4 col-4"></div>
		</div>
	</div>
</div>

<c:import url="FooterWeb.jsp"></c:import>

</body>
</html>