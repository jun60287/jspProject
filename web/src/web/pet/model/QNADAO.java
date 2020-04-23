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

public class QNADAO {

	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Connection conn = null;
	
	private Connection getConnection() throws Exception{
			Context ctx = new InitialContext();
			Context env = (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)env.lookup("jdbc/orcl"); 
			conn = ds.getConnection();
			
		return conn;
	}
	
	public QNADTO myContents(String id) {
		QNADTO dto = new QNADTO();
		try {

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
		return dto;
	}
	
	public int countMyContents(String id) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from board where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return count;		
	}
	
	public List getMyContents(String id) {
		
		QNADAO dao = new QNADAO();
		List list = null;
		int count = dao.countMyContents(id);
	
			try {
			conn = getConnection();
			String sql1 = "select * from board where id = ? order by reg";  
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {				
				list = new ArrayList(count);
				do {
					QNADTO dto = new QNADTO();
					dto.setId(rs.getString("id"));
					dto.setPw(rs.getString("pw"));
					dto.setNum(rs.getInt("num"));
					dto.setContent(rs.getString("content"));
					dto.setSubject(rs.getString("subject"));
					dto.setReg(rs.getString("reg"));
					
					list.add(dto);					
				}while(rs.next());
			}						
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e){e.printStackTrace();}
		}
		System.out.println(list);
		return list;
	}
	
	public void addPet(QNADTO dto) {
		
		String id = dto.getId();
		String name = dto.getName();
		String kind = dto.getKind();
		String age = dto.getAge();
		String img = dto.getImg();
				
		try {
			conn = getConnection();
			String sql = "insert into addpet (num, id, name, kind, age, img) values (addpet_seq.nextVal,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, kind);
			pstmt.setString(4, age);
			pstmt.setString(5, img);
			pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
	}
//////////////////////////////////////////////////////////	
	public int countMyPetList(String id) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from addpet where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}			
		}
		return count;
	}
	
	public int countMyPetListName(String id, String keyword) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from addpet where id=? and name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}			
		}
		return count;
	}	
	
	public int countMyPetListKind(String id, String keyword) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from addpet where id=? and kind = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}			
		}
		return count;
	}	
	
	public int countMyPetListAge(String id, String keyword) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from addpet where id=? and age = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}			
		}
		return count;
	}	
	
//////////////////////////////////////////////////////////	
	public List myPetList(String id) {

		QNADAO dao = new QNADAO();
		int count = dao.countMyPetList(id);		
		List list = null;

		try {
			conn = getConnection();
			list = new ArrayList(count);
			String sql = "select * from addpet where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					QNADTO dto = new QNADTO();	
					dto.setName(rs.getString("name"));
					dto.setKind(rs.getString("kind"));
					dto.setAge(rs.getString("age"));
					dto.setImg(rs.getString("img"));
					list.add(dto);					
				}while(rs.next());				
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}	
		return list;
	}
	
	public List myPetListName(String id, String keyword) {
		QNADAO dao = new QNADAO();
		int count = dao.countMyPetListName(id, keyword);
		List list = null;

		try {
			conn = getConnection();
			list = new ArrayList(count);
			String sql = "select * from addpet where id = ? and name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					QNADTO dto = new QNADTO();	
					dto.setName(rs.getString("name"));
					dto.setKind(rs.getString("kind"));
					dto.setAge(rs.getString("age"));
					dto.setImg(rs.getString("img"));
					list.add(dto);					
				}while(rs.next());				
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}	
		return list;
	}
	
	public List myPetListKind(String id, String keyword) {
		QNADAO dao = new QNADAO();
		int count = dao.countMyPetListKind(id, keyword);		
		List list = null;

		try {
			conn = getConnection();
			list = new ArrayList(count);
			String sql = "select * from addpet where id = ? and kind = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					QNADTO dto = new QNADTO();	
					dto.setName(rs.getString("name"));
					dto.setKind(rs.getString("kind"));
					dto.setAge(rs.getString("age"));
					dto.setImg(rs.getString("img"));
					list.add(dto);					
				}while(rs.next());				
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}	
		return list;
	}
	
	public List myPetListAge(String id, String keyword) {
		QNADAO dao = new QNADAO();
		int count = dao.countMyPetListAge(id, keyword);		
		List list = null;

		try {
			conn = getConnection();
			list = new ArrayList(count);
			String sql = "select * from addpet where id = ? and age = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					QNADTO dto = new QNADTO();	
					dto.setName(rs.getString("name"));
					dto.setKind(rs.getString("kind"));
					dto.setAge(rs.getString("age"));
					dto.setImg(rs.getString("img"));
					list.add(dto);					
				}while(rs.next());				
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}	
		return list;
	}
	
