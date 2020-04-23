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

public class TradeDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// DB 접속
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl"); 
		return ds.getConnection();
	}
	
	
	// 검색안했을 때 띄워주는 글 목록들 개수
	public int getArticleCount() {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from trade";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {				
				x = rs.getInt(1);		
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	
	
	// 게시글 저장
	public void insertArticle(TradeDTO article) {
		int num = article.getNum();					// 글번호(새글작성이면 0, 댓글일때 1이상)
		int ref = article.getRef();					// 글 그룹 1
		int re_step = article.getRe_step();			// 정렬 순서 0
		int re_level = article.getRe_level();		// 답글 레벨 0
		int number = 0;								// DB에 저장할 글 고유번호
		String sql = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(num) from trade");	
			rs = pstmt.executeQuery();
			if(rs.next()) number = rs.getInt(1) + 1;	
			else number = 1;							
			
			if(num != 0) { 	
				sql = "update trade set re_step=re_step+1 where ref = ? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeQuery();
				re_step = re_step+1;
				re_level = re_level+1;
			}else {			
				ref = number;		
				re_step = 0; 		
				re_level = 0;
			}
			sql = "insert into trade(num, id, pass, local, subject, time, "
					+ "content, picture, ref, re_step, re_level) values(trade_seq.nextVal,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getId());
			pstmt.setString(2, article.getPass());
			pstmt.setString(3, article.getLocal());
			pstmt.setString(4, article.getSubject());
			pstmt.setTimestamp(5, article.getTime());
			pstmt.setString(6, article.getContent());
			pstmt.setString(7, article.getPicture());
			pstmt.setInt(8, ref);
			pstmt.setInt(9, re_step);
			pstmt.setInt(10, re_level);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	
	// 지정한 게시글 가져오기
	public TradeDTO getArticle(int num) {
		TradeDTO article = null;
		try {
			conn = getConnection();
			// 먼저 조회수 올려서 저장하기
			String sql = "update trade set readcount=readcount+1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeQuery();
			
			// 다시 해당번호 레코드 가져오기
			sql = "select * from trade where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new TradeDTO();
				article.setNum(rs.getInt("num"));
				article.setId(rs.getString("id"));
				article.setPass(rs.getString("pass"));
				article.setLocal(rs.getString("local"));
				article.setSubject(rs.getString("subject"));
				article.setTime(rs.getTimestamp("time"));
				article.setReadcount(rs.getInt("readcount"));
				article.setContent(rs.getString("content"));
				article.setPicture(rs.getString("picture"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return article;
	}
	
	
	// 게시글 전체 가져오는 메서드
	public List getArticles(int startRow, int endRow) {
		List articleList = null;
		try {
			conn = getConnection();
			String sql = "select num,id,pass,local,subject,time,readcount,content,picture,ref,re_step,re_level,r "
					+ "from (select num,id,pass,local,subject,time,readcount,content,picture,ref,re_step,re_level,rownum r "
					+ "from (select num,id,pass,local,subject,time,readcount,content,picture,ref,re_step,re_level "
					+ "from trade order by ref desc, re_step asc) order by ref desc, re_step asc) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articleList = new ArrayList(endRow);
				do {
					TradeDTO article = new TradeDTO();
					article.setNum(rs.getInt("num"));
					article.setId(rs.getString("id"));
					article.setPass(rs.getString("pass"));
					article.setLocal(rs.getString("local"));
					article.setSubject(rs.getString("subject"));
					article.setTime(rs.getTimestamp("time"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					article.setPicture(rs.getString("picture"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					articleList.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return articleList;
	}
	
	
	// 검색한 글 개수 돌려주는 메서드
	public int getSearchArticleCount(String sel, String search) {
		int x = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from trade where "+sel+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return x;
	}
	
	
	// 검색했을 때 글 전체 돌려주는 메서드
	public List getSearchArticles(int startRow, int endRow, String sel, String search) {
		List articleList = null;
		try {
			conn = getConnection();
			String sql = "select num,id,pass,local,subject,time,readcount,content,picture,ref,re_step,re_level,r "
					+ "from (select num,id,pass,local,subject,time,readcount,content,picture,ref,re_step,re_level,rownum r "
					+ "from (select num,id,pass,local,subject,time,readcount,content,picture,ref,re_step,re_level "
					+ "from trade where "+sel+" like '%"+search+"%' order by ref desc, re_step asc) order by ref desc, re_step asc) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articleList = new ArrayList();
				do {
					TradeDTO article = new TradeDTO();
					article.setNum(rs.getInt("num"));
					article.setId(rs.getString("id"));
					article.setPass(rs.getString("pass"));
					article.setLocal(rs.getString("local"));
					article.setSubject(rs.getString("subject"));
					article.setTime(rs.getTimestamp("time"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					article.setPicture(rs.getString("picture"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					articleList.add(article);
				}while(rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); }catch(SQLException s) {}
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
		return articleList;
	}
	
	
	// 게시글 수정 메서드
	public int updateArticle(TradeDTO article) {
		int x = -1;
		String dbpw = "";
		try {
			conn = getConnection();
			String sql = "select pass from trade where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pass");
				if(dbpw.equals(article.getPass())) {
					sql = "update trade set id=?, subject=?, local=?, content=?, picture=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getId());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getLocal());
					pstmt.setString(4, article.getContent());
					pstmt.setString(5, article.getPicture());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate();
					x = 1;
				}else {
					x = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	
	
	// 게시글에 올려져있는 사진 가져오는 메서드
	public String getPhotoName(String id) {
		String name = null;
		try {
			conn = getConnection();
			String sql = "select picture from trade where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("picture");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return name;
	}
	
	
	// 게시글 삭제하는 메서드
	public int deleteArticle(int num, String pass) {
		int x = -1;
		String dbpw = "";
		try {
			conn = getConnection();
			String sql = "select pass from trade where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pass");
				if(dbpw.equals(pass)) {
					sql = "delete from trade where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x = 1;
				}else {
					x = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	//개인 글 갯수 리턴
	public int gettradeWriteCount(String id) {
		int tradeWriteCount = 0;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from trade where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				tradeWriteCount = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return tradeWriteCount;
	}
	
	// 관리자 전용 게시글 삭제
	public void deleteArticleByAdmin(int num) {
		try {
			conn = getConnection();
			String sql = "delete from trade where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(SQLException s) {}
			if(conn != null) try { conn.close(); }catch(SQLException s) {}
		}
	}
}

