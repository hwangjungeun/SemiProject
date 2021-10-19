<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     

<%
	String ctxPath = request.getContextPath();
	//		/SemiProject
%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="/SemiProject/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<jsp:include page="../header.jsp" />

</head>
<script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
<style type="text/css">


.titleArea {
    margin: 0 0 30px;
    text-align: center;
}

.titleArea h2 {
    display: inline-block;
    position: relative;
    margin: 10px auto 10px;
    padding: 8px 15px;
    min-width: 180px;
    color: #353535;
    font-size: 11pt;
    font-weight: bold;
    letter-spacing: 1px;
    border: 1px #ddd solid;
}

p.desc {
	font-size: 9pt;
}

#container {
    width: 1250px;
    margin: auto;
}

#contents {
   /*  position: relative; */
    margin: auto;
    min-height: 1000px;
}

table.tbl {
	width: 1000px;
	margin: auto;
	text-align: center;
	border: 1px solid #d5d5d5;
	line-height: 25px;
}
td {
	border: 1px solid #d5d5d5;
	padding: 4px 3px 4px 6px;
}
input {
	border: 1px solid #d5d5d5;
}
textarea {
	border: 1px solid #d5d5d5;
	padding: 4px 3px 4px 6px;
}
/*
input {
	border: solid 1px white;
	border-bottom: solid 1px #d5d5d5;
	
}
*/
button {
	width: 90px;
	height: 31px;
	border: 1px solid #8c8c8c;
	background-color: #444444;
    float: right;
    text-align: center;
    font-size: 9pt;
    padding: 5px;
    margin-right: 10px;
}
button.btn {
	border: 1px solid #8c8c8c;
}


</style>

<body>

<script type="text/javascript">
   
   $(document).ready(function(){
      
      $("button#btnGoEdit").click(function(){ // 수정할 글정보를 작성하고 수정하기 버튼을 클릭하면 작동하는 이벤트처리
         
          if( $("input[name=board_id]").val().trim() == "" ){
            alert("글쓴이를 입력해야합니다!");
            return;
         }
         
         if(  $("input[name=board_subject]").val().trim() == ""  ){
            alert("글제목을 입력해야합니다!");
            return;
         }
         
         if(  $("textarea[name=board_content]").val().trim() == ""  ){
            alert("글내용을 입력해야합니다!");
            return;
         }
         
         if( parseInt($("input[name=board_subject]").val().length) > 100  ){
            alert("글제목은 100글자까지 가능합니다.!");
            return;
         }
         
         
         if( parseInt($("textarea[name=board_content]").val().length) > parseInt(500)  ) {
            alert("글내용은 500글자까지 가능합니다!");
            return;
         }
         
         var checkboxCheckedLength = $("input:checkbox[id=agree]:checked").length;
			
			if(checkboxCheckedLength == 0) {
				alert("이용약관에 동의하셔야 합니다.");
				return; // 종료
			}
         
      // 값을 보내기 위해 꺼놨던 인풋을 다시 켜준다.
         $("input#board_num").prop("disabled", false);
         $("input#board_id").prop("disabled", false);
         
         var frm = document.registerFrm;
         frm.action="qnaEditEnd.go";
         frm.method="POST";
         frm.submit();
         
         
      });// end of $("button#btnGoInsert").click(function(){})---------------------------------
      
      
      
   });// end of $(document).ready(function(){})------------------------------------
   

</script>


<div id="container" >
    <div id="contents">

		<div class="titleArea">
	           <h2><font color="#333333">Q & A</font> </h2>
	           <p class="desc">Q&A 게시판입니다.</p>
	    </div>
		<br><br>   
    
		<form name="registerFrm">
		
		<table class="tbl" border="1" >
			<thead>
			 	<tr> 
			       <th colspan="2" id="th"><span style="font-size: 9pt; "><span class="star">*</span>표시는 필수입력사항 입니다.</span></th>
			  	</tr>
			</thead>
		    <tbody>
		    <tr>
			      <td style="font-weight: bold;">글번호&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
				      <input type="text" id="board_num" name="board_num" value="${requestScope.board_num}" disabled="disabled"/>
			      </td> 
			   </tr>
		    
			   <tr>
			      <td style="font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
				      <input type="text" id="board_id" name="board_id" value="${requestScope.board_id}" disabled="disabled"/>&nbsp;&nbsp;
				      <span id="idcheckResult"></span>
			      </td> 
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">제목&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
			         <input type="text" id="board_subject" name="board_subject" maxlength="100"  style="width:50%" placeholder="${requestScope.board_subject}" autofocus required />
			      </td>
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">내용&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
			         <textarea name="board_content" style="width:650px; height:250px;" maxlength="500" placeholder="${requestScope.board_content}" wrap="hard" required style="resize: none; width: 90%;" ></textarea>
			      </td>
			   </tr>
			   <tr>
				   <td style="font-weight: bold;">개인정보 수집 및 이용 동의&nbsp;<span class="star">*</span></td>
				   <td style="text-align: left; vertical-align: middle;">
			       		<iframe src="../iframeAgree/infoagree.html" width="80%" height="auto" class="box" ></iframe>   
			       </td>
			   </tr>
			  	<tr>
				   <td colspan="2" style="line-height: 50px;" class="text-center">
				    	<label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
				   </td>
			  	</tr>
		     </tbody>
		 </table>
		 <br>
		 	<button id="btnGoEdit" type="button" class="btn btn-dark btn-md" style="margin-right: 125px;">수정</button>
      		<button type="button" class="btn" onclick="javascript:history.back()">취소</button>
		 </form>
		<br><br>

	</div>
</div>



<jsp:include page="../footer.jsp" />