package web.pet.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class PDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	// 관리자 - 회원 목록 전체 출력 메서드
	public ArrayList<PDTO> getMemberAll(){
		ArrayList<PDTO> list = new ArrayList<PDTO>();
		try {
			String sql = "select * from petmember";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				PDTO dto =  new PDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setEmail(rs.getString("email"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return list;
	}
	
	
	// 관리자 선택한 회원아이디 삭제 메서드
	public void deleteMemberByAdmin(String id) {
		try {
			conn = getConnection();
			String sql = "delete from petmember where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); }catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try { conn.close(); }catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	
	// 관리자가 수정하려는 회원정보 띄워주는 메서드
	public PDTO getAdminmember(String id) {
		PDTO member = null;
		try {
			conn = getConnection();
			String sql = "select * from petmember where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			if(rs.next()) {
				member = new PDTO();
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
	
	
	// 관리자가 불러온 회원정보 수정처리 해주는 메서드
	public void modifyAdminmember(PDTO admin) {
		try {
			conn = getConnection();
			String sql = "update petmember set pw = ?, email = ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, admin.getPw());
			pstmt.setString(2, admin.getEmail());
			pstmt.setString(3, admin.getId());
			pstmt.executeUpdate();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
	}
}















