<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>       



<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>

<jsp:include page="../header.jsp" />

<style type="text/css">

	.titleArea h2{	
	 	display: inline-block;
	    position: relative;
	    margin: 20px 10px;
	    padding: 8px 15px;
	    min-width: 150px;
	    color: #353535;
	    font-size: 13px;
	    letter-spacing: 1px;
	    border: 1px #ddd solid;
	    text-align: center;
	}
	
	
	div.titleArea::after{ /*상품목록 영역이 조건별조회영역 침범하지 않게 하기 위해서*/
		display:block;
		content:"";
		clear:both;
	}
	
	div.fuction::before, div.fuction::after{ /*상품목록 영역이 조건별조회영역 침범하지 않게 하기 위해서*/
		display:block;
		content:"";
		clear:both;
	}

	div.category::before, div.category::after{ /*상품목록 영역이 조건별조회영역 침범하지 않게 하기 위해서*/
		display:block;
		content:"";
		clear:both;
	}

	
	nav.orderBy ul li:first-child {border-left:none;}
	
	
	/*조건별 조회 영역 css*/
	nav.orderBy ul, nav.menuCategory{
		padding-top:10px; /*  상단 여백 10px  */
	}  
	             
	                    
	nav.orderBy ul li, nav.menuCategory ul li {
	    display:inline;    /*  세로나열을 가로나열로 변경 */
	    border-left:1px solid #999;  /* 각 메뉴의 왼쪽에 "|" 표시(분류 표시) */
		padding : 0 10px;
	}
	
	
	nav.orderBy ul li:first-child {border-left:none;}
	
	nav.menuCategory ul li:first-child {border-left:none;}
	
 	a:hover {text-decoration: none; color:black;}

	.page-item.active .page-link {
	    z-index: 3;
	    color: #fff;
	    background-color: #777;
	    border-color: #777;
	}

</style>


