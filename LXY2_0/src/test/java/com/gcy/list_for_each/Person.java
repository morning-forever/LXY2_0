package com.gcy.list_for_each;

public class Person {
	
	private String name;
	private String tel;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	/*public Person(String name, String tel) {
		super();
		this.name = name;
		this.tel = tel;
	}*/
	@Override
	public String toString() {
		return "Person [name=" + name + ", tel=" + tel + "]";
	}
	
	
}
