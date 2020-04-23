package web.pet.model;


import java.sql.Timestamp;

public class TradeDTO {
	
	private int num;			// 글 고유번호
	private String id;			// 글쓴이
	private String pass;		// 글 비밀번호
	private String local;		// 글쓴이 지역
	private String subject;		// 글 제목
	private Timestamp time;		// 글 작성시간
	private int readcount;		// 글 조회수
	private String content;		// 글 내용
	private String picture;		// 글에 첨부한 사진
	private int ref;			// 글 그룹(새 글 기준)
	private int re_step;		// 글의 순서
	private int re_level;		// 글의 레벨(답글)
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getLocal() {
		return local;
	}
	public void setLocal(String local) {
		this.local = local;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
}
