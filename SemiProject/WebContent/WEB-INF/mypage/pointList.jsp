<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />


<style type="text/css">
	table#pointTbl {
		width: 100%;
		margin: 20px 0 ;
	}
	table#pointTbl th {
		padding: 15px 0 5px 25px;
		margin: 0;		
	}
	table#pointTbl td {
		text-align: center;
		border-right: solid 1px #d6d6d6;
		padding: 5px;
		font-size: 10pt;		
	}
	table#pointTbl h6 {
		font-weight: bold;
	}
	
	div#inner {
		border: solid 1px #d6d6d6;
		padding
	}
	
	table#infoTbl {
		width: 100%;
	}
	table#infoTbl td {
		font-size: 9pt; 
		border: solid 3px white; 
	}
	td#num {
		background-color: #AAAAAA;
		color: #fff;
		padding: 1px 5px;
		text-align: center;
	}
	div#infodiv {
		margin-top: 30px;
		margin-bottom: 100px;
	}
	div#inner {
		padding: 10px;
	}
	
	table#detailtbl {
		border-top: solid 1px #d6d6d6;
		border-bottom: solid 1px #d6d6d6;
	}
	button.btn {
		padding: 1px 5px;
	}
	a#point {
		background-color: #FAFAFA;
 		border-bottom: solid 1px #d6d6d6;
	}
	span {
		text-align: right;
		margin-left: 0;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		$("a.active").css({"background-color": "#fff",  "border-bottom": "none"});
		/* nav바가 처음 active 되어진 적립내역보기에는 선택되었을 때의 css 추가 */
		
		$("a#point").click(function(){
			$("a#point").css({"background-color": "#FAFAFA",  "border-bottom": "solid 1px #d6d6d6"});
			/* 다른 버튼 클릭 시에 css가 누적되지 않도록 모든 a 태그의 css 초기화 */
			
			$(this).css({"background-color": "#fff",  "border-bottom": "none"});
		});
		
		
		showPointUnuseList();
		showPointUsedList();
		
	});
	
	// Function Decalaration
	function showPointUnuseList(){
		$.ajax ({
			url: "<%= ctxPath%>/mypage/showPointUnuseList.go",
// 			type: "POST",
		    data:{"userid":"${requestScope.userid}"},
			dataType:"JSON",
			success:function(json) {
				
				var html = "";
				
				if (json.length == 0) {
					// 받아온 json의 길이기 0일때,(데이터가 존재하지 않음)
					
					html += "<tr>"+
								"<td colspan='5' style=' height: 100px; vertical-align: middle'>"+
									"<h6 style='color: #d6d6d6; text-align: center; '> 적립금내역이 없습니다.</h6>"+
								"</td>"+
							  "</tr>";

					$("tbody#displayUnusePointList").html(html);
					
				}
				else if( json.length > 0 ) {
		        	  // 데이터가 존재하는 경우
		        	  
		        	  $.each(json, function(index, item){	// 반복문
		        		  
		        		  html += "<tr align='center'>"+
		        				  "<td><h6>"+item.odrdate.substring(0,10)+"</h6></td>"+
		        				  "<td><h6>"+(item.point).toLocaleString('en')+" point" +"</h6></td>"+
		        				  "<td><h6>"+item.fk_odrcode +"</h6></td>"+
		        				  "<td><h6>"+item.start_day.substring(0,10) +"</h6></td>"+
		        				  "<td><h6>주문번호("+item.fk_odrcode +")의 구매금액에 대한 적립</h6></td>"+
		        				  "</tr>";
		        	  });
		        	  
		        	  
		        	  
		        	  $("tbody#displayUnusePointList").html(html);
				}
		        
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "
						+ request.responseText + "\n" + "error: " + error);
			}

		});

	}// end of function showPointUnuseList()
	
	
	function showPointUsedList(){
		
		$.ajax ({
			url: "<%= ctxPath%>/mypage/showPointUsedList.go",
// 			type: "POST",
		    data:{"userid":"${requestScope.userid}"},
			dataType:"JSON",
			success:function(json) {
				
				var html = "";
				
				if (json.length == 0) {
					// 받아온 json의 길이기 0일때,(데이터가 존재하지 않음)
					
					html += "<tr>"+
								"<td colspan='5' style=' height: 100px; vertical-align: middle'>"+
									"<h6 style='color: #d6d6d6; text-align: center; '> 적립금내역이 없습니다.</h6>"+
								"</td>"+
							  "</tr>";

					$("tbody#displayUsedPointList").html(html);
					
				}
				else if( json.length > 0 ) {
		        	  // 데이터가 존재하는 경우
		        	  
		        	  $.each(json, function(index, item){	// 반복문
		        		  
		        		  html += "<tr align='center'>"+
		        				  "<td><h6>"+item.odrdate.substring(0,10)+"</h6></td>"+
		        				  "<td><h6>"+(item.point).toLocaleString('en')+" point" +"</h6></td>"+
		        				  "<td><h6>"+item.fk_odrcode +"</h6></td>"+
		        				  "<td><h6>이미 사용된 적립금 입니다.</h6></td>"+
		        				  "</tr>";
		        	  });
		        	   
		        	  
		        	  $("tbody#displayUsedPointList").html(html);
				}
		        
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: "
						+ request.responseText + "\n" + "error: " + error);
			}

		});
		
	} // end of showPointUsedList()
