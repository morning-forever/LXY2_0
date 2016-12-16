package com.gcy.list;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Client {
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static void main(String args[]){
		
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();	
		
		for(int j=0;j<5;j++){
			
			for(int i=0;i<5;i++){
				Map map = new HashMap<String,String>();
				
				map.put("type", j+14+"座");
				map.put("plateNumber", i);
				list.add(map);
			}
			
		}
		
		
		
		Map<String, Integer> groupCount = LxyUtil.classificAndCount(list, "type");
		
		for( Map.Entry<String, Integer> entry : groupCount.entrySet()){
			
			System.out.println(entry.getKey()+"："+entry.getValue());
			
		}
		
	}
}
