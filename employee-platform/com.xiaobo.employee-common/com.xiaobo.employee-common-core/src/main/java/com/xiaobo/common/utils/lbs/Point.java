package com.xiaobo.common.utils.lbs;
 

public class Point {

	private double x;
	private double y;

	
	
	public double getX() {
		return x;
	}



	public void setX(double x) {
		this.x = x;
	}



	public double getY() {
		return y;
	}
 
	public void setY(double y) {
		this.y = y;
	}



	public Point(double x, double y) {
		super();
		this.x = x;
		this.y = y;
	}

	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return (int)(x * 1000000 + y * 1000000);
	}
	
	@Override
	public boolean equals(Object obj) {
		
		if(obj instanceof Point) {
			Point new_name = (Point) obj;
			if(new_name.x == x && new_name.y == y)
				return true ;
		} 
		
		return super.equals(obj);
	}


	public Point() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public String toString() {
		
		// TODO Auto-generated method stub
		return x + "_" + y;
	}
}
