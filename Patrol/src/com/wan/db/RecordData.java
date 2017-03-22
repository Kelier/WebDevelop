package com.wan.db;

public class RecordData {
	int id;

	
	public int getDept() {
		return dept;
	}
	public void setDept(int dept) {
		this.dept = dept;
	}
	public int getU_class() {
		return u_class;
	}
	public void setU_class(int u_class) {
		this.u_class = u_class;
	}
	public int getCourse() {
		return course;
	}
	public void setCourse(int course) {
		this.course = course;
	}
	public int getLate() {
		return late;
	}
	public void setLate(int late) {
		this.late = late;
	}
	public int getPlay() {
		return play;
	}
	public void setPlay(int play) {
		this.play = play;
	}
	
	public int getSleep() {
		return sleep;
	}
	public void setSleep(int sleep) {
		this.sleep = sleep;
	}
	public String getOntime() {
		return ontime;
	}
	public void setOntime(String ontime) {
		this.ontime = ontime;
	}
	public String getOnaction() {
		return onaction;
	}
	public void setOnaction(String onaction) {
		this.onaction = onaction;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	int dept;
	int  u_class;
	int course;
	int late;
	int table;
	public int getTable() {
		return table;
	}
	public void setTable(int table) {
		this.table = table;
	}
	int play;
	int book;
	public int getBook() {
		return book;
	}
	public void setBook(int book) {
		this.book = book;
	}
	int sleep;
	String ontime;
	String onaction;
	String date;
	String remarks;
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
