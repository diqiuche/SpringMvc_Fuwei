<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@page import="com.fuwei.commons.SystemCache"%>
<%@page import="com.fuwei.util.SerializeTool"%>
<%@page import="com.fuwei.util.DateTool"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.fuwei.entity.producesystem.SelfFuliaoIn"%>
<%@page import="com.fuwei.entity.producesystem.SelfFuliaoInDetail"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//辅料入库单
	SelfFuliaoIn object = (SelfFuliaoIn) request.getAttribute("selfFuliaoIn");
	String employee_name = SystemCache.getEmployeeName(object.getCharge_employee())  ;//跟单人
	List<SelfFuliaoInDetail> detaillist = object == null ? new ArrayList<SelfFuliaoInDetail>() :object.getDetaillist();
	String date_string = DateTool.formatDateYMD(DateTool.getYanDate(object.getDate()));
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>打印自购辅料标签 -- 桐庐富伟针织厂</title>
		<meta charset="utf-8">
		<meta http-equiv="keywords" content="针织厂,针织,富伟,桐庐">
		<meta http-equiv="description" content="富伟桐庐针织厂">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<script src="js/plugins/jquery-1.10.2.min.js"></script>
		<script src="js/plugins/jquery-barcode.min.js"></script>
		<!-- 为了让IE浏览器运行最新的渲染模式 -->

		<style type="text/css">
body {
	margin: auto;
	font-family: "Microsoft Yahei", "Verdana", "Tahoma, Arial",
		"Helvetica Neue", Helvetica, Sans-Serif, "SimSun";
	font-size: 14px;
}

.gridTab {
	height: 10cm;
	width: 7cm;
	margin: auto;
    padding-left: 3px;
    font-size: 15px;
}
.pull-right {
	float: right;
}
.tagWidget{margin:auto;}
table tr td.firsttd{width:75px;}
table caption strong{width: 250px;display: inline-block;}
</style>

	</head>
	<body class="">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12 tablewidget">
					<%for(SelfFuliaoInDetail detail : detaillist){
						String tag_string = object.getId() + "_" + detail.getId();
					%>
					<div style="page-break-after: always">
						<div class="gridTab auto_container">
							<table class="table noborder tagWidget">
								<caption>
									<div tag_string='<%=tag_string %>' class="id_barcode"></div>
									<strong>入库自购辅料标签</strong>
									<div><%=object.getOrderNumber() %> -- <%=object.getNumber()%> -- <%=employee_name %></div>
								</caption>
								<tr>
									<td class="firsttd">
										款名：
									</td>
									<td><%=object.getName() %></td>
								</tr>
								<tr>
									<td class="firsttd">
										辅料类型：
									</td>
									<td><%=SystemCache.getFuliaoTypeName(detail.getStyle()) %></td>
								</tr>
								<tr>
									<td class="firsttd">
										入库数量：
									</td>
									<td><%=detail.getQuantity() %></td>
								</tr>
								<tr>
									<td class="firsttd">
										库位：
									</td>
									<td><%=SystemCache.getLocationNumber(detail.getLocationId()) %></td>
								</tr>
								<tr>
									<td class="firsttd">
										备注：
									</td>
									<td><%=detail.getMemo() == null ? "": detail.getMemo()%></td>
								</tr>
								<tr>
									<td class="firsttd">
										入库时间：
									</td>
									<td><%=date_string %></td>
								</tr>

							</table>
							
						</div>
					</div>
				</div>
				<%} %>
			</div>

		</div>
		</div>
		<script type="text/javascript">
	$(".id_barcode").each( function() {
		var id = $(this).attr("tag_string");
		$(this).barcode(id, "code128", {
			barWidth :2,
			barHeight :30,
			showHRI :false
		});
	});
	window.print();
</script>
	</body>
</html>