package com.gcy;

import java.util.ArrayList;
import java.util.List;

import com.lx.util.PageData;

public class DayTest {
	
	@SuppressWarnings("unused")
	public static void main(String args[]){
		
		
		 
		List<PageData> distList = new ArrayList<PageData>();
		
		
		
		PageData distItem1 = new PageData();
		distItem1.put("distance",134);
		distItem1.put("day",1);
		distList.add(distItem1);
		
		PageData distItem2 = new PageData();
		distItem2.put("distance",235);
		distItem2.put("day",1);
		distList.add(distItem2);
		
		PageData distItem3 = new PageData();
		distItem3.put("distance",322);
		distItem3.put("day",1);
		distList.add(distItem3);
		
		
		PageData distItem4 = new PageData();
		distItem3.put("distance",1322);
		distItem3.put("day",2);
		distList.add(distItem3);
		
		
		PageData distItem5 = new PageData();
		distItem3.put("distance",122);
		distItem3.put("day",2);
		distList.add(distItem3);
		
		PageData distItem6 = new PageData();
		distItem3.put("distance",322);
		distItem3.put("day",1);
		distList.add(distItem3);
		
		
		
		PageData distItem7 = new PageData();
		distItem3.put("distance",322);
		distItem3.put("day",1);
		distList.add(distItem3);
		
	  
		
		System.out.println(distList);
		
		
		
		
		
	}
}
