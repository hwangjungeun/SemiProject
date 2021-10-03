<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../header.jsp" />


<style>
	
	input.datepicker {
		width: 72px; /* datepicker의 날짜 입력되어있는부분 가로길이 줄임 */
	}
	
	table > thead > tr > th.verticalM { /* 테이블 안에 있는 th태그들을 세로방향으로 가운데정렬  */
		vertical-align: middle;
	}
	
	table > tbody > tr > td.verticalM { /* 테이블 안에 있는 td태그들을 세로방향으로 가운데정렬  */
		vertical-align: middle;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		// === jQuery UI 의 datepicker === //
	    $("input.datepicker").datepicker({
              dateFormat: 'yy-mm-dd'  //Input Display Format 변경
             ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
             ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
        //     ,changeYear: true        //select태그에서 년 선택 가능
        //     ,changeMonth: true       //select태그에서 월 선택 가능                
             ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
             ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
             ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
             ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
             ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
             ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
             ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
             ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
             ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
           //,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
           //,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
        });                    
	    
	  	//초기값을 90일 전으로 설정
	    $('#datepicker1').datepicker('setDate', '-90D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
		//초기값을 오늘 날짜로 설정
	    $('#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
	    
	  //초기값을 90일 전으로 설정
	    $('#datepicker3').datepicker('setDate', '-90D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
		//초기값을 오늘 날짜로 설정
	    $('#datepicker4').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
	    /////////////////////////////////////////////////////
	    
	});
	
</script>

	<div class = "container px-0">
		
		<div class="border border-muted mx-auto" style="display:table; width:150px; height:25px; text-align: center;">
			<h4 class="h4" style="display:table-cell; vertical-align: middle">ORDER LIST</h4> <!-- 세로방향으로 가운데정렬 -->
		</div>
		<br>
	
	
		<!-- 탭을 토글 가능하게 만들려면 각 링크에 data-toggle="tab" 속성을 추가하십시오. 
			  그런 다음 모든 탭에 대해 고유한 ID가 있는 .tab-pane 클래스를 추가하고 .tab-content 클래스가 있는 <div> 요소 안에 래핑합니다.
	    -->
		<ul class="nav nav-tabs nav-fill"> <!-- nav-fill : 전체 넓이에 동일한 크기로 배분하기 -->
			<li class="nav-item">
				<a class="nav-link active" data-toggle="tab" href="#listView1">주문내역조회(0)</a>
			</li>
			<li class="nav-item">
		    	<a class="nav-link" data-toggle="tab" href="#listView2">취소/반품/교환 내역(0)</a>
			</li>
		</ul>
		
		<!-- Tab panes 시작-->
		<div class="tab-content py-3">
			<!-- 주문내역조회(0) 시작 -->
			<div class="tab-pane container active" id="listView1" style="padding: 0px;"> <!-- 탭을 클릭할 때 탭이 페이드 인 및 페이드 아웃되도록 하려면 .fade 클래스를 .tab-pane에 추가하세요. --> 
				
				<!-- 기간 조회하는 부분 시작-->
				<div class="border" style="padding: 20px;">
					<div class="btn-group" role="group">
						<button type="button" class="btn btn-light border">오늘</button>
						<button type="button" class="btn btn-light border">1주일</button>
						<button type="button" class="btn btn-light border">1개월</button>
						<button type="button" class="btn btn-light border">3개월</button>
						<button type="button" class="btn btn-light border">6개월</button>
					</div>
					
					<input type="text" id="datepicker1" class="datepicker">
		       		~
			  		<input type="text" id="datepicker2" class="datepicker">
			  		
			  		<button type="button" class="btn btn-dark">조회</button>
		  		</div>
		  		<!-- 기간 조회하는 부분 끝 -->
		  		
		  		<ul style="list-style-type: disc; padding-left: 20px;">
		  			<li>기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.</li>	  
		  			<li>취소/교환/반품 신청은 배송완료일 기준 7일까지 가능합니다.</li>		
		  		</ul>
		  		
		  		
		  		<!-- 주문상품정보 테이블 시작 -->
		  		<div style="margin-top: 30px; font-weight: bold; font-size: 12px;">주문 상품 정보</div>
		  		
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr style="text-align: center;"> <!-- 글자 가운데정렬 -->
								<th>주문일자<br>[주문번호]</th>
								<th class="verticalM">이미지</th>
								<th class="verticalM">상품정보</th>
								<th class="verticalM">수량</th>
								<th class="verticalM">상품구매금액</th>
								<th class="verticalM">주문처리상태</th>
								<th class="verticalM">취소/교환/반품</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="verticalM" align="center">s20211003-17</td>
								<td class="verticalM" align="center"><img alt="300.jpg" src="../images/300.jpg" width="90" height="100"></td>
								<td class="verticalM">
									<strong>상품명이 들어갈 곳 riha angora cardigan(5color)</strong>
									<ul style="margin-top: 15px;">
										<li>[옵션: 브라운]</li>
									</ul>
								</td>
								<td class="verticalM" align="center">1 개</td>
								<td class="verticalM" align="center"><strong>31,400원</strong></td>
								<td class="verticalM text-info" align="center">주문완료,배송중,배송완료</td>
								<td class="verticalM text-danger" align="center">취소,교환,반품</td>
							</tr>
							<tr>
								<td class="verticalM" align="center">s20211003-17</td>
								<td class="verticalM" align="center"><img alt="302.jpg" src="../images/302.jpg" width="90" height="100"></td>
								<td class="verticalM">
									<strong>상품명이 들어갈 곳 toy cotton pants(4color)</strong>
								</td>
								<td class="verticalM" align="center">2 개</td>
								<td class="verticalM" align="center"><strong>17,900원</strong></td>
								<td class="verticalM text-info" align="center">주문완료,배송중,배송완료</td>
								<td class="verticalM text-danger" align="center">취소,교환,반품</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 주문상품정보 테이블 끝 -->
		  		
		  		<!-- 페이지바 시작 -->
				<nav style="clear: both;">
				  <ul class="pagination justify-content-center" style="margin-top: 50px;">
				  	<li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&laquo;&laquo;</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&laquo;</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">1</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">2</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">3</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&raquo;</span></a></li> 
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&raquo;&raquo;</span></a></li> 
				  </ul>
				</nav>
				<!-- 페이지바 끝 -->
		  		
			</div>
			<!-- 주문내역조회(0) 끝 -->
			
			
			
			
			
			
			
			<!-- 취소/반품/교환 내역(0) 시작 -->
			<div class="tab-pane container" id="listView2" style="padding: 0px;"> <!-- 탭을 클릭할 때 탭이 페이드 인 및 페이드 아웃되도록 하려면 .fade 클래스를 .tab-pane에 추가하세요. --> 
				
				<!-- 기간 조회하는 부분 시작-->
				<div class="border" style="padding: 20px;">
					<div class="btn-group" role="group">
						<button type="button" class="btn btn-light border">오늘</button>
						<button type="button" class="btn btn-light border">1주일</button>
						<button type="button" class="btn btn-light border">1개월</button>
						<button type="button" class="btn btn-light border">3개월</button>
						<button type="button" class="btn btn-light border">6개월</button>
					</div>
					
					<input type="text" id="datepicker3" class="datepicker">
		       		~
			  		<input type="text" id="datepicker4" class="datepicker">
			  		
			  		<button type="button" class="btn btn-dark">조회</button>
		  		</div>
		  		<!-- 기간 조회하는 부분 끝 -->
		  		
		  		<ul style="list-style-type: disc; padding-left: 20px;">
		  			<li>기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.</li>
		  		</ul>
		  		
		  		
		  		<!-- 주문상품정보 테이블 시작 -->
		  		<div style="margin-top: 30px; font-weight: bold; font-size: 12px;">주문 상품 정보</div>
		  		
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr style="text-align: center;"> <!-- 글자 가운데정렬 -->
								<th>주문일자<br>[주문번호]</th>
								<th class="verticalM">이미지</th>
								<th class="verticalM">상품정보</th>
								<th class="verticalM">수량</th>
								<th class="verticalM">상품구매금액</th>
								<th class="verticalM">취소/교환/반품</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="verticalM" align="center">s20211003-17</td>
								<td class="verticalM" align="center"><img alt="300.jpg" src="../images/300.jpg" width="90" height="100"></td>
								<td class="verticalM">
									<strong>상품명이 들어갈 곳 riha angora cardigan(5color)</strong>
									<ul style="margin-top: 15px;">
										<li>[옵션: 브라운]</li>
									</ul>
								</td>
								<td class="verticalM" align="center">1 개</td>
								<td class="verticalM" align="center"><strong>31,400원</strong></td>
								<td class="verticalM text-danger" align="center">취소,교환,반품</td>
							</tr>
							<tr>
								<td class="verticalM" align="center">s20211003-17</td>
								<td class="verticalM" align="center"><img alt="302.jpg" src="../images/302.jpg" width="90" height="100"></td>
								<td class="verticalM">
									<strong>상품명이 들어갈 곳 toy cotton pants(4color)</strong>
								</td>
								<td class="verticalM" align="center">2 개</td>
								<td class="verticalM" align="center"><strong>17,900원</strong></td>
								<td class="verticalM text-danger" align="center">취소,교환,반품</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 주문상품정보 테이블 끝 -->
		  		
		  		<!-- 페이지바 시작 -->
				<nav style="clear: both;">
				  <ul class="pagination justify-content-center" style="margin-top: 50px;">
				  	<li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&laquo;&laquo;</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&laquo;</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">1</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">2</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark">3</span></a></li>
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&raquo;</span></a></li> 
				    <li class="page-item"><a class="page-link" href="#"><span class="text-dark" aria-hidden="true">&raquo;&raquo;</span></a></li> 
				  </ul>
				</nav>
				<!-- 페이지바 끝 -->
		  		
			</div>
			<!-- 취소/반품/교환 내역(0) 끝 -->
			
			
			
			
		</div>	
		<!-- Tab panes 끝 -->
	

	</div>

	
<jsp:include page="../footer.jsp" />