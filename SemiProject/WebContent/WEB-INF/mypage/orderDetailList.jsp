<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
    
<%
	String ctxPath = request.getContextPath();
%>    

<jsp:include page="../header.jsp" />

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/datepicker.css" />
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
		
		showOrderDetailList();
	    
	});
	
	function showOrderDetailList() {
		$.ajax({
			url:"/SemiProject/mypage/orderDetailListJSON.go",
			data:{"userid":"${requestScope.userid}"
				 ,"odrcode":"${requestScope.odrcode}"},   
			dataType:"JSON",
			success:function(json) {
				
				var html = "";
				
				if( json.length == 0) {
		        	// 처음부터 데이터가 존재하지 않는 경우
			    	// !!! 주의 !!!
			    	// if(json == null) 이 아님!!!
			    	// if(json.length == 0) 으로 해야함!!
					html += "<tr>"+
								"<td colspan='7' style=' height: 100px; vertical-align: middle'>"+
									"<h6 style='color: #d6d6d6; text-align: center; '> 주문내역이 없습니다.</h6>"+
								"</td>"+
						    "</tr>";
	
					$("tbody#showOrderList").html(html);
	          }
	          
	          else {
	        	  // 데이터가 존재하는 경우
	        	  
	        	  $.each(json, function(index, item){	// 반복문
	        		// fk_odrcode, pimage, pname ,totalquantity , odrtotalprice ,deliverstatus, cancelstatus, totalproduct
	        		  html += "<tr>"+
							  	"<td class='verticalM' align='center'>"+item.odrseqnum+"</td>"+
								"<td class='verticalM' align='center'><img alt='"+item.pimage+"' src='../images/"+item.pimage+"' width='90' height='100'></td>"+
								"<td class='verticalM'>"+
									"<strong>"+item.pname+"</strong>"+
									"<ul style='margin-top: 15px;'>"+
										"<li>[옵션: "+item.cname+"]</li>"+
									"</ul>"+
								"</td>"+
								"<td class='verticalM' align='center'>"+item.oqty+"</td>"+
								"<td class='verticalM' align='center'><strong>"+(item.odrprice).toLocaleString('en')+" 원</strong></td>"+
								"<td class='verticalM text-info' align='center'>"+item.deliverstatus+"</td>"+
								"<td class='verticalM text-danger' align='center'>"+item.cancelstatus+"</td>"+
							 "</tr>";
	        	  });
	        	  
	        	  $("tbody#showOrderList").append(html);
	          }
			
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	
</script>

<div class="container px-0">

	<!-- 주문상세정보 테이블 시작 -->
	<div style="margin-top: 30px; font-weight: bold; font-size: 12px;">주문
		상세 정보</div>

	<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr style="text-align: center;">
					<!-- 글자 가운데정렬 -->
					<th>주문상세일련번호</th>
					<th class="verticalM">이미지</th>
					<th class="verticalM">상품정보</th>
					<th class="verticalM">수량</th>
					<th class="verticalM">상품구매금액</th>
					<th class="verticalM">주문처리상태</th>
					<th class="verticalM">취소/교환/반품</th>
				</tr>
			</thead>
			<tbody id="showOrderList">

			</tbody>
		</table>
	</div>
	<!-- 주문상세 내역조회 끝 -->
</div>

<div class="container my-5 text-right ">
	<button type="button" class='btn btn-outline-dark btn-sm' onclick="javascript:history.back();">주문목록</button>
</div>


<jsp:include page="../footer.jsp" />