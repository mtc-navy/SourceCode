<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0" />
        <link rel="stylesheet" href="layui/css/layui.css" />
        <link rel="stylesheet" href="css/global.css" />
        <link rel="stylesheet" href="//at.alicdn.com/t/font_774762_412l1yn4gmg.css" />
        <title>饲料账单</title>
    </head>

    <body>
        <header class="layui-bg-liner">
            <div class="layui-container">
                <div class="layui-row">
                    <div class="text-middle layui-pull-left">
                        <span class="main-title">
                        	<i class="layui-icon layui-icon-release" style="font-size: 22px;"></i> 饲料账单
                        </span>
                    </div>
                    <div class="layui-pull-right text-middle">
                        <ul class="layui-nav" style="padding: 0px;background: transparent" lay-filter="">
                            <li class="layui-nav-item">
                                <a href="javascript:;" style="font-size:16px ;">饲料账单</a>
                                <dl class="layui-nav-child">
                                	<dd><a href="index.html" style="font-size:16px ;">今日资讯</a></dd>
                                    <dd><a href="javascript:;" style="font-size:16px ;">饲料账单</a></dd>
                                    <dd><a href="piglet.html" style="font-size:16px ;">买羊明细</a></dd>
                                    <dd><a href="sale.html" style="font-size:16px ;">卖羊详情</a></dd>
                                    <dd><a href="vaccine.html" style="font-size:16px ;">疫苗接种</a></dd>
                                    <dd><a href="other.html" style="font-size:16px ;">其他收支</a></dd>
                                </dl>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </header>
        
        <section class="layui-container wrap">
            <div class="layui-row" style="margin-top: 10px;">
                <a href="addfeed.html" class="btn layui-btn layui-bg-liner layui-btn-lg layui-btn-fluid layui-btn-radius">添加记录</a>
            </div>
            <table id="account" lay-filter="account"></table>
        </section>
        
        
        <footer>
            <div class="footer-nav">
            	<a href="index.html" class="on-this">
            	    <i class="iconfont icon-shouye" style="font-size: 20px;"></i><br />
            	    <span>首页</span>
            	</a>
            	<a href="count.html">
            	    <i class="iconfont icon-tongji" style="font-size: 20px;"></i><br />
                    <span>统计</span>
            	</a>
            	<%--<a href="prices.html">
            	    <i class="iconfont icon-jiage" style="font-size: 20px;"></i><br />
                    <span>羊价</span>
            	</a>--%>
            	<a href="setting.html">
            	    <i class="iconfont icon-shezhichilun" style="font-size: 20px;"></i><br />
                    <span>设置</span>
            	</a>
            </div>
        </footer>
        
        <script type="text/javascript" src="layui/layui.js"></script>
        <script type="text/javascript">
            layui.use(['element','table','layer'], function() {
                var element = layui.element,
                $ = layui.jquery,
                table = layui.table,
                layer = layui.layer;

                //数据展示
                var dt = table.render({
                    elem:"#account",
                    id:'t-date',
	                url:"feedrecord",
                    page:true,
                    limit:7,
                    page:{  
                    	prev:'上一页',
                        next:'下一页',
                        layout:['prev', 'page', 'next','count'],
                        groups:4
                    },
                	cols: [[ //表头
                       {title:'操作',align:'center',width:115,toolbar:'#tools'}
                      ,{field: 'feedPayState', title: '状态',align:'center',width:75}
                      ,{field: 'sendDate', title: '日期', sort: true,align:'center',width:85}
                      ,{field: 'feedQuantity', title: '数量',align:'center'}
                      ,{field: 'feedTotal', title: '总价',align:'center',width:75}
                      ,{field: 'feedArrears', title: '欠款',align:'center',width:75}
                      ,{field: 'feedPrice', title: '单价',align:'center',width:75}
                	]]
                });
                
                table.on('tool(account)',function(obj){
                    var data = obj.data;
                    var layEvent = obj.event;
                    var tr = obj.tr;
                    if(layEvent === 'edit'){
						window.location.href="updatefeed.html?feedID="+data.feedID;
                    }
                    if(layEvent === 'delete'){
                        layer.confirm('确认删除当前数据吗？',{icon:3}, function(index){
                        	$.post("deletefeed",{feedID:data.feedID},function(result){
                        		if(result=="OK"){
		                            obj.del();
                            		layer.msg('删除成功');
                            		dt.reload({
                            			page:{curr:1}
                            		});
                        		}else{
                        			layer.msg("删除失败,请稍后重试");
                        		}
                        	});
                        });
                    }
                });
            });
        </script>
        <!--操作按钮-->
        <script type="text/html" id="tools">
        	<a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
        	<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
        </script>
        <!--单元格样式-->
        <script type="text/html" id="stateTpl">
          {{#  if(d.feedPayState === '已付'){ }}
            <span style="color: #009688;">{{ d.feedPayState}}</span>
          {{#  } else { }}
            <span style="color: #FF5722;">{{ d.feedPayState }}</span>
          {{#  } }}
        </script>
    </body>
</html>