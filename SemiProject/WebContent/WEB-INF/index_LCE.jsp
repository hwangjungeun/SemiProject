<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      



<%

	String ctxPath = request.getContextPath();
	//		/SemiProject
%>


<jsp:include page="./header.jsp" />
	
	
	<!-- 상단 컨텐츠 시작 -->
	<div id="visual" class ="row custom-topcontents container mx-auto p-0">
		<div class="col-md-8 pr-0" style="width: 900;">
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
				<div id="olli"></div>
				
				<div class="carousel-inner">
				    <div class="carousel-item active">                            
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/09/10/8cf888f5fd85d65a5bae739064492bbd.jpg" alt="..." title="" border="0"/>
					</div>
			
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/09/10/8bb4379d5ab5de58dc6b4c94ed22866e.jpg" alt="..." title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/09/10/b690b25aeb81586b44fec9180b0d0ee8.jpg" alt="..." title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/08/26/2c66ea67db4c1ce68891119eec6638ce.jpg" alt="" title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/08/24/b2c3191033860e96ef837804c1bb741c.jpg" alt="" title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/08/30/871fb3dc8b077067ba7d0b58dbe6fe30.jpg" alt="" title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/08/27/e84119d7ef174e9b764d207dc2f53b94.jpg" alt="" title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/09/08/679ecf7b3e4c657bf7cbbd0df4df2b76.jpg" alt="" title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/09/06/6982ef3dc41bdbf8c3cba2ebfd53e812.jpg" alt="" title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/09/03/daca8589cf41f89dad14bca2261c637e.jpg" alt="" title="" border="0"/>
					</div>
					
					<div class="carousel-item">
						<img src="//app-storage-edge-008.cafe24.com/photoslide2/jennyb/2021/09/03/97b5b435f7ce0dfb85ffefa06ace6754.jpg" alt="" title="" border="0"/>
					</div>
				</div>
				
				<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
				   <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				   <span class="sr-only">Previous</span>
				</a>
				<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
				   <span class="carousel-control-next-icon" aria-hidden="true"></span>
				   <span class="sr-only">Next</span>
				</a>
		    </div>
		</div>
		
		<div class="col-md-4 ">
			<img class='banner_image mb-3 float-right' width="340" title='01' alt='01' src='//app-storage-edge-006.cafe24.com/bannermanage2/jennyb/2021/08/18/b3e1a9a305f11d38c59d4b8d94a6e859.jpg' />
			<img class='banner_image pr-0 float-right' width="340" title='02' alt='02' src='//app-storage-edge-006.cafe24.com/bannermanage2/jennyb/2021/08/18/6a8d48ba645468d7a488a3f70c850316.jpg' />
		</div>
	</div>
	
	<div class="container text-center my-3 mb-5">
		<img class='col-md-4 px-0' title='01' alt='01' src='//app-storage-edge-006.cafe24.com/bannermanage2/jennyb/2021/08/31/b34656f3dad185c134495f72a7d4f55e.gif' />
		<img class='col-md-4 px-0' title='02' alt='02' src='//app-storage-edge-006.cafe24.com/bannermanage2/jennyb/2021/09/02/6f5915700b8a6bba4fb37126332ebe14.gif' />
		<img class='col-md-4 px-0' title='03' alt='03' src='//app-storage-edge-006.cafe24.com/bannermanage2/jennyb/2021/09/02/823c961e6443f546d9d41d9a7af26231.jpg' />
	</div>
			
	<!-- 상단 컨텐츠 끝 -->	
	
	
<jsp:include page="./footer.jsp" />