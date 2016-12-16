package com.gcy.liskov_substitution;

import java.util.Map;

public class Son extends Father{
	
	
	@SuppressWarnings("rawtypes")
	public void doSomething(Map map){
		System.out.println("子类被执行");
	}

}
