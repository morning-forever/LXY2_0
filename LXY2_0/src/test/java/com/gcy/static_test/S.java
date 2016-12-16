package com.gcy.static_test;

public class S extends F{
	
	static{
		System.out.println("子类静态代码块执行");
	}
	
	public S() {
		
		System.out.println("Hello World!-----子类无参构造方法中");
	}

	public void sDoSomething(){
		System.out.println("子类做一些事情，下面调用父类的");
		doSomething();
	}
	
	
}
