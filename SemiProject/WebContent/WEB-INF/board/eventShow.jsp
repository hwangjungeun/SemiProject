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


img {
	display: block;
	width: 600px;
	height: auto;
	margin: auto;
}

table.tb {
	text-align: center;
	margin: auto;
	width: 1000px;
	
	border-top-color: dark;
	border-bottom-color: dark;
}
table#tb {
	text-align: center;
	margin: auto;
}


</style>


<jsp:include page="../header.jsp" />

<div id="wrap">
    <div id="header">
    <div class="inner">
        <div class="topArea">
            
</div>
</div>
<!-- //category -->
</div><!-- //sidebar --> 
    <div id="container">
        <div id="contents">
            
<div class="xans-element- xans-board xans-board-readpackage-8 xans-board-readpackage xans-board-8 "><div class="xans-element- xans-board xans-board-title-8 xans-board-title xans-board-8 "><div class="path">

            <ol>
<li><a href="<%=ctxPath%>/index.go">home</a></li>
                <li title="현재 위치"><strong>EVENT</strong></li>
            </ol>
</div>
<div class="titleArea">
            <h2><font color="#333333">EVENT</font> </h2>
            <p class="desc">이벤트 공지 게시판입니다.</p>
        </div>
</div>

<div class="ec-base-table typeWrite ">
            <table class="tb" border="1">

<tr>
<th scope="row">제목</th>
<td>2020 크리스마스 무료배송 이벤트</td>
</tr>
<tr>
<th scope="row">작성자</th>
<td> nearwear </td>
                    
</tr>
<tr>
			<td colspan="2" align="center"><img src="../images/event.png" alt=""></td>			
		</tr>

<tr class="view">
<td colspan="2">
                        <div class="detail"><br><div class="fr-view fr-view-article"><p><span style="color: rgb(136, 136, 136); font-family: Roboto, NanumBarunGothic, &quot;맑은 고딕&quot;, malgungothic, arial, AppleGothic, Dotum, sans-serif; font-size: 11px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">♥</span> merry christmas <span style="color: rgb(136, 136, 136); font-family: Roboto, NanumBarunGothic, &quot;맑은 고딕&quot;, malgungothic, arial, AppleGothic, Dotum, sans-serif; font-size: 11px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">♥</span></p><p>12/25 단하루, 무료배송으로 진행되어요 :-)</p><p><br></p><p><br></p><p><br></p><p>*타 쿠폰적용 가능해요.</p><p>*악세사리제품은 무배이벤트에서 제외되어요.</p></div></div>
                    </td>
                </tr>

</table>
</div>

<div class="ec-base-button ">
            
            <span class="gRight">
                <a href="/board/event/8/" class="btnNormalFix sizeS">목록</a>
                  </span>
                
                </div>


 

<jsp:include page="../footer.jsp" />
