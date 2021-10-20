<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 필요한 클래스를 import 하려면 <%@ page %>  page directive(페이지 지시어)를 사용하여 import 를 한다. --%>    
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>

<jsp:include page="../header.jsp" />

<% 
	//현재날짜와 시간을 알아오는 메소드 생성하기
	Date now = new Date(); // 현재시각
	
	SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String today = sdformat.format(now);
%>

<div class="container">
	<div class="jumbotron">
	<!-- 점보트론은 특별한 내용이나 정보에 대한 추가 주의를 환기시키기 위한 큰 회색 상자를 나타내는 것입니다. -->
		<h2 class="display-4"><i class="fas fa-shopping-basket"></i>Thank you for your purchase!</h2>
		<p class="lead">주문번호 : ${requestScope.odrcode}<br>주문일자 : <%= today%></p>
		<hr class="my-4">
		<p>고객님의 주문이 완료 되었습니다.</p>
		 주문내역 및 배송에 관한 안내는 <a href="../mypage/orderList.go" style="color: blue;">주문조회</a> 를 통하여 확인 가능합니다.
	</div>	
</div>


<jsp:include page="../footer.jsp" />