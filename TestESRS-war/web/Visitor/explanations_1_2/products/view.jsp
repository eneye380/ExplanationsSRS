<%-- 
    Document   : index
    Created on : Jul 16, 2015, 1:30:21 PM
    Author     : eneye380
--%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%--Visitor/explanations/products/products.jsp--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="aspect.bean.CategorySB"%>
<%@page import="aspect.bean.ProductSetSB"%>
<%@page import="aspect.model.Productdetail"%>
<%@page import="aspect.bean.ProductSB"%>
<%@page import="aspect.model.Queryproductandrecommendation"%>
<%@page import="java.util.ArrayList"%>
<%@page  import="aspect.bean.ProductSBLocal"%>
<%@include file="../header/headerproductview.jsp" %>
<!-- Page Content -->
<script>


</script>
<style>
    .a,.b,.c{

    }
    .c{

    }
    .recommendation{
        /**background: rgb(60,90,100);*/
        background: rgb(10,50,50);

    }
    .rec_prodname_h4{
        color: grey;
    }
    .nhidden{
        color:white;
    }
    .aspect{
        background: rgb(10,50,50);
        color:orange;
    }
    .top_m1{
        position:relative;
        top:-10px;        
    }
    .top_m2{
        position:relative;
        top:-20px;        
    }
    .top_m3{
        position:relative;
        top:-30px;        
    }
    .top_m4{
        position:relative;
        top:-40px;        
    }
    .top_m5{
        position:relative;
        top:-50px;        
    }
    .top_m6{
        position:relative;
        top:-60px;        
    }
    .desc{
        color:sienna;         
    }
</style>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.symbol.js" type="text/javascript" ></script>
<script src="https://cdn.jsdelivr.net/jquery.flot/0.8.3/jquery.flot.resize.js" type="text/javascript" ></script>
<!--script src="https://raw.github.com/xuanluo/flot-axislabels/master/jquery.flot.axislabels.js" type="text/javascript" ></script-->
<script src="https://cdn.jsdelivr.net/jquery.flot.tooltip/0.8.4/jquery.flot.tooltip.min.js" type="text/javascript" ></script>
<script src="http://code.highcharts.com/highcharts.js" type="text/javascript" ></script>




