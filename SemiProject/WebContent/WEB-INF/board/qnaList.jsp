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
    min-height: 1300px;
}

table {
	width: 1200px;
	margin: auto;
}

th {
	text-align: center;
}

td {
	text-align: center;
}

select#searchType {
    display: inline-block;
    margin-left: 60px;
    min-width: 100px;
    height: 22px;
    line-height: 22px;
    margin: 0 2 0 0px;
    padding: 0 0 0 5px;
    color: #333;
    border: 1px #d5d5d5 solid;
}

input {
    height: 22px;
    line-height: 22px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}

select#sizePerPage {
	display: inline-block;
    min-width: 50px;
    height: 22px;
    line-height: 22px;
    margin: 0 2 0 0px;
    padding: 0 0 0 5px;
    color: #333;
    border: 1px #d5d5d5 solid;
}

button#search {
	background-color: #fff;
	border: 1px solid #d5d5d5;
	height: 22px;
}

span.button {
	width: 96px;
	height: 22;
	border: 1px solid #b3b3b3;
    float: right;
    text-align: center;
    padding: 5px;
    margin-right: 60px;
}

</style>

</head>

<body>


<script type="text/javascript">

   $(document).ready(function(){
	   
	 
      
   });// end of $(document).ready(function(){})----------------------------------

   // Function Declaration
   function goList(){
	   var frm = document.boardFrm;
	   frm.action = "qnaList.go";
	   frm.method = "GET";
	   frm.submit();
   }
   
</script>

<div id="container">
    <div id="contents">

		<div class="titleArea">
            <h2><font color="#333333">Q & A</font> </h2>
            <p class="desc">Q&A 게시판입니다.</p>
    	</div>
    	
	<br>
   
	    <table id="boardTbl" class="table table-bordered" style="width: 90%; margin-top: 20px;">
	    	<colgroup>
			    <col style="width:100px;">
				<col style="width:750px;">
				<col style="width:125px;">
				<col style="width:75px;" >
				<col style="width:150px;" class="displaynone">
			</colgroup>
	
			<thead >
					<tr style=" ">
						<th scope="col">NO</th>
			            <th scope="col">SUBJECT</th>
			            <th scope="col">NAME</th>
			            <th scope="col" class="displaynone">HIT</th>
			            <th scope="col" class="">DATE</th>      
				    </tr>
		    </thead>
		    <tbody>
		         <c:forEach var="bvo" items="${requestScope.boardList}">
		            <tr>
		               <td>${bvo.board_num}</td>
		               <td>${bvo.board_subject}</td>
		               <td>${bvo.board_id}</td>
		               <td>${bvo.board_count}</td>
		               <td>${bvo.board_date}</td>
		            </tr>
		         </c:forEach>
		     </tbody>
     	</table>
     
     	<br>
     
	     <form name="memberFrm">
	     	<p> 
		      <select id="searchType" name="searchType">
		         <option value="id">회원명</option>
		         <option value="subject">제목</option>
		         <option value="content">내용</option>
		      </select>
	      
		      <input type="text" id="searchWord" name="searchWord" />
		      <button id="search" type="button" onclick="goSearch();">검색</button>
		
		      <select id="sizePerPage" name="sizePerPage">
		         <option value="10">10</option>
		         <option value="5">5</option>
		         <option value="3">3</option>
		      </select>
		      
		      <span class="button">	
		         <a href="<%=ctxPath%>/board/qnaWrite.go">글작성</a> 
		      </span>
		   </p>
		      
	    </form>
	      
	    <nav class="my-5">
	      	 <div style="display: flex; width::80%;">
	      	 	<ul class="pagination" style="margin: auto;">${requestScope.pageBar}</ul>
	      	 </div>	 			
	    </nav>
      
   </div>
</div>
    
</body>
</html>

<jsp:include page="../footer.jsp" />