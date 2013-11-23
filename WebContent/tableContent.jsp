<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.hadoop.conf.Configuration,
org.apache.hadoop.hbase.HBaseConfiguration,
org.apache.hadoop.hbase.client.HTable,
org.apache.hadoop.hbase.HColumnDescriptor,
java.util.Collection,
org.apache.hadoop.hbase.client.ResultScanner,
org.apache.hadoop.hbase.client.Scan,
org.apache.hadoop.hbase.client.Result,
org.apache.hadoop.hbase.util.Bytes" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% String tableName = request.getAttribute("tableName").toString(); %>
<title><%= tableName %></title>
</head>
<body>

<%
Configuration conf = (new HBaseConfiguration()).create();
HTable table = new HTable(conf, String.valueOf(tableName));
Collection<HColumnDescriptor> descs = table.getTableDescriptor().getFamilies();
%>
<table border='2'>
<tr>
<% for (HColumnDescriptor coldesc : descs) { %>
<td><%= coldesc.getNameAsString()%></td>
<% } %>
</tr>
<% ResultScanner scanner = table.getScanner(new Scan());
for (Result rr = scanner.next(); rr != null; rr = scanner.next()) {
%>
<tr>
<% for (HColumnDescriptor coldesc : descs) {
        try {
        String value = new String(rr.getValue(coldesc.getName(), coldesc.getName()));
         %>
<td><%= value %></td>
<%
        }
        catch (NullPointerException e) { %>
        <td></td>
<%                System.out.println(coldesc.getNameAsString());
        }
        } %>
</tr>
<% } %>
</table>
<% table.close(); %>
</body>
</html>