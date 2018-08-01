package org.manager.data;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.extern.log4j.Log4j;

@Log4j
public class AdminDAO {

	// 이벤트 추가 쿼리
	public static final String INSERTEVENT = "INSERT INTO TBL_EVENT (ENO, ENAME, DRATE, DCOUNT, SDAY, EDAY)\r\n" + 
			"VALUES (SEQ_EVENT.NEXTVAL, ?, 1 - (? / 100), ?, ?, ?)";
	// 이벤트 리스트 다 가져오기
	public static final String EPAGING = "SELECT *\r\n" + 
			"FROM (\r\n" + 
			"    SELECT ROWNUM RN, ENO, ENAME, DRATE, DCOUNT, SDAY, EDAY /*+ IDEX DESC(TBL_EVENT PK_EVENT) */\r\n" + 
			"    FROM TBL_EVENT WHERE ROWNUM <= (10 * ?) AND ENO > 0 ORDER BY ENO DESC\r\n" + 
			"    )\r\n" + 
			"WHERE RN > 10 * (? - 1)"; 
	// 컨텐츠의 총 개수 구하기
	public static final String PAGECOUNT = "SELECT COUNT(*) FROM TBL_MENU";
	// 이벤트 개수
	public static final String EVENTCOUNT = "SELECT COUNT(*) FROM TBL_EVENT";
	// 관리자 계정 불러오기
	public static final String GETADMIN = "SELECT USERID FROM TBL_USERS WHERE USERID = ? AND USERPW = ?";
	// 컨텐츠 가져오기
	public static final String PAGING = "SELECT *  FROM (SELECT ROWNUM RN, MNO, MNAME, MPRICE, IMG, MCLASS, REGDATE, UPDATEDATE /*+ INDEX DESC(TBL_MENU PK_MENU) */ FROM TBL_MENU WHERE ROWNUM <= (10 * ?) AND MNO > 0 ) WHERE RN > 10 * (? - 1)";
	// 특정 상품 가져오기
	public static final String GETPRODUCT = "SELECT * FROM TBL_MENU WHERE MNO = ?";
	//
	public static final String GETEVENT = "SELECT * FROM TBL_EVENT WHERE ENO = ?";
	// 수정하기
	public static final String UPDATEPRODUCT = "UPDATE TBL_MENU \r\n"
			+ "SET MNAME = ?, MPRICE = ?, MCLASS = ?, SELLCHECK = ?, UPDATEDATE = SYSDATE, ENO = ? WHERE MNO = ?";
	// 삭제하기
	public static final String DELETEPRODUCT = "DELETE FROM TBL_MENU WHERE MNO = ?";
	// 등록하기
	public static final String INSERTPRODUCT = "INSERT INTO TBL_MENU (MNO, MNAME, MPRICE, IMG, MCLASS, SELLCHECK) VALUES "
			+ "(SEQ_MENU.NEXTVAL, ?, ?, ?, ?, ?)";
	public static final String DELETEEVENT = "DELETE FROM TBL_EVENT WHERE ENO = ?";
	
