package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import order.model.CartVO_LCE;

public interface InterProductDAO_LCE {
	
	// 한 페이지마다 보여줄 상품을 가져오기 (상위카테고리 사용)
	List<ProductVO_LCE> selectPagingProduct(Map<String, String> paraMap) throws SQLException;

	// 한 페이지마다 보여줄 상품을 가져오기 (하위카테고리 사용)
	List<ProductVO_LCE> selectPagingProductLow(Map<String, String> paraMap) throws SQLException;

	// 검색이 있는 혹은 검색이 없는 전체회원에 대한 총페이지 알아오기 (상위카테고리 사용)
	int getTotalPage(Map<String, String> paraMap) throws SQLException ;
	
	// 검색이 있는 혹은 검색이 없는 전체회원에 대한 총페이지 알아오기 (하위카테고리 사용)
	int getTotalPageLow(Map<String, String> paraMap) throws SQLException;

	// tbl_categoryL에서 카테고리하위번호(clseq), 카테고리하위명(clname), 카테고리상위번호(fk_cuseq)가져오기 (MAP사용)
	List<Map<String, String>> getCategoryList() throws SQLException;

	// 상위카테고리에 해당하는 베스트 아이템 n개(8) 조회해오기 (베스트영역)
	List<ProductVO_LCE> selectBest(Map<String, String> paraMap) throws SQLException;

	// 상위카테고리를 가져오지 않고 베스트아이템n개(8) 조회해오기 (베스트페이지)
	List<ProductVO_LCE> selectBestitems(Map<String, String> paraMap) throws SQLException ;

	// 조건에 맞는 베스트아이템 전체 갯수 (베스트페이지)
	int totalBestCount(int allsum) throws SQLException;

	// 해당 상품 가져오기 (상품상세페이지)
	ProductVO_LCE selectProduct(String pseq) throws SQLException;

	// 해당 상품의 옵션 가져오기 (상세페이지)
	List<OptionVO_LCE> selectProductOption(String pseq) throws SQLException;

	// 장바구니테이블의 상품가져오기(장바구니페이지)
	List<CartVO_LCE> selectBasket(String userid) throws SQLException;

	// 상세페이지에서  장바구니 테이블로 insert해줌
	int insertBasket(Map<String, String> paraMap) throws SQLException;

	// 옵션번호를 이용하여 제품 번호 알아오기
	int selectPseq(String num) throws SQLException;

	// 아이디와 옵션번호로 위시리스트에서 delete해줌 
	int deleteWish(Map<String, String> paraMap) throws SQLException;

	// 장바구니테이블에서 삭제하기
	void deleteBasket(String cartseq) throws SQLException;
	
	// 장바구니테이블에서 장바구니 수량 변경해주기 
	void updateBasketcnt(Map<String, String> paraMap) throws SQLException;

	// 로그인한 유저의 장바구니에 담긴 총 상품갯수 가져오기(전체 수량이 아니라 장바구니 테이블의 레코드 갯수)
	int getBasketCnt(String userid) throws SQLException;

	// 상품목록페이지에서 상품전체 갯수 가져오기(상위카테고리)
	int geTotalProductCnt(String searchNO) throws SQLException;
	
	// 상품목록페이지에서 상품전체 갯수 가져오기(하위카테고리)
	int geTotalProductCntLow(String searchNO) throws SQLException;

	// 장바구니 페이지에 저장, 위시리스트에서 삭제하기 ( 위시리스트->장바구니로 넘어올때)
	int insertDelete(Map<String, String> paraMap) throws SQLException;


	////////// 현지님 //////////////////////
	
	// 최근본상품 리스트에 해당 제품을 insert/update해야함.
	int insertRecentViewProd(String userid, String pseq) throws SQLException;

    // 상세페이지에서 해당옵션번호를 위시리스트에 insert/update해야함.
    boolean insertWishList(String fk_userid, String fk_opseq) throws SQLException;

	
}
