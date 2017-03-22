package com.wan.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionSupport;
import com.wan.db.DBUtils;
import com.wan.db.TeacherInfo;

@ParentPackage("struts-default")
@Namespace("/")
public class WorkManage extends ActionSupport {
	Map map;
	int page=1;
	int rows=5;
	int u_id;
	int d_id;
	String seprate;
	
	String tb_name;
	@Action("findWorkInfo")
	public void findWorkInfo() {
		System.out.println("paipai");
		String[] array= {"u_id","d_id","seprate"};
		tb_name="tb_work";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("total", dbutils.getTbSize(tb_name));
		map.put("rows", dbutils.findTbPageInfo(tb_name,page,rows,array));
		String jsonstr = JSON.toJSONString(map);
		PrintWriter out;
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			out = ServletActionContext.getResponse().getWriter();
			out.print(jsonstr);
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	
	public Map getMap() {
		return map;
	}
	public void setMap(Map map) {
		this.map = map;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public int getD_id() {
		return d_id;
	}
	public void setD_id(int d_id) {
		this.d_id = d_id;
	}
	public String getSeprate() {
		return seprate;
	}
	public void setSeprate(String seprate) {
		this.seprate = seprate;
	}
}
