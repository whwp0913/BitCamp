package org.kiosk.data;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import lombok.extern.log4j.Log4j;

@Log4j
public class MenuDAO {

	// 분류 별 데이터
	public static final String SELECTALL = "SELECT * FROM TBL_MENU WHERE SELLCHECK LIKE 'Y' AND MCLASS LIKE ? AND ENO = 0";

	// 이벤트 상품 데이터
	public static final String EVENTSELECT = "SELECT * FROM TBL_MENU WHERE SELLCHECK LIKE 'Y' AND ENO > 0";

	// 장바구니에 담을 데이터
	public static final String CHOICE = "select * from tbl_menu where mno = ?";

	// (1-order)takeout, sellstate 담기
	public static final String CREATEONO = "INSERT INTO TBL_ORDER (ONO, TAKEOUT, SELLSTATE)\r\n"
			+ "VALUES (SEQ_ORDER.NEXTVAL, ?, ?)";

	// (2-order)주문 목록 담기
	public static final String INSETORDERS = "INSERT INTO TBL_ORDERITEM (OINO, MNO, ONO, AMOUNT, SPRICE)\r\n"
			+ "VALUES (SEQ_ORDERITEM.NEXTVAL, ?, SEQ_ORDER.CURRVAL, ?, ?)";

	// (3-order)주문 목록들 하나로 저장하기
	public static final String CREATEORDER = "UPDATE TBL_ORDER SET TOTAL = \r\n"
			+ "    (SELECT SUM(AMOUNT * SPRICE) TOTALS\r\n" + "    FROM TBL_ORDERITEM WHERE ONO = ?) \r\n"
			+ "WHERE ONO = ?";

	// 주문 번호 갖고 오기
	public static final String GETONO = "select max(ono) ono from tbl_order";

