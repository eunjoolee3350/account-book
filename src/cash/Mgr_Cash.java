package cash;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class Mgr_Cash {

	private DBConnectionMgr pool;

	public Mgr_Cash() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
/************************************<<Member>>*********************************************/
	// ID 중복 체크
	public boolean checkId(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select usid from cash_mem where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			flag = pstmt.executeQuery().next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 우편번호 찾기
	public Vector<ZipcodeBean> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from jsp_post where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + area3 + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 회원 추가
	public boolean insertMember(Bean_Member bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert cash_mem(numb,usid,uspw,state,appro,name,telp,gend,birth,email,post"
					+ ",addr,hobby,job)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNumb());
			pstmt.setString(2, bean.getUsid());
			pstmt.setString(3, bean.getUspw());
			pstmt.setString(4, bean.getState());
			pstmt.setString(5, bean.getAppro());
			pstmt.setString(6, bean.getName());
			pstmt.setString(7, bean.getTelp());
			pstmt.setString(8, bean.getGend());
			pstmt.setString(9, bean.getBirth());
			pstmt.setString(10, bean.getEmail());
			pstmt.setString(11, bean.getPost());
			pstmt.setString(12, bean.getAddr());
			String hobby[] = bean.getHobby();
			char hb[] = { '0', '0', '0', '0', '0'};
			String lists[] = { "인터넷", "여행", "게임", "영화", "운동"};
			for (int i = 0; i < hobby.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if (hobby[i].equals(lists[j]))
						hb[j] = '1';
				}
			}
			pstmt.setString(13, new String(hb));
			pstmt.setString(14, bean.getJob());

			//System.out.print("uspw : ");
			//System.out.println(bean.getUspw());

			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 로그인
	public boolean loginMember(String usid, String uspw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select usid from cash_mem where usid = ? and uspw = ? and appro= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			pstmt.setString(2, uspw);
			pstmt.setString(3, "승인");
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 회원자료 가져오기 (usid, numb) - 관리자가 클릭 
	public Bean_Member getMember(String usid, int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Member bean = null;
		try {
			con = pool.getConnection();
			if (numb > 0) {
				String sql = "select * from cash_mem where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
			} else {
				String sql = "select * from cash_mem where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);
			}
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Member();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setState(rs.getString("state"));
				bean.setAppro(rs.getString("appro"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setGend(rs.getString("gend"));
				bean.setBirth(rs.getString("birth"));
				bean.setEmail(rs.getString("email"));
				bean.setPost(rs.getString("post"));
				bean.setAddr(rs.getString("addr"));
				String hobbys[] = new String[5];
				String hobb = rs.getString("hobby");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobb.substring(i, i + 1);
				}
				bean.setHobby(hobbys);
				bean.setJob(rs.getString("job"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}

	// 회원 조회 (usid)
	public Bean_Member getMember2(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Member bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from cash_mem where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
		if (rs.next()) {
			bean = new Bean_Member();
			bean.setNumb(rs.getInt("numb"));
			bean.setUsid(rs.getString("usid"));
			bean.setUspw(rs.getString("uspw"));
			bean.setState(rs.getString("state"));
			bean.setAppro(rs.getString("appro"));
			bean.setName(rs.getString("name"));
			bean.setTelp(rs.getString("telp"));
			bean.setGend(rs.getString("gend"));
			bean.setBirth(rs.getString("birth"));
			bean.setEmail(rs.getString("email"));
			bean.setPost(rs.getString("post"));
			bean.setAddr(rs.getString("addr"));
			String hobbys[] = new String[5];
			String hobb = rs.getString("hobby");// 01001
			for (int i = 0; i < hobbys.length; i++) {
				hobbys[i] = hobb.substring(i, i + 1);
			}
			bean.setHobby(hobbys);
			bean.setJob(rs.getString("job"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 회원 조회 (numb)
		public Bean_Member getMember3(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Member bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from cash_mem where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Member();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setState(rs.getString("state"));
				bean.setAppro(rs.getString("appro"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setGend(rs.getString("gend"));
				bean.setBirth(rs.getString("birth"));
				bean.setEmail(rs.getString("email"));
				bean.setPost(rs.getString("post"));
				bean.setAddr(rs.getString("addr"));
				String hobbys[] = new String[5];
				String hobb = rs.getString("hobby");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobb.substring(i, i + 1);
				}
				bean.setHobby(hobbys);
				bean.setJob(rs.getString("job"));

				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	
	// 회원 정보 수정
	public boolean updateMember(Bean_Member bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update cash_mem set uspw=?, state=?, appro=?, name=?, telp=?,"
					+ " gend=?, birth=?, email=?, post=?, addr=?, hobby=?, job=? where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUspw());
			pstmt.setString(2, bean.getState());
			pstmt.setString(3, bean.getAppro());
			pstmt.setString(4, bean.getName());
			pstmt.setString(5, bean.getTelp());
			pstmt.setString(6, bean.getGend());
			pstmt.setString(7, bean.getBirth());
			pstmt.setString(8, bean.getEmail());
			pstmt.setString(9, bean.getPost());
			pstmt.setString(10, bean.getAddr());
			char hobby[] = { '0', '0', '0', '0', '0' };
			if (bean.getHobby() != null) {
				String hobbys[] = bean.getHobby();
				String list[] = { "인터넷", "여행", "게임", "영화", "운동" };
				for (int i = 0; i < hobbys.length; i++) {
					for (int j = 0; j < list.length; j++)
						if (hobbys[i].equals(list[j]))
							hobby[j] = '1';
				}
			}
			pstmt.setString(11, new String(hobby));
			pstmt.setString(12, bean.getJob());
			pstmt.setString(13, bean.getUsid());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 회원 총 수
	public int getTotalCount(String state, String check) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if ( (state.equals("관리자")) && (check.equals("N")) ) {
		       sql = "select count(numb) from cash_mem where state='관리자' or state='사용자' ";
			   pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("관리자")) && (check.equals("Y")) ) {
			   sql = "select count(numb) from cash_mem where appro='미승인' and (state='관리자' or state='사용자') ";
			   pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("관리자")) && (check.equals("J")) ) {
				sql = "select count(numb) from cash_mem where appro='승인' and (state='관리자' or state='사용자') ";
				pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("사용자")) && (check.equals("Y")) ) {
				sql = "select count(numb) from cash_mem where appro='미승인' and state='사용자' ";
				pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("사용자")) && (check.equals("J")) ) {
				sql = "select count(numb) from cash_mem where appro='승인' and state='사용자' ";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select count(numb) from cash_mem where state='사용자' ";
				pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	// 해당 조건의 회원 조회
	public Vector<Bean_Member> getMemberList(String state, String check) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Member> vlist = new Vector<Bean_Member>();
		try {
			con = pool.getConnection();
			if ( (state.equals("관리자")) && (check.equals("N")) ) {
		       sql = "select * from cash_mem where state='관리자' or state='사용자' ";
			   pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("관리자")) && (check.equals("Y")) ) {
			   sql = "select * from cash_mem where appro='미승인' and (state='관리자' or state='사용자') ";
			   pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("관리자")) && (check.equals("J")) ) {
				sql = "select * from cash_mem where appro='승인' and (state='관리자' or state='사용자') ";
				pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("사용자")) && (check.equals("Y")) ) {
				sql = "select * from cash_mem where appro='미승인' and state='사용자' ";
				pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("사용자")) && (check.equals("J")) ) {
				sql = "select * from cash_mem where appro='승인' and state='사용자' ";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select * from cash_mem where state='사용자' ";
				pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Member bean = new Bean_Member();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setUspw(rs.getString("uspw"));
				bean.setState(rs.getString("state"));
				bean.setAppro(rs.getString("appro"));
				bean.setName(rs.getString("name"));
				bean.setTelp(rs.getString("telp"));
				bean.setEmail(rs.getString("email"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	

	// 회원 정보 삭제
	public void deleteMember(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from cash_mem where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 회원 정보 수정
		public boolean updatePerm(int recnum, String perm) {
			Connection con = null;
			PreparedStatement pstmt = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				if (perm.equals("미승인")) {
					String sql = "update cash_mem set appro=? where numb = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "승인");
					pstmt.setInt(2, recnum);
				} else {
					String sql = "update cash_mem set appro=? where numb = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "미승인");
					pstmt.setInt(2, recnum);
				}
				int count = pstmt.executeUpdate();
				if (count > 0)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
	
	
	
	
	
/************************************<<Code>>*********************************************/
	// 코드 추가
	public boolean insertCode(Bean_Code bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert cash_code(usid, code, gubun)values(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsid());
			pstmt.setString(2, bean.getCode());
			pstmt.setString(3, bean.getGubun());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 코드목록 가져오기  ()
		public Bean_Code getCode() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Code bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from cash_code";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Code();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setCode(rs.getString("code"));
					bean.setGubun(rs.getString("gubun"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	
	// 코드목록 가져오기  (usid)
	public Bean_Code getCode1(String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Bean_Code bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from cash_code where usid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new Bean_Code();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setCode(rs.getString("code"));
				bean.setGubun(rs.getString("gubun"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	
	// 코드목록 가져오기  (numb)
		public Bean_Code getCode2(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Code bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from cash_code where numb = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Code();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setCode(rs.getString("code"));
					bean.setGubun(rs.getString("gubun"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
		// 코드 목록가져오기
		public Vector<Bean_Code> getCodelist2(String check) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<Bean_Code> vlist = new Vector<Bean_Code>();
			try {

//				System.out.print("usid : ");
//				System.out.println(usid);
				
				con = pool.getConnection();
				if (check.equals("N")) {
					sql = "select * from cash_code order by code";
					pstmt = con.prepareStatement(sql);
				} else if ( check.equals("Su") ){
					sql = "select * from cash_code where substr(code, 1, 1) = '1' and substr(code,5,1) != '0' order by code";
					pstmt = con.prepareStatement(sql);
				} else if ( check.equals("Ji") ){
					sql = "select * from cash_code where substr(code, 1, 1) = '2' and substr(code,5,1) != '0' order by code";
					pstmt = con.prepareStatement(sql);
				} else if ( check.equals("Cs") ){
					sql = "select * from cash_code where substr(code, 1, 1) = '3' and substr(code,5,1) != '0' order by code";
					pstmt = con.prepareStatement(sql);
				} else if ( check.equals("Cd") ){
					sql = "select * from cash_code where substr(code, 1, 1) = '4' and substr(code,5,1) != '0' order by code";
					pstmt = con.prepareStatement(sql);
				} else if ( check.equals("Ba") ){
					sql = "select * from cash_code where substr(code, 1, 1) = '5' and substr(code,5,1) != '0' order by code";
					pstmt = con.prepareStatement(sql);
				} 
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bean_Code bean = new Bean_Code();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setCode(rs.getString("code"));
					bean.setGubun(rs.getString("gubun"));
					vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
	// 코드 목록가져오기
	public Vector<Bean_Code> getCodelist(String check, String keyWord, String keyField) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Code> vlist = new Vector<Bean_Code>();
		try {

//			System.out.print("usid : ");
//			System.out.println(usid);
			
			con = pool.getConnection();
			if (check.equals("N")) {
				sql = "select * from cash_code order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Su") ){
				sql = "select * from cash_code where substr(code, 1, 1) = '1' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Ji") ){
				sql = "select * from cash_code where substr(code, 1, 1) = '2' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Cs") ){
				sql = "select * from cash_code where substr(code, 1, 1) = '3' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Cd") ){
				sql = "select * from cash_code where substr(code, 1, 1) = '4' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Ba") ){
				sql = "select * from cash_code where substr(code, 1, 1) = '5' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if (check.equals("S")) {
				sql = "select * from cash_code where " + keyField + " like ? order by code";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Code bean = new Bean_Code();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setCode(rs.getString("code"));
				bean.setGubun(rs.getString("gubun"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 해당 코드 수
	public int getCodelistCount(String check, String keyWord, String keyField) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (check.equals("N")) {
				sql = "select count(numb) from cash_code order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Su") ){
				sql = "select count(numb) from cash_code where substr(code, 1, 1) = '1' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Ji") ){
				sql = "select count(numb) from cash_code where substr(code, 1, 1) = '2' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Cs") ){
				sql = "select count(numb) from cash_code where substr(code, 1, 1) = '3' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Cd") ){
				sql = "select count(numb) from cash_code where substr(code, 1, 1) = '4' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if ( check.equals("Ba") ){
				sql = "select count(numb) from cash_code where substr(code, 1, 1) = '5' and substr(code,5,1) != '0' order by code";
				pstmt = con.prepareStatement(sql);
			} else if (check.equals("S")) {
				sql = "select count(numb) from cash_code where " + keyField + " like ? order by code";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 코드 수정
	public boolean updateCode(Bean_Code bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update cash_code set code=?, gubun=?, usid=? where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCode());
			pstmt.setString(2, bean.getGubun());
			pstmt.setString(3, bean.getUsid());
			pstmt.setInt(4, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 코드 삭제
	public void deleteCode(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from cash_code where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	
	
/************************************<<출납>>*********************************************/
	// 출납 추가
	public boolean insertChul(Bean_Chul bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert cash_chul(usid, nalja, g_suip, g_gichul, g_cash, g_card, g_bank,"
					+ "gichul_list, suip, gichul, bigo)values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsid());
			pstmt.setString(2, bean.getNalja());
			pstmt.setString(3, bean.getG_suip());
			pstmt.setString(4, bean.getG_gichul());
			pstmt.setString(5, bean.getG_cash());
			pstmt.setString(6, bean.getG_card());
			pstmt.setString(7, bean.getG_bank());
			pstmt.setString(8, bean.getGichul_list());
			pstmt.setInt(9, bean.getSuip());
			pstmt.setInt(10, bean.getGichul());
			pstmt.setString(11, bean.getBigo());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 출납목록 가져오기  (usid)
		public Bean_Chul getChul(String usid) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Chul bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from cash_chul where usid=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(0, usid);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Chul();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setNalja(rs.getString("nalja"));
					bean.setG_suip(rs.getString("g_suip"));
					bean.setG_gichul(rs.getString("g_gichul"));
					bean.setG_cash(rs.getString("g_cash"));
					bean.setG_card(rs.getString("g_card"));
					bean.setG_bank(rs.getString("g_bank"));
					bean.setGichul_list(rs.getString("gichul_list"));
					bean.setSuip(rs.getInt("suip"));
					bean.setGichul(rs.getInt("gichul"));
					bean.setJan(rs.getInt("jan"));
					bean.setBigo(rs.getString("bigo"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	
	// 출납목록 가져오기  (numb)
		public Bean_Chul getChul2(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Chul bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from cash_chul where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Chul();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setNalja(rs.getString("nalja"));
					bean.setG_suip(rs.getString("g_suip"));
					bean.setG_gichul(rs.getString("g_gichul"));
					bean.setG_cash(rs.getString("g_cash"));
					bean.setG_card(rs.getString("g_card"));
					bean.setG_bank(rs.getString("g_bank"));
					bean.setGichul_list(rs.getString("gichul_list"));
					bean.setSuip(rs.getInt("suip"));
					bean.setGichul(rs.getInt("gichul"));
					bean.setJan(rs.getInt("jan"));
					bean.setBigo(rs.getString("bigo"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	

	// 코드 목록가져오기
	public Vector<Bean_Chul> getChulList(String check, String keyWord, String keyField, String state, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Chul> vlist = new Vector<Bean_Chul>();
		try {

//			System.out.print("usid : ");
//			System.out.println(usid);
			
			con = pool.getConnection();
			if ( (state.equals("관리자")) && (check.equals("N")) ) {
				sql = "select * from cash_chul";
				pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("사용자")) && (check.equals("N")) ) {
				sql = "select * from cash_chul where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);			
			} else if ( (state.equals("관리자")) && (check.equals("S")) ) {
				sql = "select * from cash_chul where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyField + "%");
			}  else if ( (state.equals("사용자")) && (check.equals("S")) ) {
				sql = "select * from cash_chul where (" + keyField + " like ?) and (usid = ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyField + "%");
				pstmt.setString(2, usid);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Chul bean = new Bean_Chul();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setNalja(rs.getString("nalja"));
				bean.setG_suip(rs.getString("g_suip"));
				bean.setG_gichul(rs.getString("g_gichul"));
				bean.setG_cash(rs.getString("g_cash"));
				bean.setG_card(rs.getString("g_card"));
				bean.setG_bank(rs.getString("g_bank"));
				bean.setGichul_list(rs.getString("gichul_list"));
				bean.setSuip(rs.getInt("suip"));
				bean.setGichul(rs.getInt("gichul"));
				bean.setJan(rs.getInt("jan"));
				bean.setBigo(rs.getString("bigo"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 해당 코드 수
	public int getChulCount(String check, String keyWord, String keyField, String state, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if ( (state.equals("관리자")) && (check.equals("N")) ) {
				sql = "select count(numb) from cash_chul";
				pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("사용자")) && (check.equals("N")) ) {
				sql = "select count(numb) from cash_chul where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);			
			} else if ( (state.equals("관리자")) && (check.equals("S")) ) {
				sql = "select count(numb) from cash_chul where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyField + "%");
			}  else if ( (state.equals("사용자")) && (check.equals("S")) ) {
				sql = "select count(numb) from cash_chul where (" + keyField + " like ?) and (usid = ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyField + "%");
				pstmt.setString(2, usid);
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 출납 수정
	public boolean updateChul(Bean_Chul bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update cash_chul set nalja=?, g_suip=?, g_gichul=?, g_cash=?"
					+ ", g_card=?, g_bank=?, gichul_list=?, suip=?, gichul=?, jan=?, bigo=? where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getNalja());
			pstmt.setString(2, bean.getG_suip());
			pstmt.setString(3, bean.getG_gichul());
			pstmt.setString(4, bean.getG_cash());
			pstmt.setString(5, bean.getG_card());
			pstmt.setString(6, bean.getG_bank());
			pstmt.setString(7, bean.getGichul_list());
			pstmt.setInt(8, bean.getSuip());
			pstmt.setInt(9, bean.getGichul());
			pstmt.setInt(10, bean.getJan());
			pstmt.setString(11, bean.getBigo());
			pstmt.setInt(12, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 출납 삭제
	public void deleteChul(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from cash_chul where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	public boolean updateJan(int numb, int imsi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		Bean_Chul bean = new Bean_Chul();
		try {
			con = pool.getConnection();
			String sql = "update cash_chul set jan=? where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, imsi);
			pstmt.setInt(2, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	

/************************************<<요금계산>>*********************************************/
	// 요금자료 추가
	public boolean insertCost(Bean_Cost bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert cash_cost(usid, g_cost, yt_1, yt, total, gum, vat, nabbu) "
					+ "values(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsid());
			pstmt.setString(2, bean.getG_cost());
			pstmt.setInt(3, bean.getYt_1());
			pstmt.setInt(4, bean.getYt());
			pstmt.setInt(5, bean.getYt() - bean.getYt_1());
			pstmt.setDouble(6, bean.getGum());
			pstmt.setInt(7, bean.getVat());
			pstmt.setInt(8, bean.getNabbu());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 요금목록 가져오기  (usid)
		public Bean_Cost getCost(String usid) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Cost bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from cash_cost where usid=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Cost();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setG_cost(rs.getString("g_cost"));
					bean.setYt_1(rs.getInt("yt_1"));
					bean.setYt(rs.getInt("yt"));
					bean.setTotal(rs.getInt("total"));
					bean.setGum(rs.getDouble("gum"));
					bean.setVat(rs.getInt("vat"));
					bean.setNabbu(rs.getInt("nabbu"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	
	// 요금목록 가져오기  (numb)
		public Bean_Cost getCost2(int numb) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Bean_Cost bean = null;
			try {
				con = pool.getConnection();
				String sql = "select * from cash_cost where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, numb);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean = new Bean_Cost();
					bean.setNumb(rs.getInt("numb"));
					bean.setUsid(rs.getString("usid"));
					bean.setG_cost(rs.getString("g_cost"));
					bean.setYt_1(rs.getInt("yt_1"));
					bean.setYt(rs.getInt("yt"));
					bean.setTotal(rs.getInt("total"));
					bean.setGum(rs.getDouble("gum"));
					bean.setVat(rs.getInt("vat"));
					bean.setNabbu(rs.getInt("nabbu"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return bean;
		}
	

	// 요금 목록가져오기
	public Vector<Bean_Cost> getCostList(String check, String keyWord, String keyField, String state, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Bean_Cost> vlist = new Vector<Bean_Cost>();
		try {

//			System.out.print("usid : ");
//			System.out.println(usid);
			
			con = pool.getConnection();
			if ( (state.equals("관리자")) && (check.equals("N")) ) {
				sql = "select * from cash_cost";
				pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("사용자")) && (check.equals("N")) ) {
				sql = "select * from cash_cost where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);			
			} else if ( (state.equals("관리자")) && (check.equals("S")) ) {
				sql = "select * from cash_cost where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyField + "%");
			}  else if ( (state.equals("사용자")) && (check.equals("S")) ) {
				sql = "select * from cash_cost where (" + keyField + " like ?) and (usid = ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyField + "%");
				pstmt.setString(2, usid);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bean_Cost bean = new Bean_Cost();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsid(rs.getString("usid"));
				bean.setG_cost(rs.getString("g_cost"));
				bean.setYt_1(rs.getInt("yt_1"));
				bean.setYt(rs.getInt("yt"));
				bean.setTotal(rs.getInt("total"));
				bean.setGum(rs.getDouble("gum"));
				bean.setVat(rs.getInt("vat"));
				bean.setNabbu(rs.getInt("nabbu"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 해당 요금목록 수
	public int getCostCount(String check, String keyWord, String keyField, String state, String usid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if ( (state.equals("관리자")) && (check.equals("N")) ) {
				sql = "select count(numb) from cash_cost";
				pstmt = con.prepareStatement(sql);
			} else if ( (state.equals("사용자")) && (check.equals("N")) ) {
				sql = "select count(numb) from cash_cost where usid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, usid);			
			} else if ( (state.equals("관리자")) && (check.equals("S")) ) {
				sql = "select count(numb) from cash_cost where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyField + "%");
			}  else if ( (state.equals("사용자")) && (check.equals("S")) ) {
				sql = "select count(numb) from cash_cost where (" + keyField + " like ?) and (usid = ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyField + "%");
				pstmt.setString(2, usid);
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 요금 수정
	public boolean updateCost(Bean_Cost bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update cash_cost set g_cost=?, yt_1=?, yt=?, total=? "
					+ "where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getG_cost());
			pstmt.setInt(2, bean.getYt_1());
			pstmt.setInt(3, bean.getYt());
			pstmt.setInt(4, bean.getYt() - bean.getYt_1());
			pstmt.setInt(5, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 출납 삭제
	public void deleteCost(int numb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "delete from cash_cost where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, numb);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	public boolean updateCo(int numb, int imsi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		Bean_Chul bean = new Bean_Chul();
		try {
			con = pool.getConnection();
			String sql = "update cash_chul set jan=? where numb = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, imsi);
			pstmt.setInt(2, bean.getNumb());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 요금 계산 (총 사용량 계산 total = yt = yt_1)
	public boolean updateCGum(int numb, int total, double gum8, double gum9, double gum10) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update cash_cost set total=?, gum=?, vat=?, nabbu=? where numb=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, total);
			pstmt.setDouble(2, gum8);
			pstmt.setDouble(3, gum9);
			pstmt.setDouble(4, gum10);
			pstmt.setInt(5, numb);
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}