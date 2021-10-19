package product.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.*;
import javax.sql.DataSource;

import order.model.CartVO_LCE;

public class ProductDAO_LCE implements InterProductDAO_LCE {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO_LCE() {
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

    
    // 한 페이지마다 보여줄 상품을 가져오기 (상위카테고리 사용)
	@Override
	public List<ProductVO_LCE> selectPagingProduct(Map<String, String> paraMap) throws SQLException {
		List<ProductVO_LCE> productList = new ArrayList<>();
		
		try {
			String sortType = paraMap.get("sortType");
			
			if(sortType != null) {
				
				switch (sortType) {
				case "1":
					sortType = "pseq desc";
					break;
				case "2":
					sortType = "pname";
					break;
				case "3":
					sortType = "price";
					break;
				case "4":
					sortType = "price desc";
					break;
				
				default:
					sortType = "pseq";
					break;
				}
				
			}
			else {
				sortType = "pseq";
			}
			
			conn = ds.getConnection(); 
			
			String sql = " select pseq, pname, pimage, price, fk_clseq  "+
						" from "+
						" ( "+
						"    select row_number() over(order by "+ sortType +") AS RNO, pseq, pname, pimage, price, fk_clseq "+
						"    from tbl_product P "+ 
						"	 join tbl_categoryl L "+
						"    on p.FK_clseq = L.clseq "+ 
						"	 where fk_cuseq = ? "+
						" )V "+
						" where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paraMap.get("searchNO"))); //상위카테고리 번호가져오기
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage-1));// 공식사용
			pstmt.setInt(3, (currentShowPageNo * sizePerPage));//공식사용
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO_LCE pvo = new ProductVO_LCE();
				pvo.setPseq(String.valueOf(rs.getInt(1)));
				pvo.setPname(rs.getString(2));
				pvo.setPimage(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				pvo.setFk_clseq(String.valueOf(rs.getInt(5)));
				
				productList.add(pvo);
			
			}// end of while ----------------------------------
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("여기입니당 DAO");
		}
		finally {
			close();
		}
		