	public int getONO() throws Exception {
		List<Integer> ono = new ArrayList<>();

		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(GETONO);
				rs = pstmt.executeQuery();

				log.info(pstmt);
				while (rs.next()) {
					ono.add(rs.getInt("ono"));
					log.info("==================" + ono.get(0));
				}
				log.info("=================" + ono.get(0));
			}
		}.execute();

		return ono.get(0);
	}

	public void finalOrder(int ono) throws Exception {

		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(CREATEORDER);
				pstmt.setInt(1, ono);
				pstmt.setInt(2, ono);
				pstmt.executeUpdate();
			}
		}.execute();

	}

	public void insertOrders(Map<String, MenuVO> cookieMap) throws Exception {

		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(INSETORDERS);
				log.info("cookiemap : " + cookieMap);
				for (Map.Entry<String, MenuVO> cookie : cookieMap.entrySet()) {
					MenuVO vo = cookieMap.get(cookie.getKey());
					
					log.info("amount========================================================================="+vo.getAmount());
					// for(int i = 0 ; i < cookieMap.size() ; i ++) {
					// MenuVO vo = cookieMap.get(cookieMap.get());
					log.info(
							"=========================================================================================ddd"
									+ vo.getMno());
					pstmt.setInt(1, vo.getMno());
					pstmt.setInt(2, vo.getAmount());
					pstmt.setInt(3, vo.getMprice());
					pstmt.executeUpdate();
				}
			}
		}.execute();

	}

	public void insertONO(int takeout) throws Exception {

		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(CREATEONO);
				pstmt.setInt(1, takeout);
				pstmt.setString(2, "Y");
				pstmt.executeUpdate();
			}
		}.execute();

	}

	public List<MenuVO> getSpeical() throws Exception {
		List<MenuVO> list = new ArrayList<>();

		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {

				pstmt = con.prepareStatement(EVENTSELECT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					MenuVO vo = new MenuVO();
					vo.setMno(rs.getInt(1));
					vo.setMname(rs.getString(2));
					vo.setMprice(rs.getInt(3));
					vo.setImg(rs.getString(4));
					vo.setDiscost(rs.getInt(5));
					vo.setMclass(rs.getString(6));
					vo.setSellcheck(rs.getString(7));
					vo.setRegdate(rs.getDate(8));
					vo.setUpdatedate(rs.getDate(9));
					vo.setEno(rs.getInt(10));

					list.add(vo);

				}
			}
		}.execute();

		return list;
	}

	public List<MenuVO> getList(String mclass) throws Exception {

		List<MenuVO> list = new ArrayList<>();
		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {

				pstmt = con.prepareStatement(SELECTALL);
				pstmt.setString(1, mclass);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					MenuVO vo = new MenuVO();
					vo.setMno(rs.getInt(1));
					vo.setMname(rs.getString(2));
					vo.setMprice(rs.getInt(3));
					vo.setImg(rs.getString(4));
					vo.setDiscost(rs.getInt(5));
					vo.setMclass(rs.getString(6));
					vo.setSellcheck(rs.getString(7));
					vo.setRegdate(rs.getDate(8));
					vo.setUpdatedate(rs.getDate(9));
					vo.setEno(rs.getInt(10));

					list.add(vo);

				}
			}
		}.execute();
		return list;
	}

	public List<MenuVO> getEventList() throws Exception {
		List<MenuVO> list = new ArrayList<>();

		new SQLTemplate() {
			@Override
			public void runSQL() throws Exception {
				pstmt = con.prepareStatement(EVENTSELECT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					MenuVO vo = new MenuVO();

					vo.setMno(rs.getInt("mno"));
					vo.setMname(rs.getString("mname"));
					vo.setMprice(rs.getInt("discost"));
					vo.setImg(rs.getString("img"));
					// vo.setDiscost(rs.getInt("discost"));
					vo.setMclass(rs.getString("mclass"));
					vo.setSellcheck(rs.getString("sellcheck"));
					vo.setRegdate(rs.getDate("regdate"));
					vo.setUpdatedate(rs.getDate("updatedate"));
					vo.setEno(rs.getInt("eno"));

					list.add(vo);
				}
			}
		}.execute();
		return list;
	}

	public List<MenuVO> choice(String mno) throws Exception {

		List<MenuVO> list = new ArrayList<>();
		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {

				pstmt = con.prepareStatement(CHOICE);
				pstmt.setString(1, mno);
				rs = pstmt.executeQuery();

				while (rs.next()) {

					MenuVO vo = new MenuVO();
					vo.setMno(rs.getInt(1));
					vo.setMname(rs.getString(2));
					vo.setMprice(rs.getInt(3));
					vo.setImg(rs.getString(4));
					vo.setDiscost(rs.getInt(5));
					vo.setMclass(rs.getString(6));
					vo.setSellcheck(rs.getString(7));
					vo.setRegdate(rs.getDate(8));
					vo.setUpdatedate(rs.getDate(9));
					vo.setEno(rs.getInt(10));
				

					list.add(vo);
				}
			}
		}.execute();
		return list;
	}

	public MenuVO choiceVO(String mno) throws Exception {

		List<MenuVO> list = new ArrayList<>();
		new SQLTemplate() {

			@Override
			public void runSQL() throws Exception {

				pstmt = con.prepareStatement(CHOICE);
				pstmt.setString(1, mno);
				rs = pstmt.executeQuery();

				while (rs.next()) {

					MenuVO vo = new MenuVO();
					vo.setMno(rs.getInt(1));
					vo.setMname(rs.getString(2));
					vo.setMprice(rs.getInt(3));
					vo.setImg(rs.getString(4));
					vo.setDiscost(rs.getInt(5));
					vo.setMclass(rs.getString(6));
					vo.setSellcheck(rs.getString(7));
					vo.setRegdate(rs.getDate(8));
					vo.setUpdatedate(rs.getDate(9));
					vo.setEno(rs.getInt(10));

					list.add(vo);
				}
			}
		}.execute();
		return list.get(0);
	}
}
