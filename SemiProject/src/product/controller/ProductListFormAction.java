package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class ProductListFormAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		/*
		 어차피 get방식으로만 들어가는데 이렇게 할 필요가 있는 건가?
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			
			
		}
		else { // index.go의 메뉴에서 Best카테고리 클릭시(get방식)
			
			super.setViewPage("/WEB-INF/product/productListForm.jsp");
		}
		*/
		
		
		
		
		// 확인용(view단에 넘어갔을때 잘 나오는지 확인)
		List<ProductVO> productList = new ArrayList<>();//ProductVO(확인용)담는 리스트생성
		
		ProductVO pvo = new ProductVO();//첫번쨰 ProductVO생성
		
		pvo.setTitle("(unusually) hailey cable cardigan (2color)");
		pvo.setPrice("38,000원");
		pvo.setComment("주문폭주!✨ 겨울까지 계속 꺼내입기좋은 내추럴한 무드의 울 가디건♡ 특별히 신경쓴, 흔치 않은 꽈배기 짜임으로 제작되어 소장가치있는 가디건이에요 :)");
		pvo.setImgSource("//nearwear.co.kr/web/product/medium/202108/4827ec19d896aea7b1e76aa6bd69f293.webp");
		
		productList.add(pvo);
		
		
		pvo = new ProductVO();//두번째 ProductVO 생성
		
		pvo.setTitle("(unusually) hailey cable cardigan2 (2color)");
		pvo.setPrice("38,000원");
		pvo.setComment("주문폭주!✨ 겨울까지 계속 꺼내입기좋은 내추럴한 무드의 울 가디건♡ 특별히 신경쓴, 흔치 않은 꽈배기 짜임으로 제작되어 소장가치있는 가디건이에요 :)");
		pvo.setImgSource("//nearwear.co.kr/web/product/medium/202108/4827ec19d896aea7b1e76aa6bd69f293.webp");
		
		productList.add(pvo);
		
		
		pvo = new ProductVO();//세번째 ProductVO 생성
		
		pvo.setTitle("(unusually) hailey cable cardigan3 (2color)");
		pvo.setPrice("38,000원");
		pvo.setComment("주문폭주!✨ 겨울까지 계속 꺼내입기좋은 내추럴한 무드의 울 가디건♡ 특별히 신경쓴, 흔치 않은 꽈배기 짜임으로 제작되어 소장가치있는 가디건이에요 :)");
		pvo.setImgSource("//nearwear.co.kr/web/product/medium/202108/4827ec19d896aea7b1e76aa6bd69f293.webp");
		
		productList.add(pvo);
		
		
		pvo = new ProductVO();//네번째 ProductVO 생성
		
		pvo.setTitle("(unusually) hailey cable cardigan4 (2color)");
		pvo.setPrice("38,000원");
		pvo.setComment("주문폭주!✨ 겨울까지 계속 꺼내입기좋은 내추럴한 무드의 울 가디건♡ 특별히 신경쓴, 흔치 않은 꽈배기 짜임으로 제작되어 소장가치있는 가디건이에요 :)");
		pvo.setImgSource("//nearwear.co.kr/web/product/medium/202108/4827ec19d896aea7b1e76aa6bd69f293.webp");
		
		productList.add(pvo);
		
		pvo = new ProductVO();//다섯번째 ProductVO 생성
		
		pvo.setTitle("(unusually) hailey cable cardigan5 (2color)");
		pvo.setPrice("38,000원");
		pvo.setComment("주문폭주!✨ 겨울까지 계속 꺼내입기좋은 내추럴한 무드의 울 가디건♡ 특별히 신경쓴, 흔치 않은 꽈배기 짜임으로 제작되어 소장가치있는 가디건이에요 :)");
		pvo.setImgSource("//nearwear.co.kr/web/product/medium/202108/4827ec19d896aea7b1e76aa6bd69f293.webp");
		
		productList.add(pvo);
		
		
		request.setAttribute("productList",productList);//리스트 넘김
		
		super.setViewPage("/WEB-INF/product/productListForm.jsp");
		
		
	}

}
