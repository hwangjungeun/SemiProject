package product.model;

public class CategoryLVO_LCE {

	private String clseq;
	private String clname;
	private CategoryUVO_LCE fk_cuseq; //외래키
	
	public String getClseq() {
		return clseq;
	}
	
	public void setClseq(String clseq) {
		this.clseq = clseq;
	}
	
	public String getClname() {
		return clname;
	}
	
	public void setClname(String clname) {
		this.clname = clname;
	}
	
	public CategoryUVO_LCE getFk_cuseq() {
		return fk_cuseq;
	}
	
	public void setFk_cuseq(CategoryUVO_LCE fk_cuseq) {
		this.fk_cuseq = fk_cuseq;
	}
	
	
}
