<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     

<%
	String ctxPath = request.getContextPath();
	//		/SemiProject
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="/SemiProject/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<style type="text/css">

#contents {
    position: relative;
    margin: 0 auto;
    min-height: 800px;
}

.titleArea {
    margin: 0 0 30px;
    text-align: center;
}

.titleArea h2 {
    display: inline-block;
    position: relative;
    margin: 10px auto 10px;
    padding: 8px 15px;
    min-width: 180px;
    color: #353535;
    font-size: 11pt;
    font-weight: bold;
    letter-spacing: 1px;
    border: 1px #ddd solid;
}
p.desc {
	font-size: 9pt;
}
.box{
	text-align: center;
}
#container {
    width: 1250px;
    margin: auto;
}

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: 1200px;
}

table.tbl {
    width: 1100px;
    margin: auto;
    border-top: 1.5px solid #dfdfdf;
    border-bottom: 1px solid #dfdfdf;
    line-height: 3.5;
    border-left: hidden;
    border-right: hidden;
  }
tr#top {
	border-top: 1px solid #dfdfdf;
}
tr#bt {
	border-top: hidden;
	border-bottom: 1px solid #dfdfdf;
}

th {
	font-size: 9pt;
    padding: 12px 0px 12px 18px;
}
td {
	font-size: 9pt;
    padding: 8px 0px 7px;
}
script {
	text-align: center;
}
span#shr {
	font-weight: bold;
	font-size: 9pt;
}
.button {
	width: 100px;
	height: 32px;
	border: 1px solid #8c8c8c;
    float: right;
    text-align: center;
    font-size: 10pt;
    padding: 5px;
    margin-right: 10px;
}

</style>

<jsp:include page="../header.jsp" />

<div class="container">
	<div id="contents">
	  	<div class="titleArea" >
           <h2 id="event" align="center" ><font color="#333333">SHOWROOM</font> </h2>
           <p class="desc" align="center">오시는길 안내</p>
           <p class="imgArea"><img src="https://nearwear.co.kr/web/upload/bc4d43b5f82e421450e1539def2717e1.jpg"></p>
     	</div>

		<div class="typeWrite ">
            <table class="tbl">

			<colgroup>
			<col style="width:130px;">
			<col style="width:auto;">
			<col style="width:130px;">
			</colgroup> 

				<tr id="top">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;제목</th>
				   <td>오!데일리 쇼룸 오시는길 :)</td>
				</tr>
				<tr id="bt">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;작성자</th>
				   <td id="btt">oh! daily</td>
                            <td><span class="date">date</span><span class="txtNum">&nbsp;2021-10-15</span></td>
		        </tr>  
				<tr>
				   <td colspan="2">
				   	<br><br>
				   	<p><!-- * 카카오맵 - 지도퍼가기 -->
					<!-- 1. 지도 노드 -->
					<div id="daumRoughmapContainer1634109936879" class="root_daum_roughmap root_daum_roughmap_landing"></div>

					<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
					
					<!-- 3. 실행 스크립트 -->
					<script charset="UTF-8">
						new daum.roughmap.Lander({
							"timestamp" : "1634109936879",
							"key" : "27ozq",
							"mapWidth" : "800",
							"mapHeight" : "520"
						}).render();
					</script>
					<br>
					<span id="shr">위치 :</span>&nbsp;서울 마포구 월드컵북로 21 풍성빌딩 2~4층 (우) <br>
					<span id="shr">번호 :</span>&nbsp;02) 336-8546 <br>
					<span id="shr">운영 시간 :</span>&nbsp;평일 AM 09:00 - PM 18:00 <br><br>
					</p>

				   </td>
			 </table>
		</div>
		<br>
		<div class="button">	
            <a href="<%=ctxPath%>/index.go">홈으로</a>
        </div>
        <br>
	</div>
</div>

<jsp:include page="../footer.jsp" />