//////////////////////////////////////////////////////////////	
	public QNADTO searchMyPet(String category, String keyword) {
		QNADTO dto = null;
		try {
			conn = getConnection();
			String sql = "select * from addpet where ?=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setString(2, keyword);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		return dto;
	} 

	
	
	public void addPetDelete (String id, int i) {
		QNADAO dao = new QNADAO();
		List list = dao.myPetList(id);
		QNADTO dto = (QNADTO)list.get(i);
		String name = dto.getName();
		String kind = dto.getKind();
		String age = dto.getAge();
		
		try {
			conn = getConnection();
			String sql = "delete from addpet where name=? and kind=? and age=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, kind);
			pstmt.setString(3, age);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}		 		
	}
	
	
	public String getPw(String id) {
		
		String pw = null;
		try {
			conn = getConnection();
			String sql = "select * from petmember where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pw = rs.getString("pw");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
		return pw;
	}
	
	public void insertQNA(String id, String content) {

		QNADAO dao = new QNADAO();
		String pw = dao.getPw(id);
		
		try {
			conn = getConnection();
			String sql = "insert into qna (writer, pw, content, reg, ref) values (?,?,?,sysdate,qna_seq.nextval)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, content);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
	
	}
	
	public void insertQNA(String id, String content, String img) {
		
		QNADAO dao = new QNADAO();
		String pw = dao.getPw(id);
		
		try {
			conn = getConnection();
			String sql = "insert into qna (writer, pw, content, reg, ref, img) values (?,?,?,sysdate,qna_seq.nextval,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, content);
			pstmt.setString(4, img);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
	
	}
	
	
	public List getQNA() {
		List list = null;
		try {
			conn = getConnection();
			int count = 0;
			String sql = "select count(*) from qna";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}			
			
			String sql1 = "select * from qna order by reg";
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList(count);
				do {
					QNADTO dto = new QNADTO();
					dto.setId(rs.getString("writer"));
					dto.setPw(rs.getString("pw"));
					dto.setContent(rs.getString("content"));
					dto.setImg(rs.getString("img"));
					dto.setReg(rs.getString("reg"));
					dto.setNum(rs.getInt("no"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_level(rs.getInt("re_level"));
					list.add(dto);		
				}while(rs.next());
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
		return list;
	}

	
	public void insertQNAReple(String id, String pw, String reple, String ref) {
				
		QNADAO dao = new QNADAO();
		int re_level = dao.getMaxReple(ref);
		System.out.println(re_level);
		
		try {			 
			conn = getConnection();
			String sql = ("insert into qnareple values (?,?,?,sysdate, qnareple_seq.nextval,?,"+(re_level+1)+")");									
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, reple);
			pstmt.setString(4, ref);						
			pstmt.executeUpdate();		
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
	}
	
	public void qnaDelete(int ref) {

		try {			
			conn = getConnection();
			String sql = "update qna set content = '삭제된 글입니다.' where ref = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.executeUpdate();						
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
	}	
	
	public int getCount(int ref) {
		
		int count = 0;		
		try {			
			conn = getConnection();
			String sql = "select count(*) from qnareple where ref = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();	
			if(rs.next()) {
				count = rs.getInt(1);
			}
							
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
		}return count;		
	}
	
	public int getMaxReple(String ref) {
		int max = 0;		
		try {
			conn = getConnection();
			String sql = "select max(re_level) from qnareple where ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ref);
			rs = pstmt.executeQuery();	
			if(rs.next()) {				
				max = rs.getInt(1);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
		}		
		return max;
	}
	
	
	public void test(String id) {
		try {
			
			String a = "1";			
			conn = getConnection();
			String sql = ("insert into test (id, pw) values (?,"+(a+10)+")");
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}	
	}
	
	public List getReple(int ref) {
		List list = null;
		
		try {
			
			conn = getConnection();
			
			String sql = "select * from qnareple where ref=? order by reg";			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			if(rs.next()) {		
				
				QNADAO dao = new QNADAO();
				int size = dao.getCount(ref);
				list = new ArrayList(size);
				do {
					
					QNADTO dto = new QNADTO();
					dto.setIdQNA(rs.getString("writer"));
					dto.setPwQNA(rs.getString("pw"));
					dto.setContentQNA(rs.getString("content"));					
					dto.setRegQNA(rs.getString("reg"));
					dto.setNumQNA(rs.getInt("no"));
					dto.setRefQNA(rs.getInt("ref"));
					dto.setRe_levelQNA(rs.getInt("re_level"));
					list.add(dto);
					
				}while(rs.next());					
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}		
		return list;
	}
	
	public boolean checkUser(String id, String pw, int ref) {
		boolean check = false;
			try {
				conn =  getConnection();
				String sql = "select * from qna where writer=? and pw=? and ref=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				pstmt.setInt(3, ref);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					check = true;
				}				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
				if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
				if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}				
			}			
		return check;
	}
	
	public void qnaDeleteReple(String ref, String re_level) {
		try {
			conn = getConnection();
			String sql = "update qnareple set content = '삭제된 댓글입니다.' where ref=? and re_level=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ref);
			pstmt.setString(2, re_level);
			pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}		
		}
	}
	
	
	public boolean checkUserReple(String id, String pw, String ref, String re_level) {
		boolean check = false;
			try {
				conn =  getConnection();
				String sql = "select * from qnareple where writer=? and pw=? and ref=? and re_level=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				pstmt.setString(3, ref);
				pstmt.setString(4, re_level);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					check = true;
				}			
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
				if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
				if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}				
			}			
		return check;
	}
	
	public boolean checkContent(int ref) {
		
		boolean check = false;
		
		try {
			conn = getConnection();
			String sql = "select * from qna where content='삭제된 글입니다.' and ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check = true;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}		
		}
		return check;
	}
	
	
	public boolean checkContentReple(int ref, int re_level) {
		
		boolean check = false;
		
		try {
			conn = getConnection();
			String sql = "select * from qnareple where content='삭제된 댓글입니다.' and ref=? and re_level=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check = true;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}		
		}
		return check;
	}	
	
	public int getQNANum() {
		int count = 0;
		
		try {
			conn = getConnection();
			String sql = "select count(*) from qna";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}		
		}
		return count;
	}
	
	public List getQNA(int startNum, int endNum, int contentsSize) {
		List list = null;
		try {
			System.out.println("222");
			conn = getConnection();
			String sql1 = "select * from ( select a.*, rownum as rnum, count(*) over() as totcnt from (select * from qna order by reg)a)where rnum >= ? and rnum <= ?";
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, endNum);
			pstmt.setInt(2, startNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList(contentsSize);
				System.out.println("111");
				do {
					QNADTO dto = new QNADTO();
					dto.setId(rs.getString("writer"));
					dto.setPw(rs.getString("pw"));
					dto.setContent(rs.getString("content"));
					dto.setImg(rs.getString("img"));
					dto.setReg(rs.getString("reg"));
					dto.setNum(rs.getInt("no"));
					dto.setRef(rs.getInt("ref"));
					dto.setRnum(rs.getInt("rnum"));
					dto.setRe_level(rs.getInt("re_level"));
					list.add(dto);		
				}while(rs.next());
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
		return list;
	}
	
	public List getMyContents(String id, int num) {
		
		
		List list = null;
		int count = countMyContents(id);
	
			try {
			conn = getConnection();
			String sql1 = "select * from board where id = ? and num = ?";  
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setInt(2, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {				
				list = new ArrayList(count);
				do {
					QNADTO dto = new QNADTO();
					dto.setId(rs.getString("id"));
					dto.setPw(rs.getString("pw"));
					dto.setNum(rs.getInt("num"));
					dto.setContent(rs.getString("content"));
					dto.setSubject(rs.getString("subject"));
					dto.setReg(rs.getString("reg"));
					
					list.add(dto);					
				}while(rs.next());
			}						
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e){e.printStackTrace();}
		}
		return list;
	}
	
	public void modifyContent(int num, String text) {
		try {
			conn = getConnection();
			String sql = "update board set content = ? where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, text);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();	
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try {pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e){e.printStackTrace();}
		}
	}
	
}