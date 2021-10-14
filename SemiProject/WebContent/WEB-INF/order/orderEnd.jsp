<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../header.jsp" />


<div class="container">
	<div class="jumbotron">
	<!-- 점보트론은 특별한 내용이나 정보에 대한 추가 주의를 환기시키기 위한 큰 회색 상자를 나타내는 것입니다. -->
		<h2 class="display-4"><i class="fas fa-shopping-basket"></i>Thank you for your purchase!</h2>
		<p class="lead">주문번호 : s20211005-15<br>주문일자 : 2021-10-05 22:45:57</p>
		<hr class="my-4">
		<p>고객님의 주문이 완료 되었습니다.</p>
		 주문내역 및 배송에 관한 안내는 <a href="../mypage/orderList.go" style="color: blue;">주문조회</a> 를 통하여 확인 가능합니다.
	</div>	
</div>


<jsp:include page="../footer.jsp" />