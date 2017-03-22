package com.wan.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

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
public class PersonCenter extends ActionSupport {
	int id;
	int dept;
	int u_class;
	int course;
	String uname = "";
	String rname = "";
	String role = "";
	String phone = "";
	String sex = "";
	String position = "";
	String tb_name;
	String tb_name2;

	File photo;
	String photoFileName;
	String photoContentType;
	String context;

	@Action(value = "photoUpload")
	public void photoupload() {
		System.out.println("进入"+photo.getName());
		HttpSession session = ServletActionContext.getRequest().getSession();
		String extName = photoFileName
				.substring(photoFileName.lastIndexOf("."));
		String context = ServletActionContext.getServletContext().getRealPath(
				"/");
		try {
			ArrayList al = new ArrayList();
			al.add(".jpg");
			al.add(".png");
			al.add(".gif");
			al.add(".bmp");
			al.add(".jpeg");
			FileInputStream fis;
			FileOutputStream fos;
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			;
			String fileName = "photoupload/" + new Date().getTime() + extName;
			if (al.contains(extName)) {
				fis = new FileInputStream(photo);
				fos = new FileOutputStream(context + fileName);
				System.out.println(context + fileName);
				byte[] size = new byte[fis.available()];
				int length = 0;
				while ((length = fis.read(size)) != -1) {
					fos.write(size, 0, length);
				}
				DBUtils db = new DBUtils();
				boolean temp = db.chageUserInfoPhoto(
						session.getAttribute("uname").toString(), fileName);
				if (temp) {
					// session.setAttribute("photo", fileName);
					System.out.println("图片路径修改成功");
					out.print(fileName);
				} else {
					out.print("photoerror");
				}

				db.close();
				fos.flush();
				fos.close();
				fis.close();
			} else {
				out.print("extnameerror");
			}
			out.flush();
			out.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Action(value = "findPhoto")
	public void findPhoto() {
		String tb_name = "tb_userinfo";
		HttpSession session = ServletActionContext.getRequest().getSession();
		uname=session.getAttribute("uname").toString();
		String[] array = { "id", "uname", "upwd", "rname", "role", "patrol",
				"phone", "sex", "position", "score", "photo" };
		DBUtils dbutils = new DBUtils();
		String photo_address = dbutils.findPhoto(tb_name, uname, array);
		System.out.println(photo_address);
		PrintWriter out;
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			out = ServletActionContext.getResponse().getWriter();
			out.print(photo_address);
			out.flush();
			out.close();
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}

	// 完善信息
	@Action(value = "update_PersonMsg")
	public void update_PersonMsg() {
		tb_name = "tb_userinfo";
		tb_name2 = "tb_teach";
		UserData array = new UserData();
		array.setUname(uname);
		array.setRname(rname);
		array.setSex(sex);
		array.setPosition(position);
		array.setDept(dept);
		array.setU_class(u_class);
		array.setCourse(course);
		array.setPhone(phone);
		
		System.out.println("个人信息更新" + array.getRname() + array.getSex()
				+ array.getPosition());
		DBUtils dbutils = new DBUtils();
		PrintWriter out;
		boolean temp = dbutils.updatePersonInfoById(tb_name,tb_name2,array);
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
	
	// 完善信息
		@Action(value = "update_PersonMsg_all")
		public void update_PersonMsg_all() {
			tb_name = "tb_userinfo";
			tb_name2 = "tb_teach";
			UserData array = new UserData();
			array.setUname(uname);
			array.setRname(rname);
			array.setSex(sex);
			array.setPosition(position);
			array.setDept(dept);
			array.setU_class(u_class);
			array.setCourse(course);
			array.setPhone(phone);
			
			System.out.println("个人信息更新" + array.getRname() + array.getSex()
					+ array.getPosition());
			DBUtils dbutils = new DBUtils();
			PrintWriter out;
			boolean temp = dbutils.updatePersonInfoById(tb_name,tb_name2,array);
			try {
				ServletActionContext.getResponse().setCharacterEncoding("utf-8");
				out = ServletActionContext.getResponse().getWriter();
				if (temp) {
					System.out.println(uname+role);
					temp = dbutils.changeRoleByName(tb_name, uname, role);
					if(temp)out.print("updateSuccess");
					else
						out.print("updateFailed");
				} else
					out.print("updateFailed");
				out.flush();
				out.close();
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}
		}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public File getPhoto() {
		return photo;
	}

	public void setPhoto(File photo) {
		this.photo = photo;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}

	public String getPhotoContentType() {
		return photoContentType;
	}

	public void setPhotoContentType(String photoContentType) {
		this.photoContentType = photoContentType;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

}
