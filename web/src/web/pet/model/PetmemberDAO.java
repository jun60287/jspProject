package web.pet.model;

import java.lang.invoke.MethodHandles.Lookup;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PetmemberDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl"); 
		
		return ds.getConnection();
	}
	
	//로그인메소드
	public boolean login(String id, String pw) {
		boolean b = false;
		
		try {
			conn = getConnection();
			String sql = "select * from petmember where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				b = true;
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return b;
	}
	
	//회원가입 메소드
	public void signup(PetmemberDTO petmember) {
		try {
			
			conn = getConnection();
			String sql = "insert into petmember values(?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, petmember.getId());
			pstmt.setString(2, petmember.getPw());
			pstmt.setString(3, petmember.getEmail());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
	}
	
	//회원정보 리턴하는 메소드
	public PetmemberDTO getPetmember(String id) {
		PetmemberDTO member = null;
		try {
			conn = getConnection();
			String sql = "select * from petmember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new PetmemberDTO();
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setEmail(rs.getString("email"));
				member.setReg(rs.getTimestamp("reg"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return member;
	}
	
	//회원정보 수정하는 메소드
	public void modifyPetmember(PetmemberDTO member) {
		try {
			conn = getConnection();
			String sql = "update petmember set pw=?, email=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getEmail());
			pstmt.setString(3, member.getId());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
	}
	
	//아이디 중복검사 메소드
	public boolean checkId(String id) {
		boolean b = false;
		try {
			conn = getConnection();
			String sql = "select id from petmember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				b = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return b;
	}
	
	//회원탈퇴 메소드
	public int deleteMember(String id, String pw) {
		int x = -1;
		String dbpw = null;
		try {
			conn = getConnection();
			String sql = "select pw from petmember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) dbpw = rs.getString(1);
			
			if(dbpw.equals(pw)) {
				sql = "delete from petmember where id=? and pw=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);				
				pstmt.setString(2, pw);
				pstmt.executeUpdate();
				
				x = 1;
			}else {
				x = 0;
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
	
	//펫시터 등록 여부를 리턴해주는 메소드
	public boolean checkSitter(String id) {
		boolean b = false;
		try {
			conn = getConnection();
			String sql = "select * from petsitter where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				b = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return b;
	}
	
}
