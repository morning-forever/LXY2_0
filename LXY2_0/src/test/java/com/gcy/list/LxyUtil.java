package com.gcy.list;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LxyUtil {
	

    public static Map<String, Integer> classificAndCount(List<Map<String,String>> list, String groupKey){
		
		//一、解决分成几组(groupValue:组的键值)
		String groupValue = (String) list.get(0).get(groupKey);

		List<String> groupValues = new ArrayList<String>();
		groupValues.add(groupValue);
		
		for(Map<String,String> map: list){
			groupValue = (String)map.get(groupKey);
			if(!groupValues.contains(groupValue)){
				groupValues.add(groupValue);
			}
		}
		
		//二、统计每一组的数量
		int count ;
		Map<String, Integer> resultMap = new HashMap<String,Integer>();
		
		for(String groupv: groupValues ){
			count=0;
			for(Map<String,String> map : list){
				if(map.get(groupKey).equals(groupv)){
					count++;
				}
			}
			resultMap.put(groupv, count);
		}
		
		return resultMap;
	}
}
