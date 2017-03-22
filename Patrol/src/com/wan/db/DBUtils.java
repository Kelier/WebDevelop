package com.wan.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class DBUtils {
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	CallableStatement cstmt;
	ResultSet rs;
	ResultSet rs2;
	ResultSet rs3;

	public DBUtils() {
		try {
			Properties properties = new Properties();
			properties.load(getClass().getResourceAsStream(
					"../../../jdbc.properties"));
			String driverName = properties.getProperty("driverName");
			String url = properties.getProperty("url");
			String uname = properties.getProperty("uname");
			String upwd = properties.getProperty("upwd");
			// //////////////////////////////////////////
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, uname, upwd);
			// Statement里面带有很多方法，比如executeUpdate可以实现插入，更新和删除等
			// Statement stmt = conn.createStatement();

		} catch (Exception e) {
			System.out.println("test");
		}
	}

	/*
	 * public static void main(String[] args) { DBUtils db=new DBUtils(); Login
	 * login=new Login(); login.setRole("admin"); login.setUname("admin");
	 * login.setUpwd("123456"); db.login(login); }
	 */
	public boolean login(Login_Register login) {
		try {
			String sql = "select * from login where uname=? and upwd=? and role=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, login.getUname());
			pstmt.setString(2, login.getUpwd());
			pstmt.setString(3, login.getRole());
			rs = pstmt.executeQuery();// executeQuery会返回结果的集合，否则返回空值
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public String androidlogin(Login_Register login) {
		try {
			String sql = "select role from login where uname=? and upwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, login.getUname());
			pstmt.setString(2, login.getUpwd());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "false";
	}

	// 三表一起注册
	public boolean register(Login_Register register) {
		try {

			String sql = "insert into login(uname,upwd) values('"
					+ register.getUname() + "','" + register.getUpwd()
					+ "');";
			pstmt = conn.prepareStatement(sql);
			int rows = pstmt.executeUpdate();
			if (rows > 0) {
				sql = "insert into tb_userinfo(uname) values('"
						+ register.getUname() + "');";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
				// teach表加数据
				sql = "insert into tb_teach(u_id) values((select id from tb_userinfo where uname=?))";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, register.getUname());

				pstmt.executeUpdate();
				return true;
			} else
				return false;
		} catch (SQLException e) {
			System.out.println("注册失败");
		}
		return false;
	}

	public void register2(Login_Register register) {
		try {
			String sql = "insert into tb_userinfo(uname,upwd,rname,role) values('"
					+ register.getUname()
					+ "','"
					+ register.getUpwd()
					+ "','默认名字','plant')";
			pstmt = conn.prepareStatement(sql);
			int rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("注册失败");
		}

	}

	// 注册前查重处理
	public boolean finduser(Login_Register finduser) {
		try {
			String sql = "select * from login where uname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, finduser.getUname());
			rs = pstmt.executeQuery();
			if (rs.next())
				return false;
		} catch (SQLException e) {
			System.out.println("注册失败");
		}
		return true;
	}

	// 修改密码
	public boolean update_pwd(Login_Register update_pwd) {
		try {
			if (login(update_pwd)) {
				String sql = "update login set upwd=? where uname=?";
				System.out.println("hello");
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, update_pwd.getNewpwd());
				pstmt.setString(2, update_pwd.getUname());
				int rows = pstmt.executeUpdate();
				if (rows > 0)
					return true;
				else
					return false;
			} else {
				System.out.println("帐号密码不匹配");
				return false;
			}
		} catch (SQLException e) {
			System.out.println("更新失败");
		}
		return true;
	}

	// 根据用户姓名进行查找
	public boolean findUserInfoByUname(String uname) {
		try {
			String sql = "select * from login where uname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			System.out.println("查找用戶失敗");
		}
		return false;
	}

	// 用户高级搜索
	public List<Map<String, String>> findUserInfo(String tb_name, int page,
			int rows, String rname, String role, String[] array) {
		try {

			String sql1 = "select * from " + tb_name + " limit ?,?";
			if (!rname.equals("") && role.equals("")) {
				String sql3 = "select * from " + tb_name
						+ " where rname like ?  limit ?,?";
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, "%" + rname + "%");
				pstmt.setInt(2, rows * (page - 1));
				pstmt.setInt(3, rows);
			}
			if (rname.equals("") && !role.equals("")) {
				String sql3 = "select * from " + tb_name
						+ " where role = ?  limit ?,?";
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, role);
				pstmt.setInt(2, rows * (page - 1));
				pstmt.setInt(3, rows);
			}
			if (!rname.equals("") && !role.equals("")) {
				String sql3 = "select * from " + tb_name
						+ " where rname like ? and role=?  limit ?,?";
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, "%" + rname + "%");
				pstmt.setString(2, role);
				pstmt.setInt(3, rows * (page - 1));
				pstmt.setInt(4, rows);
			}
			if (rname.equals("") && role.equals("")) {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setInt(1, rows * (page - 1));
				pstmt.setInt(2, rows);
			}
			ArrayList al = new ArrayList();
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					if (string.equals("score"))
						map.put(string, rs.getInt(i + 1));
					else if (string.equals("phone"))
						map.put(string, rs.getLong(i + 1));
					else
						map.put(string, rs.getString(i + 1));
				}
				al.add(map);
			}
			return al;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public List<Map<String, String>> getRecord(String tb_name, String[] array) {
		try {

			String sql1 = "select * from tb_record "+tb_name+" order by date desc";
			pstmt = conn.prepareStatement(sql1);
			ArrayList al = new ArrayList();
			String[] dept_list = { "高一年级", "高二年级", "高三年级", "高四年级" };
			String[] action = { "非常好", "还不错", "一般般", "略不好", "非常差" };
			String[] course_list = { "语文", "数学", "英语", "物理", "化学", "生物", "政治",
					"历史", "地理" };
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					if (string.equals("remarks"))
						map.put(string, rs.getString(i + 1));
					else if (string.equals("date"))
						map.put(string, rs.getString(i + 1));
					else if (string.equals("course")) {
						for (int j = 0; j < course_list.length; j++) {
							if (rs.getInt(i + 1) == (j + 1)) {
								map.put(string, course_list[j]);
							}
						}
					} else if (string.equals("dept")) {
						for (int j = 0; j < dept_list.length; j++) {
							if (rs.getInt(i + 1) == (j + 1)) {
								map.put(string, dept_list[j]);
							}
						}
					} else if (string.equals("onaction")) {
						for (int j = 0; j < action.length; j++) {
							if (rs.getInt(i + 1) == (j)) {
								map.put(string, action[j]);
							}
						}
					} else if (string.equals("ontime")) {
						if (rs.getInt(i + 1) == 1)
							map.put(string, "是");
						else
							map.put(string, "否");
					} else
						map.put(string, rs.getInt(i + 1));
				}
				al.add(map);
			}
			return al;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public List<Map<String, String>> getDept(int grade) {
		try {
			ArrayList al = new ArrayList();
			String[] course_list = { "语文", "数学", "英语", "物理", "化学", "生物", "政治",
					"历史", "地理" };
			String sql = "select * from tb_teach where d_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grade);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				sql = "select * from tb_userinfo where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt(1));
				rs2 = pstmt.executeQuery();
				while (rs2.next()) {
					Map map = new HashMap();
					map.put("rname", rs2.getString(3));
					map.put("position", rs2.getString(8));
					map.put("sex", rs2.getString(7));
					map.put("class", rs.getInt(3));
					for (int i = 0; i < course_list.length; i++) {
						if (rs.getInt(4) == (i + 1)) {
							map.put("course", course_list[i]);
						}
					}
					map.put("phone", rs2.getString(6));
					map.put("score", rs2.getInt(9));
					map.put("role", rs2.getString(4));
					al.add(map);
				}

			}
			return al;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public List<Map<String, String>> getClassInfo() {
		try {
			ArrayList al = new ArrayList();
			String[] course_list = { "Chinese", "Math", "English", "Physic",
					"Chemistry", "Biology", "Politics", "History", "Geography" };
			String[] dept_list = { "高一年级", "高二年级", "高三年级", "高四年级" };
			for (int d = 1; d < 5; d++) {
				for (int c = 1; c < 9; c++) {
					String sql = "select * from tb_classinfo where dept=? and class=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, d);
					pstmt.setInt(2, c);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						Map map = new HashMap();
						for (int g = 0; g < dept_list.length; g++) {
							if (rs.getInt(5) == (g + 1)) {
								map.put("grade", dept_list[g]);
							}
						}
						map.put("class", rs.getInt("class"));
						map.put("mainteacher", rs.getString(2));
						map.put("score", rs.getInt("score"));
						sql = "select * from tb_teach where d_id=? and c_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, d);
						pstmt.setInt(2, c);
						rs2 = pstmt.executeQuery();
						while (rs2.next()) {
							for (int k = 0; k < course_list.length; k++) {
								if (rs2.getInt(4) == (k + 1)) {
									sql = "select * from tb_userinfo where id=?";
									pstmt = conn.prepareStatement(sql);
									pstmt.setInt(1, rs2.getInt(1));
									rs3 = pstmt.executeQuery();
									if (rs3.next()) {
										map.put(course_list[k],
												rs3.getString(3));
									} else
										map.put(course_list[k], "");
								}
							}

						}
						al.add(map);
					}
				}
			}
			return al;

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public List<Map<String, String>> getSingleClassInfo(int d,int c) {
		try {
			ArrayList al = new ArrayList();
			String[] course_list = { "Chinese", "Math", "English", "Physic",
					"Chemistry", "Biology", "Politics", "History", "Geography" };
			Map map = new HashMap();
			for(int i=0;i<course_list.length;i++){
				map.put(course_list[i],"无");
			}
			
			
					String sql = "select * from tb_classinfo where dept=? and class=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, d);
					pstmt.setInt(2, c);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						
						map.put("mainteacher", rs.getString(2));
						map.put("score", rs.getInt("score"));
						sql = "select * from tb_teach where d_id=? and c_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, d);
						pstmt.setInt(2, c);
						rs2 = pstmt.executeQuery();
						while (rs2.next()) {
							for (int k = 0; k < course_list.length; k++) {
								if (rs2.getInt(4) == (k + 1)) {
									sql = "select * from tb_userinfo where id=?";
									pstmt = conn.prepareStatement(sql);
									pstmt.setInt(1, rs2.getInt(1));
									rs3 = pstmt.executeQuery();
									if (rs3.next()) {
										map.put(course_list[k],
												rs3.getString(3));
									} else
										map.put(course_list[k], "");
								}
							}

						}
						al.add(map);
					}
					
			return al;

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public List<Map<String, String>> getTeacherInfo() {
		try {
			ArrayList al = new ArrayList();
			String[] course_list = { "语文", "数学", "英语", "物理", "化学", "生物", "政治",
					"历史", "地理" };
			String[] dept_list = { "高一年级", "高二年级", "高三年级", "高四年级" };
			String sql = "select * from tb_userinfo";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				map.put("rname", rs.getString(3));
				map.put("position", rs.getString("position"));
				map.put("score", rs.getInt(9));
				map.put("role", rs.getString(4));
				map.put("sex", rs.getString(7));
				map.put("phone", rs.getString(6));
				sql = "select * from tb_teach where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt(1));
				rs2 = pstmt.executeQuery();
				if(rs2.next()){
					for (int k = 0; k < course_list.length; k++) {
						if(rs2.getInt(4)==(k+1)){
							map.put("course",course_list[k]);
						}
					}
					for (int d = 0; d < dept_list.length; d++) {
						if(rs2.getInt(4)==(d+1)){
							map.put("dept",dept_list[d]);
						}
					}
					map.put("class",rs2.getInt(3));
					
				}
				al.add(map);
			}

			return al;

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	// 寻找图片地址
	public String findPhoto(String tb_name, String uname, String[] array) {
		try {
			String sql1 = "select photo from " + tb_name + " where uname=?";
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, uname);
			ArrayList al = new ArrayList();
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	// 查找表中某页某行具体信息，翻页功能
	public List<Map<String, String>> findTbPageInfo(String tb_name, int page,
			int rows, String[] array) {
		try {
			String sql = "select * from " + tb_name + " limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rows * (page - 1));
			pstmt.setInt(2, rows);
			ArrayList a1 = new ArrayList();
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
				}
				a1.add(map);
			}
			return a1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	// 获取表条数总数量
	public int getTbSize(String tb_name) {
		try {
			String sql = "select count(*)from " + tb_name;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return 0;
	}

	// 根据用户ID来删除对应用户数据
	public boolean deleteUserInfoById(String tb_name, String tb_name2, int id) {
		try {
			conn.setAutoCommit(false);
			String sql2 = "delete from " + tb_name + " where uname="
					+ "(select uname from " + tb_name2 + " where id=?)";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			System.out.println("第一次查询");
			String sql1 = "delete from " + tb_name2 + " where id=?";
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			System.out.println("第二次查询");
			conn.commit();
			return true;
		} catch (Exception e) {
			System.out.println("删除用户数据");
		}
		return false;
	}

	// 根据个人用户ID来批量改变数据
	public boolean updatePersonInfoById(String tb_name, String tb_name2,
			UserData array) {
		try {
			String sql = "update " + tb_name
					+ " set rname=?,sex=?,phone=?,position=? where uname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, array.getRname());
			pstmt.setString(2, array.getSex());
			pstmt.setString(3, array.getPhone());
			pstmt.setString(4, array.getPosition());
			pstmt.setString(5, array.getUname());
			System.out.println(array.rname + array.phone + array.sex
					+ array.position);
			int rows = pstmt.executeUpdate();
			if (rows > 0) {
				String sql2 = "update "
						+ tb_name2
						+ " set d_id=?,c_id=?,k_id=? where u_id = (select id from "
						+ tb_name + " where uname=?)";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, array.getDept());
				pstmt.setInt(2, array.getU_class());
				pstmt.setInt(3, array.getCourse());
				pstmt.setString(4, array.getUname());
				pstmt.executeUpdate();
				System.out.println("更新成功");
				return true;
			}
		} catch (Exception e) {
			System.out.println("更新失败");
		}
		return false;
	}

	// 根据用户姓名来批量更新数据----------这是教师页面
	public boolean updateUserInfoById(String tb_name, UserData array) {
		try {
			String sql = "update " + tb_name
					+ " set rname=?,sex=?,role=?,phone=?,score=? where id=?";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, array.rname);
			pstmt.setString(2, array.sex);
			pstmt.setString(3, array.role);
			pstmt.setString(4, array.phone);
			pstmt.setInt(5, array.score);
			pstmt.setInt(6, array.id);
			System.out.println(array.rname + array.sex + array.role
					+ array.phone + array.score + array.id);
			int rows = pstmt.executeUpdate();

			if (rows > 0) {
				System.out.println("第一次更新成功");
				sql = "update login set role=? where uname=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, array.role);
				pstmt.setString(2, array.uname);
				rows = pstmt.executeUpdate();
				if (rows > 0) {
					System.out.println("更新成功");
					return true;
				}
			}
		} catch (Exception e) {
			System.out.println("更新失败");
		}
		return false;
	}

	// 根据用户ID来改变用户权限
	public boolean changeRoleById(String tb_name, int id, String role) {
		try {
			String sql1 = "update " + tb_name + " set role=? where id=?";
			System.out.println(sql1);
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, role);
			pstmt.setInt(2, id);
			int rows = pstmt.executeUpdate();
			System.out.println("更新权限" + rows);
			if (rows > 0)
				return true;
		} catch (Exception e) {
			// TODO
		}
		return false;
	}

	// 根据用户Name来改变用户权限
	public boolean changeRoleByName(String tb_name, String uname, String role) {
		try {
			String sql1 = "update " + tb_name + " set role=? where uname=?";
			System.out.println(sql1);
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, role);
			pstmt.setString(2, uname);
			int rows = pstmt.executeUpdate();
			System.out.println("更新权限" + rows);
			if (rows > 0)
				return true;
		} catch (Exception e) {
			// TODO
		}
		return false;
	}

	public boolean chageUserInfoPhoto(String uname, String photo) {
		try {
			String sql = "update tb_userinfo set photo=? where uname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, photo);
			pstmt.setString(2, uname);
			int i = pstmt.executeUpdate();
			if (i > 0)
				return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}

	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {

		}
	}

	public boolean importExcel2DB(ArrayList<TeacherInfo> teacherinfo) {
		// TODO Auto-generated method stub
		try {
			conn.setAutoCommit(false);
			for (int i = 0; i < teacherinfo.size(); i++) {
				TeacherInfo user = teacherinfo.get(i);
				String sql = "select * from tb_userinfo where uname=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user.getUname());
				rs = pstmt.executeQuery();
				if (!rs.next()) {
					String insertSql = "insert into tb_userinfo(uname,rname,role,patrol,phone,sex,position,score,photo) values(?,?,?,?,?,?,?,?,?)";
					pstmt = conn.prepareStatement(insertSql);
					// pstmt.setLong(1, user.getId());
					pstmt.setString(1, user.getUname());
					pstmt.setString(2, user.getRname());
					pstmt.setString(3, user.getRole());
					pstmt.setString(4, user.getPatrol());
					pstmt.setString(5, user.getPhone());
					pstmt.setString(6, user.getSex());
					pstmt.setString(7, user.getPosition());
					pstmt.setInt(8, user.getScore());
					pstmt.setString(9, user.getPhoto());

					pstmt.executeUpdate();
				} else {
					System.out.println("重复数据");
				}
			}
			conn.commit();
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return false;
	}

	public List<Map<String, String>> findClassInfo(String tb_name, int page,
			int rows, String mainteacher, String[] array) {
		// TODO Auto-generated method stub
		try {

			String sql1 = "select * from " + tb_name + " limit ?,?";
			if (!mainteacher.equals("")) {
				String sql3 = "select * from " + tb_name
						+ " where mainteacher like ?  limit ?,?";
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, "%" + mainteacher + "%");
				pstmt.setInt(2, rows * (page - 1));
				pstmt.setInt(3, rows);
			} else {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setInt(1, rows * (page - 1));
				pstmt.setInt(2, rows);
			}

			ArrayList al = new ArrayList();
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
				}
				al.add(map);
			}
			return al;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	// 根据用户姓名来批量更新数据----------这是班级页面
	public boolean updateClassInfoById(String tb_name, ClassData array) {
		try {
			String sql = "update "
					+ tb_name
					+ " set mainteacher=?,phone=?,dept=?,class=?,score=? where id=?";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, array.mainteacher);
			pstmt.setString(2, array.phone);
			pstmt.setInt(3, array.dept);
			pstmt.setInt(4, array.d_class);
			pstmt.setFloat(5, array.score);
			pstmt.setInt(6, array.id);
			System.out.println(array.mainteacher + array.dept + array.d_class
					+ array.phone + array.score + array.id);
			int rows = pstmt.executeUpdate();

			if (rows > 0) {
				System.out.println("更新成功");
				return true;
			}
		} catch (Exception e) {
			System.out.println("更新失败");
		}
		return false;
	}

	// 这是删除班级信息

	public boolean deleteClassInfoById(String tb_name2, int id) {
		try {
			conn.setAutoCommit(false);
			String sql1 = "delete from " + tb_name2 + " where id=?";
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			System.out.println("删除用户数据");
			conn.commit();
			return true;
		} catch (Exception e) {
			System.out.println("删除失败");
		}
		return false;
	}

	public List<Map<String, String>> getSelectItem(String tb_name) {
		try {
			ArrayList a1 = new ArrayList();
			String sql = "select * from " + tb_name;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				map.put("id", rs.getInt(1));
				map.put("name", rs.getString(2));
				a1.add(map);
			}
			return a1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
	}

	public Boolean recordMsg(RecordData array) {
		try {
			System.out.println("DButils进入");
			String sql = "insert into tb_record(dept,class,course,late,lazy,play,book,sleep,ontime,onaction,remarks,date) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, array.getDept());
			pstmt.setInt(2, array.getU_class());
			pstmt.setInt(3, array.getCourse());
			pstmt.setInt(4, array.getLate());
			pstmt.setInt(5, array.getTable());
			pstmt.setInt(6, array.getPlay());
			pstmt.setInt(7, array.getBook());
			pstmt.setInt(8, array.getSleep());
			pstmt.setString(9, array.getOntime());
			pstmt.setString(10, array.getOnaction());
			pstmt.setString(11, array.getRemarks());
			pstmt.setString(12, array.getDate());
			System.out.println("完整" + sql);
			int rows = pstmt.executeUpdate();
			if (rows > 0) {
				System.out.println("录入成功");
				return true;
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println("录入失败");
		}
		return false;
	}

	// 更新成绩
	public String updateScore(ClassData array) {
		try {
			String sql2 = "select score from tb_classinfo where class=? and dept=? ";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, array.getD_class());
			pstmt.setInt(2, array.getDept());
			rs = pstmt.executeQuery();
			System.out.println(array.getD_class() + "    " + array.getDept()
					+ "    " + array.getCourse());
			if (rs.next()) {
				float score = rs.getFloat(1);
				System.out.println(score);
				score -= array.score;
				String sql = "update  tb_classinfo  set score=(?) where class=? and dept=? ";
				System.out.println(sql);
				pstmt = conn.prepareStatement(sql);
				pstmt.setFloat(1, score);
				pstmt.setInt(2, array.getD_class());
				pstmt.setInt(3, array.getDept());
				int rows = pstmt.executeUpdate();
				if (rows > 0) {
					System.out.println("班级分数已经录入");
					// 教师分数更新
					sql = "select u_id from tb_teach where c_id=? and d_id=? and k_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, array.getD_class());
					pstmt.setInt(2, array.getDept());
					pstmt.setInt(3, array.getCourse());
					rs = pstmt.executeQuery();
					System.out.println("教师U_id,SQL查询");
					if (rs.next()) {
						int u_id = rs.getInt(1);
						System.out.println("教师U_id已经找到，开始查找教师Score" + u_id);
						sql = "select score from tb_userinfo where id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, u_id);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							System.out.println("教师score准备更新");
							score = rs.getFloat(1);
							score -= array.t_score;
							sql = "update tb_userinfo set score=(?) where id=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setFloat(1, score);
							pstmt.setInt(2, u_id);
							rows = pstmt.executeUpdate();
							if (rows > 0) {
								System.out.println("分数更新成功");
								return "updateSuccess";
							} else {
								System.out.println("教师score更新失败");
							}
						}
					} else {
						return "noteacher";
					}

				} else {
					System.out.println("分数更新失败");
				}
			} else {
				return "noclass";
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("更新失败");
		}
		return "updateFailed";
	}

	// 获取单个人信息
	public List<Map<String, String>> findSingleUser(String tb_name,
			String uname, String[] array) {
		try {
			ArrayList al = new ArrayList();
			String sql = "select * from tb_userinfo where uname =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
				}
				al.add(map);
				return al;
			}

		} catch (SQLException e) {
			System.out.println("失败");
		}
		return null;
	}

	public List<Map<String, String>> findRnameUser(String tb_name,
			String rname, String[] array) {
		try {
			ArrayList al = new ArrayList();
			String sql = "select * from tb_userinfo where rname =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
				}
				al.add(map);
				return al;
			}

		} catch (SQLException e) {
			System.out.println("失败");
		}
		return null;
	}

	// 获取教课表信息
	public List<Map<String, String>> findTeach(String tb_name, String uname,
			String[] array) {
		try {
			ArrayList al = new ArrayList();
			String sql = "select * from tb_userinfo where uname =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "select * from tb_teach where u_id =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt(1));
				rs = pstmt.executeQuery();
				if (rs.next()) {
					Map map = new HashMap();
					for (int i = 0; i < array.length; i++) {
						String string = array[i];
						map.put(string, rs.getString(i + 1));
					}
					al.add(map);
					return al;
				}
			}
		} catch (SQLException e) {
			System.out.println("失败");
		}
		return null;
	}

	// 获取高一年级班数
	public int getTbSize1(String tb_name) {
		try {
			String sql = "select count(*)from tb_classinfo where dept=1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return 0;
	}

	// 获取年级数据
	public List<Map<String, String>> updateGradescore1(String tb_name,String[] array) {
		try {

			ArrayList al = new ArrayList();
			String sql = "select * from tb_classinfo  where dept =1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i +1));
				}
				al.add(map);
			}
			return al;

		} catch (SQLException e) {
			System.out.println("hohoho");
		}

		return null;
	}

	// 获取高2年级班数
	public int getTbSize2(String tb_name) {
		try {
			String sql = "select count(*)from tb_classinfo where dept=2";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return 0;
	}

	// 获取年级数据
	public List<Map<String, String>> updateGradescore2(String tb_name, String[] array) {

		ArrayList al = new ArrayList();
		String sql = "select * from tb_classinfo  where dept=2";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
				}
				al.add(map);
			}
			return al;
		} catch (SQLException e) {
			System.out.println("hohoho");
		}

		return null;
	}

	// 获取高3年级班数
	public int getTbSize3(String tb_name) {
		try {
			String sql = "select count(*)from tb_classinfo where dept=3";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return 0;
	}

	// 获取年级数据
	public List<Map<String, String>> updateGradescore3(String tb_name, String[] array) {

		ArrayList al = new ArrayList();
		String sql = "select * from tb_classinfo  where dept=3";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
				}
				al.add(map);
			}
			return al;
		} catch (SQLException e) {
			System.out.println("hohoho");
		}

		return null;
	}

	// 获取高4年级班数
	public int getTbSize4(String tb_name) {
		try {
			String sql = "select count(*)from tb_classinfo where dept=4";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return 0;
	}

	// 获取年级数据
	public List<Map<String, String>> updateGradescore4(String tb_name, String[] array) {

		ArrayList al = new ArrayList();
		String sql = "select * from tb_classinfo  where dept=4";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
				}
				al.add(map);
			}
			return al;
		} catch (SQLException e) {
			System.out.println("hohoho");
		}

		return null;
	}
	// 获取班级1数据
	public int getTbSize5(String tb_name,int dept,int classone) {
		try {
			String sql = "select count(*)from tb_classinfo where dept=? and class=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dept);
			pstmt.setInt(2, classone);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return 0;
	}
	
	// 获取班级1数据
	public List<Map<String, String>> classCompare1(String tb_name, String[] array,int dept,int classone) {
		
		ArrayList al = new ArrayList();
		String sql = "select * from tb_classinfo  where dept=? and class=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,dept);
			pstmt.setInt(2,classone);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
					
				}
				al.add(map);
				System.out.println("noo");
			}
			return al;
		} catch (SQLException e) {
			System.out.println("hohoho");
		}
		
		return null;
	}
	// 获取班级2数据
	public int getTbSize6(String tb_name,int dept,int classtwo) {
		try {
			String sql = "select count(*)from tb_classinfo where dept=? and class=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dept);
			pstmt.setInt(2, classtwo);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return 0;
	}
	
	// 获取班级2数据
	public List<Map<String, String>> classCompare2(String tb_name, String[] array,int dept,int classtwo) {
		
		ArrayList al = new ArrayList();
		String sql = "select * from tb_classinfo  where dept=? and class=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,dept);
			pstmt.setInt(2,classtwo);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Map map = new HashMap();
				for (int i = 0; i < array.length; i++) {
					String string = array[i];
					map.put(string, rs.getString(i + 1));
				}
				al.add(map);
			}
			return al;
		} catch (SQLException e) {
			System.out.println("hohoho");
		}
		
		return null;
	}
	
	
		
}