<script type="text/javascript">


	$(document).ready(function(){
		 
	   bestDiv(); // 베스트 아이템 영역
		
	   // hover효과
	   $(document).on({

	        mouseenter: function () {
	            $(this).find("div.pname").css({'display':'block'});
	            $(this).find(".pimage").css({'opacity':'0.2'});
	        },

	        mouseleave: function () {
	        	$(this).find("div.pname").css({'display':'none'});
	            $(this).find(".pimage").css({'opacity':'1.0'});
	        }

	    }, "div.box");
	
	});// end of $(document).ready(function(){}
	
	
	
	//Function Declaration
	
	// 상위카테고리에 해당하는 베스트 아이템 가져오기(8개씩) 
	function bestDiv(){
		
		var cnt = "8"; 
		var cuseq = ${requestScope.searchNO};
		
		console.log(cuseq);
				
		$.ajax({
			url:"/SemiProject/product/bestDivJSON.go",
			data:{"cuseq":cuseq
				 ,"cnt":cnt},
			dataType:"JSON",
			success:function(json){

				var html = "";
				
				$.each(json, function(index,item){
					// 이부분 수정해야함 
					html += "<li class='bestitem' style='list-style-type:none; margin:7px; float: left;'>" +
							 "<a href ='/SemiProject/product/productDetail.go?pseq=" + item.pseq + "'>" +
						    	"<div class='box mb-2' style='width:260px; height:260px;'>"+
						   			"<img class='pimage card-img-top' style='opacity:1.0; height:260px;' src='/SemiProject/images/"+ item.pimage+"' alt='...'>" +
						   			"<div class='pname' style='display:none; margin:-50px; font-size:17px; font-weight:bold;'>"+ item.pname +"</div>" +
			     				 "</div>" +
							  "</a>" +
					     	"</li>";
				
					     	
					 
				});// end of $.each(json, function(index,items){}
				
				$("ul.bestitems").html(html);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});
		
	}// end of function bestDiv(){

</script>



<!-- 해야할 기능들: 베스트품목가져오기/전체품목갯수가져오기/조건별조회/페이징처리/상품상세페이지 -->

<!-- 중앙 컨텐츠 시작 -->
<div class="container">

	<!-- 페이지 제목(best item)영역-->
	<div class="titleArea m-5" align="center">
		<c:set var = "cuname" value=""/>
			<c:forEach var="map" items="${requestScope.categoryList}">
				<c:if test="${map.fk_cuseq == requestScope.searchNO and map.cuname ne cuname}">
					<h2>${map.cuname}</h2>
					<c:set var = "cuname" value="${map.cuname}"/>
				</c:if>
			</c:forEach>
	</div>
	
	<!-- 베스트 아이템 영역 -->
	<div class="bestItem">
	
		<div class="my-5">
			<h2 class ="text-center" style="letter-spacing: 1px;">
           		<span>-BEST ITEM-</span>
       		</h2>
       	</div>
       	
		<ul class="bestitems text-center mb-5"></ul>
		
	
	<div class="category my-5"><!-- 상단 카테고리에서 미리 나눌거면 이 영역 삭제해도 됨-->
		
		<hr class="mb-5">
		
		<div>
			<nav class="menuCategory" style="align:center;">
				<ul class="menuCategory" style="text-align:center; font-size:15px;">
					<c:forEach var="map" items="${requestScope.categoryList}">
						<c:if test="${map.fk_cuseq == requestScope.searchNO }">
							<li><a href="<%= request.getContextPath()%>/product/productListLow.go?clseq=${map.clseq}">${map.clname}</a>&nbsp;</li>
						</c:if>
					</c:forEach>
				</ul>
			</nav>
		</div>
		
	</div>
	
	</div>


	<!-- 전체 항목/조건별 조회 영역 : 10월 9일 디폴트는 신상품으로 해당하는 방법에 효과넣기 -->
	<div class="fuction mb-5">
		<p class="prdcount" style="float:left;"> 
			Total: &nbsp;
			<strong>${requestScope.totalProductCnt}</strong>
			&nbsp; items
		</p>
		<nav class="orderBy" style="float:right;">
			<ul>
				<li><a href="<%= ctxPath%>/product/productListUp.go?cuseq=${searchNO}&sortType=1">신상품</a></li>
				<li><a href="<%= ctxPath%>/product/productListUp.go?cuseq=${searchNO}&sortType=2">상품명</a></li>
				<li><a href="<%= ctxPath%>/product/productListUp.go?cuseq=${searchNO}&sortType=3">낮은가격</a></li>
				<li><a href="<%= ctxPath%>/product/productListUp.go?cuseq=${searchNO}&sortType=4">높은가격</a></li>
				<li><a href="<%= ctxPath%>/product/productListUp.go?cuseq=${searchNO}&sortType=5">사용후기</a></li>
			</ul>
		</nav>
	</div>

	
    <!-- 상품목록 영역 : 데이터 불러와서 넣어줄 예정입니당.(베스트상품 페이지도 동일하게 처리하면 됨)-->
    <!-- 수정부분 : ProductVO 클래스 생성/ header.jsp에 jquery부분 주석해제/ jquery폴더 추가/ ProductListFormAction.java 수정함 -->
    <!-- 해결할 부분 : 1행에 카드 갯수 제한(4개씩) => 카드 크기 고정해야하나? 안됨 따흑,,==> 해결-->
    <!-- 10월 7일 해결할 부분 : 카드이미지고정../카드 이미지 플립으로 만드는 것이 더 역동성있어보임-->
    <!-- 10월 8일 해결할 부분 : 카드에 링크걸기-->
    <div class="card-deck mb-5">
	    <c:forEach var="pvo" items="${requestScope.productList}">
	    	<div class="col-md-3 col-lg-3">
		    	<div class="card mb-3" style="width:255px; border:0px; padding:0px;" >
		   			<img src="<%= ctxPath%>/images/${pvo.pimage}" class="card-img-top" style="height:330px;""alt="...">
	   				<div class="card-body">
	     				<a class="stretched-link" href = "<%= ctxPath %>/product/productDetail.go?pseq=${pvo.pseq}"></a>
	     				<h5 class="card-title">${pvo.pname}</h5>
	     				<p class="card-text"><fmt:formatNumber value="${pvo.price}" pattern="#,###" /></p>
	  				</div>
		 		</div>
	 		</div>
		</c:forEach>
    </div>
       
       
    
    <!-- 페이징영역: 중간 정렬해야함  -->   
    
    <nav class="my-5">
	     <div>
	     	<ul class="page pagination justify-content-center" style="margin:auto; align:center;">${requestScope.pageBar}</ul>
	     </div>
    </nav>
    
    </div>
   


<jsp:include page="../footer.jsp" />
    