		return productList;
		
	}// end of public List<ProductVO> selectPagingProduct(Map<String, String> paraMap)

	
	
	
	// 한 페이지마다 보여줄 상품을 가져오기 (하위카테고리 사용)
	@Override
	public List<ProductVO_LCE> selectPagingProductLow(Map<String, String> paraMap) {
		
		List<ProductVO_LCE> productList = new ArrayList<>();
		
		try {
			
			String sortType = paraMap.get("sortType");
			
			if(sortType != null) {
				
				switch (sortType) {
				case "1":
					sortType = "pseq desc";
					break;
				case "2":
					sortType = "pname";
					break;
				case "3":
					sortType = "price";
					break;
				case "4":
					sortType = "price desc";
					break;
				default:
					sortType = "pseq";
					break;
				}
			}
			else {
				sortType = "pseq";
			}
			
			conn = ds.getConnection(); 
			
			String sql = " select pseq, pname, pimage, price "+
						" from "+
						" ( "+
						"    select row_number() over(order by " + sortType + ") AS RNO, pseq, pname, pimage, price "+
						"    from tbl_product "+ 
						"	 where fk_clseq = ? " +
						" )V "+
						" where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paraMap.get("searchNO"))); //하위카테고리 번호가져오기
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage-1));// 공식사용
			pstmt.setInt(3, (currentShowPageNo * sizePerPage));//공식사용
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO_LCE pvo = new ProductVO_LCE();
				pvo.setPseq(String.valueOf(rs.getInt(1)));
				pvo.setPname(rs.getString(2));
				pvo.setPimage(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				
				productList.add(pvo);
			
			}// end of while ----------------------------------
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("여기입니당 DAO");
		}
		finally {
			close();
		}
		
		return productList;
		
	}// end of public List<ProductVO> selectPagingProductLow(Map<String, String> paraMap)

	
	// 검색이 있는 혹은 검색이 없는 전체회원에 대한 총페이지 알아오기 (상위카테고리 사용)
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "+
					" from tbl_product P "+
					" join tbl_categoryl L " + // 일단 전체만 확인 
					" on p.FK_clseq = L.clseq "+
					" where fk_cuseq = ? ";
			
			/*
			// 10월 7일 아직 searchWord, searchType 어떻게 쓸지 모르겠음 
			String colname = paraMap.get("searchType");
			//String searchWord = paraMap.get("searchWord");
			
			if(colname != null ) {
				// searchType(조회방법)에 따른 sql문 넣기
				// 10월 7일 아직 카테고리하위는 어케할지 모르겠음 
			}
			*/
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("sizePerPage")); //페이지당 상품갯수 가져오기
			pstmt.setInt(2, Integer.parseInt(paraMap.get("searchNO"))); //상위카테고리 가져오기 
			
			rs=pstmt.executeQuery();
				
			rs.next();
			
			totalPage = rs.getInt(1);
				
		} finally {
			close();
		}
		
		return totalPage;
		
	}// end of public int getTotalPage(Map<String, String> paraMap)

	
	// 검색이 있는 혹은 검색이 없는 전체회원에 대한 총페이지 알아오기 (하위카테고리 사용)
	@Override
	public int getTotalPageLow(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "+
					" from tbl_product  "+
					" where fk_clseq = ? ";
			
			/*
			// 10월 7일 아직 searchWord, searchType 어떻게 쓸지 모르겠음 
			String colname = paraMap.get("searchType");
			//String searchWord = paraMap.get("searchWord");
			
			if(colname != null ) {
				// searchType(조회방법)에 따른 sql문 넣기
				// 10월 7일 아직 카테고리하위는 어케할지 모르겠음 
			}
			*/
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("sizePerPage")); //페이지당 상품갯수 가져오기
			pstmt.setInt(2, Integer.parseInt(paraMap.get("searchNO"))); //상위카테고리 가져오기 
			
			rs=pstmt.executeQuery();
				
			rs.next();
			
			totalPage = rs.getInt(1);
				
		} finally {
			close();
		}
		
		return totalPage;
		
	}// end of public int getTotalPageLow(Map<String, String> paraMap) throws SQLException 
		
		
		
		
	//tbl_categoryL에서 카테고리하위번호(clseq), 카테고리하위명(clname), 카테고리상위번호(fk_cuseq)가져오기
	@Override
	public List<Map<String, String>> getCategoryList() throws SQLException {
		
		List<Map<String, String>> categoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			/*
			String sql = " select clseq, clname, fk_cuseq " +
					 	 " from tbl_categoryL " +
					     " order by clseq ";
			*/
			
			// 페이지이름 넣기 위해서 , 아마 메소드에 파라미터 추가해야함 abstract,dao,productListUpAction.java전부 수정해야함 
			String sql = " select clseq, clname, fk_cuseq, cuname" +
						 " from tbl_categoryL L " +
						 " join tbl_categoryU U " +
						 " on L.fk_cuseq = U.cuseq " +
						 " order by clseq ";
			
			
			pstmt = conn.prepareStatement(sql);
	
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Map<String, String> map = new HashMap<>();
				map.put("clseq", rs.getString(1));
				map.put("clname", rs.getString(2));
				map.put("fk_cuseq", rs.getString(3));
				map.put("cuname", rs.getString(4));
				
				categoryList.add(map);
				
				
				
			}// end of while(rs.next())
			
		} finally {
			close();
		}
		
		return categoryList;
		
	}// end of public List<Map<String, String>> getCategoryList()


	// 상위카테고리에 해당하는 베스트 아이템 n개(8) 조회해오기
	@Override
	public List<ProductVO_LCE> selectBest(Map<String, String> paraMap) throws SQLException {
		List<ProductVO_LCE> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pseq, pimage, pname  "+
							" from "+
							" ( "+
							"    select row_number() over(order by allsum desc) AS RNO ,p.pseq as pseq , allsum, fk_cuseq as cuseq, pimage, pname "+
							"    from tbl_product p    "+
							"    join "+
							"    (   select fk_pseq, sum(oqty) as allsum "+
							"        from tbl_orderdetail "+
							"        group by fk_pseq "+
							"    )V "+
							"    on v.fk_pseq = p.pseq        "+
							"    join "+
							"    (   select clseq, fk_cuseq "+
							"        from tbl_categoryl "+
							"    )D "+
							"    on d.clseq = p.fk_clseq "+
							"    where fk_cuseq = ?    "+
							")A "+
							"where rno between 1 and ? ";
							
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("cuseq")); //상위카테고리
			pstmt.setString(2, paraMap.get("cnt")); // 갯수
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO_LCE pvo = new ProductVO_LCE();
				pvo.setPseq(String.valueOf(rs.getInt(1))); // 제품번호
				pvo.setPimage(rs.getString(2)); // 제품이미지
				pvo.setPname(rs.getString(3));// 제품이름 
				// 가격,이름을 가져올 수도 잇음 
				
				productList.add(pvo);
				
			}
			
		} finally {
			close();
		}
		
		return productList;
	}
	
	
	// 상위카테고리를 가져오지 않고 베스트아이템n개(8) 조회해오기 (베스트페이지)
	@Override
	public List<ProductVO_LCE> selectBestitems(Map<String, String> paraMap) throws SQLException {
	
		List<ProductVO_LCE> prodList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pseq, pimage, price, pname "+
						" from "+
						" ( "+
						"    select row_number() over(order by allsum desc) as rno, p.pseq, allsum, pimage, price,pname"+
						"    from tbl_product p "+
						"    join "+
						"    ( "+
						"        select fk_pseq, sum(oqty) as allsum "+
						"        from tbl_orderdetail "+
						"        group by fk_pseq "+
						"    )V "+
						"    on p.pseq = v.fk_pseq "+
						" )A "+
						" where rno between ? and ? ";
						//" order by "+ paraMap.get("sortType");
				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("start"));
			pstmt.setString(2, paraMap.get("end"));
			//pstmt.setString(3, paraMap.get("allsum"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO_LCE pvo = new ProductVO_LCE();
				
				pvo.setPseq(rs.getString(1));
				pvo.setPimage(rs.getString(2));
				pvo.setPrice(rs.getInt(3));
				pvo.setPname(rs.getString(4));
				//pvo.setFk_clseq(rs.getString(4));
				
				prodList.add(pvo);
			}// end of while(rs.next())-----------------------
			
		} finally {
			close();
		}		
	
		return prodList;
	}// end of public List<ProductVO> selectBestitems

	
	
	// 조건에 맞는 베스트아이템 전체 갯수 (베스트페이지)
	@Override
	public int totalBestCount(int allsum) throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select count(pseq) "+
							" from "+
							" ( "+
							"    select row_number() over(order by allsum desc) as rno, p.pseq, allsum "+
							"    from tbl_product p "+
							"    join "+
							"    ( "+
							"        select fk_pseq, sum(oqty) as allsum "+
							"        from tbl_orderdetail "+
							"        group by fk_pseq "+
							"    )V "+
							"    on p.pseq = v.fk_pseq "+
							")A ";
							//"where allsum >= 10 "; 아직 갯수가 모자라서 이거 추가하면 아무것도 안나옴 
			
			pstmt = conn.prepareStatement(sql);
			//pstmt.setInt(1, allsum);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt(1);
			
			System.out.println("totalCount" + totalCount);
			
		} finally {
			close();
		}
		
		return totalCount;
	}// end of public int totalBestCount(int allsum)

	// 해당 상품 가져오기 (상품상세페이지) -> 상세페이지에서 정보 보여줄 것 
	@Override
	public ProductVO_LCE selectProduct(String pseq) throws SQLException {
		
		ProductVO_LCE pvo = null;
		
		try {
			conn = ds.getConnection();

			String sql = " select pseq, fk_clseq, pname, pimage, price, pcontent, point " +
						 " from tbl_product " +
						 " where pseq = ? " ;
						
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(pseq));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pvo = new ProductVO_LCE();
				
				pvo.setPseq(rs.getString(1));
				pvo.setFk_clseq(rs.getString(2));
				pvo.setPname(rs.getString(3));
				pvo.setPimage(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setPcontent(rs.getString(6));
				pvo.setPoint(rs.getInt(7));
				
			}// end of while(rs.next())
		}
		finally {
			close();
		}
		
		return pvo;
	}// end of end of public ProductVO selectProduct(String pseq)

	
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
				
				ProductVO_LCE pvo = new ProductVO_LCE();
				
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
				
				ColorVO_LCE cvo = new ColorVO_LCE();
				cvo.setCname(rs.getString(10));
				
				ovo.setFk_cseq(cvo);
			
				optionList.add(ovo);
			}// end of while(rs.next())-----------------------
			
		} finally {
			close();
		}		
	
		return optionList;
		
	}// end of public List<OptionVO> selectProductOption(String pseq)

	
	// 해당 상품 가져오기 (장바구니테이블)
	@Override
	public List<CartVO_LCE> selectBasket(String userid) throws SQLException {

		List<CartVO_LCE> cartList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select cartseq, pname, cimage, price, oqty, cname, fk_opseq, cnt, point, pseq" + 
							" from " + 
							" ( select cartseq, fk_userid, fk_pseq, fk_opseq, oqty, registerday " + 
							"    from tbl_cart " + 
							"    where fk_userid = ? " + 
							" ) C " + 
							" join tbl_product P " + 
							" on C.fk_pseq = p.pseq " + 
							" join tbl_poption O " + 
							" on O.opseq = c.fk_opseq " + 
							" join tbl_pcolor L " + 
							" on l.cseq = O.fk_cseq ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				CartVO_LCE cvo = new CartVO_LCE();
				
				cvo.setCartseq(String.valueOf(rs.getInt("cartseq"))); // 장바구니번호
				cvo.setOqty(rs.getInt("oqty")); 					  // 장바구니에 넣은 갯수
				
				ProductVO_LCE pvo = new ProductVO_LCE();
				pvo.setPseq(rs.getString("pseq"));					// 제품번호
				pvo.setPname(rs.getString("pname")); 				// 제품이름
				//pvo.setPimage(rs.getString("pimage")); 			// 제품이미지
				pvo.setPrice(rs.getInt("price")); 					// 제품가격
				pvo.setPoint(rs.getInt("point")); 					// 제품포인트
				
				cvo.setFk_pseq(pvo);
				
				OptionVO_LCE opvo = new OptionVO_LCE();
				opvo.setOpseq(rs.getString("fk_opseq")); 			// 옵션번호
				opvo.setCnt(rs.getInt("cnt")); 						// 옵션의 재고량 
				opvo.setCimage(rs.getString("cimage"));				// 옵션이미지 
				
				ColorVO_LCE covo = new ColorVO_LCE();
				covo.setCname(rs.getString("cname"));
				opvo.setFk_cseq(covo);
				
				cvo.setFk_opseq(opvo);
				
				cartList.add(cvo);
			}
			
		} finally {
			close();
		}
		
		
		return cartList;
	}

	
	// 상세페이지에서  장바구니 테이블로 추가 ( 이미 존재하면 update 아니면 insert ) 
	@Override
	public int insertBasket(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cartseq "
					+ " from tbl_cart "
					+ " where fk_userid = ? and fk_opseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, paraMap.get("loginuserid"));
	        pstmt.setString(2, paraMap.get("opseq"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 장바구니에 이미 존재하여서 추가하는 경우 
				
				int cartseq = rs.getInt("cartseq");
				
				sql = " update tbl_cart set oqty = oqty + ? "+
					  " where cartseq = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")));
				pstmt.setInt(2, cartseq);
				
				n = pstmt.executeUpdate();
				
				System.out.println("dao1 n값" + n);
			}
			else { // 장바구니에 존재하지 않아 새로 추가하는 경우
				
				sql = " insert into tbl_cart(cartseq, fk_userid, fk_pseq, fk_opseq, oqty, registerday) "+
						" values (seq_tbl_cart_cartseq.nextval, ? , ? , ? , ?, sysdate) ";
			
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("loginuserid"));
				pstmt.setString(2, paraMap.get("fk_pseq"));
				pstmt.setString(3, paraMap.get("opseq"));
				pstmt.setString(4, paraMap.get("oqty"));
				
				n= pstmt.executeUpdate();
				
				System.out.println("dao2 n값" + n);
			}
			
		} finally {
			close();
		}
		
		return n;
		
	}// end of public int insertBasket(Map<String, String> paraMap)

	
	// 옵션번호를 이용하여 제품 번호 알아오기
	@Override
	public int selectPseq(String num) throws SQLException {
		int pseq = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pseq "+
						" from "+
						" ( "+
						"    select p.pseq, opseq "+
						"    from tbl_poption O "+
						"    join tbl_product P "+
						"    on p.pseq = o.fk_pseq "+
						" )V "+
						" where opseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
		
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 이거 안해도됨 딱히 
				pseq = rs.getInt(1);
			}
			
		} finally {
			close();
		}
		
		return pseq;
	}// end of public int selectPseq(String num)

	
	// 아이디와 옵션번호로 위시리스트에서 delete해줌 
	@Override
	public int deleteWish(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_wishlist "+
						 " where fk_userid = ? and fk_opseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("loginuserid"));
			pstmt.setString(2, paraMap.get("opseq"));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
		
	}// end of public void deleteWish(Map<String, String> paraMap)

	// 장바구니테이블에서 삭제하기
	@Override
	public void deleteBasket(String cartseq) throws SQLException {
		
		try {
			conn = ds.getConnection();
			
			String sql = " delete from tbl_cart "+
							" where cartseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cartseq);
			
			pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
	}// end of public void deleteBasket(String cartseq)

	// 장바구니테이블에서 장바구니 수량 변경해주기 
	@Override
	public void updateBasketcnt(Map<String, String> paraMap) throws SQLException {
		
		
		try {
			conn = ds.getConnection();
			

			String sql = " update tbl_cart set oqty = ? "+
						 " where cartseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("oqty"));
			pstmt.setString(2, paraMap.get("cartseq"));
			
			pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
	}// end of public void updateBasketcnt(Map<String, String> paraMap) 

	
	// 로그인한 유저의 장바구니에 담긴 총 상품갯수 가져오기(전체 수량이 아니라 장바구니 테이블의 레코드 갯수)
	@Override
	public int getBasketCnt(String userid) throws SQLException {
		int basketCnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select count(cartseq) "
					+ " from tbl_cart "
					+ " where fk_userid = ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
		
			rs = pstmt.executeQuery();
			
			rs.next();
			
			basketCnt = rs.getInt(1);
			
			
		}finally {
			close();
		}
		
		return basketCnt;
		
	}// end of public int getBasketCnt(String userid)

	
	// 상품목록페이지에서 상품전체 갯수 가져오기(상위카테고리)
	@Override
	public int geTotalProductCnt(String searchNO) throws SQLException {

		int totalProductCnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(cuseq) "+
						" from tbl_product p "+
						" join tbl_categoryl L "+
						" on p.fk_clseq = l.clseq "+
						" join tbl_categoryu U "+
						" on l.fk_cuseq = u.cuseq "+
						" where fk_cuseq = ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchNO);
		
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalProductCnt = rs.getInt(1);
			
		}
		finally {
			close();
		}
		
		return totalProductCnt;
		
	}// end of public int geTotalProductCnt(String searchNO)---------------------------------------------

	
	// 상품목록페이지에서 상품전체 갯수 가져오기(하위카테고리)
	@Override
	public int geTotalProductCntLow(String searchNO) throws SQLException {
		int totalProductCnt = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select count(pseq) "+
						" from tbl_product "+
						" where fk_clseq = ?";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchNO);
		
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalProductCnt = rs.getInt(1);
			
		}
		finally {
			close();
		}
		
		return totalProductCnt;
	}// end of public int geTotalProductCntLow(String searchNO)

	
	

	
	/////////////////현지님 ////////////////////////////	
	
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

	   
	// 장바구니 페이지에 저장, 위시리스트에서 삭제하기 ( 위시리스트->장바구니로 넘어올때)   
	@Override
	public int insertDelete(Map<String, String> paraMap) throws SQLException {

		int n = 0;
		
		try {
			
			// 먼저 해당 상품 제품번호 가져옴 
			int pseq = selectPseq(paraMap.get("opseq"));
			paraMap.put("fk_pseq", String.valueOf(pseq));
			
			// 장바구니 추가해줌 
			n = insertBasket(paraMap);
			
			if(n == 1) { // 장바구니 담기에 성공하면 위시리스트에서 삭제 
				
				conn = ds.getConnection(); //이거 중복해도 되는건가?
				
				String sql = " delete from tbl_wishlist "+
							 " where fk_userid = ? and fk_opseq = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("loginuserid"));
				pstmt.setString(2, paraMap.get("opseq"));
				
				n = pstmt.executeUpdate();

			}
			
		} finally {
			close();
		}
		
		return n;
		
	}// end of public int insertDelete(Map<String, String> paraMap)
	
	  
}
