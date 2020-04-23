package web.pet.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentbDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl"); 
		
		return ds.getConnection();
	}
	
	//전체 글 갯수를 반환하는 메소드
	public int getCommentCount() {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from commentb";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		
		return count;
	}
	
	//글리스트 반환하는 메소드
	public List getConmmentList(int startRow, int endRow) {
		List getConmmentList = null;
		
		try {
			conn = getConnection();
			String sql = "select id, num, subject, content, readcount, img, ref, re_step, area, name, petdate, petday, point, ip, reg, r "
					+ "from (select id, num, subject, content, readcount, img, ref, re_step, area, name, petdate, petday, point, ip, reg, rownum r "
					+ "from (select id, num, subject, content, readcount, img, ref, re_step, area, name, petdate, petday, point, ip, reg "
					+ "from commentb order by ref desc, re_step asc) order by ref desc, re_step asc) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			getConmmentList = new ArrayList();
			CommentbDTO dto = null;
			while(rs.next()) {
				dto = new CommentbDTO();
				
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setImg(rs.getString("img"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setArea(rs.getString("area"));
				dto.setName(rs.getString("name"));
				dto.setPetdate(rs.getString("petdate"));
				dto.setPetday(rs.getString("petday"));
				dto.setPoint(rs.getInt("point"));
				dto.setIp(rs.getString("ip"));
				dto.setReg(rs.getTimestamp("reg"));
				
				getConmmentList.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		
		return getConmmentList;
	}
	
	//검색어 관련 글 갯수를 리턴하는 메소드
	public int getSearchCommentCount(String sel, String search) {
		int count = 0;
			try {
				conn = getConnection();
				String sql = "select count(*) from commentb where "+sel+" like '%"+search+"%'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) count = rs.getInt(1);
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
				if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
				if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
			}
		
		return count;
	}
	
	//검색어 관련 글 리턴하는 메소드
	public List getSearchCommentList(String sel, String search, int startRow, int endRow) {
		List getSearchCommentList = null;
		try {
			conn = getConnection();
			String sql = "select id, num, subject, content, readcount, img, ref, re_step, area, name, petdate, petday, point, ip, reg, r "
					+ "from (select id, num, subject, content, readcount, img, ref, re_step, area, name, petdate, petday, point, ip, reg, rownum r "
					+ "from (select id, num, subject, content, readcount, img, ref, re_step, area, name, petdate, petday, point, ip, reg "
					+ "from commentb where "+sel+" like '%"+search+"%' order by ref desc, re_step asc) order by ref desc, re_step asc) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			getSearchCommentList = new ArrayList();
			CommentbDTO dto = null;
			
			while(rs.next()) {
				dto = new CommentbDTO();
				
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setImg(rs.getString("img"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setArea(rs.getString("area"));
				dto.setName(rs.getString("name"));
				dto.setPetdate(rs.getString("petdate"));				
				dto.setPetday(rs.getString("petday"));
				dto.setPoint(rs.getInt("point"));
				dto.setIp(rs.getString("ip"));
				dto.setReg(rs.getTimestamp("reg"));
				
				getSearchCommentList.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return getSearchCommentList;
	}
	

	
	// 글 저장하는 메소드
	public int insertCommenet(CommentbDTO comment) {
		int n = 0;
		int num = comment.getNum();
		int ref = comment.getRef();

		int point = 0;
		double avgpoint = 0;
		int countpoint = 0;
				
		String sql = null;
		try {
			conn = getConnection();
			
			//고유넘버 구해서 ref에 담기
			sql = "select max(num) from commentb";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) ref = rs.getInt(1)+1;
			else ref = 1;
				
			//시터db에 point, avgpoint, countpoint올려주기
			sql = "select point, countpoint from petsitter where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment.getName());
			rs = pstmt.executeQuery();
			if(rs.next()) point = rs.getInt("point"); countpoint= rs.getInt("countpoint");
				
			point = point+comment.getPoint();
			countpoint = countpoint+1;
			avgpoint = (double)point/countpoint;
				
			sql = "update petsitter set point=?, avgpoint=?, countpoint=? where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, point);
			pstmt.setDouble(2, avgpoint);
			pstmt.setDouble(3, countpoint);
			pstmt.setString(4, comment.getName());
			pstmt.executeUpdate();
			
			//시터의 펫시터게시판 글컬럼에도 avg업데이트해주기
			sql = "update getpet set avgpoint=? where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setDouble(1, avgpoint);
			pstmt.setString(2, comment.getName());
			pstmt.executeUpdate();
					
			//글 저장하는 메소드
			sql = "insert into commentb(num, id, subject, content, img, ref, area, name, petdate, petday, point, ip, reg) "
					+ "values(commentb_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment.getId());
			pstmt.setString(2, comment.getSubject());
			pstmt.setString(3, comment.getContent());
			pstmt.setString(4, comment.getImg());
			pstmt.setInt(5, ref);
			pstmt.setString(6, comment.getArea());
			pstmt.setString(7, comment.getName());
			pstmt.setString(8, comment.getPetdate());
			pstmt.setString(9, comment.getPetday());
			pstmt.setInt(10, comment.getPoint());
			pstmt.setString(11, comment.getIp());
			pstmt.setTimestamp(12, comment.getReg());
			
			pstmt.executeUpdate();
			
			
			sql = "select num from commentb where ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			
			if(rs.next()) n = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		return n;
	}
	// 답글 저장하는 메소드
	public int insertRecommenet(CommentbDTO comment) {
		int n = 0;
		int ref = comment.getRef();
		int re_step = comment.getRe_step();
		
		String name = null;
	
		String sql = null;
		try {
			conn = getConnection();
			//이름 꺼내와서 name에 넣어주기
			sql = "select name from petsitter where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment.getId());
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString(1);

			sql = "update commentb set re_step = re_step+1 where ref=? and re_step > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_step);
			pstmt.executeUpdate();
			System.out.println(ref);	
			re_step += 1;
			
			//글 저장하는 메소드
			sql = "insert into commentb(num, id, subject, content, img, ref, re_step, name, ip, reg) "
					+ "values(commentb_seq.nextval,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment.getId());
			pstmt.setString(2, comment.getSubject());
			pstmt.setString(3, comment.getContent());
			pstmt.setString(4, comment.getImg());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setString(7, name);
			pstmt.setString(8, comment.getIp());
			pstmt.setTimestamp(9, comment.getReg());
			
			pstmt.executeUpdate();
			
			
			sql = "select num from commentb where ref=? and re_step=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_step);
			rs = pstmt.executeQuery();
			
			if(rs.next()) n = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		return n;
	}
	
	//후기글 리턴하는 메소드
	public CommentbDTO getContent(int num) {
		CommentbDTO comment = null;
		try {
			conn = getConnection();
			String sql = "update commentb set readcount = readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from commentb where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				comment = new CommentbDTO();
				comment.setId(rs.getString("id"));
				comment.setNum(rs.getInt("num"));
				comment.setSubject(rs.getString("subject"));
				comment.setContent(rs.getString("content"));
				comment.setReadcount(rs.getInt("readcount"));
				comment.setImg(rs.getString("img"));
				comment.setRef(rs.getInt("ref"));
				comment.setRe_step(rs.getInt("re_step"));
				comment.setArea(rs.getString("area"));
				comment.setName(rs.getString("name"));
				comment.setPetdate(rs.getString("petdate"));				
				comment.setPetday(rs.getString("petday"));
				comment.setPoint(rs.getInt("point"));
				comment.setIp(rs.getString("ip"));
				comment.setReg(rs.getTimestamp("reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return comment;
	}
	
	//후기글 리턴하는 메소드
	public CommentbDTO getComment(int num) {
		CommentbDTO comment = null;
		try {
			conn = getConnection();
			
			String sql = "select * from commentb where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				comment = new CommentbDTO();
				comment.setId(rs.getString("id"));
				comment.setNum(rs.getInt("num"));
				comment.setSubject(rs.getString("subject"));
				comment.setContent(rs.getString("content"));
				comment.setReadcount(rs.getInt("readcount"));
				comment.setImg(rs.getString("img"));
				comment.setRef(rs.getInt("ref"));
				comment.setRe_step(rs.getInt("re_step"));
				comment.setArea(rs.getString("area"));
				comment.setName(rs.getString("name"));
				comment.setPetdate(rs.getString("petdate"));				
				comment.setPetday(rs.getString("petday"));
				comment.setPoint(rs.getInt("point"));
				comment.setIp(rs.getString("ip"));
				comment.setReg(rs.getTimestamp("reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return comment;
	}
	
	
	//폴더에 사진 삭제를 위한 사진 이름 리턴하는 메소드
	public String commentImage(int num) {
		String img = null;
		try {
			conn = getConnection();
			
			String sql = "select img from commentb where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) img = rs.getString(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return img;
	}	
	//글 수정하는 메소드
	public void modifyComment(CommentbDTO comment) {
		int dbPoint = 0;
		int sitterPoint = 0;
		int countpoint = 0;
		double avgpoint = 0;
		String sql = null;
		
		try {
			conn = getConnection();
			
			//만약에 입력받은 point와 기존후기에 point가 다를 경우
			sql = "select point from commentb where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, comment.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) dbPoint = rs.getInt(1);
			
			
			if(dbPoint != comment.getPoint()) {
				sql = "select * from petsitter where name=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, comment.getName());
				rs = pstmt.executeQuery();
				if(rs.next()) sitterPoint = rs.getInt("point"); countpoint = rs.getInt("countpoint");
				System.out.println(sitterPoint);
				sitterPoint = sitterPoint - dbPoint + comment.getPoint();
				avgpoint = (double)sitterPoint / countpoint;
				
				System.out.println("최종="+sitterPoint);
				sql = "update petsitter set point=?, avgpoint=? where name=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, sitterPoint);
				pstmt.setDouble(2, avgpoint);
				pstmt.setString(3, comment.getName());
				pstmt.executeUpdate();
				
				//시터의 펫시터게시판 글컬럼에도 avg업데이트해주기
				sql = "update getpet set avgpoint=? where name=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setDouble(1, avgpoint);
				pstmt.setString(2, comment.getName());
				int x = pstmt.executeUpdate();

			}
			
			sql = "update commentb set subject=?,content=?,img=?,area=?,name=?,petdate=?,petday=?,point=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment.getSubject());
			pstmt.setString(2, comment.getContent());
			pstmt.setString(3, comment.getImg());
			pstmt.setString(4, comment.getArea());
			pstmt.setString(5, comment.getName());
			pstmt.setString(6, comment.getPetdate());
			pstmt.setString(7, comment.getPetday());
			pstmt.setInt(8, comment.getPoint());
			pstmt.setInt(9, comment.getNum());
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
	}
	
	//답글 수정하는 메소드
	public void modifyRecomment(CommentbDTO comment) {
		
		try {
			conn = getConnection();
			
			String sql = "update commentb set subject=?,content=?,img=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, comment.getSubject());
			pstmt.setString(2, comment.getContent());
			pstmt.setString(3, comment.getImg());
			pstmt.setInt(4, comment.getNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
	}	
	
	//펫시터 한명의 후기글 갯수 리턴하는 메소드
	public int sitterCommentCount(String name) {
		int sitterCommentCount = 0;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from commentb where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				sitterCommentCount = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return sitterCommentCount;
	}
	
	
	//글 삭제하기 메소드
	public int deleteArticle(String id, int num, String pw) {
		int x = 0;
		String dbpw = null;
		try {
			conn = getConnection();
			
			String sql = "select pw from petmember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) dbpw = rs.getString(1);
			
			if(dbpw.equals(pw)) {
				sql = "delete from commentb where num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				
				x = 1;
			}else {
				x = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return x;
	}
	
	//관리자가 글 삭제하기 메소드
	public int deleteArticle(int num) {
		int x = 0;
		try {
			conn = getConnection();
					
			String sql = "delete from commentb where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
				
			x = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return x;
	}
	
	
	//Content에 이전글 버튼생성
	//num값의 rownum 받아 이전의rownum값으로 이전글 num받기 -> 이전글 = 현재글rownum+1
	public int pastnum(int num, int count) {
		int rownum = 0;
		int pastNum = 0;
		//num의 rownum 찾기
		List getCommentList = getConmmentList(1, count);
		CommentbDTO comment = null;
		
		for(int i = 0; i < getCommentList.size(); i++) {
			comment = (CommentbDTO)getCommentList.get(i);
			if(comment.getNum() == num) {
				rownum = i+1;
			}
		}
		
		if(rownum < count ) { //rownum이 1보다 크면 
			//rownum-1의 num찾기
			comment = (CommentbDTO)getCommentList.get(rownum);
			
			pastNum = comment.getNum();
		}	
		
		return pastNum;
	}
	 
	//Content에 다음글 버튼생성
	//다음글의 num값을 리턴받는 메소드 -> 다음글 = 현재글rownum-1
	public int nextnum(int num, int count) {
		int rownum = 0;
		int nextNum = 0;
		
		//num의 rownum 찾기
		List getCommentList = getConmmentList(1, count);
		CommentbDTO comment = null;
		
		for(int i = 0; i < getCommentList.size(); i++) {
			comment = (CommentbDTO)getCommentList.get(i);
			if(comment.getNum() == num) {
				rownum = i+1;
			}
		}
		
		if(rownum > 1) { //num의 다른글이 존재하면
			//rownum+1의 num찾기
			comment = (CommentbDTO)getCommentList.get(rownum-2);
			nextNum = comment.getNum();
		} 	
		return nextNum;
	}
	
	//작성한 후기글 갯수를 리턴하는 메소드
	public int getcommentWriteCount(String id) {
		int count = 0;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from commentb where id=? and re_step=0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return count;
	}
	
	//펫시터에게 달린 후기글 리턴하는 메소드
	public List getConmmentList1(int startRow, int endRow, String name) {
	      List getConmmentList = null;
	      
	      try {
	         conn = getConnection();
	         String sql = "select id, num, subject, content, readcount, img, area, name, petdate, petday, point, ip, reg, r "
	               + "from (select id, num, subject, content, readcount, img, area, name, petdate, petday, point, ip, reg, rownum r "
	               + "from (select id, num, subject, content, readcount, img, area, name, petdate, petday, point, ip, reg "
	               + "from commentb)) "
	               + "where r >= ? and r <= ? and name = ?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, startRow);
	         pstmt.setInt(2, endRow);
	         pstmt.setString(3, name);
	         rs = pstmt.executeQuery();
	         
	         getConmmentList = new ArrayList();
	         CommentbDTO dto = null;
	         while(rs.next()) {
	            dto = new CommentbDTO();
	            
	            dto.setId(rs.getString("id"));
	            dto.setNum(rs.getInt("num"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setContent(rs.getString("content"));
	            dto.setReadcount(rs.getInt("readcount"));
	            dto.setImg(rs.getString("img"));
	            dto.setArea(rs.getString("area"));
	            dto.setName(rs.getString("name"));
	            dto.setPetdate(rs.getString("petdate"));
	            dto.setPetday(rs.getString("petday"));
	            dto.setPoint(rs.getInt("point"));
	            dto.setIp(rs.getString("ip"));
	            dto.setReg(rs.getTimestamp("reg"));
	            
	            getConmmentList.add(dto);
	         }
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
	         if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
	         if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
	      } 
	      
	      return getConmmentList;
	   }	
	
}
