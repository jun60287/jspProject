package web.pet.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GetpetDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Connection getConnection() throws Exception{
		Context cxt = new InitialContext();
		Context env = (Context)cxt.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}
	
	//게시판 전제 글 갯수 리턴하는 메소드
	public int articleCount() {
		int count = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from getpet";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		return count;
	}
	
	//검색관련 글 갯수 리턴하는 메소드
	public int getSearchArticleCount(String sel, String search) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from getpet where "+sel+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);		
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		
		return count;
	}
	
	//게시판 글 List 가져오는 메소드
	public List getpetList(int startRow, int endRow) {
		List getpetList = null;
		
		try {
			conn = getConnection();
			
			String sql = "select id, num, subject, content, readcount, img, ip, area, petsit, reg, avgpoint, name, r "
					+ "from (select id, num, subject, content, readcount, img, ip, area, petsit, reg, avgpoint, name, rownum r "
					+ "from (select id, num, subject, content, readcount, img, ip, area, petsit, reg, avgpoint, name "
					+ "from getpet order by num desc) order by num desc) "
					+ "where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			getpetList = new ArrayList();
			GetpetDTO dto = null;
			
			while(rs.next()) {
				dto = new GetpetDTO();

				dto.setId(rs.getString("id"));
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setImg(rs.getString("img"));
				dto.setIp(rs.getString("ip"));
				dto.setArea(rs.getString("area"));
				dto.setPetsit(rs.getString("petsit"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setAvgpoint(rs.getDouble("avgpoint"));
				dto.setName(rs.getString("name"));
				
				getpetList.add(dto);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 

		return getpetList;
	}
	
	//검색한 게시판 글 List 리턴하는 메소드
	public List getSearchArticleList(int startRow, int endRow, String sel, String search) {
		List getpetList = null;
		try {
			conn = getConnection();
			String sql = "select id, num, subject, content, readcount, img, ip, area, petsit, reg, avgpoint, name, r "
					+ "from (select id, num, subject, content, readcount, img, ip, area, petsit, reg, avgpoint, name, rownum r "
					+ "from (select id, num, subject, content, readcount, img, ip, area, petsit, reg, avgpoint, name "
					+ "from getpet where "+sel+" like '%"+search+"%' order by num desc) order by num desc) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			getpetList = new ArrayList();
			GetpetDTO dto = null;
			
			while(rs.next()) {
				dto = new GetpetDTO();
				
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setImg(rs.getString("img"));
				dto.setIp(rs.getString("ip"));
				dto.setArea(rs.getString("area"));
				dto.setPetsit(rs.getString("petsit"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setAvgpoint(rs.getDouble("avgpoint"));
				dto.setName(rs.getString("name"));
				
				getpetList.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		
		return getpetList;
	}
	
	//id정보로 펫시터멤버의 정보를 가져오는 메소드
	public PetsitterDTO getSitter(String id) {
		PetsitterDTO sitter = null;
		
		try {
			conn = getConnection();
			
			String sql = "select * from petsitter where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sitter = new PetsitterDTO();

				sitter.setId(rs.getString("id"));
				sitter.setPw(rs.getString("pw"));
				sitter.setName(rs.getString("name"));
				sitter.setArea(rs.getString("area"));
				sitter.setPetsit(rs.getString("petsit"));
				sitter.setPet(rs.getString("pet"));
				sitter.setPhon(rs.getString("phone"));
				sitter.setBox(rs.getString("box"));
				sitter.setPhoto(rs.getString("photo"));
				sitter.setAvgpoint(rs.getDouble("avgpoint"));
				sitter.setName(rs.getString("name"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return sitter;
	}
	
	//펫시터의 이름으로 후기갯수를 리턴하는 메소드
	public int getCommentCount(String name) {
		int CommentCount = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from commentb where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if(rs.next()) CommentCount = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return CommentCount;
	}
	
	
	
	//펫시터구하기 글 저장하는 메소드
	public void insertArticle(GetpetDTO article) {
		int num = 0;
		
		try {
			conn = getConnection();
			String sql = "select max(num) from getpet";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) num = rs.getInt(1)+1;
			else num = 1;
			
			sql = "insert into getpet(id, num, subject, content, img, ip, area, petsit, reg, avgpoint, name) "
					+ "values(?, getpet_seq.nextVal, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getId());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getContent());
			pstmt.setString(4, article.getImg());
			pstmt.setString(5, article.getIp());
			pstmt.setString(6, article.getArea());
			pstmt.setString(7, article.getPetsit());
			pstmt.setTimestamp(8, article.getReg());
			pstmt.setDouble(9, article.getAvgpoint());
			pstmt.setString(10, article.getName());
			
			pstmt.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
	}
	
	
	//펫시터구하기 글 넘버 가져오기 메소드
	public int getArticleNum(String id, String subject, String content) {
		int num = 0;
		try {
			conn = getConnection();
			
			String sql = "select num from getpet where id=? and subject=? and content=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, subject);
			pstmt.setString(3, content);
			rs = pstmt.executeQuery();
			if(rs.next()) num = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return num;
	}
	
	//펫시터 구하기 글 꺼내오는 메소드 content
	public GetpetDTO getpetArticle(int num) {
		GetpetDTO article = null;
		
		try {
			conn = getConnection();
			
			//조회수 올리기
			String sql = "update getpet set readcount= readcount+1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			//글꺼내오기
			sql = "select * from getpet where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new GetpetDTO();
				
				article.setId(rs.getString("id"));
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setIp(rs.getString("ip"));
				article.setReg(rs.getTimestamp("reg"));
				article.setImg(rs.getString("img"));
				article.setAvgpoint(rs.getDouble("avgpoint"));
				article.setName(rs.getString("name"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return article;
	}
	
	//펫시터 구하기 글 꺼내오는 메소드 content
	public GetpetDTO getContent(int num) {
		GetpetDTO article = null;
		
		try {
			conn = getConnection();
			
			String sql = "select * from getpet where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new GetpetDTO();
				
				article.setId(rs.getString("id"));
				article.setNum(rs.getInt("num"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReadcount(rs.getInt("readcount"));
				article.setIp(rs.getString("ip"));
				article.setReg(rs.getTimestamp("reg"));
				article.setImg(rs.getString("img"));
				article.setAvgpoint(rs.getDouble("avgpoint"));
				article.setName(rs.getString("name"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return article;
	}
	
	
	//이미지파일 이름 리턴하는 메소드
	public String getpetImage(int num) {
		String img = null;
		try {
			conn = getConnection();
			
			String sql = "select img from getpet where num=?";
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
	
	//글 수정하기 메소드
	public void modifyGetpet(GetpetDTO article) {
		try {
			conn = getConnection();
			
			//System.out.println(article.getContent());
			//System.out.println(article.getNum());
			//System.out.println(article.getSubject());
			
			String sql = "update getpet set subject=?, content=?, img=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getSubject());
			pstmt.setString(2, article.getContent());
			pstmt.setString(3, article.getImg());
			pstmt.setInt(4, article.getNum());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
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
				sql = "delete from getpet where num=?";
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
	public int deleteArticle(int num) {
		int x = 0;
		try {
			conn = getConnection();
			
			String sql = "delete from getpet where num=?";
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
	
	//num값의 rownum 받아 이전의rownum값으로 이전글 num받기 -> 이전글 = 현재글rownum+1
	public int pastnum(int num, int count) {
		int rownum = 0;
		int pastNum = 0;
		//num의 rownum 찾기
		List getpetList = getpetList(1, count);
		GetpetDTO getpet = null;
		
		for(int i = 0; i < getpetList.size(); i++) {
			getpet = (GetpetDTO)getpetList.get(i);
			if(getpet.getNum() == num) {
				rownum = i+1;
			}
		}
		
		if(rownum < count ) { //rownum이 1보다 크면 
			//rownum-1의 num찾기
			getpet = (GetpetDTO)getpetList.get(rownum);
			
			pastNum = getpet.getNum();
		}	
		
		return pastNum;
	}
	 
	//다음글의 num값을 리턴받는 메소드 -> 다음글 = 현재글rownum-1
	public int nextnum(int num, int count) {
		int rownum = 0;
		int nextNum = 0;
		
		//num의 rownum 찾기
		List getpetList = getpetList(1, count);
		GetpetDTO getpet = null;
		
		for(int i = 0; i < getpetList.size(); i++) {
			getpet = (GetpetDTO)getpetList.get(i);
			if(getpet.getNum() == num) {
				rownum = i+1;
			}
		}
		
		if(rownum > 1) { //num의 다른글이 존재하면
			//rownum+1의 num찾기
			getpet = (GetpetDTO)getpetList.get(rownum-2);
			nextNum = getpet.getNum();
		}	
		return nextNum;
	}
	
	
}
