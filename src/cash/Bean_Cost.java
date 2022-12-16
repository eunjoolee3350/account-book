package cash;

public class Bean_Cost {

	private int    numb;	// 순번
	private String usid;	// 아이디
	private String g_cost;	// 요금종류
	private int yt_1;		// 전달 계량값
	private int yt;			// 이번달 계량값
	private int total;		// 총 사용량
	private double gum;	// 사용금액
	private int vat;		// 부가가치세
	private int nabbu;		// 납부금액

	public int getNumb() {
		return numb;
	}

	public void setNumb(int numb) {
		this.numb = numb;
	}

	public String getUsid() {
		return usid;
	}

	public void setUsid(String usid) {
		this.usid = usid;
	}

	public String getG_cost() {
		return g_cost;
	}

	public void setG_cost(String g_cost) {
		this.g_cost = g_cost;
	}
	
	public int getYt_1() {
		return yt_1;
	}

	public void setYt_1(int yt_1) {
		this.yt_1 = yt_1;
	}
	
	public int getYt() {
		return yt;
	}

	public void setYt(int yt) {
		this.yt = yt;
	}
	
	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}
	
	public double getGum() {
		return gum;
	}

	public void setGum(double gum) {
		this.gum = gum;
	}
	
	public int getVat() {
		return vat;
	}

	public void setVat(int vat) {
		this.vat = vat;
	}
	
	public int getNabbu() {
		return nabbu;
	}

	public void setNabbu(int nabbu) {
		this.nabbu = nabbu;
	}
}