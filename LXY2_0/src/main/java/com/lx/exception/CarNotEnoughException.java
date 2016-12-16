package com.lx.exception;

@SuppressWarnings("serial")
public class CarNotEnoughException extends RuntimeException{

  public CarNotEnoughException(String message) {
	super(message);
  }
	
}
