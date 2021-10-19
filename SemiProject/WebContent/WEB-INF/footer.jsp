<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>


    <!-- 푸터 시작 -->
	<div id="footer" class="conatiner-fluid row py-5">
		<div class="footer-inner container">
			<ul class="pl-0">
				<li class="inner01">
					<div class="col-md-5">
						<h2>about us</h2>
						<p><span>company. (주)제니비인터네셔널</span></p>
						<p><span>owner. 이용민</span><span>personal info manager. 이용민</span></p>
						<p><span>tel. 070-4245-5548</span> <span>email. hariboyongribo@naver.com</span></p>
						<p><span>business no. 798-88-01292</span></p>
						<p><span>mail order license. 제 2019-부산부산진-0828호 <a href="#none" onclick="window.open('http://www.ftc.go.kr/bizCommPop.do?wrkr_no=7988801292', 'bizCommPop', 'width=750, height=950;');return false;">[사업자정보확인]</a></span></p>
						<p><span>address. [47366] 부산광역시 부산진구 자유평화로37번길 15-15 (범천동) 대교빌딩 1층 니어웨어</span></p>
						<h4 class="mt-15px">[교환/반품 주소지]</h4>
						<p>부산광역시 부산진구 범천동 839-26 대교빌딩 1층</p>
						<p>CJ대한통운 택배고객센터 : 1588-1255</p>
					</div>
				</li>
				
				<li class="inner02">
					<div class="col-md-3">
						<h2>c/s center</h2>
						<h3>070-4245-5548</h3>
						<h3>070-4245-5546</h3>
						<p>mon-fri am10:00-pm05:00</p>
						<p>lunch pm01:00-pm02:00</p>
						<p>sat,sun,holiday off</p>
						<h4>[무통장 계좌 안내]</h4>
						<p>국민 565001-01-542054</p>
						<p>예금주:(주)제니비인터네셔널</p>
					</div>
				</li>
				
				<li class="inner03">
					<div class="col-md-4">
						<div class="row">
							<div class="col-md-4">
								<h2>community</h2>
								<p><a href="<%= ctxPath%>/board/noticeList.go">NOTICE</a></p>
								<p><a href="<%= ctxPath%>/board/qnaList.go">Q&amp;A</a></p>
								<p><a href="<%= ctxPath%>/board/delay.go">DELAY</a></p>
								<p><a href="<%= ctxPath%>/board/review.go">REVIEW</a></p>
								<p><a href="<%= ctxPath%>/board/event.go">EVENT</a></p>
							</div>
							
							<div class="col-md-4">
								<h2>membership</h2>
								<p><a href="<%= ctxPath %>/member/memberRegister.go">회원가입</a></p>
								<p><a href="<%= ctxPath %>/login/idSearch.go">아이디 찾기</a></p>
								<p><a href="<%= ctxPath %>/login/pwdSearch.go">비밀번호 찾기</a></p>
								<p><a href="<%= ctxPath %>/mypage/orderList.go?userid=${sessionScope.loginuser.userid}">주문조회 바로가기</a></p>
								<p><a href="<%= ctxPath%>/product/recentViewProduct.go?userid=${sessionScope.loginuser.userid}">최근 본 상품</a></p>
							</div>
							
							<div class="col-md-4">
								<h2>shop guide</h2>
								<p><a href="<%= ctxPath%>/index.go">홈으로</a></p>
								<p><a href="#">회사소개</a></p>
								<p><a href="#">이용약관안내</a></p>
								<p><a href="#">개인정보취급방침</a></p>
								<p><a href="#">이용안내</a></p>
							</div>
							<br><br>
							<p>모든이미지는 (주)제니비인터네셔널의 소유로 법적인 보호를 받고 있습니다. 무단게재 및 도용시 저작권법에 의해 형사고발 및 손해배상을 묻습니다.</p>
							<p class="copy">+ copyright © nearwear all rights reserved / published by plain design</p>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<!-- 푸터 끝 -->
	
</body>
</html>

