package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;
import product.model.ProductVO_LCE;

public class ProductListUpAction extends AbstractController_LCE {
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.getBasketCnt(request);// 다른 페이지들도 다 넣어야지 장바구니 갯수 볼 수 있음 !!<---이거 굳이 필요있을까? session에 넣었는데?
		
		super.getCategoryList(request);
		//System.out.println(request.getAttribute("categoryList"));
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();
		
		Map<String, String> paraMap = new HashMap<>();
		
		//String searchType = "cuseq"; // 상위카테고리  --> 상위 하위 액션단 나눌거면 이거 굳이 필요없는 변수 고정값으로 넣으면 되니깐 
		String searchNO = request.getParameter("cuseq"); // 상위카테고리코드
		
		String sortType = request.getParameter("sortType"); // 정렬방법 
		
		//paraMap.put("searchType",searchType); // 상위카테고리  --> 상위 하위 액션단 나눌거면 이거 굳이 필요없는 변수 고정값으로 넣으면 되니깐 
		paraMap.put("searchNO",searchNO);
		paraMap.put("sortType",sortType); 
		
		request.setAttribute("searchNO", searchNO);
		
		
		//***** 페이징 처리구간 *****
		
		String currentShowPageNo = request.getParameter("currentShowPageNo"); // 현재페이지
		String sizePerPage = "8"; // 페이지마다 보여줄 항목 갯수, dao에서 고정시켜버리고 여기서 지우는 것이 나음 
		
		// 현재페이지번호, 상품항목갯수 보정해주기 (항상 8개씩만 보여주기)
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
		
		List<ProductVO_LCE> productList = pdao.selectPagingProduct(paraMap);// 상품들 가져오기 
		int totalProductCnt = pdao.geTotalProductCnt(searchNO); // 상품들 전체 갯수 가져오기
		
		/*
		// 값이 넘어왔는지 확인용 
		for(int i = 0; i<productList.size(); i++) {
			if( productList.get(i).getPrice() == 0) {
				System.out.println("값없음 ");
			}
		}
		*/
		
		request.setAttribute("productList", productList);
		request.setAttribute("totalProductCnt",totalProductCnt);
		request.setAttribute("sizePerPage", sizePerPage);
		
		// 페이지바 만들기 시작 (페이지바 1개블럭당 3개, 1개페이지당 8개 상품보여줌)
		String pageBar = "";
		
		int blockSize = 3; //페이지바 블럭사이즈
		
		int loop = 1;
		
		int pageNo= ( (Integer.parseInt(currentShowPageNo)-1) / blockSize ) * blockSize + 1;
		
		// 검색이 있는 혹은 검색이 없는 전체회원에 대한 총페이지 알아오기
		int totalPage = pdao.getTotalPage(paraMap);
		//System.out.println("확인용 totalPage=>" + totalPage); 잘나옴 
		
		// [맨처음]과 [이전] 만들기
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='productListUp.go?cuseq="+searchNO+"&currentShowPageNo=1&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>[맨처음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='productListUp.go?cuseq="+searchNO+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage)) {
			
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='productListUp.go?cuseq="+searchNO+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			
			pageNo++;
			
		}// end of while-----------------------------------------------------
		
		 //[다음]과 [마지막] 만들기 
		if( pageNo <= totalPage) {
			pageBar +=  "<li class='page-item'><a class='page-link' href='productListUp.up?cuseq="+searchNO+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>[다음]</a></li>";
			pageBar +=  "<li class='page-item'><a class='page-link' href='productListUp.up?cuseq="+searchNO+"&currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&sortType="+sortType+"'>[마지막]</a></li>";
			
		}
		
		request.setAttribute("pageBar", pageBar); //페이지바 넘겨주기 
		
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productListUp.jsp");
		// 여기까지가 상품항목불러오기(페이징바 일단 제외)
		
	}

}
