package product.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;


public class ProductDAO_OHJ implements InterProductDAO_OHJ {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO_OHJ() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
    private void close() {
    	try {
    		if(rs != null)    {rs.close();    rs=null;}
    		if(pstmt != null) {pstmt.close(); pstmt=null;}
    		if(conn != null)  {conn.close();  conn=null;}
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    }

    
    // 최근본상품 목록을 조회(select)하는 메소드
	@Override
	public List<RecentViewProdVO_OHJ> selectRecentViewProduct(Map<String, String> paraMap) throws SQLException {
		
		List<RecentViewProdVO_OHJ> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
		/*	
			String sql = " select pname, pimage, price, pseq, recentseq " + 
						 " from tbl_recentViewProduct V JOIN tbl_product P " + 
						 " ON V.fk_pseq = P.pseq " + 
						 " where fk_userid = ? " + 
						 " order by viewday desc ";
		*/	
			String sql = " select pname, pimage, price, pseq, recentseq " + 
						 " from " + 
						 " ( " + 
						 "     select rownum AS RNO, pname, pimage, price, pseq, recentseq " + 
						 "     from " + 
						 "     ( " + 
						 "         select pname, pimage, price, pseq, recentseq " + 
						 "         from tbl_recentViewProduct V JOIN tbl_product P " + 
						 "         ON V.fk_pseq = P.pseq " + 
						 "         where fk_userid = ? " + 
						 "         order by viewday desc " + 
						 "     ) R " + 
						 " ) T " + 
						 " where T.RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = 3; // 한 페이지당 화면상에 보여줄 제품의 개수는 3 으로 한다.
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
			pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				RecentViewProdVO_OHJ rvpvo = new RecentViewProdVO_OHJ();
				
				ProductVO_OHJ pvo = new ProductVO_OHJ();
				pvo.setPname(rs.getString(1));
				pvo.setPimage(rs.getString(2));
				pvo.setPrice(rs.getInt(3));
				pvo.setPseq(rs.getString(4));
				rvpvo.setPvo(pvo);
				
				rvpvo.setRecentseq(rs.getString(5));
				
				productList.add(rvpvo);
				
			}// end of while------------------------------------------------
			
		} finally {
			close();
		}
		
