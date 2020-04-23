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

public class PetsitterDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl"); 
		
		return ds.getConnection();
	}
	// 펫시터 가입 메서드
	public void insertpetMember(PetsitterDTO pet) {
		try {
			conn = getConnection();
			String sql = "insert into petSitter(id, pw, name, area, petsit, pet, phone, box, photo) values(?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pet.getId());
			pstmt.setString(2, pet.getPw());
			pstmt.setString(3, pet.getName());
			pstmt.setString(4, pet.getArea());
			pstmt.setString(5, pet.getPetsit());
			pstmt.setString(6, pet.getPet());
			pstmt.setString(7, pet.getPhon());
			pstmt.setString(8, pet.getBox());
			pstmt.setString(9, pet.getPhoto());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	// 글 작성시 펫시터 이름 갯수 리턴하는 메소드
	public int searchPersitterCount(String name) {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from petsitter where name like '%"+name+"%'";
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
	// 글 작성시 펫시터 이름 검색하는 메소드 
	public List searchPersitter(String name) {
		List petsitters = null;
		try {
			conn = getConnection();
			
			String sql = "select * from petsitter where name like '%"+name+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			petsitters = new ArrayList();
			PetsitterDTO petsitter = null;
			while(rs.next()) {
				petsitter = new PetsitterDTO();
				petsitter.setId(rs.getString("id"));
				petsitter.setPw(rs.getString("pw"));
				petsitter.setName(rs.getString("name"));
				petsitter.setArea(rs.getString("area"));
				petsitter.setPetsit(rs.getString("petsit"));
				petsitter.setPet(rs.getString("pet"));
				petsitter.setPhon(rs.getString("phone"));
				petsitter.setBox(rs.getString("box"));
				petsitter.setPhoto(rs.getString("photo"));
				petsitter.setPoint(rs.getInt("point"));
				
				petsitters.add(petsitter);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		
		return petsitters;
	}
	
	//전체 펫시터 count 리턴하는 메소드
	public int allPersitterCount() {
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from petsitter";
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
	
	//전체 펫시터 List 리턴하는 메소드
	public List allPersitter() {
		List petsitters = null;
		try {
			conn = getConnection();
			
			String sql = "select * from petsitter";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			petsitters = new ArrayList();
			PetsitterDTO petsitter = null;
			while(rs.next()) {
				petsitter = new PetsitterDTO();
				petsitter.setId(rs.getString("id"));
				petsitter.setPw(rs.getString("pw"));
				petsitter.setName(rs.getString("name"));
				petsitter.setArea(rs.getString("area"));
				petsitter.setPetsit(rs.getString("petsit"));
				petsitter.setPet(rs.getString("pet"));
				petsitter.setPhon(rs.getString("phone"));
				petsitter.setBox(rs.getString("box"));
				petsitter.setPhoto(rs.getString("photo"));
				petsitter.setPoint(rs.getInt("point"));
				
				petsitters.add(petsitter);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return petsitters;
	}
	
	//펫시터 point 리턴하는 메소드
	public int getSitterPoint(String name) {
		int sitterPoint = 0;
		
		try {
			conn = getConnection();
			String sql = "select point from petsitter where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				sitterPoint = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		}
		return sitterPoint;
	}
	
	//회원 id로 펫시터 정보 리턴하는 메소드
	public PetsitterDTO getPetsitter(String id) {
		PetsitterDTO sitter = null;
		
		try {
			conn = getConnection();
			String sql = "select * from petsitter where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sitter = new PetsitterDTO();
				sitter.setId(id);
				sitter.setPw(rs.getString("pw"));
				sitter.setName(rs.getString("name"));
				sitter.setPetsit(rs.getString("petsit"));
				sitter.setPet(rs.getString("pet"));
				sitter.setPhon(rs.getString("phone"));
				sitter.setBox(rs.getString("box"));
				sitter.setPhoto(rs.getString("photo"));
				sitter.setPoint(rs.getInt("point"));
				sitter.setAvgpoint(rs.getDouble("avgpoint"));
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
	//펫시터가입메솧드
	public void updatePet(PetsitterDTO pet) {
		System.out.println(pet.getId());
		try {
			conn = getConnection();
			String sql = "select * from petSitter where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pet.getId());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "update petSitter set pw = ?, name = ?, area = ?, petsit = ?, pet = ?, phone = ?, box = ?, photo = ? where id = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, pet.getPw());
				pstmt.setString(2, pet.getName());
				pstmt.setString(3, pet.getArea());
				pstmt.setString(4, pet.getPetsit());
				pstmt.setString(5, pet.getPet());
				pstmt.setString(6, pet.getPhon());
				pstmt.setString(7, pet.getBox());
				pstmt.setString(8, pet.getPhoto());
				pstmt.setString(9, pet.getId());
				
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
	
	}
	
	// 펫시터 등록 삭제할 때 사진도 삭제해야되니까 사진 가져오는 메서드
	public String getPhotoNamePet(String id) {
		String name = null;
		try {
			conn = getConnection();
			String sql = "select photo from petSitter where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				name = rs.getString("photo");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) {try{rs.close();}catch(SQLException e) {e.printStackTrace();}}
			if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {e.printStackTrace();}}
			if(conn!=null) {try{conn.close();}catch(SQLException e) {e.printStackTrace();}}
		} 
		return name;
	}
	
	// 펫시터 데이터 삭제 메서드
	public int deletepetMember(String id, String pw) {
		int x = -1;
		String dbpw = "";
		try {
			conn = getConnection();
			String sql = "select pw from petSitter where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) {
					sql = "delete from petSitter where id=? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x = 1;
				}else {
					System.out.println("비번 오류");
					x = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
		return x;
	}
	public void deleteGetpet(String id) {
		String dbpw = "";
		try {
			conn = getConnection();
			String sql = "select pw from petSitter where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "delete from getpet where id=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				}else {
					System.out.println("비번 오류");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)try {rs.close();}catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(SQLException e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(SQLException e) {e.printStackTrace();}
		}
	}
	
	// 펫시터 확인 메서드(펫시터 메인 페이지 들어갔을 때 펫시터 등록상태인지 아닌지 알려주는 메서드) - 펫시터 DB에 아이디가 존재하는지 확인하는 메서드
	public boolean petsitCheck(String id) {
		boolean check = false;
		try {
			conn = getConnection();
			String sql = "select id from petSitter where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn != null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
		return check;
	}
	
}
