<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          

<jsp:include page="../header.jsp" />

<%--
<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>
--%>

<style type="text/css">

	div{
		margin: 10px, 0px;
		align: left;
	}
	
	.buttons{
		border: 0px;
		width: 100%;
		font-size: 15px;
	}
	
	td{padding: 10px;}
 	
 	
	span{
		width: 20px;
	}
 	
 	.imageList li {
	    display: inline-block;
	    width: 79px;
	    margin: 1px;
	    font-size: 11px;
	    line-height: 14px;
	    vertical-align: top;
	}
 	
 	input[type=number]::-webkit-inner-spin-button {opacity: 1}
 	
</style>

<script type="text/javascript">

	var newOpseq= "";
	var lastOpseq = "";
	var opseqArr = new Array();// 생성한 옵션 번호 저장 
	
	$(document).ready(function(){
		
		//alert("확인용");
	
		// 삭제버튼 클릭시 옵션 삭제 
		$(document).on("click","button#delcart", function(){ 
			
			var $target = $(this); 
			var delOpseq = $target.val(); 
			console.log("삭제버튼클릭시 :" + delOpseq);
			
			for(var i=0; i< opseqArr.length ; i++){	// 옵션 번호 삭제 
				if( delOpseq == opseqArr[i]){
					opseqArr.splice(i, 1);
				}
			}// end of for----------------------------------

			$("."+delOpseq).remove(); // 옵션 삭제
			
			$("#optionselect option:eq(0)").prop("selected","selected");
			
			calTotalPrice();
			
		});// end of $(document).on("click","button#delcart", function(){
	
			
		//수량변경
		$(document).on("input","input#oqty", function(){ 
		
			//alert("클릭됨!");
			var $target = $(this); 
			var cnt = $target.val(); // 갯수 
			cnt = Number(cnt);
			//console.log("cnt => " +cnt);
			
			var price = ${requestScope.pvo.price}; // 가격
			//console.log("price =>" + price);
			var point = ${requestScope.pvo.point};
			
			var id = $target.attr("value2");  	   // 가격 보여줄 td의 id(=input태그의 value2 = 옵션번호)
			
			var totalPrice = price * cnt ;
			totalPrice = totalPrice.toLocaleString();

			var totalPoint = point * cnt ;
			
			//수량에 따라 가격 변경
			$("#"+id).empty();
			$("#"+id).text(totalPrice + "원 (" + totalPoint + ")");
		
			calTotalPrice();
		});
		
		
		// 장바구니에 추가하기
		$(document).on("click","button#submit", function(){ 
		
			var opseqArr = new Array();
			
			// 옵션번호 받아오기 
			$("td#opseq").each(function(){
				
				opseqArr.push( $(this).attr("value"));
				//console.log("옵션값 확인: " + opseq);
			});
			
			var opseq = opseqArr.join();
			$("input:hidden[name=opseq]").val(opseq); // 밑이랑 붙이면 오류남 붙이지마 
			
			console.log("확인용 opseq =>" + opseq);  
			
			
			// 옵션갯수 받아오기 
			var oqtyArr = new Array();
			
			$(".cartList").find("input").each(function(){
				var $target = $(this); 
				oqtyArr.push($target.val());
			});
			
			var oqty = oqtyArr.join();
			
			$("input:hidden[name=oqty]").val(oqty); // 밑이랑 붙이면 오류남 붙이지마 
		
			console.log("확인용 oqty =>" + oqty); 
			
			
			if( opseq == "" || oqty == ""){ //아무것도 안 누른 경우
				alert("옵션을 선택하지 않으셨습니다");
				return false;
			}
			else{
				
				$.ajax({
					url:"/SemiProject/order/productDetailInsert.go",
					type:"POST",
					data:{"opseq":opseq,
						  "oqty":oqty},
					dataType:"JSON",  
					success:function(json){
						
						alert(json.message);
						
						if(json.check == "1"){
							location.href="/SemiProject/order/basket.go";
						}
						else{
							javascript:history.go(0);
						}
						
					},
					error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			         }
					
				});	
				
				console.log("보내기");
			}
			
		});// end of $(document).on("click","button#submit", function(){ 
			
			
		//사진 클릭시 크게 띄우기	
		$(document).on("click","li.img", function(){ 
			
			//alert("클릭함");		
			
			var $target = $(this);
			var html = $target.html();
			
			//console.log(html);
			
			$("div.keyImage").html(html);
			
		});
	
		
		///////////////////현지님/////////////////////////////
		
		
		// 위시리스트 목록에 추가(문자열로 변환)
		$(document).on("click","button#submit3", function(){ 
		
			var opseqArr = new Array(); // 여러개의 opseq
			
			// 옵션번호 받아오기 
			$("td#opseq").each(function(){ // table인데 클래스가 cartList인거에 opseq가 append되고있는상태임.
				
				opseqArr.push( $(this).attr("value"));
				
			});
			
			var str_opseq = opseqArr.join();
			$("input[name=opseq]").val(str_opseq); // POST방식으로 보내기 위해 hidden타입에 넣어줌.
			
		//	console.log("확인용 str_opseq : " + str_opseq);  
			
			
			if( str_opseq == "" ){ // 옵션번호가 ""이면, 아무것도 선택을 안한거다.
				alert("옵션을 선택하지 않으셨습니다");
				return false;
			}
			else{
				 
				$.ajax({
					url:"<%= request.getContextPath()%>/mypage/insertWishList.go",
					type:"PosT", // 안쓰면 기본 get방식임.
					data:{"fk_opseq":str_opseq,
						  "fk_userid":"${requestScope.fk_userid}"},
					dataType:"JSON",  
					success:function(json){
						
						if(json.success){
							
							alert("관심상품이 등록되었습니다.");
							// 위시리스트 목록에 담았으면 위시리스트로 이동해야함. -> get방식으로 userid를 넘김.
							location.href = "<%= request.getContextPath()%>/mypage/wishList.go?userid=eomjh"; // 이부분은 나중에  ${sessionScope.loginuser.userid}로 고쳐야함!!########################
							
						}
						else{
							alert("죄송하지만, 관심상품등록이 실패되었습니다.");
							location.href = "javascript:history.go(0)"; // 새로고침
						}
						
					},
					error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
					
				});	// end of $.ajax()---------------------------------------
				
			//	console.log("확인용 : ajax로 위시리스트에 insert합니다~~~");
			}
		});
		
		
		// 주문진행중 목록으로 이동
		$(document).on("click","button#submit2", function(){ 
		
			var opseqArr = new Array(); // 여러개의 opseq
			
			// 옵션번호 받아오기 
			$("td#opseq").each(function(){ // table인데 클래스가 cartList인거에 opseq가 append되고있는상태임.
				
				opseqArr.push( $(this).attr("value"));
				
			});
			
			var str_opseq = opseqArr.join();
			
			$("input[name=opseq]").val(str_opseq); // POST방식으로 보내기 위해 hidden타입에 넣어줌.
			
			console.log("확인용 str_opseq : " + str_opseq);  
			
			/////////////////////////////////////////////////////////
			
			// 주문수량 받아오기 
			var oqtyArr = new Array();
			
			$(".cartList").find("input").each(function(){
			//	console.log("확인용 $(this).val() : " + $(this).val());
				oqtyArr.push($(this).val());
			});
			
			var str_oqty = oqtyArr.join();
			
			$("input:hidden[name=oqty]").val(str_oqty); // POST방식으로 보내기 위해 hidden타입에 넣어줌.
		
			console.log("확인용 str_oqty =>" + str_oqty); 
			
			/////////////////////////////////////////////////////////

			if( str_opseq == "" ){ // 옵션번호가 "" 이면, 아무것도 선택을 안한거다. 수량은 디폴트로 1이다.
				alert("옵션을 선택하지 않으셨습니다");
				return false;
			}
			else{
			//	alert("주문서로 갈수있습니다~~");
				
				// 자바스크립트에서 페이지 이동 (상세페이지->주문하기)
				location.href = "<%= request.getContextPath()%>/order/orderForm.go?userid=eomjh&opseq="+str_opseq+"&cnt="+str_oqty;
				//																   userid=${(sessionScope.loginuser).userid}로 나중에 변경해야함##################################
				
			}
				
		});// end of $(document).on("click","button#submit2", function(){})----------
		
		
		
	}); // end of $(document).ready(function(){})--------------------------------------------------
	
	
	// Function Decalration

	
	// 옵션선택시 옵션창 생성
	function addToForm(){ //삭제하고 바로누르면 안눌려짐 /... ㅠㅠㅠㅠㅠㅠ
		
		newOpseq = $("#optionselect option:selected").val()
		
		if( newOpseq != "0"){ //'필수선택'을 제외한 경우에만 생성
			
			//console.log("새로 넣기전 =>" + lastOpseq);
			
			// 생성된 옵션인지 확인 
			var bool = false;
			for(var i=0; i< opseqArr.length ; i++){
				if( newOpseq == opseqArr[i]){
					bool = true;
				}
			}
			
			console.log("bool값:" + bool);// 확인용

			if(!bool){ // 생성된 것이 없는 경우
			
				var opname = $("#optionselect option:selected").attr("value2");
			
				//console.log(opseq); //확인용 
				
				html = "<tr class='"+ newOpseq +"  m-3'  >" +
							"<td id='opseq' value='"+ newOpseq +"'>"+opname+"</td>&nbsp;"+
							"<td><input type='number' id='oqty' class='my-3' min='1' max='100' value='1' value2='"+ newOpseq +"'step='1' ;/></td>&nbsp;"+
							"<td><fmt:formatNumber value='${requestScope.pvo.price}' pattern='#,###'/>원</td>"+
							"<td id='"+ newOpseq +"'><fmt:formatNumber value='${requestScope.pvo.price}' pattern='#,###'/>원(${requestScope.pvo.point})</td>"+
							"<td><button type='button' class='btn-outline-secondary' id='delcart'  style='border: 0px;' value='"+newOpseq+"' ><i class='fas fa-times'></i></button></td>"+
					    "</tr>";
							
				$("table.cartList").append(html);
				
				lastOpseq = newOpseq;
				opseqArr.push(lastOpseq); // 배열에 저장하기 
				
			}
			
			//console.log("새로 넣은 후 => "+ lastOpseq); // 확인용
			
			//console.log(html); // 확인용
			
			//<option value="english" disabled>영어</option> => 비활성화 방법 
			
		}// end of if 
		
		calTotalPrice();
		
	}// end of function addToForm()---------------------------------------------------------------------
	

	// 총 금액 계산 
	function calTotalPrice(){
		
		
		$("span#tprice").empty();
		$("span#tcnt").empty();
		
		var finalTotalPrice = 0; 		 // 최종 전체 가격
		var finalTotalOqty = 0;			 // 최종 수량 
		var finalTotalPoint = 0;			 // 최종 수량 
		
		
		$(".cartList").find("input").each(function(){
			var $target = $(this);
			var oqty = $target.val();
			oqty = Number(oqty);
			
			var price = ${requestScope.pvo.price} * oqty;
			var point = ${requestScope.pvo.point} * oqty;
			
			finalTotalPrice = finalTotalPrice + price;
			finalTotalOqty = finalTotalOqty + oqty;
			finalTotalPoint = finalTotalPoint + point;
			
			//console.log("반복문진행중");
		});
		
		finalTotalPrice = finalTotalPrice.toLocaleString();
		//console.log("가격" + finalTotalPrice );
		//console.log("갯수" + finalTotaloqty);
		
		
		$("span#tprice").text(finalTotalPrice + "원 (" + finalTotalPoint + ")");
		$("span#tcnt").text(finalTotalOqty);
		
	}
	
	
	
	function changeImg(){
		alert("클릭됨!");
		
		var $target = $(this);
		var html = $target.html();

		$("div.keyImgae").html(html);
		
	}
	
