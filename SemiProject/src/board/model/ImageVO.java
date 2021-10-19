package board.model;

public class ImageVO {

	private int 	inum;       // 이미지번호
	private String 	iname;      // 이미지명
	private String  nimage;     // 이미지파일명
	private String  prdmanual_systemFileName;  // 파일서버에 업로드되어지는 실제 제품설명서 파일명 (파일명이 중복되는 것을 피하기 위해서 중복된 파일명이 있으면 파일명뒤에 숫자가 자동적으로 붙어 생성됨) 
	private String  prdmanual_orginFileName;   // 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명 
	
	public ImageVO() { }
	
	public ImageVO(int inum, String iname, String nimage, String prdmanual_systemFileName, String prdmanual_orginFileName) {
	
		this.inum = inum;
		this.iname = iname;
		this.nimage = nimage;
		this.prdmanual_systemFileName = prdmanual_systemFileName;
		this.prdmanual_orginFileName = prdmanual_orginFileName;
	}

	
	public int getInum() {
		return inum;
	}
	public void setInum(int inum) {
		this.inum = inum;
	}
	public String getIname() {
		return iname;
	}
	public void setIname(String iname) {
		this.iname = iname;
	}
	public String getNimage() {
		return nimage;
	}
	public void setNimage(String nimage) {
		this.nimage = nimage;
	}
	public String getPrdmanual_systemFileName() {
		return prdmanual_systemFileName;
	}
	public void setPrdmanual_systemFileName(String prdmanual_systemFileName) {
		this.prdmanual_systemFileName = prdmanual_systemFileName;
	}
	public String getPrdmanual_orginFileName() {
		return prdmanual_orginFileName;
	}
	public void setPrdmanual_orginFileName(String prdmanual_orginFileName) {
		this.prdmanual_orginFileName = prdmanual_orginFileName;
	}

	
	
}
