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
	width: 700px;
	height: auto;
	margin-left: 20px;
	margin-top: 20px;
}


.ec-base-table table {

    width: 90%;
    position: relative;
    border-top: 1px solid #dfdfdf;
    border-bottom: 1px solid #dfdfdf;
    border-top: 0;
    color: #fff;
    line-height: 3;
  }

table {
    width: 1250px;
    border: 0;
    border-spacing: 0;
    border-collapse: collapse;
    text-indent: initial;
}

tr#top {
	border-top: 2px solid #dfdfdf;
}
tr#bt {
	border-top: hidden;
	border-bottom: 1px solid #dfdfdf;
}

th {
	font-size: 10pt;
    padding: 12px 0px 12px 18px;
}
td {
	font-size: 10pt;
    padding: 8px 0px 7px;
}
td#btt {
	border-bottom: 1px solid #dfdfdf;
}

.button {
	width: 100px;
	border: 1px solid #808080;
    float: right;
    text-align: center;
    font-size: 10pt;
}
.button a {display:block; height: 35px; padding:7px}
	

</style>


<jsp:include page="../header.jsp" />



<div id="container">
     <div id="contents">


	<div class="titleArea">
            <h2><font color="#333333">NOTICE</font> </h2>
            <p class="desc">공지사항입니다.</p>
    </div>


	<div class="typeWrite ">
            <table class="ec-base-table table">

			<colgroup>
			<col style="width:130px;">
			<col style="width:auto;">
			</colgroup> 

				<tr id="top">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;제목</th>
				   <td>&nbsp;&nbsp;가을맞이 리뷰 이벤트!</td>
				</tr>
				<tr id="bt">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;작성자</th>
				   <td id="btt">&nbsp;&nbsp; oh! daily </td>
		        </tr>
				<tr>
				   <td colspan="2"><img src="../images/notice1.png" alt=""><img src="../images/notice2.png" alt=""><img src="../images/notice3.png" alt=""></td>			
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