</script>

<div class = "container px-0">
		<div class="border border-muted mx-auto" style="display:table; width:150px; height:25px; text-align: center;">
			<h4 class="h4" style="display:table-cell; vertical-align: middle">MILEAGE</h4>
		</div>
			<h6 class="mt-2" style="text-align: center">고객님의 사용가능 적립금 금액 입니다.</h6>
		<br>

	<!-- 포인트 테이블 -->
	<table id="pointTbl" class="border">

		<tbody>
			<tr>
				<th><h6>> 총 적립금</h6></th>
				<td>${requestScope.point_sum }</td>

				<th><h6>> 사용가능 적립금</h6></th>
				<td>${requestScope.point_canuse }</td>
			</tr>
			<tr>
				<th><h6>> 사용된 적립금</h6></th>
				<td>${requestScope.point_used }</td>

				<th><h6>> 미가용 적립금&nbsp;
					<button class="btn btn-outline-secondary rounded-circle"
						data-bs-toggle="tooltip" data-bs-placement="bottom"
						title="상품 배송 완료 후 해당 주문으로 인해 발생한 적립금을 일정 기간동안 사용하지 않게 하는 기능으로, 20일이 지난 후 사용이 가능합니다.">?</button>
					</h6></th>
				<td>${requestScope.point_unuse }</td>
			</tr>
		</tbody>
	</table>
		

	<!-- 네비게이션 바 -->
	<ul class="nav nav-tabs nav-fill border">
		<li class ="nav-item">
			<a id="point" class="nav-link active mx-0" data-toggle="tab" href="#pointList">적립내역보기</a>
		</li>
		<li class ="nav-item" style="border-left: solid 1px #d6d6d6; border-right: solid 1px #d6d6d6;">
			<a id="point" class="nav-link  mx-0" data-toggle="tab" href="#pointunuseList">미가용적립내역보기</a>
		</li>
		<li class ="nav-item">
			<a id="point" class="nav-link mx-0" data-toggle="tab" href="#couponunuseList">사용된적립내역보기</a>
		</li>
	</ul>
	
	<!-- Tab이 선택되면 내용이 보여지는 영역이다. -->
	<!-- 각 탭이 선택되면 보여지는 내용이다. 태그는 div이고 클래스는 tab-pane이다. -->
	<div class="tab-content my-5">
		<div class="tab-pane active" id="pointList">
			<table id="detailtbl" class="table">
				<thead>
					<tr class="text-center">
						<th width="20%"><h6>주문날짜</h6></th>
						<th width="20%"><h6>적립금</h6></th>
						<th width="25%"><h6>관련주문</h6></th>
						<th width="35%"><h6>내용</h6></th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${empty requestScope.pointList}">
						<tbody>
							<tr>
			        			<td colspan="4" style=" height: 100px; vertical-align: middle">
			        				<h6 style="color: #d6d6d6; text-align: center; "> 적립금내역이 없습니다.</h6>
			        			</td>
			        		</tr>
		        		</tbody>							
					</c:when>
					<c:otherwise>
						<tbody>
							<c:forEach var="pvo" items="${requestScope.pointList}">
				        		<tr align="center">
				        			<td><h6>${pvo.odrdate.substring(0,10) }</h6></td>
				        			<td><h6><fmt:formatNumber>${pvo.point }</fmt:formatNumber> point</h6></td>
				        			<td><h6>${pvo.fk_odrcode }</h6></td>
				        			<td><h6>주문번호(${pvo.fk_odrcode })의 구매금액에 대한 적립</h6></td>
				        		</tr>
				        		
				        	</c:forEach>
			        		<tr><td colspan="4">
							<nav class="my-5">
								<div style="display: flex; width: 100%;">
										<ul class="pagination" style="margin: auto;">${requestScope.pageBar }</ul>
									</div>
								</nav>
							</td></tr>
			        	</tbody>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		
		<div class="tab-pane" id="pointunuseList">
			<div class="tab-pane active" id="pointList">
			<table id="detailtbl" class="table">
				<thead>
					<tr class="text-center">
						<th width="10%"><h6>주문날짜</h6></th>
						<th width="10%"><h6>미가용적립금</h6></th>
						<th width="25%"><h6>관련주문</h6></th>
						<th width="25%"><h6>사용가능예정일</h6></th>
						<th width="30%"><h6>내용</h6></th>
					</tr>
				</thead>
				<tbody id="displayUnusePointList">
					
				</tbody>
			</table>
			</div>
		</div>
		
		<div class="tab-pane" id="couponunuseList">
			<div class="tab-pane active" id="pointList">
			<table id="detailtbl" class="table">
				<thead>
					<tr class="text-center">
						<th width="20%"><h6>주문날짜</h6></th>
						<th width="20%"><h6>사용된적립금</h6></th>
						<th width="25%"><h6>관련주문</h6></th>
						<th width="35%"><h6>내용</h6></th>
					</tr>
				</thead>
				<tbody id="displayUsedPointList">
				
				</tbody>	
			</table>
		</div>
		</div>
	</div>


	<!-- 적립금 안내페이지 -->
	<div id="infodiv" class="border">
		<h3 class="py-3 pl-3">적립금 안내</h3>
		
		<div id="inner">
		
			<table id="infotbl" class="border">
				<tbody>
					<tr>
						<td id="num">1</td>
						<td>&nbsp;주문으로 발생한 적립금은 배송완료 후 14일 부터 실제 사용 가능한 적립금으로 전환됩니다. 배송완료 시점으로부터 14일 동안은 미가용 적립금으로 분류됩니다.</td>
					</tr>
					<tr>
						<td id="num">2</td>
						<td>&nbsp;미가용 적립금은 반품, 구매취소 등을 대비한 임시 적립금으로 사용가능 적립금으로 전환되기까지 상품구매에 사용하실 수 없습니다.</td>
					</tr>
					<tr>
						<td id="num">3</td>
						<td>&nbsp;사용가능 적립금(총적립금 - 사용된적립금 - 미가용적립금)은 상품구매 시 바로 사용가능합니다.</td>
					</tr>
				</tbody>
			</table>
		
		</div>
	</div>
	

	
	
</div>


<jsp:include page="../footer.jsp" />