<div class="container" id="pbody">

    <jsp:useBean id="recommend" class="aspect.bean.ProductSetSB" scope="request"/>
    <jsp:setProperty name="recommend" property="queryProduct" param="product" />
    <%
    %>

    <%    String s = recommend.getQueryProduct();
        //String r1,r2,r3;
        //r1 = recommend.getProduct1();
        //r2 = recommend.getProduct2();
        //r3 = recommend.getProduct3();
        ArrayList<ProductSetSB> p = recommend.getSet();
        ArrayList<String> myR = new ArrayList();
        if (p.size() > 1) {
            for (int i = 0; i < p.size(); i++) {
                ProductSetSB l = p.get(i);
                //out.println(l.getProduct());
                myR.add(l.getProduct());
            }
        }

    %>
    <jsp:useBean id="detail" class="aspect.bean.ProductDetailSB" scope="request"/>
    <jsp:setProperty name="detail" property="prodid" value="<%=s%>"/>
    <jsp:setProperty name="detail" property="recommSet" value="<%=myR%>"/>

    <%
        ArrayList<Productdetail> d = detail.retrieveDetail();
    %>  

    <%
        Productdetail pdqp = d.get(0);
    %>

    <jsp:useBean id="aspectScore" class="aspect.bean.AspectScoreSB" scope="request"/>
    <jsp:setProperty name="aspectScore" property="prodid" value="<%=s%>"/>
    <jsp:setProperty name="aspectScore" property="recommSet" value="<%=myR%>"/>
    <%--
        Map<String, Map<String, Map<String, Number>>> scores = new HashMap();
        scores = aspectScore.retrieveAspectScores();
    --%>
    <%
        Map<String, Map<String, Map<String, Number>>> productScoresMap = new HashMap();
        productScoresMap = aspectScore.retrieveAspectScores();
    %>
    <!--jsp:getProperty name="aspectScore" property="scoreSet"/-->
    <!--%=scores%-->
    <body id="body" onload="retrievePRJSONDetail('<%=s%>', '1')">

        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" >
            <div class="container-fluid" >
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../welcome/">ESRS</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="#">Products</a>
                        </li>
                        <li>
                            <a href="#">Concept</a>
                        </li>
                        <li>
                            <a href="#" onclick="">About</a>
                        </li>
                    </ul>
                    <span class="pull-right" style="color:rgb(255,247,217)"><%=dd%></span>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>



        <div class="row"  >

            <!--div class="col-md-2 col-sm-2 col-xs-12 well aspect">
            <%@include file="../sidebar/sidebar.jsp" %>
        </div-->

            <!--Side Bar Start><-->


            <div class="col-md-2 col-sm-2 col-xs-12 well aspect">
                <jsp:useBean id="category_1" class="aspect.bean.CategorySB" scope="request"/>
                <%--jsp:getProperty name="category" property="catSet"/--%>
                <%
                    ArrayList<CategorySB> cc = category_1.getCatSet();

                %>


                <div class="btn-group" style="margin-top: 5px;">
                    <button type="button" class="btn btn-primary" id="button_category">Category</button>
                </div>
                <div class="category_selection" style="margin-top: 5px;display1:none">
                    <div class="list-group ">
                        <%for (int r = 0; r < cc.size(); r++) {%>
                        <%CategorySB ct = cc.get(r);%>


                        <a href="../products/category.jsp?category=<%=ct.getCategory()%>" class="list-group-item "><%=ct.getCategory()%></a>                    
                        <%}%>
                    </div>

                </div>
                <!-- Algorithm to finds common aspects-->
                <% ArrayList<Double> l = new ArrayList();%>
                <%
                    //array storing common aspects
                    ArrayList<String> e = new ArrayList();%>
                <%
                    Map<String, Map<String, Number>> qPS = productScoresMap.get(s);
                    Set k = qPS.keySet();
                    Iterator i = k.iterator();
                    int count = 0;
                    while (i.hasNext()) {

                        String key = (String) i.next();
                        //Map<String, Number> value = (Map) qPS.get(key);
                        int sent = myR.size();
                        for (int b = 0; b < myR.size(); b++) {
                            Map<String, Map<String, Number>> rPS = productScoresMap.get(myR.get(b));
                            if (rPS.containsKey(key)) {
                                sent--;
                            }
                            if (sent == 0) {
                                if (!e.contains(key)) {
                                    e.add(key);
                                    count++;
                                }
                            }
                        }
                    }

                %>

                <div class="btn-group" style="margin-top: 10px">
                    <button type="button" class="btn btn-primary btn-xs" id="button_aspect">Shared Aspects</button>
                    <button type="button" class="btn btn-primary btn-xs" id="button_aspect_reset" onclick="clearSelection('1')">Reset</button>
                </div>
                <div class="aspect_selection" style="display1:none;height:300px;overflow: auto">
                    
                    <form>
                        <%if(myR.size()!=0){%>
                        <%for (int r = 0; r < e.size(); r++) {%>
                        <%String key = e.get(r);%>
                        <div class="checkbox"><label><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this,'1')"><%=key%></label></div>                            
                                <%}%>
                        
                        <%} else if(productScoresMap.containsKey(s)) {%>
                            <%
                                Map<String, Map<String, Number>> productScores = productScoresMap.get(s);
                                Set keyset = productScores.keySet();
                                Iterator ite = keyset.iterator();

                            %>
                            <%while (ite.hasNext()) {%>
                            <%
                                String key = (String) ite.next();
                                Map<String, Number> value = (Map) productScores.get(key);
                                Number a = value.get("score");
                                double val = a.doubleValue();
                                double absVal = Math.abs(val);
                                double ii = val / absVal;
                                l.add(val);

                            %>
                            <%--if (ii == 1.0) {--%>
                            <!--li><%=key%> : <%=a%></li-->
                            <!--label class='checkbox-inline'><input type="checkbox" value="<%=key%>"><%=key%></label-->
                            <div class="checkbox"><label><input type="checkbox" value="<%=key%>" name="aspect<%=key%>" class="aspect_cb" onclick="aspectSelect(this,'2')"><%=key%></label></div>                            
                            <!--li><%=key%></li-->
                            <%--}--%>
                            <%}%>
                            <%}%>

                    </form>

                </div>
            </div>
            <%--=e--%>
            <!--Side Bar End><-->

            <!--Main Content Start><-->


            <div class="col-md-10 col-sm-10 col-xs-12">

                <div class="well">   

                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <h4 style="color:royalblue"><%=pdqp.getName()%></h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2 col-sm-6 col-xs-12">
                            <div>
                                <a href="detail.jsp?product=<%=pdqp.getProdid()%>"><img class="img-responsive " id="productimage" src="../../../img/<%=pdqp.getProdid()%>.jpg" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="heighth:90px"></a>
                            </div>
                        </div>
                        <!--div class="col-md-1 col-sm-6 col-xs-12">

                        </div-->

                        <div class="col-md-7 col-sm-6 col-xs-12 text-center thumbnail">
                            <h5>Sentiment Score</h5>
                            <div id="<%=s%>" id1="container" style="height:200px"></div>                            
                        </div>   
                        <div class="col-md-3 col-sm-6 col-xs-12 thumbnail" >
                            <p class="text-center">Description</p>
                            <div style="height:180px;overflow: auto">
                                <div  style="background: grey;padding:2px">
                                    <div style="background: white;height:" id="desc_1">
                                        <%
                                            String r = pdqp.getRating();
                                            double rr = 0.0;
                                            if (r != null) {
                                                if (!r.equalsIgnoreCase("null")) {
                                                    rr = Double.parseDouble(r);
                                                }
                                            }
                                        %>
                                        <p><span class="desc">Rating: </span><%=pdqp.getRating()%></p>
                                        <p class="top_m1"><span class="desc">Price: </span><%=pdqp.getPrice()%></p>
                                        <p class="top_m2"><span class="desc">Rank: </span><%=pdqp.getRank()%></p>
                                        <p class="top_m2"><span class="desc">Date: </span><%=pdqp.getDate()%></p>
                                        <p class="top_m3"><span class="desc">Category: </span><%=pdqp.getCategory()%></p>
                                        <p class="top_m4"><span class="desc">No. of Questions: </span><%=pdqp.getNquestions()%></p> 
                                        <p class="top_m5"><span class="desc">No. of Comments: </span><%=pdqp.getNcomments()%></p>                                                
                                        <p class="top_m6"><span class="desc">No. of Reviews: </span><%=pdqp.getNreviews()%></p>                                                
                                    </div>
                                </div>
                            </div>                                    
                        </div>
                    </div>


                    <div class="well" style="height:300px;overflow:scroll">

                        <div class="row text-left">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <h4 style="position: relative;top: -20px">Here are Recommended Products<!--a class="btn btn-success pull-right">Compare</a--></h4>
                                <p style="position: relative;top: -20px">(<%=count%>) common aspects - change display from sidebar</p>
                            </div>
                        </div>

                        <!--div class="text-right">
                            <a class="btn btn-success pull-right">Compare</a>
                        </div-->
                        <!--hr-->
                        <div class="row well recommendation" style="position: relative;top: -15px">                            
                            <div class="col-md-12 col-sm-12 col-xs-12">  
                                <div class="row text-center">

                                    <%Productdetail pdr = null;%>
                                    <%if ((d.size() > 1)) {%>
                                    <%--for (int m = 0; m < d.size(); m++) {--%>
                                    <%for (int m = 0; m < 4; m++) {%>
                                    <%if (m != 0) {%>
                                    <%pdr = d.get(m);%>

                                    <div class="col-md-3 col-sm-6 col-xs-12 thumbnail" >
                                        <img src="../../../img/<%=pdr.getProdid()%>.jpg" alt="" class="img-thumbnail" style="height:100px;width:50%">
                                        <div class="caption">                                            
                                            <div style="height: 20px;overflow: hidden"><h6><%=pdr.getName()%></h6></div>                                            
                                            <p>

                                            <form action="view.jsp" style="display:inline">
                                                <input type="hidden" name="product" id="prod_4" value="<%=pdr.getProdid()%>">
                                                <input type="submit" value="View" class="btn btn-primary" >
                                            </form>
                                            <form action="detail.jsp" style="display:inline">
                                                <input type="hidden" name="product" id="prod_4" value="<%=pdr.getProdid()%>">
                                                <input type="submit" value="Detail" class="btn btn-primary" >
                                            </form>
                                            </p>
                                        </div>
                                        <span class="pull-left" style="color:white"></span>
                                    </div> 



                                    <!--hr-->
                                    <%}%>
                                    <%}%>
                                    <%} else {%>                    
                                    <h4 style="color:red">Sorry No Available Recommendations</h4>
                                    <%}%>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>

            <!--Main Content End><-->


            <!-- /.container -->
            <div class="container">

                <hr>

                <%@include file="../footer/footer.jsp" %>
