<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>       


<%--
<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>
--%>

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
	
	
	div.fuction::after{ /*상품목록 영역이 조건별조회영역 침범하지 않게 하기 위해서*/
		display:block;
		content:"";
		clear:both;
	}
	
	
	/*조건별 조회 영역 css bestList.jsp파일 것*/
	nav.orderBy ul{
		padding-top:10px; /*  상단 여백 10px  */
	}  
	             
	                    
	nav.orderBy ul li {
	    display:inline;    /*  세로나열을 가로나열로 변경 */
	    border-left:1px solid #999;  /* 각 메뉴의 왼쪽에 "|" 표시(분류 표시) */
		padding : 0 10px;
	}
	
	li.sort:hover {
		font-weight:bold;
	}

	
</style>


<script type="text/javascript">

	//var sortType = ${requestScope.sortType};
	
	$(document).ready(function(){
		
		// 갯수 카운트 감추기 
		$("span#totalBestCount").hide();
		$("span#countBest").hide();
		//$("span#sortType").hide();
		
		//bestPage(1,sortType);//베스트상품 조회
		bestPage(1);//베스트상품 조회
		
		$("button#btnMoreBest").click(function(){
			
			if($(this).text() == "처음으로"){
				//var sortType = $("span#sortType").text();
				$("div#displayBest").empty();
				$("span#end").empty();
				bestPage(1);
				//bestPage(1,sortType);
				$(this).text("더보기");
			}
			else{
				bestPage($(this).val());
			}
		});
					
		
	});// end of $(document).ready
	
	
	//Function Declaration
	
	function bestPage(start){
		
		var cnt = 8; //페이지당 갯수
		var allsum = 50; // 베스트 조건갯수
		
		$.ajax({
			url:"/SemiProject/product/bestPageJSON.go",
			data:{"cnt":cnt // 8
				,"start":start},
				//,"sortType":sortType},// 페이지시작 ,"allsum" : allsum} => 갯수 부족하므로 좀 더 채워지면 넣을 것 
			dataType:"JSON",
			success:function(json){
				
				var html = "";
				
				if(start == "1" && json.length == 0 ){
					html += "현재 상품 준비중.....";
					$("div#displayBest").html(html);
					
				}
				else if(json.length > 0){
					
					$.each(json, function(index,item){
					
						var price = item.price.toLocaleString();
						
						html += "<div class='card-deck mb-5'>" +
									"<div class='col-md-3 col-lg-3'>" +
								    	"<div class='card mb-3' style='width:255px; border:0px; padding:0px;'>"+
								    	 "<img src='/SemiProject/images/"+ item.pimage + "' class='card-img-top'  style='height:340px;'alt='...'>" +
							   				"<div class='card-body'>" +
							     				"<a class='stretched-link' href = '/SemiProject/product/productDetail.go?pseq="+item.pseq+"'></a>" +
							     				"<h5 class='card-title'>"+item.pname+"</h5>" +
							     				"<p class='card-text'>"+price+"원</p>" +
							  				"</div>" +
								 		"</div>" +
						 			"</div>"+
						 		"</div>";
						 		
					});// end of $.each(json, function(index,items){}
					
					
					//$("span#sortType").text(sortType);
					
					$("div#displayBest").append(html);
					
					$("button#btnMoreBest").val( Number(start) + cnt );
					
					$("span#countBest").text(Number($("span#countBest").text()) + json.length );
					
					if( $("span#countBest").text() == $("span#totalBestCount").text() ) {
						$("span#end").html("마지막 상품입니다 :)");
						$("button#btnMoreBest").text("처음으로");
						$("span#BestHIT").text("0");
					}
					
				}
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});
		
	}// end of bestPage()
	
</script>

<!-- 중앙 컨텐츠 시작 -->
<div class="container">

	<!-- 페이지 제목(best item)영역-->
	<div class="titleArea m-5" align="center">
		<h2>BEST ITEM</h2>
	</div>


	<!-- 전체 항목/조건별 조회 영역 -->
	<div class="fuction mb-5">
		<p class="prdcount" style="float:left;"> 
			Total: &nbsp;(
			<strong>${requestScope.totalBestCount}</strong>)
			&nbsp; items
		</p>
	</div>

	
    <!-- 상품목록 영역 -->
    <div>
	    <div class= "row card-deck mb-5" id="displayBest"></div>
	    
	    <div>
			<p class="text-center">
				<span id="end" style="display:block; margin:20px; font-size: 12pt; font-weight: bold;"></span> 
				<button type="button" class="btn btn-secondary btn-lg" id="btnMoreBest" value="" >더보기</button>
				<span id ="totalBestCount">${requestScope.totalBestCount}</span>
				<span id="countBest">0</span>
				<!--<span id="sortType">1</span>-->
			</p>
		</div>
    </div> 
    
    <!-- 페이징영역: 더보기  -->   
    
    
</div>
<!-- 중앙 컨텐츠 끝 -->


<jsp:include page="../footer.jsp" />
    