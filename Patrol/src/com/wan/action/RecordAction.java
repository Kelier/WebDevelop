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
import com.wan.db.RecordData;
import com.wan.db.UserData;

@ParentPackage("struts-default")
@Namespace("/")
public class RecordAction extends ActionSupport {

	
	

	int classone;
	int classtwo;
	
	
	String uname;
	String mainteacher;
	

	Map map;
	int page = 1;
	int rows = 10;
	int id;
	String tb_name;
	int dept;
	int u_class;
	int course;
	int late;
	int table;
	int play;
	int book;
	int sleep;
	float score;
	float t_score;
	String ontime;
	String onaction;
	String remarks;

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

	

	String date;;

	@Action(value = "recordMsg")
	public void recordMsg() {
		RecordData array = new RecordData();
		ClassData c_array = new ClassData();
		c_array.setD_class(u_class);
		c_array.setCourse(course);
		c_array.setT_score(t_score);
		c_array.setDept(dept);
		c_array.setScore(score);
		// ///////////////////
		array.setDept(dept);
		array.setU_class(u_class);
		array.setCourse(course);
		array.setLate(late);
		array.setTable(table);
		array.setPlay(play);
		array.setBook(book);
		array.setSleep(sleep);
		array.setOntime(ontime);
		array.setOnaction(onaction);
		array.setRemarks(remarks);
		array.setDate(date);
		System.out.println(array.getCourse() + array.getDate()
				+ array.getPlay() + array.getBook());
		DBUtils dbutils = new DBUtils();
		PrintWriter out;
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			out = ServletActionContext.getResponse().getWriter();
			String str = dbutils.updateScore(c_array);
			if (!str.equals("noclass")) {
				if(!str.equals("noteacher")){
					boolean temp = dbutils.recordMsg(array);
					if (temp) {
						out.print("recordSuccess");
					} else
						out.print("recordFailed");
				}else
					out.print("noteacher");
			} else
				out.print("noclass");
			out.flush();
			out.close();
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}
	
	@Action(value="tabGradestar1")
	public void tabGradestar1(){
	String[] array= {"id","mainteacher","phone","dept","u_class","score"};
		
		tb_name="tb_classinfo";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
	
		map.put("total", dbutils.getTbSize1(tb_name));
		map.put("rows", dbutils.updateGradescore1(tb_name,array));
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
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	@Action(value="tabGradestar2")
	public void tabGradestar2(){
		String[] array= {"id","mainteacher","phone","dept","u_class","score"};
		
		tb_name="tb_classinfo";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		
		map.put("total", dbutils.getTbSize2(tb_name));
		map.put("rows", dbutils.updateGradescore2(tb_name,array));
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
	@Action(value="tabGradestar3")
	public void tabGradestar3(){
		String[] array= {"id","mainteacher","phone","dept","u_class","score"};
		
		tb_name="tb_classinfo";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		
		map.put("total", dbutils.getTbSize3(tb_name));
		map.put("rows", dbutils.updateGradescore3(tb_name,array));
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
	@Action(value="tabGradestar4")
	public void tabGradestar4(){
		String[] array= {"id","mainteacher","phone","dept","u_class","score"};
		
		tb_name="tb_classinfo";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		
		map.put("total", dbutils.getTbSize4(tb_name));
		map.put("rows", dbutils.updateGradescore4(tb_name,array));
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
	
	@Action(value="tabClassstar")
	public void tabClassstar(){
		String[] array= {"id","dept","u_class","course","late","lazy","play","book","sleep","ontime","onaction","remarks","date"};
		
		tb_name="tb_record";
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
	
	@Action(value="tabScorestar1")
	public void tabScorestar1(){
		System.out.println("hei");
		String[] array= {"id","mainteacher","phone","dept","classone","score"};
		
		tb_name="tb_classinfo";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("total", dbutils.getTbSize5(tb_name,dept,classone));
		map.put("rows", dbutils.classCompare1(tb_name,array,dept,classone));
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
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	@Action(value="tabScorestar2")
	public void tabScorestar2(){
		System.out.println("hei");
		String[] array= {"id","mainteacher","phone","dept","classtwo","score"};
		
		tb_name="tb_classinfo";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("total", dbutils.getTbSize6(tb_name,dept,classtwo));
		map.put("rows", dbutils.classCompare2(tb_name,array,dept,classtwo));
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
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}

	@Action(value="tabStuNum")
	public void tabStuNum(){
		System.out.println("skoyi");
		String[] array= {"id","dept","u_class","course","late","lazy","play","book","sleep","ontime","onaction","remarks","date"};
		
		tb_name="tb_record";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("total", dbutils.getTbSize(tb_name));
		map.put("rows", dbutils.findTbPageInfo(tb_name,page,rows,array));
		
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
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	@Action(value="getTeascore")
	public void getTeascore(){
		System.out.println("meimie");
		String[] array= {"id","uname","rname","role","patrol","phone","sex","position","score","photo"};
		
		tb_name="tb_userinfo";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("total", dbutils.getTbSize(tb_name));
		map.put("rows", dbutils.findTbPageInfo(tb_name,page,rows,array));
		
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
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	@Action(value="getTeainfo")
	public void getTeainfo(){
		System.out.println("eee");
		String[] array= {"id","mainteacher","phone","dept","u_class","score"};
		
		tb_name="tb_classinfo";
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("total", dbutils.getTbSize(tb_name));
		map.put("rows", dbutils.findTbPageInfo(tb_name,page,rows,array));
		
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
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	
	public int getClassone() {
		return classone;
	}

	public void setClassone(int classone) {
		this.classone = classone;
	}

	public int getClasstwo() {
		return classtwo;
	}

	public void setClasstwo(int classtwo) {
		this.classtwo = classtwo;
	}

	public int getTable() {
		return table;
	}
	
	public void setTable(int table) {
		this.table = table;
	}
	public int getBook() {
		return book;
	}

	public void setBook(int book) {
		this.book = book;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTb_name() {
		return tb_name;
	}

	public void setTb_name(String tb_name) {
		this.tb_name = tb_name;
	}

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

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getMainteacher() {
		return mainteacher;
	}

	public void setMainteacher(String mainteacher) {
		this.mainteacher = mainteacher;
	}
}
