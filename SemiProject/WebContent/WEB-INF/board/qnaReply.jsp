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

<style>


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
    min-height: 800px;
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
button#btnReply {
	width: 90px;
	height: 31px;
	border: 1px solid #8c8c8c;
	background-color: #444444;
    float: right;
    text-align: center;
    font-size: 9pt;
    padding: 5px;
    margin-right: 10px;
    color: #ffffff;
}

button#btn {
	width: 90px;
	height: 31px;
	border: 1px solid #8c8c8c;
	background-color: #ffffff;
    float: right;
    text-align: center;
    font-size: 9pt;
    padding: 5px;
    margin-right: 10px;
}


</style>

<script type="text/javascript">

	$("document").ready(function(){
		
		 $("button#btnReply").click(function(){ 

		      // 값을 보내기 위해 꺼놨던 인풋을 다시 켜준다.
	        $("input#board_num").prop("disabled", false);
	        $("input#board_id").prop("disabled", false);
	        
	        var frm = document.replyFrm;
	        frm.action="qnaReplyEnd.go";
	        frm.method="POST";
	        frm.submit();
	        
			});
	
	 });// end of $("document").ready(function(){})-------------------------------	 
	
</script>
</head>

<body>


<div id="container" >
    <div id="contents">

		<div class="titleArea">
	           <h2><font color="#333333">Q & A</font> </h2>
	           <p class="desc">Q&A 게시판입니다.</p>
	    </div>
		<br><br>   
    
		<form name="replyFrm">
		
		<table class="tbl" border="1" >
			<thead>
			 	<tr> 
			       <th colspan="2" id="th" bgcolor="#f2f2f2"><span style="font-size: 9pt; ">답글 달기</span></th>
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
				      <input type="text" id="board_id" name="board_id" value="${requestScope.userid}" disabled="disabled"/>&nbsp;&nbsp;
				      <span id="idcheckResult"></span>
			      </td> 
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">제목&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
			         <input type="text" id="board_subject" name="board_subject" maxlength="100"  style="width:50%" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RE : 답글입니다." autofocus required />
			      </td>
			   </tr>
			   <tr>
			      <td style="font-weight: bold;">내용&nbsp;<span class="star">*</span></td>
			      <td style="text-align: left;">
			         <textarea id="board_content" name="board_content" style="width:650px; height:250px;" maxlength="500" placeholder="${requestScope.board_content}" wrap="hard" required style="resize: none; width: 90%;" >			         
-------------------------------------------------------------------------	
|답변|
									         
			         </textarea>
			      </td>
			   </tr>
		     </tbody>
		 </table>
		 </form>
		<br><br>
		
		<button id="btn" style="margin-right: 120px;" type="button" onclick="javascript:history.back();">취소</button>
		<button id="btnReply" style="margin-right: 5px;">등록</button>

</div>
</div> 


</body>
</html>

<jsp:include page="../footer.jsp" />