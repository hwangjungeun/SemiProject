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
	
	a:hover {text-decoration: none; color:black;}
	
	nav.orderBy ul li:first-child {border-left:none;}
	
	nav.menuCategory ul li:first-child {border-left:none;}
	
	.page-item.active .page-link {
	    z-index: 3;
	    color: #fff;
	    background-color: #777;
	    border-color: #777;
	}
	
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
	});

</script>


<!-- 중앙 컨텐츠 시작 -->
<div class="container">

	<!-- 페이지 제목(best item)영역-->
	<div class="titleArea m-5" align="center">
		<c:forEach var="map" items="${requestScope.categoryList}">
			<c:if test="${map.clseq == requestScope.searchNO}">
				<h2>${map.clname}</h2>
			</c:if>
		</c:forEach>
	</div>

	
	<!-- 내부 카테고리 영역 -->
	<div class="bestItem">
		<div class="category my-5">
			<nav class="menuCategory" style="align:center;">
				<ul class="menuCategory" style="text-align:center; font-size:15px;">
					<c:set var = "cuname" value=""/>
						<c:forEach var="map" items="${requestScope.categoryList}">
							<c:if test="${map.fk_cuseq == requestScope.cuseq}">
								<li><a href="<%= request.getContextPath()%>/product/productListLow.go?clseq=${map.clseq}">${map.clname}</a>&nbsp;</li>
								<c:set var = "cuname" value="${map.cuname}"/>
							</c:if>
						</c:forEach>
				</ul>
			</nav>
		</div>
	</div>
	
	
	<!-- 전체 항목/조건별 조회 영역  -->
	<div class="fuction mb-5">
		<p class="prdcount" style="float:left;"> 
			Total: &nbsp;
			<strong>${requestScope.totalProductCnt}</strong>
			&nbsp; items
		</p>
		
		<nav class="orderBy" style="float:right;">
			<ul>
				<li><a href="<%= ctxPath%>/product/productListLow.go?clseq=${searchNO}&sortType=1">신상품</a></li>
				<li><a href="<%= ctxPath%>/product/productListLow.go?clseq=${searchNO}&sortType=2">상품명</a></li>
				<li><a href="<%= ctxPath%>/product/productListLow.go?clseq=${searchNO}&sortType=3">낮은가격</a></li>
				<li><a href="<%= ctxPath%>/product/productListLow.go?clseq=${searchNO}&sortType=4">높은가격</a></li>
				<li><a href="<%= ctxPath%>/product/productListLow.go?clseq=${searchNO}&sortType=5">사용후기</a></li>
			</ul>
		</nav>
		
	</div>

	
    <!-- 상품목록 영역-->
    <div class="card-deck mb-5">
	    <c:forEach var="pvo" items="${requestScope.productList}">
	    	<div class="col-md-3 col-lg-3">
		    	<div class="card mb-3" style="width:255px; border:0px; padding:0px;">
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
       
    
    <!-- 페이징영역 -->   
    <nav class="my-5">
	     <div>
	     	<ul class="pagination justify-content-center" style="margin:auto;">${requestScope.pageBar}</ul>
	     </div>
    </nav>
    
</div>
   


<jsp:include page="../footer.jsp" />
    