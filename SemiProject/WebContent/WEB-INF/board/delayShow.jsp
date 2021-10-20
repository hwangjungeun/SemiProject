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

#container {
    width: 1250px;
    margin: auto;
}

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: auto;
}

div.typeWrite{
	width: 1250px;
	vertical-align: middle;
	margin: auto;
}

img {
	display: block;
	width: 1000px;
	height: auto;
	margin-top: 70px;
	margin-left: 100px;
}


table.tbl {
    width: 1200px;
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
span.date {
	font-weight: bold;
}
span.txtNum {
	color: #737373;
}

td#btt {
	border-bottom: 1px solid #dfdfdf;
}
tr.view {
	border-top: hidden;
	border-bottom: 1px solid #dfdfdf;
}
span#delaylist {
	font-weight: bold;
	font-size: 12pt;
}
span#delayred {
	font-weight: bold;
	font-size: 12pt;
	color: red;
}
.button {
	width: 100px;
	height: 32px;
	border: 1px solid #8c8c8c;
    float: right;
    text-align: center;
    font-size: 10pt;
    padding: 5px;
    margin-right: 25px;
}


</style>


<jsp:include page="../header.jsp" />



<div id="container">
     <div id="contents">


	<div class="titleArea">
            <h2><font color="#333333">DELAY</font> </h2>
            <p class="desc">입고 지연 게시판입니다.</p>
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
				   <td>&nbsp;&nbsp;10/15 금 기준 입고 예정일 안내</td>
				</tr>
				<tr id="bt">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;작성자</th>
				   <td id="btt">&nbsp;&nbsp; oh! daily</td>
                            <td><span class="date">date</span><span class="txtNum">&nbsp;2021-10-01</span></td>
		        </tr>
				<tr>
				   <td colspan="2"><img src="../images/delay.png" alt=""></td>		
				</tr>   
				<tr>
				   <td colspan="2">
				   	<br><br>
				   	<p><span id="delaylist">ailee wrap cardigan (4color)<br>▶ 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">air cap (2color)<br>▶ 네이비컬러 10/15쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">arne tee (4color)<br>▶ 아이보리컬러 10/17쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">baul squre knit (5color)<br>▶ 아이보리컬러 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">bene crop cardigan (3color)<br>▶ 아이보리컬러 10/17쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">blando cardigan (3color)<br>▶ 아이보리컬러 10/25쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delayred">bolo wrap cardigan (4color)<br>▶ 다음주 주중 순차입고예정 / ※ 주문폭주! 여유있는 주문 부탁드립니다.</span></p>
				   	<p><span id="delaylist">butter bag (2color)<br>▶ 버터컬러 10/25쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">cobiro short pants (2color)<br>▶ 네이비컬러 일부 오늘(10/15) 순차입고 및 순차배송 후, 10/4쯤 순차입고 및 순차배송 될 예정입니다. </span></p>
				   	<p><span id="delaylist">coconut jogger pants (6color)<br>▶ 10/24쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delayred">cutout knit (3color)<br>▶ 베이지컬러 일부 오늘(10/15) 순차입고 및 순차배송 후, 다음주 주중 순차입고 및 순차배송 될 예정입니다. / ※ 주문폭주! 여유있는 주문 부탁드립니다.</span></p>
				   	<p><span id="delaylist">deeper tee (4color)<br>▶그린컬러 10/22쯤 순차입고 및 순차배송 될 예정입니다. </span></p>
				   	<p><span id="delaylist">enne sleeveless (5color)<br>▶ 아이보리컬러 10/17쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">falling tee (3color)<br>▶ 10/17쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">fever knit (3color)<br>▶ 소라컬러 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">figure wide pants (2color)<br>▶ 베이지(M)컬러 10/24쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">humor jacket (3color)<br>▶ 네이비컬러 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delayred">katlyn cardigan (2color)<br>▶ 일부 오늘(10/15) 순차입고 및 순차배송 후, 10/4쯤 순차입고 및 순차배송 될 예정입니다. / ※ 주문폭주! 여유있는 주문 부탁드립니다. </span></p>
				   	<p><span id="delaylist">kong wool vest (2color)<br>▶ 그린컬러 10/23쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">like knit set (4color)<br>▶ 핑크컬러 일부 오늘(10/15) 순차입고 및 순차배송 후, 10/6쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">lucy alpaca knit (5color)<br>▶ 10/25쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">maria wool collar knit (3color)<br>▶ 소라/아이보리컬러 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">milkshake cardigan (4color)<br>▶ 브라운컬러 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">mudy cardigan (4color)<br>▶ 소라/그레이컬러 일부 오늘(10/15) 순차입고 및 순차배송 후, 10/6쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">noi slacks (3color)<br>▶ 브라운(S)컬러 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">normal denim (2color)<br>▶ 화이트컬러 일부 오늘(10/15) 순차입고 및 순차배송 후, 10/16쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">odds crop tee (3color)<br>▶ 그레이컬러 일부 오늘(10/1) 순차입고 및 순차배송 후, 10/15쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">plot tee (4color)<br>▶ 일부 오늘(10/15) 순차입고 및 순차배송 후, 10/4쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delayred">pole cashmere knit (4color)<br>▶ 멜론컬러 일부 오늘(10/15) 순차입고 및 순차배송 후, 10/24쯤 순차입고 및 순차배송 될 예정입니다. / ※ 주문폭주! 여유있는 주문 부탁드립니다.</span></p>
				   	<p><span id="delaylist">poy twoway crop knit (3color)<br>▶ 브라운컬러 10/25쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delayred">puddy cashmere cardigan (6color)<br>▶ 레드컬러 10/24쯤 순차입고 및 순차배송 될 예정입니다.  / ※ 주문폭주! 여유있는 주문 부탁드립니다.</span></p>
				   	<p><span id="delaylist">purin blouse<br>▶ 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">rico argyle cardigan<br>▶ 10/17쯤 순차입고 및 순차배송 될 예정입니다.</span></p>	
				   	<p><span id="delaylist">sente knit (3color)<br>▶ 오트밀컬러 10/16쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">shure cotton pants (3color)<br>▶ 크림컬러 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">slom alpaca knit (4color)<br>▶ 일부 오늘(10/15) 순차입고 및 순차배송 후, 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">sole wool jogger pants (3color)<br>▶ 그레이컬러 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">space pants (2color)<br>▶ 카키(M)컬러 10/24쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">tickle cardigan (3color)<br>▶ 10/25쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">tooth tee (5color)<br>▶ 화이트컬러 10/24쯤 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<p><span id="delaylist">union denim<br>▶ S사이즈 다음주 주중 순차입고 및 순차배송 될 예정입니다.</span></p>
				   	<br><br> 	
				   </td>
				   </tr>

		 </table>
</div>
<br>
		<div class="button">	
            <a href="<%=ctxPath%>/board/delay.go">목록</a>
        </div>

<br><br><br><br><br><br><br><br><br><br><br><br>


</div>
</div>

<jsp:include page="../footer.jsp" />
