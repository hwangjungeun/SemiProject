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
			
			for(int i=0; i<odrpriceArr.length; i++) {
				totalquantity += Integer.parseInt(odrpriceArr[i]);
			}// end of for------------------------------------
			
		//	System.out.println("주문 총 수량 : " + totalquantity);
			
			
			////////////////////////////////////////////////////////////////////
			// 5) tbl_wishlist 해당목록delete
			// * 6) tbl_recentViewProduct 해당목록delete(-> 안함!)
			// 7) tbl_poption 의 cnt(재고) 감소update
			
			
			// 1-1) tbl_order에 주문내역insert (회원아이디, 주문총액 ) - 수동커밋처리
			String sql = " insert into tbl_order(odrcode,fk_userid,odrtotalprice,odrdate,totalquantity) " + 
						 " values(?,?,?,default,?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, odrcode);
			pstmt.setString(2, userid);
			pstmt.setString(3, odrtotalprice);
			pstmt.setInt(4, totalquantity);
			
			int n_orderInsert = pstmt.executeUpdate();
			// insert 가 성공되어지면 n_orderInsert 에는 1 이 들어올 것이다.
			// insert 가 실패되어지면 n_orderInsert 에는 0 이 들어올 것이다.
		//	System.out.println("확인용 n_orderInsert : " + n_orderInsert);
			
			
			if(n_orderInsert == 1) { // 주문테이블에 insert성공
				
				// 1-2) tbl_orderdetail에 주문내역insert (제품번호, 주문량, 주문가격)
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
					
					// 2) tbl_orderProgress 주문대기중목록delete (회원아이디)
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
						
						
						
						
						
						
						
						
					}// 2)주문진행테이블에 user의 모든행 delete성공 -------------------------------------------
					
				} // 1-2)주문상세테이블에 insert성공 -------------------------------------------------
				
			}// 1-1)주문테이블에 insert성공 -------------------------------------------------
				
				
				
			
				
			
					
					
				/*		
						// 3) tbl_point 포인트 update,delete
						sql = "~~~~";
						
	//					if() {
							// 포인트 테이블 변경
							
							// 4) tbl_cart 해당목록delete
							sql = " delete from tbl_cart " + 
								  " where fk_userid = ? and fk_opseq = ? ";
							
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, (String)paraMap.get("userid"));
	//						pstmt.setString(2, opseq); // fk_opseqArr
							
							int n_cartDelete = pstmt.executeUpdate();
							
	//						if(n_cartDelete가 해당하는유저의 옵션번호들을 지웠으면) {
								// 포인트테이블 변경완료
								
	//						}// end of if(n_cartDelete가 해당하는유저의 옵션번호들을 지웠으면)-----------------
							
	//					}// end of 3)-----------------------------------------------------
					
*/			
		} finally {
			close();
		}
		
		//////////////////////////////////////////////////////////////////////////////////////
		/*
			
			int n_update = 0;
			if(n_insert == 1) {
				n_update = mdao.updateMemberPoint(member.getUserid());
				// 회원테이블에서 글을 작성한 회원의 point를 10 증가하도록 하는 update.
		        // update 가 성공되어지면 n_update 에는 1 이 들어올것이다.
		        // 그런데 jdbc_member 테이블에 point 컬럼에는 check 제약으로 인해서
		        // 30을 넘지 못한다. 30을 넘으면 check 제약으로 인해 오류가 발생할 것이다.
		        // check 제약으로 인해 오류가 발생할 경우에는 n_update 에 0 을 넣어주도록 하겠다.
			}
			
			Connection conn = MyDBConnection.getConn();
			
			try {
				if(n_insert == 1 && n_update == 1) {
					// 게시판에 글쓰기 및 회원의 point 값이 10 증가 한 것이 모두 성공이라면
					do {
						System.out.print(">> 정말로 글쓰기를 하시겠습니까?[Y/N] : ");
						String yn = sc.nextLine();
						
						if("y".equalsIgnoreCase(yn)) {
							conn.commit();
							result = 1;
							break;
						}
						
						else if("n".equalsIgnoreCase(yn)) {
							conn.rollback();
							result = 0;
							break;
						}
						
						else {
							System.out.println(">> Y 또는 N 만 입력하세요!! << \n");
						}
						
					}while(true); // end of do~while(true)-----------------------
				} // end of if(n_insert == 1 && n_update == 1)-------------------
				
				else {
					// 제약조건을 포함한 SQL구문 장애가 발생한 경우
					conn.rollback();
					result = -1;
				}
				
			} catch(SQLException e) {
				
			}
		*/	
		//////////////////////////////////////////////////////////////////////////////////////
		
		
		
		return isSuccess;
	/*	
		리턴되는 isSuccess 값이 1 인 경우는 성공한 경우
		리턴되는 isSuccess 값이 0 인 경우는 취소한 경우
		리턴되는 isSuccess 값이 -1인 경우는 장애가 발생해서 실패한 경우
	*/	
	}// end of public int orderAdd(Map<String, Object> paraMap-------------------------


		
	
}
