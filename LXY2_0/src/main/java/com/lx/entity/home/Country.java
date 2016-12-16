package com.lx.entity.home;

public class Country {
	private int id;
	private String countryId;
	private String countryName;
	private String areaId;
	private int hasHotel;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCountryId() {
		return countryId;
	}
	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}
	public String getCountryName() {
		return countryName;
	}
	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}
	public String getAreaId() {
		return areaId;
	}
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}
	
	public int getHasHotel() {
		return hasHotel;
	}
	
	public void setHasHotel(int hasHotel) {
		this.hasHotel = hasHotel;
	}
	
	
	

}
