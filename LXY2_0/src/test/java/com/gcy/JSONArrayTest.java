package com.gcy;

import com.alibaba.fastjson.JSONArray;

public class JSONArrayTest {
	
	public static void main(String args[]){
		
		String idsString = "[[1,2,3],[4,5,6]]";
		JSONArray dayIds = JSONArray.parseArray(idsString);
		
		for(Object obj : dayIds){
			
			if(obj instanceof JSONArray ){
				
				System.out.println(true);
			}
			
		}
		System.out.println("hello");
	}
}
