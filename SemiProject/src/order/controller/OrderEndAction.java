package order.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO_OHJ;
import product.model.ProductDAO_OHJ;

public class OrderEndAction extends AbstractController {

	// === 전표(주문코드)를 생성해주는 메소드 생성하기 === //
	private String getOdrcode() throws SQLException {
		
		// 전표(주문코드) 형식 : s+날짜+sequence  s20211018-1
		
		// 날짜 생성
	    Date now = new Date(); // java.util로 import
	    SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd"); 
	    String today = smdatefm.format(now); // 20211018
		
	    InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
	    
	    String seq = pdao.getSeq_ordercode();
	    // pdao.getSeq_tbl_order(); 는 시퀀스 seq_tbl_order_odrcode 값을 채번해오는 것.
		
	    return "s"+today+"-"+seq;
	    
	}// end of private String getOdrcode()--------------------
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// orderForm으로부터 post방식으로 가져온거(form태그의 name)
		
		// destination,receiverName,postcode,address,detailAddress,extraAddress,hp1,hp2,hp3,email,deliveryMsg 아니고,
		// 회원아이디, 주문총액 / 제품번호, 주문량, 주문가격 / 옵션번호 / 포인트테이블의 주문코드
		
		String userid = request.getParameter("userid");
		String odrtotalprice = request.getParameter("odrtotalprice");
		String fk_pseqjoin = request.getParameter("fk_pseqjoin");
		String oqtyjoin = request.getParameter("oqtyjoin");
		String odrpricejoin = request.getParameter("odrpricejoin");
		String fk_opseqjoin = request.getParameter("fk_opseqjoin");
		String fk_odrcodejoin = request.getParameter("fk_odrcodejoin");
		//------------------------------------------------------------
		String pointUsed = request.getParameter("pointUsed");
		
		String[] fk_pseqArr = fk_pseqjoin.split(",");
		String[] oqtyArr  = oqtyjoin.split(",");
		String[] odrpriceArr = odrpricejoin.split(",");
		String[] fk_opseqArr = fk_opseqjoin.split(",");	
		String[] fk_odrcodeArr = fk_odrcodejoin.split("_");
		
	/*			
		for(int i=0; i<fk_pseqArr.length; i++) { // fk_pseqArr의 개수나 oqtyArr의 개수나 똑같음
            System.out.println("~~~~ 확인용 fk_pseq: " + fk_pseqArr[i]
            						 + ", oqty: " + oqtyArr[i]
            						 + ", odrprice: " + odrpriceArr[i]  
            						 + ", fk_opseq: " + fk_opseqArr[i] 
            					//	 + ", fk_odrcode: " + fk_odrcodeArr[i] // 얘는 fk_pseqArr의 갯수와 다름
            				); 
        }// end of for--------------------------------------------------------------------		
	*/			
		
		
		// ===== Transaction 처리하기 ===== // 
		// 1) tbl_order와 tbl_orderdetail 주문내역insert
		// 2) tbl_orderProgress 주문대기중목록delete
		// 3) tbl_cart 해당목록delete
		// 4) tbl_wishlist 해당목록delete
		// * 5) tbl_recentViewProduct 해당목록delete(-> 안함!)
		// 6) tbl_poption 의 cnt 감소 update
		// 7) tbl_member 포인트 insert,update
		
		
		// 결제성공했으니, orderEnd.jsp에 넘겨줄꺼야~~
		Map<String,Object> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("odrtotalprice", odrtotalprice);
		paraMap.put("fk_pseqArr", fk_pseqArr);
		paraMap.put("oqtyArr", oqtyArr);
		paraMap.put("odrpriceArr", odrpriceArr);
		paraMap.put("fk_opseqArr", fk_opseqArr);
		paraMap.put("fk_odrcodeArr", fk_odrcodeArr);
		//-----------------------------------------
		paraMap.put("pointUsed",pointUsed);
		
		// 주문코드(명세서번호) 채번하기
        // 주문코드 형식 : s+날짜+sequence
        String odrcode = getOdrcode();
        paraMap.put("odrcode", odrcode);
		
        
		InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
        // !!!!!! Transaction 처리를 해주는 메소드 !!!!!!
		
        int isSuccess = pdao.orderAdd(paraMap);
		
        if(isSuccess == 1) { // 데이터베이스에서 성공한 경우
        	
        //	System.out.println("~~~주문이 성공적으로 완료되었습니다!!!~~~");
        	
        	request.setAttribute("odrcode", odrcode); // 주문완료페이지에 보여줄 주문코드번호
        
        //	super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/orderEnd.jsp");
		
        }
        else { // 데이터베이스에서 실패한 경우
        	String loc = request.getContextPath() + "/index.go";
        	String message = "Sorry! 주문이 실패되었습니다...";
        	
        	request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			 
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
        }
        
		
	}

}
