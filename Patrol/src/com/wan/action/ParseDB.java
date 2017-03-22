package com.wan.action;

import java.text.DecimalFormat;

import org.apache.poi.hssf.usermodel.HSSFCell;

public class ParseDB {
	static	public String parseDB(int celltype, HSSFCell hc) {
		
		if (celltype == HSSFCell.CELL_TYPE_STRING) {
			return String.valueOf(hc.getStringCellValue());
		} 
		else if (celltype == HSSFCell.CELL_TYPE_NUMERIC)
			return String.valueOf(new DecimalFormat("0").format(hc.getNumericCellValue()));
		else
			return String.valueOf(hc.getBooleanCellValue());

	}
}