package org.kiosk.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public abstract class SQLTemplate implements SQLFragment {
	
	protected Connection con;
	protected PreparedStatement pstmt;
	protected ResultSet rs;

	private Connection getConnection()throws Exception {
		
		return JrDataSource.INSTANCE.getConnection();
	}
	
	public void execute()throws Exception {		
		try {
			con = getConnection();
			runSQL();			
//			System.out.println("222...ResultSet: " + rs);
//			System.out.println("222...PreparedStatement: " + pstmt);
//			System.out.println("222...Connection : " + con);
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll(con,pstmt,rs);
		}
		
	}

	private void closeAll(Connection con, 
			PreparedStatement pstmt, 
			ResultSet rs) {
		
//		System.out.println("333...ResultSet: " + rs);
//		System.out.println("333...PreparedStatement: " + pstmt);
//		System.out.println("333...Connection : " + con);
		
		if(rs != null){ 
			try { 	rs.close();	}catch(Exception e) {} 
		}
		if(pstmt != null){ 
			try { 	pstmt.close();	}catch(Exception e) {} 
		}
		if(con != null){ 
			try { 	con.close();}catch(Exception e) {} 
		}		
	}
}