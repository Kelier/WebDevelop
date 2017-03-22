package com.wan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.opensymphony.xwork2.ActionSupport;
import com.wan.db.DBUtils;
import com.wan.db.Login_Register;

@ParentPackage("struts-default")
@Namespace("/")
public class LoginSystemAction extends ActionSupport {
	String uname="null";
	String upwd;
	String oldpwd;
	String newpwd;
	String vcode;
	String role="null";
	String returnResult;

	@Action(value = "androidlogin")
	// TODO 登录
	public void androidlogin() {
		try {
			// 获取输出流对象
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			HttpSession session = ServletActionContext.getRequest()
					.getSession();
			DBUtils dbutils = new DBUtils();
			Login_Register login = new Login_Register();
			login.setUname(uname);
			login.setUpwd(upwd);
			// login.setRole(role);
			System.out.println(uname + "   " + upwd);
			String temp = dbutils.androidlogin(login);
			System.out.println(temp);
			if (temp.equals("false")) {
				returnResult = "loginError";
			} else {
				session.setAttribute("uname", uname);
				if (temp.equals("管理员")) {
					session.setAttribute("role", temp);
					returnResult = "adminLoginSuccess";
				} else if (temp.equals("巡查员")) {
					session.setAttribute("role", temp);
					returnResult = "plantLoginSuccess";
				}else{
					session.setAttribute("role", temp);
					returnResult = "teacherLoginSuccess";
				}
			}
			System.out.println(returnResult);
			dbutils.close();
			out.print(returnResult);
			out.flush();
			out.close();

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	@Action(value = "androidregister")
	// TODO 安卓注册
	public void androidregister() {
		try {
			// 获取输出流对象
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			DBUtils dbutils = new DBUtils();
			Login_Register register = new Login_Register();
			register.setUname(uname);
			register.setUpwd(upwd);
			boolean temp = dbutils.finduser(register);
			if (temp) {
				temp = dbutils.register(register);
				if (temp) {
					returnResult = "registerSuccess";
				} else {
					returnResult = "registerError";
				}
			} else {
				returnResult = "existuser";
			}
			dbutils.close();
			out.print(returnResult);
			out.flush();
			out.close();
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	@Action(value = "login")
	// TODO 登录
	public void login() {
		try {
			// 获取输出流对象
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			// 获取session对象
			HttpSession session = ServletActionContext.getRequest()
					.getSession();
			String imgvcode = session.getAttribute("rand").toString();
			if (vcode.equals(imgvcode)) {
				DBUtils dbutils = new DBUtils();
				Login_Register login = new Login_Register();
				login.setUname(uname);
				login.setUpwd(upwd);
				login.setRole(role);
				// System.out.println(login.getRole()+login.getUname()+login.getUpwd());
				boolean temp = dbutils.login(login);
				if (temp) {
					session.setAttribute("uname", uname);
					session.setAttribute("role", role);
					if (role.equals("admin")) {
						returnResult = "adminLoginSuccess";
					} else {
						returnResult = "plantLoginSuccess";
					}
				} else {
					returnResult = "loginError";
				}
				System.out.println(returnResult);
				dbutils.close();
				/*
				 * if(uname.equals("admin")&&upwd.equals("123456")&&role.equals(
				 * "admin")){ returnResult="adminLoginSuccess"; }else
				 * if(uname.equals
				 * ("admin")&&upwd.equals("123456")&&role.equals("plant")){
				 * returnResult="plantLoginSuccess"; }else{
				 * returnResult="loginError"; }
				 */

			} else {
				returnResult = "vcodeError";
			}
			out.print(returnResult);
			out.flush();
			out.close();

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	@Action(value = "register")
	// TODO 注册
	public void register() {
		try {
			// 获取输出流对象
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			// 获取session对象
			HttpSession session = ServletActionContext.getRequest()
					.getSession();
			String imgvcode = session.getAttribute("rand").toString();
			System.out.println("验证码为："+imgvcode);
			if (vcode.equals(imgvcode)) {
				DBUtils dbutils = new DBUtils();
				Login_Register register = new Login_Register();
				register.setUname(uname);
				register.setUpwd(upwd);
				boolean temp = dbutils.finduser(register);
				if (temp) {
					temp = dbutils.register(register);
					if (temp) {
						session.setAttribute("uname",uname);
						returnResult = "registerSuccess";
					} else {
						returnResult = "registerError";
					}
				} else {
					returnResult = "existuser";
				}
				dbutils.close();
			} else {
				returnResult = "vcodeError";
			}
			out.print(returnResult);
			out.flush();
			out.close();

		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	@Action(value = "update")
	// TODO 修改密码
	public void update() {
		try {
			// 获取输出流对象
			System.out.println("s");
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			// 获取session对象
			HttpSession session = ServletActionContext.getRequest()
					.getSession();
			DBUtils dbutils = new DBUtils();
			Login_Register update = new Login_Register();
			update.setUname(session.getAttribute("uname").toString());
			update.setRole(session.getAttribute("role").toString());
			update.setUpwd(oldpwd);
			update.setNewpwd(newpwd);
			boolean temp = dbutils.update_pwd(update);
			if (temp) {
				returnResult = "updateSuccess";
			} else {
				returnResult = "updateError";
			}
			dbutils.close();
			out.print(returnResult);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getUpwd() {
		return upwd;
	}

	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}

	public String getVcode() {
		return vcode;
	}

	public void setVcode(String vcode) {
		this.vcode = vcode;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getReturnResult() {
		return returnResult;
	}

	public void setReturnResult(String returnResult) {
		this.returnResult = returnResult;
	}

	public String getNewpwd() {
		return newpwd;
	}

	public void setNewpwd(String newpwd) {
		this.newpwd = newpwd;
	}

	public String getOldpwd() {
		return oldpwd;
	}

	public void setOldpwd(String oldpwd) {
		this.oldpwd = oldpwd;
	}
}
