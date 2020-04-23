package web.pet.model;

public class PetsitterDTO {
	
	private String id;
	private String pw;
	private String name;
	private String area;
	private String petsit;
	private String pet;
	private String phon;
	private String box;
	private String photo;
	private int point;
	private double avgpoint;
	
	public double getAvgpoint() {
		return avgpoint;
	}
	public void setAvgpoint(double avgpoint) {
		this.avgpoint = avgpoint;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getPetsit() {
		return petsit;
	}
	public void setPetsit(String petsit) {
		this.petsit = petsit;
	}
	public String getPet() {
		return pet;
	}
	public void setPet(String pet) {
		this.pet = pet;
	}
	public String getPhon() {
		return phon;
	}
	public void setPhon(String phon) {
		this.phon = phon;
	}
	public String getBox() {
		return box;
	}
	public void setBox(String box) {
		this.box = box;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	
	
}
