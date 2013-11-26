package com.refine.controller;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.script.SimpleBindings;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.HColumnDescriptor;

import java.io.IOException;
import java.util.Collection;

import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.util.Bytes;

public class AddColumnByExprOperation {
	public void doOperation(String tableName, String colName, String expr) {
		ScriptEngineManager mgr = new ScriptEngineManager();
		ScriptEngine engine = mgr.getEngineByName("JavaScript");
		Configuration conf = (new HBaseConfiguration()).create();
		
		try {
			HBaseAdmin admin = new HBaseAdmin(conf);
			admin.disableTable(tableName);
			HColumnDescriptor cf1 = new HColumnDescriptor(colName);
			admin.addColumn(tableName, cf1);
			admin.enableTable(tableName);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		HTable table;
		SimpleBindings b = new SimpleBindings();
		try {
			table = new HTable(conf, String.valueOf(tableName));
			Collection<HColumnDescriptor> descs = table.getTableDescriptor().getFamilies();
			ResultScanner scanner = table.getScanner(new Scan());
			for (Result rr = scanner.next(); rr != null; rr = scanner.next()) {
				int i = 1;
				b.clear();
				for (HColumnDescriptor coldesc : descs) {
					try {
						String value = new String(rr.getValue(coldesc.getName(), coldesc.getName()));
						b.put("$col" + Integer.toString(i) , value);
						i++;
					}
					catch (NullPointerException e) {
					}
				}
				//System.out.println(b.keySet());
				String resVal = engine.eval(expr, b).toString();
				Put put = new Put(rr.getRow());
				put.add(Bytes.toBytes(colName), Bytes.toBytes(colName), Bytes.toBytes(resVal));
				//System.out.println("Adding value " + resVal + " to column " + colName + " in table " + tableName);
				table.put(put);
			}
			table.close();

		} catch (IOException e) {
			e.printStackTrace();
		} catch (ScriptException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

}
