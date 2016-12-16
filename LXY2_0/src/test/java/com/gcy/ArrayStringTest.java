package com.gcy;

import java.util.Arrays;

public class ArrayStringTest {
	
	public static void main(String args[]){

		Long[] ids = new Long[]{123L,234L,567L};
		String idsStr = Arrays.toString(ids);
		System.out.println(idsStr.substring(1, idsStr.length()-1));
		
	}
}
