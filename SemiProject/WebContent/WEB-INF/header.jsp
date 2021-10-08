<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>


<html lang="ko">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>오!데일리</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%=ctxPath %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%=ctxPath %>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%=ctxPath %>/jquery-ui-1.11.4.custom/jquery-ui.js"></script> 

<style type="text/css">
	ul {
		list-style-type: none;
		padding-left: 0;  
	}
	div#footer{
		background-color: #f2f2f2;
	}	
	a.navbar-brand {
		color: #4d4d4d;
		font-family: Copperplate, Fantasy;
		font-size: 28pt;
	}
	div#click{
		font-size: 9pt;
	}
	a#Dropdown{
		font-size: 9pt;
	}
	a.nav-link{
		font-size: 9pt;
	}
	span.badge {
		position: absolute; 
		right: 15px;
		top: 58px;
	}
	div a {
		color: black;
	}
	
	h2 {
		display: block;
	    font-size: 12px;
	    font-weight: bold;
	}
	h4 {
	    font-size: 11px;
	    display: block;
	    font-weight: bold;
	}
	h3 {
	    display: block;
	    font-size: 13px;
	    font-weight: bold;
	}
	
	.bottomArea > a{
	margin-left:10px;
	font-size : 10pt;
	font-weight : bold;
	color: #ffe6e6;
	display : inline-block;
	}
	
	
</style>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		var html = "<ol class='carousel-indicators'>";
		for(var i = 0; i<11; i++) {
			if(i == 0) {
				html += "<li data-target='#carouselExampleIndicators' data-slide-to='0' class='active'></li>";
			}
			else {
				html += "<li data-target='#carouselExampleIndicators' data-slide-to='"+i+"'></li>";
			}
		}
		html += "</ol>";
		
		$("div#olli").html = html;
	});
	
	function goLogOut(){
		
		// 로그아웃을 처리해주는 페이지로 이동
		location.href = "<%=request.getContextPath()%>/login/logout.go";
		
	}
	
	
</script>