</script>


<div class="container px-0">

   <div class="detail row-my-3">
      <div class="image col-md-6" >
         <div class="keyImage">
            <img src="../images/${requestScope.pvo.pimage}" style="width:90%;" alt="...">
         </div>
         <div class="imageList">
            <h2 style="font-size: 13px; margin-top: 10px; margin-bottom: 10px;">view more image</h2>
            <ul>
               <li class="img"><img src="../images/${requestScope.pvo.pimage}" style="width:90%;" alt="..." ></li>
               <c:forEach var="option" items="${requestScope.optionList}" >
                  <li class="img"><img src="../images/${option.cimage}" style="width:90%;" alt="..."></li>
               </c:forEach>
            </ul>
         </div>
      </div>   
         
      <div class="info col-md-6" align="left" >
         <div><h2 style="font-size: 15px;">${requestScope.pvo.pname}</h2></div>
         <hr>
         <div style="width: 100%;">
            <table>
               <tr>
                  <th style="width: 115px; text-align: center;">판매가</th>
                  <td><fmt:formatNumber value="${requestScope.pvo.price}" pattern="#,###"/>원</td>
               </tr>
               <tr>
                  <th style="width: 115px; text-align: center;">적립금</th>
                  <td>${requestScope.pvo.point} (1%)</td>
               </tr>
               
            </table>
            <hr style="solid 1px gray;">
            <table>   
               <tr>
                  <th style="width: 115px; text-align: center;">컬러</th>
                  <td>
                     <select id="optionselect" style="width: auto; font-size:15px;" onchange="addToForm()">
                        <option selected value="0" style="width: 350px;">-[필수] 옵션을 선택해 주세요-</option>
                        <c:forEach var="option" items="${requestScope.optionList}">
                           <c:if test=" ${option.cnt eq 0 }">
                           <option value="${option.opseq}" value2="${option.fk_cseq.cname} disabled">${option.fk_cseq.cname}--(ex:마감입박, NEW)</option>
                           </c:if>
                           <option value="${option.opseq}" value2="${option.fk_cseq.cname}">${option.fk_cseq.cname}</option>
                        </c:forEach>
                     </select>
                  </td>
               </tr>
            </table>
         </div>
         <div>   
            <table class="cartList">
            
            </table>
               <input type ="hidden" name="opseq" value="0">
               <input type ="hidden" name="oqty"  value="0">
            
         </div>
         <hr>
         <div class="totalPrice" style="font-size:10px;" align="right" >
            <strong style="font-size: 13px;">총 상품금액 (수량): &nbsp;</strong>
            <span id="tprice">
            0원
            </span>
            &nbsp;/&nbsp;
            <span id="tcnt">
            0
            </span>
            개
         </div>
         <div class="my-5" >
            <button type ="submit" id="submit2"  class="buttons border btn btn-outline-secondary mb-4 btn-lg btn-block">BUY IT NOW</button>
            <button type ="submit" id="submit"   class="buttons border btn btn-outline-secondary btn-lg btn-block">ADD TO CART</button>
            <button type ="submit" id="submit3"  class="buttons border btn btn-outline-secondary mb-2 mt-0 btn-lg btn-block">WISH LIST</button>
         </div>
         
         <div>
            <div style="font-size: 13px; margin-bottom: 2px;">comment</div>
            <div>${requestScope.pvo.pcontent}</div>
         </div>
         
      </div>
   </div>   
   
   
</div>
<jsp:include page="../footer.jsp" />