package product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController_LCE;
import product.model.CategoryLVO_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;
import product.model.ProductVO_LCE;

public class ProductListLowAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getBasketCnt(request);// 다른 페이지들도 다 넣어야지 장바구니 갯수 볼 수 있음 !!
		
		String ViewPage = "/WEB-INF/product/productListLow.jsp";
		
		/* 카테고리 리스트를 받아오는 부분이 에러는 아니지만 불분명하고 통상적으로 쓰이는 메소드도 아닌 것 같음 
		super.getCategoryList(request);
		//System.out.println(request.getAttribute("categoryList"));
		
		List<Map<String,String>> categoryList = (ArrayList)request.getAttribute("categoryList");
		//System.out.println("확인용 ===>" + categoryList.size());
		*/
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();
		
		
		//**** 내부카테고리 만들기위한 데이터값 가져오기 ****//
		
		// 카테고리 목록 받아오기
		List<Map<String, String>> categoryList = pdao.getCategoryList(); 
		
		Map<String, String> paraMap = new HashMap<>();
		
		String searchNO = request.getParameter("clseq"); // 하위카테고리코드
		String sortType = request.getParameter("sortType"); // 정렬방법 
		
		// 상위카테고리 알아오기 
		String cuseq = "";
		for(Map<String,String> mvo: categoryList) {
			if( searchNO.equals(mvo.get("clseq"))) {
				cuseq = mvo.get("fk_cuseq");
				break;
			}
		}

		// searchNO(=clseq) 비정상적으로 입력시 보정
		int clseqcnt = categoryList.size(); // 카테고리갯수(비정상접근 처리에 쓰임)
		
		try {
			int check = Integer.parseInt(searchNO);
			
			if( check > clseqcnt) { // 숫자입력, 카테고리에 없는 숫자 입력시 
				ViewPage = "/WEB-INF/warning_LCE.jsp";
			}
			
		} catch(Exception e) { // 숫자가 아닌 문자 입력시 
			searchNO = "1"; // 안넣어주면 밑에서 오류떨어짐 
			ViewPage = "/WEB-INF/warning_LCE.jsp";
		}
		
		request.setAttribute("cuseq",cuseq);
		request.setAttribute("searchNO", searchNO); 

		paraMap.put("searchNO",searchNO);
		paraMap.put("sortType",sortType); 
		
		// 하위카테고리에 해당하는 상품 전체 갯수 가져오기 
		int totalProductCnt = pdao.geTotalProductCntLow(searchNO); // 상품들 전체 갯수 가져오기
		
		//***** 페이징 처리구간 *****
		String currentShowPageNo = request.getParameter("currentShowPageNo"); // 현재페이지
		String sizePerPage = "8"; // 페이지마다 보여줄 항목 갯수 굳이 필요없음 dao에서 고정하자
		
		// 현재페이지번호, 상품항목갯수 보정 (항상 8개씩만 보여주기)
		if(currentShowPageNo == null) {
			currentShowPageNo="1";
		}
		if(sizePerPage != "8") {
			sizePerPage = "8";
		}
		
		try {
			Integer.parseInt(currentShowPageNo); 
		} catch (Exception e) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);
		
		
		// 상품목록 가져오기 
		List<ProductVO_LCE> productList = pdao.selectPagingProductLow(paraMap);
		
		/* 값이 넘어왔는지 확인용 
		for(int i = 0; i<productList.size(); i++) {
			if( productList.get(i).getPrice() == 0) {
				System.out.println("값없음 ");
			}
		}
		*/
		
		request.setAttribute("categoryList", categoryList);
		request.setAttribute("productList", productList);
		request.setAttribute("totalProductCnt",totalProductCnt);
		request.setAttribute("sizePerPage", sizePerPage);
		
		// 페이지바 만들기 시작 (페이지바 1개블럭당 3개, 1개페이지당 8개 상품보여줌)
		String pageBar = "";
		
		int blockSize = 3; //페이지바 블럭사이즈
		
		int loop = 1;
		
		int pageNo= ( (Integer.parseInt(currentShowPageNo)-1) / blockSize ) * blockSize + 1;
		
		// 검색이 있는 혹은 검색이 없는 전체회원에 대한 총페이지 알아오기
		int totalPage = pdao.getTotalPageLow(paraMap);
		//System.out.println("확인용 totalPage=>" + totalPage); 잘나옴 
		
		// [맨처음]과 [이전] 만들기
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='productListLow.go?clseq="+searchNO+"&currentShowPageNo=1&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>[맨처음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='productListLow.go?clseq="+searchNO+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage)) {
			
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='productListLow.go?clseq="+searchNO+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			
			pageNo++;
			
		}// end of while-----------------------------------------------------
		
		 //[다음]과 [마지막] 만들기 
		if( pageNo <= totalPage) {
			pageBar +=  "<li class='page-item'><a class='page-link' href='productListUp.Low?clseq="+searchNO+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>[다음]</a></li>";
			pageBar +=  "<li class='page-item'><a class='page-link' href='productListUp.Low?clseq="+searchNO+"&currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>[마지막]</a></li>";
			
		}
		
		request.setAttribute("pageBar", pageBar); //페이지바 넘겨주기 
		
		//super.setRedirect(false);
		super.setViewPage(ViewPage);
		
	}

}
