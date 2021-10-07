<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style type="text/css">
	thead th {
		background-color: #f2f2f2;
	}
	tbody th {
		border-right: none;
	}
	tbody td {
		border-left: none;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
				
		
		
	});
	

</script>

<div class="container">
	<h1 class="text-center">POINT</h1>
	
	<table id="memberTbl" class="table" style="width: 90%; margin-top: 20px; border: solid 1px #d6d6d6">
		
		<thead>
			<tr>
				<th colspan="2" style="font-size: 10pt; font-weight: bold;">적립금</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>총 적립금</th>
				<td>${requestScope.point_sum }</td>
			</tr>
			<tr>
				<th>사용가능 적립금</th>
				<td></td>
			</tr>
			<tr>
				<th>사용된 적립금</th>
				<td></td>
			</tr>
			<tr>
				<th>미가용 적립금</th>
				<td></td>
			</tr>
		</tbody>
		
	</table>
</div>

<nav class="my-5">
	<div style="display: flex; width: 80%;">
		<ul class="pagination" style="margin: auto;">${requestScope.pageBar }</ul>
	</div>	
</nav>


<jsp:include page="../footer.jsp" />