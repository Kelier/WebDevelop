package com.wan.action;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.alibaba.fastjson.JSON;
import com.wan.db.DBUtils;
import com.wan.db.TeacherInfo;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("struts-default")
@Namespace("/")
public class FindTeacherInfo extends ActionSupport {
	Map map;
	int page=1;
	int rows=5;
	String tb_name;
	String importFile;
	TeacherInfo teacherinfo;

	@Action("findTeacherInfo")
	public void findTeacherInfo() {
		String[] array= {"id","sid","tname","tage","tphone","email"};
		tb_name="teacherinfo";
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
	public String getImportFile() {
		return importFile;
	}

	public void setImportFile(String importFile) {
		this.importFile = importFile;
	}
	@Action(value = "excelImportDB")
	public void excelImportDB() {
		try {
			
			ArrayList<TeacherInfo> teaList = new ArrayList<TeacherInfo>();
			InputStream is = new FileInputStream(importFile);
			HSSFWorkbook hwb = new HSSFWorkbook(is);
			for (int i = 0; i < hwb.getNumberOfSheets(); i++) {
				HSSFSheet hs = hwb.getSheetAt(i);
				if (hs == null)
					continue;
				else {
					int firstrownum = hs.getFirstRowNum();
					int lastrownum = hs.getLastRowNum();
					//System.out.println(firstrownum+","+lastrownum);
					for (int j = firstrownum + 1; j <= lastrownum; j++) {
						HSSFRow hr = hs.getRow(j);
						int firstcolumnnum = hr.getFirstCellNum();
						int lastcolumnnum = hr.getLastCellNum();
						// System.out.println(firstcolumnnum+","+lastcolumnnum);
						String[] value = new String[lastcolumnnum];
						for (int k = firstcolumnnum; k < lastcolumnnum; k++) {
							HSSFCell hc = hr.getCell(k);
							value[k] = ParseDB.parseDB(hc.getCellType(), hc);
							 //System.out.print(value[k]+"\t");
						}
						TeacherInfo tea = new TeacherInfo();
						tea.setUname(value[1]);
						tea.setRname(value[2]);
						tea.setRole(value[3]);
						tea.setPatrol(value[4]);
						tea.setPhone(value[5]);
						tea.setSex(value[6]);
						tea.setPosition(value[7]);
						tea.setScore((int)Double.parseDouble(value[8]));
						tea.setPhoto(value[9]);
					
						teaList.add(tea);

					}
				}
			}
			for (int j = 0; j < teaList.size(); j++) {
				System.out.println(teaList.get(j).getUname());

			}
			DBUtils dbutils = new DBUtils();
			boolean temp = dbutils.importExcel2DB(teaList);
			if (temp) {
				System.out.println("导入数据成功");
			} else
				System.out.println("导入数据失败");
			dbutils.close();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

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

}
