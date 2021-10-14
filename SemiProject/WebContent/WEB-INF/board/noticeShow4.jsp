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
				   <td>&nbsp;&nbsp;주문 및 결제 안내</td>
				</tr>
				<tr id="bt">
				 <th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;작성자</th>
				   <td id="btt">&nbsp;&nbsp; oh! daily</td>
                            <td><span class="date">date</span><span class="txtNum">&nbsp;2021-10-01</span></td>
		        </tr>
				<tr>
				   <td id="content" colspan="2">
				   <p><br></p>
				   <p><br></p>
				   <p><br></p>
				   <p><strong>*주문 및 결제 안내&nbsp;</strong></p>
				   <p><br></p>
				   <p><strong>- 무통장 입금시 입금확인은 입금내역 자동화시스템으로 인해 입금 후 1~2시간 뒤 확인됩니다.</strong></p>
				   <p><br></p>
				   <p><strong>- 주문 완료 후 7일 이내 미입금시 입금전 자동취소 처리가 됩니다.</strong></p>
				   <p><br></p>
				   <p><strong>- 주문 취소와 상품 변경을 원하실 경우 배송준비 상태일 때 오후 2시전까지</strong></p>
				   <p><strong>전화나 Q&A 게시판에 문의주시면 확인후에 처리 가능하십니다.</strong></p>
				   <p><br></p>
				   <p><strong>- 적립금 포함하여 결제하신 주문건을 취소하실 경우 사용하신 적립금은 전액 반환되며</strong></p>
				   <p><strong>기타 결제금액은 실결제금액만 환불처리 됩니다.</strong></p>
				   <p><strong>부분취소시에도 사용하신 적립금은 적립금대로, 결제금액은 결제금액대로 환불되시니 참고 해 주세요.</strong></p>
				   <p><br></p>
				   <p><strong>- 입금자명, 입금금액이 다를 경우 입금확인이 어려우시니 입금 후 2일후에도 입금확인이</strong></p>
				   <p><strong>어려우실 경우 입금자명, 입금금액, 입금은행과 함께 전화나 Q&A 게시판으로 문의주시면</strong></p>
				   <p><strong>확인후에 입금 처리가 가능합니다.</strong></p>
				   <p><br></p>
				   <p><strong>- 입금차액은 자동으로 적립금 환불로 처리되시며 환불받으실 계좌,예금주,은행명과 함께 전화 혹은</strong></p>
				   <p><strong>Q&A 게시판에 문의를 남겨 주시면 현금환불이 가능합니다.</strong></p>
				   <p><br></p>
				   <p><strong>- 무통장입금 결제하신 고객님에 한해 현금영수증 발급이 가능하시며 주문서 작성시 직접 신청해 주시거나</strong></p>
				   <p><strong>주문서 작성 후 전화나 Q&A 게시판으로 문의주시면 확인후에 처리해 드립니다.</strong></p>
				   <p><br></p>
				   <p><br></p>
				   <p><br></p>
				   <p><br></p>
				   <p><br></p>
				   </td>		
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

