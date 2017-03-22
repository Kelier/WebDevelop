package com.wan.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionSupport;
import com.wan.db.DBUtils;
import com.wan.db.UserData;

@ParentPackage("struts-default")
@Namespace("/")
public class UserInfoAction extends ActionSupport {
	Map map;
	int page = 1;
	int rows = 10;
	int id;
	int photo;
	int score;
	String tb_name;
	String tb_name2;
	String uname = "";
	String birthday = "";
	String upwd = "";
	String rname = "";
	String role = "";
	String phone = "";
	String sex = "";
	String position = "";
	String patrol = "";
	int dept ;
	int u_class;
	int course;
	
	/*
	 * @Action(value = "findUserInfo") public void findUserInfo() {
	 * tb_name="userinfo"; map = new HashMap(); DBUtils dbutils = new DBUtils();
	 * map.put("total", dbutils.getTbSize(tb_name)); map.put("rows",
	 * dbutils.findUserInfo(page, rows, uname, birthday)); String jsonstr =
	 * JSON.toJSONString(map); PrintWriter out; try {
	 * ServletActionContext.getResponse().setCharacterEncoding("utf-8"); out =
	 * ServletActionContext.getResponse().getWriter(); out.print(jsonstr);
	 * out.flush(); out.close(); } catch (IOException e) {
	 * System.out.println(e.getMessage()); } }
	 */
	
	@Action(value = "findRnameUser")
	public void findRnameUser() {
		tb_name = "tb_userinfo";
		String[] array = { "id", "uname", "rname", "role", "patrol",
				"phone", "sex", "position", "score", "photo" };
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("rows",
				dbutils.findRnameUser(tb_name, rname,array));
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

	@Action(value = "findSingleUser")
	public void findSingleUser() {
		tb_name = "tb_userinfo";
		HttpSession session = ServletActionContext.getRequest().getSession();
		uname=session.getAttribute("uname").toString();
		String[] array = { "id", "uname", "rname", "role", "patrol",
				"phone", "sex", "position", "score", "photo" };
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("rows",
				dbutils.findSingleUser(tb_name, uname,array));
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
	
	@Action(value = "findTeach")
	public void findTeach() {
		tb_name = "tb_teach";
		String[] array = { "u_id", "d_id", "c_id", "k_id"};
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("rows",
				dbutils.findTeach(tb_name, uname,array));
		String jsonstr = JSON.toJSONString(map);
		System.out.println("findTeach"+jsonstr);
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

	@Action(value = "findUserInfo")
	public void findUserInfo() {
		tb_name = "tb_userinfo";
		String[] array = { "id", "uname", "rname", "role", "patrol",
				"phone", "sex", "position", "score", "photo" };
		map = new HashMap();
		DBUtils dbutils = new DBUtils();
		map.put("total", dbutils.getTbSize(tb_name));
		map.put("rows",
				dbutils.findUserInfo(tb_name, page, rows, rname, role, array));
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
	
	
	@Action(value = "updateUserInfoById")
	public void updateUserInfoById() {
		tb_name = "tb_userinfo";
		UserData array = new UserData();
		try {
			array.setUname(utf8(uname));
			array.setRname(utf8(rname));
			array.setSex(utf8(sex));
			array.setRole(utf8(role));
			array.setPatrol(utf8(patrol));
			array.setPosition(utf8(position));
		} catch (UnsupportedEncodingException e1) {
		
			e1.printStackTrace();
		}
		
		/*
		try {
			ServletActionContext.getRequest().setCharacterEncoding("utf-8");
			array.setRname(rname);
			array.setSex(rname);
			array.setRole(role);
			array.setPatrol(patrol);
			array.setPosition(position);
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		*/

		array.setId(id);
		array.setScore(score);
		array.setPhone(phone);
		System.out.println(array.getRname()+array.getRole()+array.getSex()+array.getPatrol()+array.getPosition());
		DBUtils dbutils = new DBUtils();
		PrintWriter out;
		boolean temp = dbutils.updateUserInfoById(tb_name, array);
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			
			out = ServletActionContext.getResponse().getWriter();
			if (temp) {
				out.print("updateSuccess");
			} else
				out.print("updateFailed");
			out.flush();
			out.close();
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}
	

	
	
	@Action(value = "deleteUserInfoByID")
	public void deleteUserInfoById() {
		tb_name = "login";
		tb_name2 = "tb_userinfo";
		DBUtils db = new DBUtils();
		boolean temp = db.deleteUserInfoById(tb_name, tb_name2, id);
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

	@Action(value = "changeRoleById")
	public void changeRoleById() {
		System.out.println("修改权限");
		tb_name = "tb_userinfo";
		DBUtils db = new DBUtils();
		boolean temp = db.changeRoleById(tb_name, id, role);
		System.out.println(tb_name + "    " + id + "    " + role);
		PrintWriter out;
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			out = ServletActionContext.getResponse().getWriter();
			if (temp) {
				out.print("changeRoleSuccess");
			} else {
				out.print("changeRolefailed");
				System.out.println("changeRolefailed");
			}
			out.flush();
			out.close();
		} catch (Exception e) {
		}
	}
	
	@Action(value = "changeRoleByName")
	public void changeRoleByName() {
		System.out.println("修改权限");
		tb_name = "tb_userinfo";
		DBUtils db = new DBUtils();
		boolean temp = db.changeRoleByName(tb_name, uname, role);
		System.out.println(tb_name + "    " + uname + "    " + role);
		PrintWriter out;
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			out = ServletActionContext.getResponse().getWriter();
			if (temp) {
				out.print("changeRoleSuccess");
			} else {
				out.print("changeRolefailed");
				System.out.println("changeRolefailed");
			}
			out.flush();
			out.close();
		} catch (Exception e) {
		}
	}

	public Map getMap() {
		return map;
	}

	public void setMap(Map map) {
		this.map = map;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
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

	public String getRname() {
		return rname;
	}

	public void setRname(String rname) {
		this.rname = rname;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getUpwd() {
		return upwd;
	}

	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getPatrol() {
		return patrol;
	}

	public void setPatrol(String patrol) {
		this.patrol = patrol;
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
}
