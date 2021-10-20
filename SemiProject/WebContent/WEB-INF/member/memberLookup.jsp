<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>



<jsp:include page="/WEB-INF/header.jsp" />
<%-- 헤더 끝 --%>


<style>
	
	

 	.titleArea h2 {
    display: inline-block;
    position: relative;
    margin: 20px auto 10px;
    padding: 8px 15px;
    min-width: 150px;
    color: #353535;
    font-size: 13px;
    letter-spacing: 1px;
    border: 1px #ddd solid;
    *display: inline;
    text-transform: uppercase;
	}

	h2 {
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
	}

	.titleArea {
    margin: 0 0 30px;
    text-align: center;
	}
	
	/* 적립금 박스 양식  */
	#myinfo ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
	}
    
    
    .ec-base-box.gHalf {
    position: relative;
    padding: 20px 0;
	}
   
   	/* 적립금 박스 디자인 */
    .ec-base-box {
    padding: 20px;
    margin-left: auto;
    margin-right: auto;
    border: 1px solid #dfdfdf;
    color: #555;
	}
	
	li {
    display: list-item;
    text-align: -webkit-match-parent;
	}
	
	li {
    list-style: none;
	}
	
	.xans-myshop-asyncbankbook ul li {
    /*float: left;*/  
    margin: 5px 0;
  	padding: 0 45px;
    width: 50%;
    height: 20px; 
    font-size: 12px;
    line-height: 1.6;
    vertical-align: top;
  	box-sizing: border-box;  
	}
	
	.xans-myshop-asyncbankbook ul li strong {
    font-weight: normal;
	}
	
	myshop-asyncbankbook .title {
    float: left;
    width: 40%;
    font-weight: normal;
    box-sizing: border-box;
	}
	
	
	
	/* 박스안의 데이터들 위치 */
	.xans-myshop-asyncbankbook .data {
    /* float: left; */
    width: 47%;
    padding: 0 10px;
    text-align: right;
    box-sizing: border-box;
	}
	
	
	
	/* 조회 버튼과 연관있는 css  */
	[class^='btnNormal'], a[class^='btnNormal'] {
    display: inline-block;
    box-sizing: border-box;
    padding: 2px 8px;
    border: 1px solid #bbb;
    border-radius: 0;
    font-size: 11px;
    line-height: 18px;
    font-weight: normal;
    text-decoration: none;
    vertical-align: middle;
    word-spacing: -0.5px;
    letter-spacing: 0;
    text-align: center;
    white-space: nowrap;
    color: #353535;
    background-color: #fff;
    transition: all 0.15s ease;
    }
    
    
    
    
	
	
	
	#myshopMain {
    margin: 30px auto;
	}
	
	#myshopMain ul {
    display: flex;
    margin: 0 auto;
    border: 5px #dfdfdf solid;
    border-top: 2px #333 solid;
    border-width :medium;
	}
	
	#myshopMain .shopMain .box a {
    display: block;
    padding: 20px;
    
	}
	
	#myshopMain .shopMain .box{
	border: 1px #dfdfdf solid;
	border-bottom-color: white;
	}
	
	#myshopMain .shopMain .box7{
	border: none;
	display: block;
    padding: 20px;
	}
	
	#myshopMain .shopMain {
    flex: 1;
    position: relative;
    float: left;
    box-sizing: border-box;
    border-width :medium;
    text-align: center;
	}
 	
 	
 	::selection {
    background: #888;
    color: #fff;
    text-shadow: none;
	}

	
	
	


div#any{
	clear:both;
}



</style>


<div class="titleArea">
    <h2>MY PAGE</h2>
</div>

<div id="myshopMain" class="xans-element- xans-myshop xans-myshop-main ">

<ul>
		<li class="shopMain order">
            <div class="box">
                <a href="#">
                  <h3>Order</h3>
                  <p>주문 정보</p>
                </a>
            </div>
        </li>
        <li class="shopMain profile">
            <div class="box">
                <a href="<%= ctxPath %>/member/memberEdit.go" style="cursor:pointer;">
                    <h3>Profile</h3>
                    <p>회원 정보</p>
                </a>
            </div>
        </li>
        <li class="shopMain wishlist">
            <div class="box">
                <a href="#">
                    <h3>Wish list</h3>
                    <p>관심 상품</p>
                </a>
            </div>  
        </li>
        <li class="shopMain likeIt displaynone">
            <div class="box">
                <a href="#">
                    <h3>Like it</h3>
                    <p>좋아요 상품</p>
                </a>
            </div>
        </li>
        <li class="shopMain mileage">
            <div class="box">
                <a href="<%= ctxPath %>/mypage/pointList.go?userid=${sessionScope.loginuser.userid}">
                    <h3>Mileage</h3>
                    <p>적립금 관리</p>
                </a>
            </div>
        </li>
        <li class="shopMain deposits displaynone">
            <div class="box">
                <a href="#">
                    <h3>Deposits</h3>
                    <p>예치금 관리</p>
                </a>
            </div>
        </li>
        <li class="shopMain consult displaynone">
            <div class="box">
                <a href="#">
                    <h3>Consult</h3>
                    <p>1:1 맞춤상담</p>
                </a>
            </div>
        </li>
        <li class="shopMain coupon 1">
            <div class="box">
                <a href="#">
                    <h3>Coupon</h3>
                    <p>쿠폰 목록</p>
                </a>
            </div>
        </li>
        <li class="shopMain board">
            <div class="box">
                <a href="#">
                    <h3>Board</h3>
                    <p>내 게시물 관리</p>
                </a>
            </div>
        </li>
        <li class="shopMain address">
            <div class="box7">
                <a href="<%= ctxPath %>/mypage/orderList.go?userid=${sessionScope.loginuser.userid}">
                    <h3>Address</h3>
                    <p>배송 주소록 관리</p>
                </a>
            </div>
        </li>
            </ul>
           
</div>

<div id = "myinfo" class="xans-element- xans-myshop xans-myshop-asyncbankbook ec-base-box gHalf">
	<ul>
		<li class=" ">
            <span class="title">가용적립금</span>
            <span class="data use">&nbsp;<span id="xans_myshop_bankbook_avail_mileage">0원</span></span>
            <a href="/myshop/mileage/historyList.html" class="btnNormal">조회</a>
        </li>
        <li class="">
            <strong class="title">총적립금</strong>
            <strong class="data"><span id="xans_myshop_bankbook_total_mileage">0원</span></strong>
        </li>
        <li class="">
            <strong class="title">사용적립금</strong>
            <strong class="data"><span id="xans_myshop_bankbook_used_mileage">0원</span></strong>
        </li>
      
        </ul>
        
        </div>
        <div>
        <ul>
        <li>
            <strong class="title">총주문</strong>
            <strong class="data"><span id="xans_myshop_bankbook_order_price">0원</span>(<span id="xans_myshop_bankbook_order_count">0</span>회)</strong>
        	  <li class="displaynone">
           <strong class="title"></strong>
           <strong class="data use">&nbsp;</strong>
           <a href="/myshop/deposits/historyList.html" class="btnNormal">조회</a>
        </li>
        </li>
        <li class="">
            <strong class="title">쿠폰</strong>
            <strong class="data"><span id="xans_myshop_bankbook_coupon_cnt">1</span><span>개</span></strong>
            <a href="/myshop/coupon/coupon.html" class="btnNormal">조회</a>
        </li>
        </ul>
        </div>
    




<div id = "any">
&nbsp;
</div>






<%-- 풋터 시작 --%> 
<jsp:include page="/WEB-INF/footer.jsp" />