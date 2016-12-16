package com.gcy.liskov_substitution;

import java.util.HashMap;

public class Father {

	@SuppressWarnings("rawtypes")
	public void doSomething(HashMap map){
		
		System.out.println("父类被执行*******");
		
	}
}