		return productList;
	}// end of public List<ProductVO> selectRecentViewProduct(Map<String, String> paraMap)-----------------------

	
	// 제품번호를 이용해서 옵션(색상의 종류)을 조회(select)하는 메소드
	@Override
	public List<Map<String, String>> viewColorOption(String pseq) throws SQLException {
		
		List<Map<String, String>> colorList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select C.cname, O.opseq " + 
						 " from tbl_product P JOIN tbl_poption O " + 
						 " ON P.pseq = O.fk_pseq " + 
						 " JOIN tbl_pcolor C " + 
						 " ON O.fk_cseq = C.cseq " + 
						 " where P.pseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  pseq);
			
			rs = pstmt.executeQuery();	
			
			while(rs.next()) {
				Map<String, String> map = new HashMap<>();
				map.put("CNAME", rs.getString(1));
				map.put("OPSEQ", rs.getString(2));
				
				colorList.add(map);
			}// end of while--------------------------------------
			
		} finally {
			close();
		}
		
		return colorList;
	}// end of public List<Map<String, String>> viewColorOption(String pseq)-------------------------------------

	
	// 위시리스트 목록을 조회(select)하는 메소드
	@Override
	public List<WishListVO_OHJ> selectWishList(Map<String, String> paraMap) throws SQLException {
		
		List<WishListVO_OHJ> wishList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
		/*	
			String sql = " select cimage, pname, cname, price, point " + 
						 " from tbl_wishlist W JOIN tbl_poption O " + 
						 " ON W.fk_opseq = O.opseq " + 
						 " JOIN tbl_pcolor C " + 
						 " ON O.fk_cseq = C.cseq " + 
						 " JOIN tbl_product P " + 
						 " ON W.fk_pseq = P.pseq " + 
						 " where fk_userid = ? " + 
						 " order by wishseq desc ";
		*/	
			
			String sql = " select cimage, pname, cname, price, point, opseq, wishseq " + 
						 " from " + 
						 " ( " + 
						 "     select rownum AS RNO, cimage, pname, cname, price, point, opseq, wishseq " + 
						 "     from " + 
						 "     ( " + 
						 "         select cimage, pname, cname, price, point, opseq, wishseq " + 
						 "         from tbl_wishlist W JOIN tbl_poption O " + 
						 "         ON W.fk_opseq = O.opseq " + 
						 "         JOIN tbl_pcolor C " + 
						 "         ON O.fk_cseq = C.cseq " + 
						 "         JOIN tbl_product P " + 
						 "         ON W.fk_pseq = P.pseq " + 
						 "         where fk_userid = ? " + 
						 "         order by wishseq desc " + 
						 "     )R " + 
						 " ) T " + 
						 " where T.RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = 3; // 한 페이지당 화면상에 보여줄 제품의 개수는 3 으로 한다.
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
			pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				WishListVO_OHJ wlvo = new WishListVO_OHJ();
				
				POptionVO_OHJ povo = new POptionVO_OHJ();
				povo.setCimage(rs.getString(1));
				
				ProductVO_OHJ pvo = new ProductVO_OHJ();
				pvo.setPname(rs.getString(2));
				
				PColorVO_OHJ pcvo = new PColorVO_OHJ();
				pcvo.setCname(rs.getString(3));
				
				pvo.setPrice(rs.getInt(4));
				pvo.setPoint(rs.getInt(5));
				
				povo.setOpseq(rs.getString(6));
				wlvo.setWishseq(rs.getString(7));
				
				povo.setPcvo(pcvo);
				
				wlvo.setPovo(povo);
				wlvo.setPvo(pvo);
				
				wishList.add(wlvo);
				
			}// end of while------------------------------------------------
			
		} finally {
			close();
		}
		
		return wishList;
	}// end of public List<WishListVO_OHJ> selectWishList(Map<String, String> paraMap)-----------------------
	
	
	// 최근본상품에서 해당제품의 목록을 삭제(delete)하는 메소드
	@Override
	public boolean deleteRecentViewProd(String recentseq) throws SQLException {
		
		boolean deleted = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_recentViewProduct " + 
						 " where recentseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, recentseq);
			
			int n = pstmt.executeUpdate();
			
			if(n==1) {
				// 목록삭제 성공되어짐.
				deleted = true;
			}
			
		} finally {
			close();
		}
		
		return deleted;
	}// end of public boolean deleteRecentViewProd(String recentseq)-------------------

	
	// 페이지바를 만들기 위해서 해당userid의 최근본상품 목록에 대한 총페이지수 알아오기(select) 
	@Override
	public int getRecentTotalPage(String userid) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/3) " + // 3이 sizePerPage 이다.
						 " from tbl_recentViewProduct " + 
						 " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			rs.next(); // 무조건 나오므로 if할 필요 없다.
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
	}// end of public int getRecentTotalPage(String userid)-----------------------------------

	
	// 위시리스트에서 해당제품의 목록을 삭제(delete)하는 메소드
	@Override
	public boolean deleteWishList(String wishseq) throws SQLException {
		
		boolean deleted = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_wishlist " + 
						 " where wishseq = ? "; // primary key가 아닌 opseq로 삭제하게되면 leess이 아닌 eomjh의 목록도 삭제하게 되므로 n이 1이 아니다. 따라서 조건절은 wishseq이다.
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, wishseq);
			
			int n = pstmt.executeUpdate();
			
			if(n==1) {
				// 목록삭제 성공되어짐.
				deleted = true;
			}
			
		} finally {
			close();
		}
		
		return deleted;
		
	}// end of public boolean deleteWishList(String wishseq)-------------------------------

	
	// 페이지바를 만들기 위해서 해당userid의 위시리스트 목록에 대한 총페이지수 알아오기(select) 
	@Override
	public int getWishTotalPage(String userid) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/3) " + // 3이 sizePerPage 이다.
						 " from tbl_wishlist " + 
						 " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			rs.next(); // 무조건 나오므로 if할 필요 없다.
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
		
	}// end of public int getWishTotalPage(String string)-----------------------------

	
	// 장바구니번호를 이용하여 fk_opseq(옵션번호)와 oqty(주문량)을 조회(select)하는 메소드
	@Override
	public Map<String, String> selectFromCart(String cartseq) throws SQLException {
		
		Map<String, String> map = new HashMap<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select fk_opseq, oqty " + 
						 " from tbl_cart " + 
						 " where cartseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cartseq);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				map.put("fk_opseq", rs.getString(1));
				map.put("oqty", rs.getString(2));
			}
			
		} finally {
			close();
		}
		
		return map;
	}// end of public Map<String, String> selectFromCart(String cartseq)------------------------

	
	
	// 주문진행중 테이블에 insert하는 메소드
	@Override
	public int insertOdrProg(Map<String,String> map) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_orderProgress(odrproseq,fk_opseq,fk_userid,wishoqty) " + 
						 " values(seq_tbl_odrProg_odrProseq.nextval, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, map.get("fk_opseq"));
			pstmt.setString(2, map.get("userid"));
			pstmt.setString(3, map.get("oqty"));
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}// end of public int insertOdrProg(Map<String,String> map)---------------------------

	
	// 주문원하는테이블인 tbl_orderProgress을 이용해, 주문서폼이 원하는 정보(이미지,제품명,옵션컬러명,가격,수량,적립금)와 주문완료가 원하는 정보(제품번호,옵션번호)인 orderProgList를 보내준다.
	@Override
	public List<OrderProgressVO_OHJ> showOdrProg() throws SQLException {
		
		List<OrderProgressVO_OHJ> orderProgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select O.cimage, P.pname, C.cname, P.price, g.wishoqty, P.point, P.pseq, O.opseq " + 
						 " from tbl_product P JOIN tbl_poption O " + 
						 " ON P.pseq = O.fk_pseq " + 
						 " JOIN tbl_pcolor C " + 
						 " ON O.fk_cseq = C.cseq " + 
						 " JOIN tbl_orderProgress G " + 
						 " ON O.opseq = G.fk_opseq ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrderProgressVO_OHJ opvo = new OrderProgressVO_OHJ();
				POptionVO_OHJ povo = new POptionVO_OHJ();
				PColorVO_OHJ pcvo = new PColorVO_OHJ();
				ProductVO_OHJ pvo = new ProductVO_OHJ();
				
				povo.setCimage(rs.getString(1));
				pvo.setPname(rs.getString(2));
				pcvo.setCname(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				opvo.setWishoqty(rs.getInt(5));
				pvo.setPoint(rs.getInt(6));
				pvo.setPseq(rs.getString(7));
				povo.setOpseq(rs.getString(8));
				
				povo.setPcvo(pcvo);
				povo.setPvo(pvo);
				
				opvo.setPovo(povo);
				
				orderProgList.add(opvo);
			}
			
		} finally {
			close();
		}
		
		return orderProgList;
	}// end of public List<OrderProgressVO_OHJ> showOdrProg()----------------------------

	
	// 위시리스트에서 해당 사용자의 위시리스트를 비우는(delete) 메소드
	@Override
	public boolean deleteAllWishList(String fk_userid) throws SQLException {
		
		boolean deleted = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_wishlist " + 
						 " where fk_userid = ? "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			
			int n = pstmt.executeUpdate();
			
			if(n >= 1) {
				// 목록삭제 성공되어짐.
				deleted = true;
			}
			
		} finally {
			close();
		}
		
		return deleted;
	}// end of public boolean deleteAllWishList(String fk_userid)-------------------------------------
	
	
	// 전표(주문코드)를 생성해주는 메소드
	@Override
	public String getSeq_ordercode() throws SQLException {
		
		String seq = "";
		
		try {
			conn = ds.getConnection();
			
			String sql = " select seq_tbl_order_odrcode.nextval AS seq " + 
						 " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			seq = rs.getString(1); // 채번해온 주문코드 값
			
		} finally {
			close();
		}
			
		return seq;
		
	}// end of public int getSeq_ordercode()-----------------------------------------

	
	
	// 결제성공시 transaction 처리를 해주는 메소드
	@Override
	public int orderAdd(Map<String, Object> paraMap) throws SQLException {

		int isSuccess = 0;
		
		try {
			conn = ds.getConnection();
			
			conn.setAutoCommit(false);  // ★수동커밋★

			
			String userid = (String) paraMap.get("userid"); 				// 회원아이디
			String odrtotalprice = (String) paraMap.get("odrtotalprice"); 	// 주문총액
			String[] fk_pseqArr = (String[]) paraMap.get("fk_pseqArr"); 	// 제품번호
			String[] oqtyArr = (String[]) paraMap.get("oqtyArr"); 			// 주문량
			String[] odrpriceArr = (String[]) paraMap.get("odrpriceArr"); 	// 주문가격
			String[] fk_opseqArr = (String[]) paraMap.get("fk_opseqArr"); 	// 옵션번호
			String odrcode = (String) paraMap.get("odrcode"); 				// 주문테이블의 주문코드(채번)
			
			int totalquantity = 0; // 주문 총수량
			
			for(int i=0; i<oqtyArr.length; i++) {
				totalquantity += Integer.parseInt(oqtyArr[i]);
			}// end of for------------------------------------
			
		//	System.out.println("주문 총 수량 : " + totalquantity);
			
			
			///////////////////////////////////////////////////////////////////////////////
			
			// 1-1) tbl_order에 주문내역insert (회원아이디, 주문총액 ) - 수동커밋처리
			int success1 = 0; // 성공유무
			String sql = " insert into tbl_order(odrcode,fk_userid,odrtotalprice,odrdate,totalquantity) " + 
						 " values(?,?,?,default,?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odrcode);
			pstmt.setString(2, userid);
			pstmt.setString(3, odrtotalprice);
			pstmt.setInt(4, totalquantity);
			
			success1 = pstmt.executeUpdate();
			// insert 가 성공되어지면 success1 에는 1 이 들어올 것이다.
			// insert 가 실패되어지면 success1 에는 0 이 들어올 것이다.
			System.out.println("확인용 success1 : " + success1);
			
			//////////////////////////////////////////////////////////////////////////////
			
			// 1-2) tbl_orderdetail에 주문내역insert (제품번호, 주문량, 주문가격)
			int success2 = 0; // 성공유무
			int n_orderDetailInsert = 0;
			
			for(int i=0; i<fk_pseqArr.length; i++) {
				
				sql = " insert into tbl_orderdetail(odrseqnum,fk_odrcode,fk_pseq,oqty,odrprice,deliverstatus,cancelstatus) " + 
					  " values(seq_tbl_orderdetail_odrseqnum.nextval,?,?,?,?,default,default) "; // deliverdate는 안쓰면 null이므로 그냥 빼버림
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, odrcode);
				pstmt.setString(2, fk_pseqArr[i]); 
				pstmt.setString(3, oqtyArr[i]);
				pstmt.setString(4, odrpriceArr[i]);
				
				n_orderDetailInsert += pstmt.executeUpdate();
				
			}// end of for-------------------------------------------
			
			if(n_orderDetailInsert == fk_pseqArr.length) { // 주문상세테이블에 insert성공
			//	System.out.println("확인용 n_orderDetailInsert : " + n_orderDetailInsert);
				
				success2 = 1;
			}
			System.out.println("확인용 success2 : " + success2);
			
			//////////////////////////////////////////////////////////////////////////////
			
			// 2) tbl_orderProgress 주문대기중목록delete (회원아이디)
			int success3 = 0; // 성공유무
			
			// 우선, 주문대기테이블에 해당user의 행이 총 몇개있는지 확인함.
			sql = " select count(*) " + 
				  " from tbl_orderProgress " + 
				  " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			int odrProgCount = rs.getInt(1);
			
			// 그 다음엔, delete한 행의 갯수가 odrProgCount와 같은지 확인함.
			sql = " delete from tbl_orderProgress " + 
				  " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			int n_orderProgDelete = pstmt.executeUpdate();
			
			if(odrProgCount == n_orderProgDelete) { // 주문진행테이블에 user의 모든행 delete성공
			//	System.out.println("확인용 n_orderProgDelete : " + n_orderProgDelete);
				
				success3 = 1;
			}	
			System.out.println("확인용 success3 : " + success3);	
				
			//////////////////////////////////////////////////////////////////////////////				
			
			// 3) tbl_cart 해당목록delete (회원아이디, 옵션번호)
			int success4 = 0; // 성공유무
			
			// 장바구니에서 주문한건지, 위시리스트에서 주문한건지 모르니까 일단 opseq가 존재하는지 찾아봄.
			int existsInCart = 0; // 장바구니에 해당 제품이 있는지 확인하는 용도.
			
			for(int i=0; i<fk_opseqArr.length; i++) {
				
				sql = " select count(*) " + 
					  " from tbl_cart " + 
					  " where fk_userid = ? and fk_opseq = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, fk_opseqArr[i]);
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				if(rs.getInt(1) == 1) { // count(*)가 1이면, 해당하는 행이 1개 존재한다는 뜻이므로 장바구니에 해당 제품이 존재하는 것이다.
					existsInCart++;
				}
				
			} // end of for--------------------------
		//	System.out.println("확인용 existsInCart : " + existsInCart);
			
			if(existsInCart > 0) { // 장바구니에 1개이상 제품이 존재하면 delete한다.
				
				int cartDelete = 0; // 장바구니에서 실제로 삭제된 행들의 개수
				for(int i=0; i<fk_opseqArr.length; i++) {
					sql = " delete from tbl_cart " + 
						  " where fk_userid = ? and fk_opseq = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userid);
					pstmt.setString(2,fk_opseqArr[i]);
					
					cartDelete += pstmt.executeUpdate();
				}// end of for---------------------------------
				
				
				if(existsInCart == cartDelete) { // 장바구니에 있던 제품들과 지워진 제품들이 같으면, 장바구니테이블에 해당하는 opseq들을 delete성공
				//	System.out.println("확인용 cartDelete : " + cartDelete);
					success4 = 1;
				}
				else {// 삭제실패
					// 모두 다 rollback해야함.
					// success4는 디폴트 그대로 0이다.
				}
				
			}
			else{
				// 장바구니테이블에 해당제품들이 없으므로, 지울것이 없다는 뜻이다.
				success4 = 1;
			}
			System.out.println("확인용 success4 : " + success4);
			
			//////////////////////////////////////////////////////////////////////////////	
			
			// 4) tbl_wishlist 해당목록delete (회원아이디, 옵션번호)
			int success5 = 0; // 성공유무
			
			// 위시리스트에 해당 옵션번호가 존재하는지 select
			int existsInWish = 0; // 위시리스트에 해당 제품이 있는지 확인하는 용도.
			
			for(int i=0; i<fk_opseqArr.length; i++) {
				sql = " select count(*) " + 
					  " from tbl_wishlist " + 
				      " where fk_userid = ? and fk_opseq = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, fk_opseqArr[i]);
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				if(rs.getInt(1) == 1) { // count(*)가 1이면, 해당하는 행이 1개 존재한다는 뜻이므로 위시리스트에 해당 제품이 존재하는 것이다.
					existsInWish++;
				}
				
			}// end of for-------------------------------
		//	System.out.println("확인용 existsInWish : " + existsInWish);
			
			
			if(existsInWish > 0) { // 위시리스트에 1개이상 제품이 존재하면 delete한다.
				
				int wishDelete = 0; // 위시리스트에서 실제로 삭제된 행들의 개수
				for(int i=0; i<fk_opseqArr.length; i++) {
					sql = " delete from tbl_wishlist " + 
						  " where fk_userid = ? and fk_opseq = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userid);
					pstmt.setString(2,fk_opseqArr[i]);
					
					wishDelete += pstmt.executeUpdate();
				}// end of for---------------------------------
				
				
				if(existsInWish == wishDelete) { // 위시리스트에 있던 제품들과 지워진 제품들이 같으면, 위시리스트 테이블에 해당하는 opseq들을 delete성공
				//	System.out.println("확인용 wishDelete : " + wishDelete);
					success5 = 1;
				}
				else {// 삭제실패
					// 모두 다 rollback해야함.
					// success5는 디폴트 그대로 0이다.
				}
				
			}
			else{
				// 위시리스트 테이블에 해당제품들이 없으므로, 지울것이 없다는 뜻이다.
				success5 = 1;
			}
			System.out.println("확인용 success5 : " + success5);
			
			//////////////////////////////////////////////////////////////////////////////				
			
			// 6) tbl_poption 의 cnt 감소 update (옵션번호)
			int success6 = 0; // 성공유무
			
			int updateCnt = 0;
			for(int i=0; i<oqtyArr.length; i++) { // 전제조건 : 품절인 제품은 구매를 못하게해야하는데 그러지 않았으므로, 이 코드를 실행하려면 cnt를 넉넉히 설정해뒀어야한다.
				sql = " update tbl_poption set cnt = cnt - ? " + 
					  " where opseq = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, oqtyArr[i]);
				pstmt.setString(2, fk_opseqArr[i]);
				
				updateCnt += pstmt.executeUpdate();
				
			}// end of for----------------------------------------
			
			if(updateCnt == oqtyArr.length) {
			//	System.out.println("확인용 updateCnt : " + updateCnt);
				success6 = 1;
			}
			System.out.println("확인용 success6 : " + success6);
			
			//////////////////////////////////////////////////////////////////////////////
			
			// 7) tbl_member 포인트 insert,delete
			// ##포인트 사용/적립 해야함###############################################
			int success7 = 1; // 성공유무 (원래는 0인데, 일단 1로 한다####################)
			
			//////////////////////////////////////////////////////////////////////////////
			
			// 모든 처리가 성공되어지면 리턴값인 isSuccess는 1이다. -> commit해야함.
			if(success1*success2*success3*success4*success5*success6*success7 == 1) {
				// 성공유무가 다 1이다.
				
				conn.commit();
				
				conn.setAutoCommit(true); // 자동커밋으로 전환
				
			//	System.out.println("확인용 모두 성공하였는가? => " + (success1*success2*success3*success4*success5*success6*success7));
				
				isSuccess = 1;
			}
				
		} catch(SQLException e){
			
			// SQL구문오류 발생하였으므로 rollback해야함.
			conn.rollback();
			
			conn.setAutoCommit(true); // 자동커밋으로 전환
			
			isSuccess = -1;
			
		} finally {
			close();
		}
		
		return isSuccess;
	/*	
		리턴되는 isSuccess 값이 1 인 경우는 성공한 경우
		리턴되는 isSuccess 값이 -1인 경우는 장애가 발생해서 실패한 경우
	*/	
		
	}// end of public int orderAdd(Map<String, Object> paraMap-------------------------

	
	
	
	// 상세페이지(채은님과 공통부분) 시작 -> gitignore대상
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 해당 상품 가져오기 (상품상세페이지) -> 상세페이지에서 정보 보여줄 것 
	@Override
	public ProductVO_OHJ selectProduct(String pseq) throws SQLException {
	      
	      ProductVO_OHJ pvo = null;
	      
	      try {
	    	  conn = ds.getConnection();

	    	  String sql = " select pseq, fk_clseq, pname, pimage, price, pcontent, point " +
	                   	   " from tbl_product " +
	                   	   " where pseq = ? " ;
	                  
	         
	    	  pstmt = conn.prepareStatement(sql);
	    	  pstmt.setInt(1, Integer.parseInt(pseq));
	         
	    	  rs = pstmt.executeQuery();
	         
	    	  if(rs.next()) {
	    		  pvo = new ProductVO_OHJ();
	            
	    		  pvo.setPseq(rs.getString(1));
	    		  pvo.setFk_clseq(rs.getString(2));
	    		  pvo.setPname(rs.getString(3));
	    		  pvo.setPimage(rs.getString(4));
	    		  pvo.setPrice(rs.getInt(5));
	    		  pvo.setPcontent(rs.getString(6));
	    		  pvo.setPoint(rs.getInt(7));
	         }// end of while(rs.next())---------------
	      } finally {
	    	  close();
	      }
	      
	      return pvo;
	      
	}// end of end of public ProductVO selectProduct(String pseq)-------------------------------------------
	
	// 해당 상품의 옵션 가져오기 (상세페이지) -> 옵션번호, 색상번호, 색상명, 색상이미지, 옵션재고량 가져와야함  
	@Override
	public List<OptionVO_LCE> selectProductOption(String pseq) throws SQLException {
	      
		List<OptionVO_LCE> optionList = new ArrayList<>();
	      
	      
		try {
	         conn = ds.getConnection();
	         
	         String sql = "select pseq, pname, pimage, price, pcontent, point, opseq, cimage, cnt, cname"
		                + " from "
		                + " ( "
		                + "   select p.pseq, pname, pimage, price, pcontent, point, opseq, cimage, cnt, cname "
		                + "   from tbl_product p "
		                + "   join tbl_poption O "
		                + "   on p.pseq = o.fk_pseq "
		                + "   join tbl_pcolor C "
		                + "  on o.fk_cseq = c.cseq "
		                + " ) V "
		                + " where pseq = ? ";
	         
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, pseq);
	      
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {
	            
				OptionVO_LCE ovo = new OptionVO_LCE();
			    
				ProductVO_OHJ pvo = new ProductVO_OHJ();
			    
			    pvo.setPseq(rs.getString(1));
			    pvo.setPname(rs.getString(2));
			    pvo.setPimage(rs.getString(3));
			    pvo.setPrice(rs.getInt(4));
			    pvo.setPcontent(rs.getString(5));
			    pvo.setPoint(rs.getInt(6));
			    
			    ovo.setFk_pseq(pvo);
			    ovo.setOpseq(String.valueOf(rs.getInt(7)));
			    ovo.setCimage(rs.getString(8));
			    ovo.setCnt(rs.getInt(9));
			    
			    PColorVO_OHJ cvo = new PColorVO_OHJ();
			    cvo.setCname(rs.getString(10));
			    
			    ovo.setFk_cseq(cvo);
			 
			    optionList.add(ovo);
	         }// end of while(rs.next())-----------------------
	         
		} finally {
	    	  close();
		}      
	   
		return optionList;
	      
	}// end of public List<OptionVO_LCE> selectProductOption(String pseq)---------------------------------------
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	// 상세페이지(채은님과 공통부분) 끝 -> gitignore대상

	
	// 최근본상품 리스트에 해당 제품을 insert/update해야함.
	@Override
	public int insertRecentViewProd(String userid, String pseq) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			// 먼저 해당 제품이 최근본상품 리스트에 있는지 알아온다.
			String sql = " select count(*) " + 
						 " from tbl_recentViewProduct " + 
						 " where fk_userid = ? and fk_pseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, pseq);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			int existsInRVP = rs.getInt(1); // 변수 existsInRVP는 최근본상품리스트 목록에 해당제품이 존재하는지 안하는지 유무이다.
			
			System.out.println("확인용 existsInRVP : " + existsInRVP);
			
			if(existsInRVP == 1) { // 이미 존재한다라면 update
				sql = " update tbl_recentViewProduct set viewday = sysdate " + 
					  " where fk_userid = ? and fk_pseq = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, pseq);
				
				n = pstmt.executeUpdate();
				
			}
			else { // 존재하지 않으면 새로 insert
				sql = " insert into tbl_recentViewProduct(recentseq,fk_userid,fk_pseq,viewday) " + 
					  " values(seq_tbl_rvProduct_recentseq.nextval,?,?,default) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, pseq);
				
				n = pstmt.executeUpdate();
			}
			
			// update 또는 insert를 했으면 1, 실패했으면 0이다.
			System.out.println("확인용 n : " + n);
			
		} finally {
			close();
		}
		
		return n;
	}// end of public int insertRecentViewProd(String userid, String pseq)--------------------------------------------------

	
	// 상세페이지에서 해당옵션번호를 위시리스트에 insert/update해야함.
	@Override
	public boolean insertWishList(String fk_userid, String fk_opseq) throws SQLException {

		boolean success = false;
		
		try {
			conn = ds.getConnection();
			
			// 먼저 해당 제품이 위시리스트에 있는지 알아온다.
			String sql = " select count(*) " + 
						 " from tbl_wishlist " + 
						 " where fk_userid = ? and fk_opseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			pstmt.setString(2, fk_opseq);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			int existsInWishList = rs.getInt(1); // 위시리스트에 해당 옵션번호가 있는지 확인하기
			
			System.out.println("확인용 existsInWishList : " + existsInWishList);
			
			int n = 0; // update 또는 insert를 했는지안했는지 유무
			if(existsInWishList == 1) {
				// 이미 존재하므로, 등록일자를 update한다.
				sql = " update tbl_wishlist set enrollmentday = sysdate " + 
					  " where fk_userid = ? and fk_opseq = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fk_userid);
				pstmt.setString(2, fk_opseq);
				
				n = pstmt.executeUpdate();
			}
			else {
				
				// 옵션번호에 해당하는 fk_pseq 알아오기
				sql = " select P.pseq " + 
					  " from tbl_product P JOIN tbl_poption O " + 
					  " ON P.pseq = O.fk_pseq " + 
					  " where O.opseq = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fk_opseq);
				
				rs = pstmt.executeQuery();
				rs.next();
				String pseq = rs.getString(1); // 제품번호
				
				// 존재하지 않으므로, insert해준다.
				sql = " insert into tbl_wishlist(wishseq,fk_userid,fk_pseq,fk_opseq,enrollmentday) " + 
					  " values(seq_tbl_wishlist_wishseq.nextval,?,?,?,default) ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fk_userid);
				pstmt.setString(2, pseq);
				pstmt.setString(3, fk_opseq);
				
				n = pstmt.executeUpdate();
			}
			
			if(n == 1) { // update또는insert를 성공한 경우
				success = true;
			}
			System.out.println("확인용 success : " + success);
			
		} finally {
			close();
		}
		
		return success;
	}// end of public boolean insertWishList(String fk_userid, String fk_opseq)------------------------------------------------------
	
	
	
	
	
	
	
	
	
	
	
	
}
