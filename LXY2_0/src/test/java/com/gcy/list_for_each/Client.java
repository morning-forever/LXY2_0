package com.gcy.list_for_each;

import java.util.ArrayList;
import java.util.List;

public class Client {
	@SuppressWarnings({ "unused", "serial" })
	public static void main(String args[]){
		
		List<String> list1 = new ArrayList<String>(){
			{
				add("hello!");
				add("hi");
				add("goodbye！");
				add("bye");
			}
		};
		
		
		Person person = new Person(){
			{
				setName("张三");
				setTel("18286723345");
			}
		};
		
		System.out.println(person);
		
		
		
	}
}
