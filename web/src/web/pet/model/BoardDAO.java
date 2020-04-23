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

public class BoardDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}
	
	public void inputBoard(BoardDTO article) {
		int num = article.getNum();
		int number = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(num) from board");
			rs = pstmt.executeQuery();
			
			if(rs.next()) number = rs.getInt(1)+1; 
			else number = 1;
			
			String sql = "insert into board(num,id,subject,content,reg,photo) values(board_seq.nextVal,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, article.getId());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getContent());
			pstmt.setTimestamp(4, article.getReg());
			pstmt.setString(5, article.getPhoto());
			
			pstmt.executeUpdate();
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	public int countBoard() {
		int count = 0;
		try{
			conn = getConnection();
			String sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
				System.out.println(count);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return count;
		
	}
	
	public List getArticles(int startRow, int endRow) {
		List articleList = null;
		BoardDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select num,id,content,reg,readcount,subject,r "
					+ "from(select num,id,content,reg,readcount,subject,rownum r "
					+ "from (select num,id,content,reg,readcount,subject from board order by num desc) order by num desc) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,startRow);
			pstmt.setInt(2,endRow);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("찾았다");
				articleList = new ArrayList(endRow);
				do {
					dto = new BoardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
					dto.setContent(rs.getString("content"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setSubject(rs.getString("subject"));
					
					articleList.add(dto);
				}while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
		return articleList;
	}
	public BoardDTO getArticle(int num) {
		BoardDTO article = null;
		try {
			conn = getConnection();
			String sql = "update board set readcount = readcount + 1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			sql = "select * from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new BoardDTO();
				article.setNum(rs.getInt("num"));
				article.setId(rs.getString("id"));
				article.setContent(rs.getString("content"));
				article.setReg(rs.getTimestamp("reg"));
				article.setReadcount(rs.getInt("readcount"));
				article.setSubject(rs.getString("subject"));
				article.setPhoto(rs.getString("photo"));
				article.setPw(rs.getString("pw"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return article;
	}
	
	public boolean modifyBoard(BoardDTO article) {
		boolean result = true;
		 try {
			conn = getConnection();
			String sql = "select * from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			System.out.println("=======");
			System.out.println("1");
			if(rs.next()) {
					System.out.println("2");
					sql = "update board set subject = ? , content = ? , photo = ?where num = ?" ;
					pstmt = conn.prepareStatement(sql);
					System.out.println(article.getContent());
					pstmt.setString(1, article.getSubject());
					pstmt.setString(2, article.getContent());
					pstmt.setString(3, article.getPhoto());
					pstmt.setInt(4, article.getNum());
					pstmt.executeUpdate();
					System.out.println("=======");
					result = true;
			} else {
				result = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		 
		 return result;
	}
	
	public void deleteBoard(int num) {

		try {
			conn = getConnection();
			String sql = "select * from board where num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
					sql = "delete from board where num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		
	}
	
	
	public String getPhotoname(int num) {
		String name = "";
		try {
			conn = getConnection();
			String sql = "select photo from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs =  pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString(1);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return name;
	}

	public String getPw(int num){
		String id = "";
		String pw = "";
		try {
			conn = getConnection();
			String sql = "select id from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
				sql = "select pw from petmember where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					pw = rs.getString(1);
				}
			}
		} catch (Exception e) { 
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return pw;
	}
	
	//개인 글 갯수 리턴
	public int getboardWriteCount(String id) {
		int boardWriteCount = 0;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from board where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				boardWriteCount = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return boardWriteCount;
	}
	
	
	
}