<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
	String ctxPath = request.getContextPath();
	//		/SemiProject
%>    
<!DOCTYPE html>
<<<<<<< HEAD
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
=======
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
    line-height: 1.5;
>>>>>>> refs/heads/kimminkyung
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
tr.view {
	border-top: hidden;
	border-bottom: 2px solid #dfdfdf;
}
.button {
	width: 100px;
	height: 32px;
	border: 1px solid #808080;
    float: right;
    text-align: center;
    font-size: 10pt;
    padding: 5px;
}


</style>


<jsp:include page="../header.jsp" />



<div id="container">
     <div id="contents">


	<div class="titleArea">
            <h2><font color="#333333">EVENT</font> </h2>
            <p class="desc">????????? ?????? ??????????????????.</p>
    </div>


	<div class="typeWrite ">
            <table class="ec-base-table table">

			<colgroup>
			<col style="width:130px;">
			<col style="width:auto;">
			</colgroup> 

				<tr id="top">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;??????</th>
				   <td>&nbsp;&nbsp;2021 ???????????? ???????????? ?????????</td>
				</tr>
				<tr id="bt">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;?????????</th>
				   <td id="btt">&nbsp;&nbsp; oh! daily </td>
		        </tr>
				<tr>
				   <td colspan="2"><img src="../images/event.png" alt=""></td>			
				</tr>
		
				<tr class="view">
				   <td colspan="2">
		              <div class="detail"><br><div class="fr-view fr-view-article"><p><span style="color: rgb(136, 136, 136); font-family: Roboto, NanumBarunGothic, &quot;?????? ??????&quot;, malgungothic, arial, AppleGothic, Dotum, sans-serif; font-size: 11px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;???</span> welcome autumn <span style="color: rgb(136, 136, 136); font-family: Roboto, NanumBarunGothic, &quot;?????? ??????&quot;, malgungothic, arial, AppleGothic, Dotum, sans-serif; font-size: 11px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">???</span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;10/15 ?????????, ?????????????????? ??????????????? :-)</p><p><br></p><p><br></p><p>&nbsp;&nbsp;&nbsp;&nbsp;*??? ???????????? ????????????.</p><p>&nbsp;&nbsp;&nbsp;&nbsp;*????????????????????? ????????????????????? ???????????????.</p><br><br></div></div>
		           </td>
		        </tr>
		 </table>
</div>
<br>
		<div class="button">	
            <a href="<%=ctxPath%>/board/event.go">??????</a>
        </div>

<br><br><br><br><br><br><br><br><br><br><br><br>


</div>
</div>

<jsp:include page="../footer.jsp" />
