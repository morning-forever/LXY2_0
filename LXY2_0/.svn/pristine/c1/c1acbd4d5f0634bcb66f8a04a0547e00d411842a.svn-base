package com.lx.util.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

/**
 * 加载首页菜单 和菜单连接
 * 
 * @author xq
 * @date <br>
 *       2014-10-8
 * 
 */
public class ConfigLoad {
	
	private static final String TAG = "ConfigLoad";

	private static Properties menuConfig = null;
	
	private static Map<String, String> configMap = new HashMap<String, String>();
	
	static {
		synchronized (ConfigLoad.class) {
			InputStream in = ConfigLoad.class.getClassLoader().getResourceAsStream("config.properties");
			menuConfig = new Properties();
			try {
				menuConfig.load(in);
				in.close();
				/**
				 * 放到配置的map中去
				 */
				for (Iterator<String> iterator = getStringKeys().iterator(); iterator.hasNext();) {
					String key =  iterator.next();
					configMap.put(key, getStringValue(key));
				}
			} catch (IOException e) {
				System.out.println(new Date()+" : "+TAG+" : No config.properties defined error : "+e.getMessage());
				e.printStackTrace();
			}catch (Exception e) {
				System.out.println(new Date()+" : "+TAG+" : "+e.getMessage());
				e.printStackTrace();
			}
		}
	}
	
	public static Map<String, String> getConfigMap() {
		return configMap;
	}
	
	public static Set<Object> getKeys(){
		return menuConfig.keySet();
	}
	
	public static Set<String> getStringKeys(){
		return menuConfig.stringPropertyNames();
	}
	
	public static Collection<Object> getValues(){
		return menuConfig.values();
	}
	
	public static String getStringValue(String key){
		return menuConfig.getProperty(key);
	}
	
	public static Object getValue(String key) {
		return menuConfig.get(key);
	}
	
	@SuppressWarnings("unused")
	public static void main(String[] args) {
		Set<Object> keySet = getKeys();
		Set<String> keySetString = getStringKeys();
		Collection<Object> coll = getValues();
		Object so = getValue("test1");
		String value = getStringValue("test1");
		System.out.println(configMap);
	}
	
}
