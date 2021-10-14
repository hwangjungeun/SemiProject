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
    width: 1200px;
    margin: auto;
}

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: auto;
}

div.typeWrite{
	width: 1200px;
	vertical-align: middle;
	margin: auto;
}

table.tbl {
    width: 1100px;
    margin: auto;
    border-top: 1.5px solid #dfdfdf;
    border-bottom: 1.5px solid #dfdfdf;
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
td#content {
    font-size: 12px;
    line-height: 22px;
    min-height: 100px;
    text-align: center;
}
td#btt {
	border-bottom: 1px solid #dfdfdf;
}

.button {
	width: 100px;
	height: 32px;
	border: 1px solid #8c8c8c;
    float: right;
    text-align: center;
    font-size: 9pt;
    padding: 5px;
    margin-right: 50px;
}


</style>


<jsp:include page="../header.jsp" />



<div id="container">
     <div id="contents">


	<div class="titleArea">
            <h2><font color="#333333">NOTICE</font> </h2>
            <p class="desc">공지사항입니다.</p>
    </div>
	<br>

	<div class="typeWrite ">
            <table class="tbl">

			<colgroup>
			<col style="width:130px;">
			<col style="width:auto;">
			</colgroup> 

				<tr id="top">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;제목</th>
				   <td>&nbsp;&nbsp;적립금&쿠폰 시행 안내(21.09.27 시행)</td>
				</tr>
				<tr id="bt">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;작성자</th>
				   <td id="btt">&nbsp;&nbsp; oh! daily</td>
                            <td><span class="date">date</span><span class="txtNum">&nbsp;2021-09-27</span></td>
		        </tr>
				<tr>
				   <td colspan="2"><img src="../images/point.jpg" alt=""></td>		
				</tr>
		 </table>
</div>
<br>
		<div class="button">	
            <a href="<%=ctxPath%>/board/notice.go">목록</a>
        </div>

<br><br><br><br><br><br><br><br><br><br><br><br>


</div>
</div>

<jsp:include page="../footer.jsp" />

