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
<script type='text/javascript' src='../media/js/jquery.js'></script>
<script type='text/javascript' src='../media/js/jquery-ui.js'></script>
<script type='text/javascript' src='../media/js/jquery.dataTables.js'></script>
<link rel='stylesheet' href='../media/css/jquery.dataTables.css'>
<link rel='stylesheet' href='../media/css/jquery-ui.css'>
<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				$('#contentTable').dataTable();
				$('#addColumnByExprForm').dialog({
					autoOpen: false,
					modal: true,
					width: 450,
					height: 300
				});
				$('#addColumnOperation').click(function() {
					$('#addColumnByExprForm').dialog("open");
				});
			} );
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% String tableName = request.getAttribute("tableName").toString(); %>
<title><%= tableName %></title>
</head>
<body>
<div style="float: left;">
<h3>Operations</h3>
<ul>
<li><button id='addColumnOperation'>Add Column</button></li>
</ul>
</div>
<div style="float: right;width:80%;">
<%
Configuration conf = (new HBaseConfiguration()).create();
HTable table = new HTable(conf, String.valueOf(tableName));
Collection<HColumnDescriptor> descs = table.getTableDescriptor().getFamilies();
%>
<table border='2' id='contentTable'>
<thead>
<tr>
<% for (HColumnDescriptor coldesc : descs) { %>
<th><%= coldesc.getNameAsString()%></th>
<% } %>
</tr>
</thead>
<tbody>
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
<%               // System.out.println(coldesc.getNameAsString());
        }
        } %>
</tr>
<% } %>
</tbody>
</table>
<% table.close(); %>
</div>
<div id='addColumnByExprForm' title='Add new column by expression'>
<form name='addColByExprForm' method='post'>
<label for='colName'>Column Name:</label>
<input id='colName' type='text' name='colName'><br/>
<label for='colExpr'>Column Expression:</label><br/>
<textarea id='colExpr' name='colExpr' rows='5' cols='80'>
</textarea><br />
<input type='submit' name='colExprFormSubmit'>
</form>
</div>
</body>
</html>