<%-- 
    Document   : detail
    Created on : Jul 18, 2015, 3:38:20 PM
    Author     : eneye380
--%>

<%@page import="java.util.Collections"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
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
    table tr:nth-child(even) {
        background-color: #eee;
    }
    table tr:nth-child(odd) {
        background-color: #fff;
    }
    table th {
        color: white;
        background-color: rgb(10,50,50);;
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
    <jsp
        <%
            ArrayList<Productdetail> d = detail.retrieveDetail();
        %>  

        <%
            Productdetail pdqp = d.get(0);
        %>

        <jsp:useBean id="aspectScore" class="aspect.bean.AspectScoreSB" scope="request"/>
        <jsp:setProperty name="aspectScore" property="prodid" value="<%=s%>"/>
        <jsp:setProperty name="aspectScore" property="recommSet" value="<%=myR%>"/>
        <%
            Map<String, Map<String, Map<String, Number>>> productScoresMap = new HashMap();
            productScoresMap = aspectScore.retrieveAspectScores();
        %>
        <!--jsp:getProperty name="aspectScore" property="scoreSet"/-->
        <%--=productScoresMap--%>
        <%
            String[] data = null;
            int pos = 0;
            int neg = 0;
            if (productScoresMap.containsKey(s)) {
                Map<String, Map<String, Number>> productScores = productScoresMap.get(s);
                Set keyset = productScores.keySet();
                Iterator ite = keyset.iterator();
                Iterator it = keyset.iterator();
                int w = 0;
                while (it.hasNext()) {
                    it.next();
                    w++;
                }
                data = new String[w];
                while (ite.hasNext()) {
                    String key = (String) ite.next();
                    Map<String, Number> value = (Map) productScores.get(key);
                    Number a = value.get("score");
                    double val = a.doubleValue();
                    double absVal = Math.abs(val);
                    double ii = val / absVal;
                    if(ii == 1.0){
                        pos++;
                    }else if(ii == -1.0){
                        neg++;
                    }
                }
            }
        %>
        <%--=data[0]--%>
        <body id="body" onload="retrievePRJSONDetail('<%=s%>', '2')">

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
            <%!
                public class Sort {

                    String aspect;
                    int freq;
                    double score;
                    double gini;

                    public Sort() {
                        aspect = "";
                        score = 0.0;
                        gini = 0.0;
                        freq = 0;
                    }

                }
                                                                                %>
            <% ArrayList<Double> l = new ArrayList();%>

            <%-- Collections.sort(l); --%>
            <%--for (Double e : l) {
                    out.println(e + "<br>");
                }--%>

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
                    <div class="btn-group" style="margin-top: 10px">
                        <button type="button" class="btn btn-primary" id="button_aspect">Aspects</button>
                        <button type="button" class="btn btn-primary" id="button_aspect_reset" onclick="clearSelection('2')">Reset</button>
                    </div>
                    <div class="aspect_selection" style="display1:none;height:300px;overflow: auto">
                        <form onclick1="showMe()">
                            <%if (productScoresMap.containsKey(s)) {%>
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
                            <div class="col-md-3 col-sm-6 col-xs-12">
                                <div>
                                    <img class="img-responsive" src="../../../img/<%=pdqp.getProdid()%>.jpg" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="height:150px">
                                </div>
                                <div class="row welll" style="position: relative;top: 0px" >                            
                                    <div class="col-md-12 col-sm-12 col-xs-12" style="position: relative;top: 0px"> 
                                        <div class="row text-left">
                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                <h6 style="color:black">Recommended Products</h6>
                                            </div>
                                        </div>
                                        <div class="row text-center">

                                            <div style="height:50px;overflow: scroll">
                                                <%Productdetail pdr1 = null;%>
                                                <%if ((d.size() > 1)) {%>
                                                <%for (int m = 0; m < d.size(); m++) {%>
                                                <%if (m != 0) {%>
                                                <%pdr1 = d.get(m);%>

                                                <div class="col-md-3 col-sm-6 col-xs-6 thumbnaill" >
                                                    <a href="detail.jsp?product=<%=pdr1.getProdid()%>"><img src="../../../img/<%=pdr1.getProdid()%>.jpg" alt="" class="img-thumbnail" style="height:50px;">
                                                    </a>
                                                    <div class="caption">                                            
                                                        <div style="height: 20px;overflow: hidden"><h6 style="color:grey"><%=pdr1.getName()%></h6></div>                                            
                                                        <p>                                        
                                                        </p>
                                                    </div>
                                                    <span class="pull-left" style="color:white"></span>
                                                </div> 

                                                <%}%>
                                                <%}%>
                                                <%} else {%>                    
                                                <h6 style="color:red">Sorry No Available Recommendations</h6>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-9 col-sm-6 col-xs-12 text-center thumbnail">
                                <div class="row">                                
                                    <div class="col-md-3 col-sm-6 col-xs-12 text-center">
                                        <p class="top_m11"><span class="desc">Price: </span><%=pdqp.getPrice()%></p>
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-12 text-center">
                                        <p><span class="desc">Star Rating: </span><%=pdqp.getRating()%></p>
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-12 text-center">
                                        <p class="top_m21"><span class="desc">Rank: </span><%=pdqp.getRank()%></p>
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-12 text-center">
                                        <p class="top_m21"><span class="desc">Date: </span><%=pdqp.getDate()%></p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3 col-sm-6 col-xs-12 text-center">
                                        <p class="top_m31"><span class="desc">Category: </span><%=pdqp.getCategory()%></p>
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-12 text-center">
                                        <p class="top_m41"><span class="desc">No. of Questions: </span><%=pdqp.getNquestions()%></p> 
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-12 text-center">
                                        <p class="top_m51"><span class="desc">No. of Comments: </span><%=pdqp.getNcomments()%></p>                                                
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-12 text-center">
                                        <p class="top_m61"><span class="desc">No. of Reviews: </span><%=pdqp.getNreviews()%></p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12 text-center">
                                        <div class="btn-group text-center" style="margin-bottom:5px">
                                            <button class="btn btn-success btn-xs" style="color:black;background: gainsboro; border: gainsboro" id="bar">bar</button>
                                            <button class="btn btn-success btn-xs" style="color:black;background: gainsboro; border: gainsboro" id="line">line</button>
                                            <button class="btn btn-success btn-xs" style="color:black;background: gainsboro; border: gainsboro" id="scatter" onclick="generateScatterGrapgh('<%=s%>', 'scatter')">scatter</button>
                                            <button class="btn btn-success btn-xs" style="color:black;background: gainsboro; border: gainsboro" id="hide">hide</button>
                                            <!--button class="btn btn-success btn-xs" style="color:black;background: yellowgreen; border:greenyellow" id=""></button>
                                            <button class="btn btn-success btn-xs" style="color:black;background: yellowgreen; border:greenyellow" id=""></button-->
                                        </div>
                                        <h5>Sentiment Score</h5>
                                        <div style="height:300px">
                                            <div id="<%=s%>" class="explanationbar" style="height:300px"></div>  
                                            <div id="<%=s%>scatter" class="explanationscatter" style="height:300px"></div>  
                                        </div>
                                    </div>
                                </div>
                            </div>   
                            <!--Description-->
                            <!--div class="col-md-4 col-sm-6 col-xs-12 thumbnail" >
                                <p class="text-center">Description</p>
                                <div style="height:150px;overflow: auto">
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
            </div-->
                            <!-- End of Description-->
                        </div>                




                        <!--hr-->
                        <!--div class="row welll recommendation" style="position: relative;top: 0px">                            
                            <div class="col-md-12 col-sm-12 col-xs-12" style="position: relative;top: 0px"> 
                                <div class="row text-left">
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <h6 style="color:white">Recommended Products</h6>
                                    </div>
                                </div>
                                <div class="row text-center">
    
    
                        <%Productdetail pdr = null;%>
                        <%if ((d.size() > 1)) {%>
                        <%for (int m = 0; m < d.size(); m++) {%>
                        <%if (m != 0) {%>
                        <%pdr = d.get(m);%>
    
                        <div class="col-md-3 col-sm-6 col-xs-6 thumbnaill" >
                            <a href="detail.jsp?product=<%=pdr.getProdid()%>"><img src="../../../img/<%=pdr.getProdid()%>.jpg" alt="" class="img-thumbnail" style="height:50px;width:25%">
                            </a>
                            <div class="caption">                                            
                                <div style="height: 20px;overflow: hidden"><h6 style="color:white"><%=pdr.getName()%></h6></div>                                            
                                <p>                                        
                                </p>
                            </div>
                            <span class="pull-left" style="color:white"></span>
                        </div> 
    
                        <%}%>
                        <%}%>
                        <%} else {%>                    
                        <h6 style="color:red">Sorry No Available Recommendations</h6>
                        <%}%>
    
                    </div>
                </div>
            </div>
        </div-->
                        <%--
                            if (productScoresMap.containsKey(s)) {
                                Map<String, Map<String, Number>> productScores = productScoresMap.get(s);
                                Set keyset = productScores.keySet();
                                Iterator ite = keyset.iterator();
                                while (ite.hasNext()) {
                                    String key = (String) ite.next();
                                    Map<String, Number> value = productScores.get(key);
                                }
                            }
                        --%>

                        <%--if (productScoresMap.containsKey(s)) {%>
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
                        %>
                        <P><%%></p>
                            <%}%>
                            <%}--%>
                    </div>
                    <div class="well">
                        <div class="btn-group text-center" style="margin-bottom:5px">
                            <button class="btn btn-success btn-xs" style="color:black;background: greenyellow; border:greenyellow" id="table">Table of Aspects</button>
                            <button class="btn btn-success btn-xs" style="color:black;background: green; border:green" id="aspect">Negative and Positive Aspect</button>
                            <button class="btn btn-success btn-xs" style="color:black;background: yellowgreen; border:greenyellow" id="review">Reviews</button>
                        </div>
                        <div class="row" id="aspects_table" style="display:none">
                            <div class="col-lg-12">                                
                                <h4 style="color:grey">Table of Aspects</h4>                                
                                <div style="height:300px;overflow: scroll">
                                    <table class="table" style="margin:auto">
                                        <thead>                                        
                                            <tr>
                                                <th>Aspect</th>
                                                <th>Score</th>
                                                <th>Frequency</th>
                                                <th>Gini</th>
                                            </tr>
                                        </thead>
                                        <tbody style="height:300px;overflow: scroll">
                                            <%if (productScoresMap.containsKey(s)) {%>
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
                                            %>
                                            <tr>
                                                <td><%=key%></td>
                                                <td><%=value.get("score")%></td>
                                                <td><%=value.get("freq")%></td>
                                                <td><%=value.get("gini")%></td>
                                            </tr>

                                            <%}%>
                                            <%}%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>                        
                        </div>
                        <div class='row' id='product_reviews' style='display:none'>
                            <div class='col-md-12 col-sm-12 col-xs-12' >
                                <h4>Customer Review</h4>
                                <div class='thumbnail'>
                                    <p style='color:rosybrown'>anony</p>
                                    <p class='text-right'>great product</p>
                                </div>
                                <div class='thumbnail'>
                                    <p style='color:rosybrown'>pxstar</p>
                                    <p class='text-right'>This is an awesome camera for an entry level DSLR, in my mind Nikon's the best</p>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="aspects_scores" style="display:none">                        
                            <div class="col-md-6 col-sm-6 col-sm-12 well">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h5><em><span style='color:blue'>+ve</span></em><strong> sentiment's (<%=pos%>)</strong></h5>
                                    </div>
                                </div>
                                <div class="caption thumbnail">
                                    <form>
                                        <ul>
                                            <%if (productScoresMap.containsKey(s)) {%>
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
                                            %>
                                            <%if (ii == 1.0) {%>
                                            <!--li><%=key%> : <%=a%></li-->
                                            <!--label class='checkbox-inline'><input type="checkbox" value="<%=key%>"><%=key%></label-->
                                            <li><%=key%></li>
                                                <%}%>
                                                <%}%>
                                                <%}%>
                                        </ul>
                                    </form>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6 col-sm-12 well">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h5><em><span style='color:red'>-ve</span></em><strong> sentiment's (<%=neg%>)</strong></h5>
                                    </div>
                                </div>
                                <div class="caption thumbnail">
                                    <form>
                                        <ul>
                                            <%if (productScoresMap.containsKey(s)) {%>
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
                                            %>
                                            <%if (ii == -1.0) {%>
                                            <!--li><%=key%> : <%=a%></li-->
                                            <!--label class='checkbox-inline'><input type="checkbox" value="<%=key%>"><%=key%></label-->
                                            <li><%=key%></li>
                                                <%}%>
                                                <%}%>
                                                <%}%>
                                        </ul>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--/div-->
                </div>


                <!-- /.container -->
                <div class="container">

                    <hr>

                    <%@include file="../footer/footer.jsp" %>