</head>
<body>
	<div class="container-fluid p-3" style="background-color: #ffe6e6;" ></div>
	
	<!-- 상단 네비게이션 시작 -->
	<div class = "container">
		<nav class="navbar">
			<div  class="container-fluid float-right">
				<form class="form-inline ml-auto my-2 my-lg-0">
					<input class="form-control mr-sm-2 border border-top-0 border-right-0 border-left-0" type="search">
					<button class="btn my-2 my-sm-0" type="submit"><i class="fas fa-search"></i></button>
			    </form>
			</div>

			<div class="topArea container-fluid navbar-header mx-auto text-center">
				<a class="navbar-brand mx-auto mb-3" href="<%= ctxPath %>/index.go">o H ! &nbsp; D a i L Y</a>
				<i class="fas fa-shopping-basket fa-2x"></i>
				<span class="badge badge-pill badge-light text-black-50">0</span>
			</div>
			
			<div class="bottomArea ml-auto my-3">
			<c:if test ="${empty sessionScope.loginuser}">
				<a href="<%= ctxPath %>/login/logintry.go">LOGIN</a>
				<a href="<%= ctxPath %>/member/memberRegister.go">JOIN US</a>
			</c:if>
			
			<!-- 세션에 로그인 유저 아이디가 있을때 , 즉 로그인 성공 했을 때 -->
			<c:if test = "${not empty sessionScope.loginuser }">
			
                                   어서오세요[<span style="color: black; font-weight: bold;">${(sessionScope.loginuser).name}</span>]님
                <br/>다양하고 특별한 혜택을 누리세요!
                 &nbsp; &nbsp;<button type="button" class="btn btn-danger" onclick="goLogOut()">로그아웃</button><br/>
             
		    	<a href="<%= ctxPath %>/member/memberRegister.go">MyPage</a>
			</c:if>
			<!-- 어드민으로 로그인 했을때 만 매니저 란이 활성화 된다.  -->
			<c:if test = "${(sessionScope.loginuser).userid == 'admin' }">
				<a href="#">MANAGER</a>
			</c:if>
				<a href="#">NOTICE</a>
				<a href="#">Q&amp;A</a>
			</div>
		</nav>
			
		<!-- 아코디언 같은 Navigation Bar 만들기 -->
		<nav class="navbar navbar-expand-md navbar-light">
			<button class="navbar-toggler ml-auto" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>
			
			<div class="collapse navbar-collapse" id="collapsibleNavbar">
				<ul class="nav mx-auto">
					<li class="nav-item mx-2"><a class="nav-link" href="#">BEST</a></li>
					<!-- <li class="nav-item mx-2"><a class="nav-link" href="#">NEW 5%</a></li> -->
					<li class="nav-item mx-2">
						<a class="nav-link" href="#" id="outerDropdown" data-toggle="dropdown">OUTER</a>
						<div class="dropdown-menu" aria-labelledby="outerDropdown">
				           <a class="dropdown-item" href="#">코트</a>
				           <a class="dropdown-item" href="#">자켓</a>
				           <a class="dropdown-item" href="#">가디건</a>
				           <a class="dropdown-item" href="#">야상</a>
				           <a class="dropdown-item" href="#">패딩</a>
				         </div>
					</li>
					
					<li class="nav-item mx-2">
						<a class="nav-link" href="#" id="topDropdown" data-toggle="dropdown">TOP</a>
						<div class="dropdown-menu" aria-labelledby="topDropdown">
				           <a class="dropdown-item" href="#">티셔츠</a>
				           <a class="dropdown-item" href="#">민소매</a>
				           <a class="dropdown-item" href="#">맨투맨/후드</a>
				           <a class="dropdown-item" href="#">니트</a>
				         </div>
					</li>
					<li class="nav-item mx-2">
						<a class="nav-link" href="#" id="blouseDropdown" data-toggle="dropdown">BLOUSE</a>
						<div class="dropdown-menu" aria-labelledby="blouseDropdown">
				           <a class="dropdown-item" href="#">BLOUSE</a>
				           <a class="dropdown-item" href="#">SHIRTS</a>
				         </div>
					</li>
					<li class="nav-item mx-2">
						<a class="nav-link" href="#" id="pantsDropdown" data-toggle="dropdown">PANTS</a>
						<div class="dropdown-menu" aria-labelledby="blouseDropdown">
				           <a class="dropdown-item" href="#">데님</a>
				           <a class="dropdown-item" href="#">반바지</a>
				           <a class="dropdown-item" href="#">긴바지</a>
				           <a class="dropdown-item" href="#">슬렉스</a>
				         </div>
					</li>
					<li class="nav-item mx-2">
						<a class="nav-link" href="#" id="skirtDropdown" data-toggle="dropdown">SKIRT</a>
						<div class="dropdown-menu" aria-labelledby="skirtDropdown">
				           <a class="dropdown-item" href="#">미니</a>
				           <a class="dropdown-item" href="#">미디</a>
				           <a class="dropdown-item" href="#">롱</a>
				         </div>
					</li>
					<li class="nav-item mx-2">
						<a class="nav-link" href="#" id="dressDropdown" data-toggle="dropdown">DRESS</a>
						<div class="dropdown-menu" aria-labelledby="dressDropdown">
				           <a class="dropdown-item" href="#">One-Piece</a>
				           <a class="dropdown-item" href="#">Two-Piece</a>
				         </div>
					</li>
					<li class="nav-item mx-2"><a class="nav-link" href="#">SHOES &amp; BAG</a>
					<div class="dropdown-menu" aria-labelledby="Dropdown">
				           <a class="dropdown-item" href="#">신발</a>
				           <a class="dropdown-item" href="#">가방</a>
				    </div>
					</li>
					<li class="nav-item mx-2">
						<a class="nav-link" href="#" id="accDropdown" data-toggle="dropdown">ACC</a>
						<div class="dropdown-menu" aria-labelledby="accDropdown">
				           <a class="dropdown-item" href="#">귀걸이</a>
				           <a class="dropdown-item" href="#">기타</a>
				         </div>
					</li>
					<!-- <li class="nav-item mx-2"><a class="nav-link" href="#">당일발송</a></li> -->
					<!-- <li class="nav-item mx-2"><a class="nav-link" href="#">SALE</a></li> -->
					<li class="nav-item mx-2">
						<a class="nav-link" href="#" id="Dropdown" data-toggle="dropdown">COMMUNITY</a>
						<div class="dropdown-menu" aria-labelledby="Dropdown">
				           <a class="dropdown-item" href="#">Notice</a>
				           <a class="dropdown-item" href="/WEB-INF/board/qna.jsp">Q &amp; A</a>
				           <a class="dropdown-item" href="#">Review</a>
				           <a class="dropdown-item" href="/WEB-INF/board/event.jsp">Event</a>
				           <a class="dropdown-item" href="/WEB-INF/board/delay.jsp">Delay</a>
				         </div>
					</li>
				</ul>
			</div>
		</nav>
	</div>
	<!-- 상단 네비게이션 끝 -->