	// -- 할인%, 할인가격, 할인시작, 할인종료
	public void insertEvent(String[] values) throws Exception {
		
		new SQLTemplate() {
			
			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(INSERTEVENT);
				pstmt.setString(1, values[0]);
				pstmt.setDouble(2, Double.parseDouble(values[1]));
				pstmt.setInt(3, Integer.parseInt(values[2]));
				pstmt.setDate(4, Date.valueOf(values[3]));
				pstmt.setDate(5, Date.valueOf(values[4]));
				pstmt.executeUpdate();
			}
		}.execute();
		
	}
	
	public void insertProduct(String[] values) throws Exception {
		new SQLTemplate() {
			
			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(INSERTPRODUCT);
				pstmt.setString(1, values[0]);
				pstmt.setInt(2, Integer.parseInt(values[1]));
				pstmt.setString(3, values[2]);
				pstmt.setString(4, values[3]);
				pstmt.setString(5, values[4]);
				pstmt.executeUpdate();
			}
		}.execute();
	}
	
	public void deleteProduct(int mno) throws Exception {

		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(DELETEPRODUCT);
				pstmt.setInt(1, mno);
				pstmt.executeUpdate();

			}
		}.execute();
	}

	public void updateProduct(String[] values) throws Exception {

		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(UPDATEPRODUCT);
				pstmt.setString(1, values[1]);
				pstmt.setInt(2, Integer.parseInt(values[2]));
				pstmt.setString(3, values[4]);
				pstmt.setString(4, values[6]);
				pstmt.setInt(5, Integer.parseInt(values[9]));
				pstmt.setInt(6, Integer.parseInt(values[0]));
				pstmt.executeUpdate();
			}
		}.execute();

	}

	public MenuVO getProduct(String mno) throws Exception {
		List<MenuVO> list = new ArrayList<>();
		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(GETPRODUCT);
				pstmt.setString(1, mno);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					MenuVO vo = new MenuVO();
					vo.setMno(rs.getInt("MNO"));
					vo.setMname(rs.getString("MNAME"));
					vo.setMprice(rs.getInt("MPRICE"));
					vo.setImg(rs.getString("IMG"));
					vo.setDiscost(rs.getInt("DISCOST"));
					vo.setMclass(rs.getString("MCLASS"));
					vo.setSellcheck(rs.getString("SELLCHECK"));
					vo.setRegdate(rs.getDate("REGDATE"));
					vo.setUpdatedate(rs.getDate("UPDATEDATE"));
					vo.setEno(rs.getInt("ENO"));

					list.add(vo);
				}
			}
		}.execute();
		return list.get(0);
	}

	public int getEventTotal() throws Exception {
		List<Integer> list = new ArrayList<>();
		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				
				pstmt = con.prepareStatement(EVENTCOUNT); // 애는 숫자반환
				rs = pstmt.executeQuery();
				while (rs.next()) {
					list.add(rs.getInt(1));
					
				}
			}
		}.execute();
		return list.get(0);
	}
	
	public int getPageTotal() throws Exception {
		List<Integer> list = new ArrayList<>();
		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				
				pstmt = con.prepareStatement(PAGECOUNT); // 애는 숫자반환
				rs = pstmt.executeQuery();
				while (rs.next()) {
					list.add(rs.getInt(1));
					
				}
			}
		}.execute();
		return list.get(0);
	}

	public boolean loginCheck(String id, String pw) throws Exception { // 여기에 예외를 던졌습니다 그런데 왜 또 try catch를 하십니까
		List<Boolean> check = new ArrayList<>();
		log.info("loginCheck에 들어왔지롱~~~~~~~~~~");
		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				log.info("runSQL에 들어왔지롱~~~~~~~~~~");
				pstmt = con.prepareStatement(GETADMIN);
				pstmt.setString(1, id);
				pstmt.setString(2, pw);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String name = rs.getString("USERID");
					log.info(name);
					if (id.equals(name)) {
						check.add(true);
					}
				}
				check.add(false);
			}

		}.execute();

		log.info("그냥 해봤지롱~~~~~~~~~~");
		return check.get(0);

	}

	public void getPage(int pageNum) throws Exception {

	}

	// dao 기능이 게시물뿌려주는거
	public List<MenuVO> getList(int pageNum) throws Exception {
		List<MenuVO> list = new ArrayList<>();

		new SQLTemplate() {
			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(PAGING);

				pstmt.setInt(1, pageNum);
				pstmt.setInt(2, pageNum);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					MenuVO vo = new MenuVO();
					vo.setMno(rs.getInt("MNO"));
					vo.setMname(rs.getString("MNAME"));
					vo.setMprice(rs.getInt("MPRICE"));
					vo.setImg(rs.getString("IMG"));
					vo.setMclass(rs.getString("MCLASS"));
					vo.setRegdate(rs.getDate("REGDATE"));
					vo.setUpdatedate(rs.getDate("UPDATEDATE"));

					list.add(vo);
				}
			}
		}.execute();

		return list;
	}

	public List<EventVO> getEvent(int pageNum) throws Exception {
		List<EventVO> list = new ArrayList<>();

		new SQLTemplate() {
			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(EPAGING);

				pstmt.setInt(1, pageNum);
				pstmt.setInt(2, pageNum);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					EventVO vo = new EventVO();
					vo.setEno(rs.getInt(2));
					vo.setEname(rs.getString(3));
					vo.setDrate(rs.getDouble(4));
					vo.setDcount(rs.getInt(5));
					vo.setSday(rs.getDate(6));
					vo.setEday(rs.getDate(7));
					
					list.add(vo);
				}
			}
		}.execute();

		return list;
	}
	
	public EventVO getEvent(String eno) throws Exception {
		List<EventVO> list = new ArrayList<>();
		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(GETEVENT);
				pstmt.setString(1, eno);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					EventVO vo = new EventVO();
					vo.setEno(rs.getInt("ENO"));
					vo.setEname(rs.getString("ENAME"));
					vo.setDrate(rs.getDouble("DRATE"));
					vo.setDcount(rs.getInt("DCOUNT"));
					vo.setSday(rs.getDate("SDAY"));
					vo.setEday(rs.getDate("EDAY"));

					list.add(vo);
				}
			}
		}.execute();
		return list.get(0);
	}
	
	public void eventDelete(int eno) throws Exception{
		new SQLTemplate() {
			
			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(DELETEEVENT);
				pstmt.setInt(1, eno);
				pstmt.executeUpdate();
			}
		}.execute();
		
	}
}
