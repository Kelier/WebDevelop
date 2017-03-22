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
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.opensymphony.xwork2.ActionSupport;
import com.wan.db.DBUtils;
import com.wan.db.UserData;

@ParentPackage("struts-default")
@Namespace("/")
public class QueryAction extends ActionSupport {
	Map map;
	int page = 1;
	int deptID=1;
	int classID=1;
	int rows = 100;
	int id;
	int grade=1;
	String tb_name;


	
	@Action(value = "getRecord")
	public void getRecord() {
		tb_name = "tb_record";
		String[] array = {"id", "dept", "class", "course", "late", "lazy",
				"play", "book", "sleep", "ontime", "onaction", "remarks", "date" };
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("total", dbutils.getTbSize(tb_name));
		map.put("rows",
				dbutils.getRecord(tb_name, array));
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
	
	@Action(value = "getDept")
	public void getDept() {
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("rows",
				dbutils.getDept(grade));
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
	
	@Action(value = "getClassInfo")
	public void getClassInfo() {
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("rows",
				dbutils.getClassInfo());
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
	
	@Action(value = "getSingleClassInfo")
	public void getSingleClassInfo() {
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("rows",
				dbutils.getSingleClassInfo(deptID,classID));
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
	
	@Action(value = "getTeacherInfo")
	public void getTeacherInfo() {
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("rows",
				dbutils.getTeacherInfo());
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

	public String utf8(String str) throws UnsupportedEncodingException{
		return new String(str.getBytes("ISO-8859-1"),"utf-8");
	}
	


	public Map getMap() {
		return map;
	}

	public void setMap(Map map) {
		this.map = map;
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
	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getDeptID() {
		return deptID;
	}

	public void setDeptID(int deptID) {
		this.deptID = deptID;
	}

	public int getClassID() {
		return classID;
	}

	public void setClassID(int classID) {
		this.classID = classID;
	}
}
	
