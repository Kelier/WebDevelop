package com.wan.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionSupport;
import com.wan.db.ClassData;
import com.wan.db.DBUtils;
import com.wan.db.UserData;
@ParentPackage("struts-default")
@Namespace("/")
public class ClassInfoAction extends ActionSupport {
Map map;
String tb_name;
String tb_name2;
int page=1;
int rows=5;
int id;
String mainteacher="";
String phone;
int dept;
int d_class;
int course;
float score;
float t_score;



@Action(value="findClassInfo")
public void findClassInfo(){
	System.out.println("hello");
	tb_name="tb_classinfo";
	String[] array = { "id", "mainteacher", "phone", "dept", "d_class","score"};
	map = new HashMap();
	DBUtils dbutils = new DBUtils();
	map.put("total", dbutils.getTbSize(tb_name));

	map.put("rows",
			dbutils.findClassInfo(tb_name, page, rows, mainteacher, array));
String jsonstr = JSON.toJSONString(map);
	System.out.println(jsonstr);
	PrintWriter out;
	try {
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		out = ServletActionContext.getResponse().getWriter();
		out.print(jsonstr);
		out.flush();
		out.close();
	} catch (IOException e) {
		System.out.println(e.getMessage());
	}
}



@Action(value = "updateClassInfoById")
public void updateClassInfoById() {
	System.out.println("hi");
	tb_name = "tb_classinfo";
	ClassData array = new ClassData();
	try {
		array.setMainteacher(utf8(mainteacher));
		array.setPhone(utf8(phone));
		
		
		
	} catch (UnsupportedEncodingException e1) {
	
		e1.printStackTrace();
	}

	array.setId(id);
	array.setDept(dept);
	array.setD_class(d_class);
	array.setScore(score);
	
	System.out.println(array.getMainteacher()+array.getPhone()+array.getDept()+array.getD_class()+array.getScore());
	DBUtils dbutils = new DBUtils();
	PrintWriter out;
	boolean temp = dbutils.updateClassInfoById(tb_name, array);
	try {
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		
		out = ServletActionContext.getResponse().getWriter();
		if (temp) {
			out.print("updataSuccess");
		} else
			out.print("updataFailed");
		out.flush();
		out.close();
	} catch (IOException e) {
		System.out.println(e.getMessage());
	}
}

@Action(value = "deleteClassInfoByID")
public void deleteClassInfoById() {
	tb_name2 = "tb_classinfo";
	DBUtils db = new DBUtils();
	boolean temp = db.deleteClassInfoById(tb_name2, id);
	PrintWriter out;
	try {
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		out = ServletActionContext.getResponse().getWriter();
		if (temp) {
			out.print("deleteSuccess");
		} else {
			out.print("deletefailed");
		}
		out.flush();
		out.close();
	} catch (Exception e) {
	}
}

@Action(value="updateScore")
public void updateScore(){
	ClassData array = new ClassData();
	array.setD_class(d_class);
	array.setCourse(course);
	array.setT_score(t_score);
	array.setDept(dept);
	array.setScore(score);
	System.out.println(array.getD_class()+ "    "+array.getScore());
	DBUtils dbutils = new DBUtils();
	PrintWriter out;
	System.out.println("马上进入");
	String temp = dbutils.updateScore(array);
	System.out.println("出来了");
	try {
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		
		out = ServletActionContext.getResponse().getWriter();
		if (temp.equals("updateSuccess")) {
			out.print("updateSuccess");
		} else
			out.print("updateFailed");
		out.flush();
		out.close();
	} catch (IOException e) {
		System.out.println(e.getMessage());
	}	
}

public String utf8(String str) throws UnsupportedEncodingException{
	return new String(str.getBytes("ISO-8859-1"),"utf-8");
}

public Map getMap() {
	return map;
}
public void setMap(Map map) {
	this.map = map;
}
public String getTb_name() {
	return tb_name;
}
public void setTb_name(String tb_name) {
	this.tb_name = tb_name;
}
public int getPage() {
	return page;
}
public void setPage(int page) {
	this.page = page;
}
public int getRows() {
	return rows;
}
public void setRows(int rows) {
	this.rows = rows;
}
public int getId() {
	return id;
}

public void setId(int id) {
	this.id = id;
}

public String getMainteacher() {
	return mainteacher;
}

public void setMainteacher(String mainteacher) {
	this.mainteacher = mainteacher;
}

public String getPhone() {
	return phone;
}

public void setPhone(String phone) {
	this.phone = phone;
}

public int getDept() {
	return dept;
}

public void setDept(int dept) {
	this.dept = dept;
}

public int getD_class() {
	return d_class;
}

public void setD_class(int d_class) {
	this.d_class = d_class;
}

public float getScore() {
	return score;
}

public void setScore(float score) {
	this.score = score;
}

public float getT_score() {
	return t_score;
}



public void setT_score(float t_score) {
	this.t_score = t_score;
}
public int getCourse() {
	return course;
}



public void setCourse(int course) {
	this.course = course;
}

}
