<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.hadoop.conf.Configuration, 
org.apache.hadoop.hbase.HBaseConfiguration, 
org.apache.hadoop.hbase.client.HBaseAdmin, 
org.apache.hadoop.hbase.HTableDescriptor" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Existing Projects</title>
</head>
<body>
<ul>
<% 
Configuration conf = (new HBaseConfiguration()).create();
HBaseAdmin hbaseAd = new HBaseAdmin(conf);
HTableDescriptor[] projNames = hbaseAd.listTables();
for (HTableDescriptor projName : projNames) { %>
<li><a href="./project/<%= projName.getNameAsString() %>"><%= projName.getNameAsString() %></a></li>
<% }
hbaseAd.close();
%>
</ul>
</body>
</html>