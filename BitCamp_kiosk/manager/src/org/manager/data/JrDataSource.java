package org.manager.data;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.pool.impl.GenericObjectPool;

public enum JrDataSource {

	INSTANCE;
	
    public static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
    public static final String URL = "jdbc:oracle:thin:@10.10.10.37:1521:XE";
    public static final String USERNAME = "kiosk";
    public static final String PASSWORD = "1234";
	
	private DataSource ds;
	
	JrDataSource(){
		try {
			
			Class.forName(DRIVER);
			GenericObjectPool connectionPool 
					= new GenericObjectPool();
			
			connectionPool.setMinIdle(10);
	        connectionPool.setMaxActive(30);
	        
	        ConnectionFactory cf = 
	        		new DriverManagerConnectionFactory(
	                  URL,
	                  USERNAME,
	                  PASSWORD);
	        PoolableConnectionFactory pcf =
	                new PoolableConnectionFactory(cf, connectionPool,
	                        null, null, false, true);

	        ds = new PoolingDataSource(connectionPool);		
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection()throws Exception {
		return ds.getConnection();
	}
	
}