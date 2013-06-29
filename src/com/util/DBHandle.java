/**
 * 
 */
package com.util;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author cloud
 * 数据库操作类
 */
public class DBHandle {
	
	private Connection conn = null;
	
	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	private Statement st = null;
	
	private ResultSet rs = null;
	
	private ResultSetMetaData rsm = null;
	
	private String align = "db";
	
	/** 根据连接池标志打开获得一个连接 */
	public void openConn(){
		try{
			conn = DriverManager.getConnection("proxool." + align);
			st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		}catch(Exception e){
			Log.Error("数据库连接池获得失败:" + e.getMessage());
		}
	}
	
	public void openConnMysql(){
		String strDirverPath = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://127.0.0.1:3306/fastjavaproject?characterEncoding=utf-8";
		try {
			Class.forName(strDirverPath);
			conn = DriverManager.getConnection(url,"root","111111");
			st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/** 获取sql中所有列 */
	public String[] getColumns(String sql) {
		String[] strData = null;
		try {
			rs = st.executeQuery(sql);
			rsm = rs.getMetaData();
			strData = new String[rsm.getColumnCount()];
			for(int i = 0; i < rsm.getColumnCount(); i++) {
				String colname =  rsm.getColumnName(i + 1) + "";
				strData[i] =  "".equals(colname) ? "未命名列" : colname;
			}
			return strData;
		} catch (SQLException e) {
			Log.Error("DBHandle.getColumns 执行异常,参数 " + sql + " :" + e.getMessage());
		}
		return strData;
	}
	
	/**
	 * 存储过程查询数据
	 * @param sql
	 * @return
	 */
	public String[] callOption(String sql) {
		String[] call = null;
		try {
			CallableStatement cs = conn.prepareCall(sql);
			rs = cs.executeQuery(sql);
			call = new String[30];
			while(rs.next()){
				for(int i = 0; i < call.length; i++){
					call[i] = rs.getString(i+1);
				}
			}
		}catch(Exception e){
			Log.Error("DBHandle.callOption throws a exception : " + e.getMessage());
		}
		return call;
	}
	
	/**
	 * 查询数据
	 * @param sql
	 * @return
	 */
	public String[][] executeQuery(String sql) {
		try {
			rs = st.executeQuery(sql);
			rsm = rs.getMetaData();
			int countRow = getNumRow(rs);
			if( countRow != 0 ) {
				String[][] strData = new String[countRow][rsm.getColumnCount()];
				int i = 0;
				while(rs.next()) {
					for(int j = 0; j < rsm.getColumnCount(); j ++) {
						strData[i][j] =  rs.getString(j + 1) + "";
					}
					i++;
				}
				rs.close();
				return strData;
			}
		} catch (SQLException e) {
			Log.Error("sql语句 "+sql+" 查询异常 :" + e.getMessage());
		} catch (OutOfMemoryError e){
			Log.Error("sql语句 "+sql+" 内存溢出 :" + e.getMessage());
		}
		return null;
	}
	
	/** 查询第一行数据 */
	public String[] executeOneQuery(String sql){
		try {
			rs = st.executeQuery(sql);
			rsm = rs.getMetaData();
			int countRow = getNumRow(rs);
			if( countRow != 0 ) {
				String[] strData = new String[rsm.getColumnCount()];
				if(rs.next()) {
					for(int j = 0; j < rsm.getColumnCount(); j ++) {
						strData[j] =  rs.getString(j + 1) + "";
					}
				}
				rs.close();
				return strData;
			}
		} catch (SQLException e) {
			Log.Error("sql语句 "+sql+" 查询异常 :" + e.getMessage());
		} catch (OutOfMemoryError e){
			Log.Error("sql语句 "+sql+" 内存溢出 :" + e.getMessage());
		}
		return null;
	}
	
	/** 返回第一行第一列 */
	public String singleQuery(String sql) {
		try {
			rs = st.executeQuery(sql);
			rsm = rs.getMetaData();
			int countRow = getNumRow(rs);
			if( countRow != 0 ) {
				String[][] strData = new String[countRow][rsm.getColumnCount()];
				int i = 0;
				while(rs.next()) {
					for(int j = 0; j < rsm.getColumnCount(); j ++) {
						strData[i][j] =  rs.getString(j + 1) + "";
					}
					i++;
				}
				rs.close();
				return DataHandle.handleValue(strData[0][0]);
			}
		} catch (SQLException e) {
			Log.Error("sql语句 "+sql+" 查询异常 :" + e.getMessage());
		} catch (OutOfMemoryError e){
			Log.Error("sql语句 "+sql+" 内存溢出 :" + e.getMessage());
		}
		return "";
	}
	
	public String returnPicPath(String sw_id){
		if("".equals(sw_id) || sw_id == null){
			return "";
		}
		String strSch = "SELECT CONCAT(b.sw_domain,a.sw_path) FROM front_pic a,front_pic_server b WHERE a.sw_server_id = b.sw_id AND a.sw_id = '"+sw_id+"'";
		return DataHandle.handleValue(singleQuery(strSch));
	}
	
	public String returnPicPath(String sw_id,String sw_size){
		if("".equals(sw_id) || sw_id == null){
			return "";
		}
		String strSch = "SELECT CONCAT(b.sw_domain,a.sw_path) FROM front_"+sw_size+"_pic a,front_pic_server b WHERE a.sw_server_id = b.sw_id AND a.sw_id = '"+sw_id+"'";
		return DataHandle.handleValue(singleQuery(strSch));
	}
	
	public String getCutSql(String sql,int start,int end){
		return SqlHandle.createMysqlPagingSql_SE(sql, start, end);
	}
	
	/**
	 * 查询分页数据
	 * @param sql
	 * @return
	 */
	public String[][] executeQuery(String sql,int start,int end) {
		try {
			sql = getCutSql(sql,start,end);
			rs = st.executeQuery(sql);
			rsm = rs.getMetaData();
			int countRow = DBHandle.getNumRow(rs);
			if( countRow != 0 ) {
				String[][] strData = new String[countRow][rsm.getColumnCount()];
				int i = 0;
				while(rs.next()) {
					for(int j = 0; j < rsm.getColumnCount(); j ++) {
						strData[i][j] =  rs.getString(j + 1) + "";
					}
					i++;
				}
				rs.close();
				return strData;
			}else{
				return null;
			}
		} catch (SQLException e) {
			Log.Error("分页查询sql语句异常 :" + sql + ", " + start + "," + end);
			return null;
		}
	}
	
	public void openTransaction() throws SQLException{
		try{
			conn = DriverManager.getConnection("proxool." + align);
			conn.setAutoCommit(false);
			st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		}catch(Exception e){
			Log.Error("数据库连接池获得失败:" + e.getMessage());
		}
	}
	
	public void openTransaction_nopool(){
		String strDirverPath = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://127.0.0.1:3306/yuqiao?characterEncoding=utf-8";
		try {
			Class.forName(strDirverPath);
			conn = DriverManager.getConnection(url,"root","8s3y6k5y2p");
			conn.setAutoCommit(false);
			st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void submitTransaction() throws SQLException{
		conn.commit();
		conn.setAutoCommit(true);
	}
	
	public void rollback(String message){
		try {
			conn.rollback();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			Log.Error("事务回滚失败!:"+message);
			e.printStackTrace();
		}
	}
	
	/**
	 * 返回表中字段的类型
	 * @param tablename
	 * @param columnname
	 * */
	public int getColumnType(String tablename,String columnname){
		try{
			rs = st.executeQuery("SELECT * FROM "+tablename+" WHERE 1=0");
			rsm = rs.getMetaData();
			for(int i = 1;i <= rsm.getColumnCount();i++){
				if(rsm.getColumnName(i).equals(columnname)){
					return rsm.getColumnType(i);
				}
			}
		}catch(SQLException e){
			Log.Error("返回表中字段类型异常.参数 " + tablename + "," + columnname + ". :" + e.getMessage());
		}
		return 0;
	}
	
	public boolean isString(int fieldType){
		if(fieldType == Types.TINYINT || fieldType == Types.SMALLINT || fieldType == Types.INTEGER
				|| fieldType == Types.DOUBLE || fieldType == Types.NUMERIC){
			return false;
		}else{
			return true;
		}
	}
	
	public int returnCount(String tableName){
		String sql = "SELECT COUNT(1) FROM " + tableName;
		String[][] s = executeQuery(sql);
		return DataHandle.StringToInt(s[0][0]);
	}
	
	public int returnCountWhere(String whereCon,String tableName){
		String sql;
		if(whereCon!=null && !"".equals(whereCon)){
			sql = "SELECT COUNT(1) FROM " + tableName+" WHERE 1=1 AND "+whereCon;
		}else{
			sql = "SELECT COUNT(1) FROM " + tableName;
		}
		String[][] s = executeQuery(sql);
		if(s == null || s.length == 0){
			return 0;
		}
		return DataHandle.StringToInt(s[0][0]);
	}
	
	public String returnIsString(String tableName,String columnName,String fieldValue){
		int fieldType = getColumnType(tableName, columnName);
		if(!isString(fieldType)){
			if(fieldValue == null || fieldValue.equals("")){
				fieldValue = "0";
			}
			return fieldValue;
		}else{
			return "'" + fieldValue + "'";
		}
	}
	
	/**
	 * 操作数据库
	 * @param sql
	 */
	public boolean executeUpdate(String sql) {
		int i_id = 0;
		try {
			i_id = st.executeUpdate(sql);
		} catch (SQLException e) {
			Log.Error("执行sql语句 "+sql+" 异常:" + e.getMessage());
		}
		if(i_id != 1){
			return false;
		}else{
			return true;
		}
	}
	
	public boolean executeUpdateTransaction(String sql) throws SQLException {
		int i_id = st.executeUpdate(sql);
		if(i_id != 1){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 关闭数据库连接
	 *
	 */
	public void closeConn() {
		try {
			if(st != null) {
				st.close();
			}
			if(conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			Log.Error("关闭数据库连接异常:" + e.getMessage());
		}
	}
	
	/**
	 * 关闭数据库连接
	 *
	 */
	public void closeConn(Connection con) {
		try {
			if(con != null) {
				con.close();
			}
		} catch (SQLException e) {
			Log.Error("关闭数据库连接异常:" + e.getMessage());
		}
	}
	
	public ArrayList<String> getPrimaryKey(String tableName){
		ArrayList<String> list = new ArrayList<String>();
		try {
			DatabaseMetaData dbMeta = conn.getMetaData();
			ResultSet pkRSet = dbMeta.getPrimaryKeys(null, null, tableName);
			while(pkRSet.next()){
				String pkName = (String)pkRSet.getObject("COLUMN_NAME");
				list.add(pkName);
			}
		} catch (SQLException e) {
			Log.Error("查询主键异常:" + e.getMessage());
		}
		return list;
	}
	
	/**
	 * 表是否存在
	 * true 存在
	 * false 不存在
	 * */
	public boolean isExist(String tableName,String where){
		if(where == null || where.length() == 0){
			where = " 1=1 ";
		}
		String strSch = "SELECT 1 FROM " + tableName + " WHERE " + where;
		String[][] sqlSch = executeQuery(strSch);
		if(sqlSch == null || sqlSch.length == 0){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 得到行数
	 * @param rs
	 * @return
	 */
	public static int getNumRow(ResultSet rs) {
		int count = 0;
		try {
			if(rs.last()) {
				count = rs.getRow();
				rs.beforeFirst();
			}
		} catch (SQLException e) {
			Log.Error("DBHandle.getNumRow throws a exception : " + e.getMessage());
		}
		return count;
	}
	
	public static void main(String[] args){
//		DBHandle db = new DBHandle();
//		db.openConnMysql();
//		String strProvice = "SELECT sw_id,sw_name FROM ht_province";
//		String[][] strSch = db.executeQuery(strProvice);
//		int temCity = 0;
//		for(int i = 0; strSch != null && i < strSch.length; i++){
//			String sw_province_id = DataHandle.handleValue(strSch[i][0]);
//			String sw_province_name = DataHandle.handleValue(strSch[i][1]);
//			int temProvince = i+1;
//			String insertProvince = "INSERT com_province (id,name) VALUES ("+temProvince+",'"+sw_province_name+"')";
//			db.executeUpdate(insertProvince);
//			
//			String strCity = "SELECT sw_id,sw_name FROM ht_city WHERE sw_province_id = '"+sw_province_id+"'";
//			String[][] sqlCity = db.executeQuery(strCity);
//			for(int j = 0; sqlCity != null && j < sqlCity.length; j++){
//				String sw_city_id = DataHandle.handleValue(sqlCity[j][0]);
//				String sw_city_name = DataHandle.handleValue(sqlCity[j][1]);
//				temCity = temCity + 1;
//				String insertCity = "INSERT com_city (id,name,province_id) VALUES ("+temCity+",'"+sw_city_name+"',"+temProvince+")";
//				db.executeUpdate(insertCity);
//				
//				String strSection = "SELECT sw_id,sw_name FROM ht_section WHERE sw_city_id = '"+sw_city_id+"'";
//				String[][] sqlSection = db.executeQuery(strSection);
//				for(int z = 0;sqlSection != null && z < sqlSection.length; z++ ){
//					String sw_section_name = DataHandle.handleValue(sqlSection[z][1]);
//					String insertSection = "INSERT com_section (name,city_id) VALUES ('"+sw_section_name+"',"+temCity+")";
//					db.executeUpdate(insertSection);
//				}
//			}
//		}
//		//db.executeUpdate(sql);
//		db.closeConn();
//		System.out.println("over");
		
		DBHandle db = new DBHandle();
		db.openConnMysql();
		//String[][] pageTem = db.executeQuery("SELECT ");
		db.closeConn();
		
		String content = FileHandle.readFile("D:/a.txt");
		Pattern pattern = Pattern.compile("<a(.*?)'(.*?)'(.*?)>(.*?)</a>");
		Matcher matcher = pattern.matcher(content);
		HashMap<String,String> sectionMap = new HashMap<String,String>();
		while(matcher.find()){
			sectionMap.put(matcher.group(2), matcher.group(4));
		}
		
//		String content1 = FileHandle.readFile("D:/b.txt");
//		Pattern pattern1 = Pattern.compile("<a(.*?)/(.*?)</a>");
//		Matcher matcher1 = pattern1.matcher(content1);
//		HashMap<String,String> sectionMap1 = new HashMap<String,String>();
//		while(matcher1.find()){
//			sectionMap1.put(matcher1.group(1), matcher1.group(2));
//		}
		
		File parentFile = new File("D:/file");
		File[] fileCity = parentFile.listFiles();
		for(int i = 0;fileCity != null && i < fileCity.length; i++){
			
			File cityFile = fileCity[i];
			String cityName = sectionMap.get(cityFile.getName());
			String citySch = "SELECT id FROM com_city WHERE name like '%"+cityName+"%'";
			String cityId = db.singleQuery(citySch);
			/** 查询城市id */
			File[] fileType = cityFile.listFiles();
			for(int j = 0;fileType != null && j < fileType.length; j++){
				File typeFile = fileType[j];
				String typeName = typeFile.getName();
				String typeId = returnTypeId(typeName);
				File[] fileHtml = typeFile.listFiles();
				for(int z = 0; fileHtml != null && z < fileHtml.length; z++){
					
					//System.out.println(fileHtml[z].getName());
				}
			}
			
		}
		
//		ArrayList arrCity = new ArrayList();
//		String content = FileHandle.readFile("D:/a.txt");
//		Pattern pattern = Pattern.compile("<a(.*?)'(.*?)'(.*?)>(.*?)</a>");
//		Matcher matcher = pattern.matcher(content);
//		HashMap<String,String> sectionMap = new HashMap<String,String>();
//		while(matcher.find()){
//			arrCity.add(matcher.group(2));
//		}
//		
//		ArrayList partArr = new ArrayList();
//		String content1 = FileHandle.readFile("D:/b.txt");
//		Pattern pattern1 = Pattern.compile("<a(.*?)/(.*?)</a>");
	}
	
	public static String returnTypeId(String typeName){
		if("xueshengjianzhi".equals(typeName)){
			return "18";
		}else if("xiaoshoucuxiao".equals(typeName)){
			return "5";
		}else if("fachuandan".equals(typeName)){
			return "6";
		}else if("canyinfuwu".equals(typeName)){
			return "15";
		}else if("jianzhifwy".equals(typeName)){
			return "16";
		}else if("jzjigong".equals(typeName)){
			return "11";
		}else if("kefushichang".equals(typeName)){
			return "7";
		}else if("jisuanjiwl".equals(typeName)){
			return "9";
		}else if("computer".equals(typeName)){
			return "9";
		}else if("jianjizhizuo".equals(typeName)){
			return "3";
		}else if("jzsoftware".equals(typeName)){
			return "9";
		}else if("jzbuxian".equals(typeName)){
			return "9";
		}else if("peisongyuan".equals(typeName)){
			return "4";
		}else if("jiaoyupeixun".equals(typeName)){
			return "1";
		}else if("yuyanwenzi".equals(typeName)){
			return "13";
		}else if("jzphoto".equals(typeName)){
			return "3";
		}else if("liyiyanyi".equals(typeName)){
			return "2";
		}else if("jzwenyi".equals(typeName)){
			return "15";
		}else if("partime".equals(typeName)){
			return "18";
		}
		return "";
	}
}
