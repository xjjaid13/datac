package com.util;

import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

/**
 * 读取配置文件
 * */
public class IniHandle {
	
	private Properties ini = null;
	
	private IniHandle(){
		
	}
	
	private String iniPath = Init.realPath + "WEB-INF/config.ini";
	
	public void init(){
		ini = new Properties();
		FileInputStream fin = null;
		try {
			fin = new FileInputStream (iniPath);
			ini.load (fin);
		} catch (FileNotFoundException e) {
			Log.Error(getIniPath() + ": 路径未找到.");
		} catch (IOException e) {
			Log.Error("IniHandle 构造函数异常:" + e.getMessage());
		}finally{
			try {
				if(fin != null ){
					fin.close();
				}
			} catch (IOException e) {
				Log.Error("IniHandle.setIniPath throws a exception : " + e.getMessage());
			}
		}
	}
	
	private static IniHandle iniHandle = new IniHandle();
	
	public static IniHandle getIniHandle(){
		return iniHandle;
	}
	
	/**
	 * 读取INI信息
	 * */
	public String getIniKey (String key) {
		if(!ini.containsKey (key)) {
			return "";
		}
		return ini.get(key).toString ();
	}
	/**
	 * 修改INI信息
	 * */
	public void setIniKey (String key, String value) {
		if(!ini.containsKey (key)) {
			return;
		}
		ini.put (key, value);
	}
	/**
	 * 保存INI信息
	 * */
	public void saveIni(String k[]) {
		try	{
			FileWriter fw = new FileWriter (iniPath);
			BufferedWriter bw = new BufferedWriter (fw);
			for (int i = 0; i < k.length; i++) {
				bw.write (k[i] + "=" + getIniKey (k[i]));
				bw.newLine ();
			}
			bw.close ();
			fw.close ();
		}catch (Exception ex) {
			Log.Error("IniHandle.saveIni() throw a exception:" + ex.getMessage());
		}
	}
	
	public static void main(String[] args) throws FileNotFoundException, IOException{
		Properties p = new Properties();
		p.load(new FileInputStream("D:/test.ini"));
		Set s = p.keySet();
		Iterator<String> it = s.iterator();
		while(it.hasNext()){
			System.out.println(it.next());
		}
	}

	public void setIniPath(String iniPath) {
		this.iniPath = iniPath;
	}

	public String getIniPath() {
		return iniPath;
	}
	
}

