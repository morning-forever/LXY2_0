package com.gcy.liskov_substitution;

import java.util.HashMap;
import java.util.Map;

public class Client {

	public static void main(String args[]){
		
		invoker();
		
	}      
	
	
	@SuppressWarnings("rawtypes")
	public static void invoker(){
		//Father f = new Father();
		Son f = new Son();
		//Map map = new HashMap();
		Map map = new HashMap();
		f.doSomething(map);
	}
	
	
}
