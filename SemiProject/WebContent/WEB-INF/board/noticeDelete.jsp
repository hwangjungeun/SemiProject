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
    min-height: 800px;
}

table.tbl {
	width: 900px;
	height: 500px;
    border: 0.5px #d5d5d5 solid;
    margin: auto;
    text-align: center;
}
img {
	width: 500px;
	text-align: center;
}

button.button {
	margin: auto;
	border: 1px solid #b3b3b3;
	text-align: center;
	width: 96px;
	height: 32px;
	font-size: 10pt;
	margin-bottom: 20px;
}

h2.modal-title {
	font-size: 12pt;
	font-weight: bolder;
}

h2.modal-body {
	font-size: 12pt;
	font-weight: normal;
}


</style>

</head>

<body>


<script type="text/javascript">

   $(document).ready(function(){
      
      $("button#yDelete").click(function(){ // 삭제를 눌렀다면
         var frm = document.DeleteFrm;
         frm.action = "noticeDeleteEnd.go";
         frm.method = "post";
         frm.submit();
      });
      
      
   });// end of $(document).ready(function(){})------------------------------------------------

</script>



</head>
<body>

<div id="container">
    <div id="contents">
    
    <div class="titleArea">
            <h2><font color="#333333">NOTICE</font> </h2>
            <p class="desc">공지사항입니다.</p>
    	</div>
    	
	<br>
    <div class="typeWrite ">
    <table class="tbl">
				<tr>
				   <td><img src="../images/bin.png" alt=""></td>			
				</tr>
				<tr>
				<td><button type="button" class="button" data-toggle="modal" data-target="#myModal">게시물 삭제</button></td>
        
    
    </tr>
	</table>			
	
  
    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
        
                <!-- Modal Header -->
                <div class="modal-header">
                    <h2 class="modal-title" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;게시물 삭제</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
            
                <!-- Modal body -->
                <div class="modal-body">
                    <h2 class="modal-body" align="center">${requestScope.notice_num} 번 게시물을 정말 삭제하시겠습니까? </h2>
                </div>
            
                <!-- Modal footer -->
                <div class="modal-footer">
			      	<button type="button" class="btn btn-primary" id="yDelete">삭제</button>
			       	<button type="button" class="btn btn-secondary" id="noDelete" data-dismiss="modal">취소</button>
			    </div>
            </div>   
        </div>
    </div>
    
    </div>
    </div>
    </div>
    
    <form name="DeleteFrm">
      <input type="hidden" name="notice_num" value="${requestScope.notice_num}">
   </form>
    
</body>
</html>


<jsp:include page="../footer.jsp" />