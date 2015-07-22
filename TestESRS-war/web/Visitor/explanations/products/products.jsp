<%-- 
    Document   : index
    Created on : Jul 16, 2015, 1:30:21 PM
    Author     : eneye380
--%>
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
    <%
        Map<String, Map<String, Map<String, Number>>> scores = new HashMap();
        scores = aspectScore.retrieveAspectScores();
    %>
    <!--jsp:getProperty name="aspectScore" property="scoreSet"/-->
    <!--%=scores%-->
    <body id="body" onload="retrievePRJSONDetail('<%=s%>')">
        
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

        <div class="col-md-2 col-sm-2 col-xs-12 well aspect">
            <div class="btn-group">
                <button type="button" class="btn btn-primary" id="button_aspect">Aspects</button>
            </div>
            <div class="aspect_selection">
                <form onclick1="showMe()">
                <div class="checkbox"><label><input type="checkbox" value="style" name="aspect" class=" ">Style</label></div>
                <div class="checkbox"><label><input type="checkbox" value="performance" name="aspect" class="asp_sel">Performance</label></div>
                <div class="checkbox"><label><input type="checkbox" value="range" name="aspect" class="asp_sel">Range</label></div>
                <div class="checkbox"><label><input type="checkbox" value="sense" name="aspect" class="asp_sel">Sense</label></div>
                <div class="checkbox"><label><input type="checkbox" value="advantage" name="aspect" class="asp_sel">Advantage</label></div>
                <div class="checkbox"><label><input type="checkbox" value="result" name="aspect" class="asp_sel">Result</label></div>
                <div class="checkbox"><label><input type="checkbox" value="capability" name="aspect" class="asp_sel">Capabilty</label></div>
                <div class="checkbox"><label><input type="checkbox" value="color" name="aspect" class="asp_sel">Color</label></div>
                <div class="checkbox"><label><input type="checkbox" value="processing" name="aspect" class="asp_sel">Processing</label></div>
                <div class="checkbox"><label><input type="checkbox" value="notice" name="aspect" class="asp_sel">Notice</label></div>
                </form>
                <jsp:useBean id="category" class="aspect.bean.CategorySB" scope="request"/>
                <%--jsp:getProperty name="category" property="catSet"/--%>
                <%
                    ArrayList<CategorySB> c = category.getCatSet();
                    
                %>
            </div>
            <div class="btn-group" style="margin-top: 5px;">
                <button type="button" class="btn btn-primary" id="button_aspect">Category</button>
            </div>
            <div class="category_selection" style="margin-top: 5px;">
                <%for(int r =0;r<c.size();r++){%>
                <%CategorySB ct = c.get(r);%>
                <button type="button" class="btn btn-link btn-xs"><%=ct.getCategory()%></button>
                <%}%>
            </div>
        </div>


        <div class="col-md-10 col-sm-10 col-xs-12">

            <div class="well">   

                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h4 style="color:greenyellow"><%=pdqp.getName()%></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div>
                            <img class="img-responsive" src="../../../img/<%=pdqp.getProdid()%>.jpg" alt="image of <%=pdqp.getProdid()%>" id="query_prod_img" style="height:200px">
                        </div>
                    </div>

                        <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail">
                        <p>Explanation Interface</p>
                        <div id="<%=s%>" id1="container" style="height:200px"></div>                            
                    </div>   
                    <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail" >
                        <p>Description</p>
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
                                    <p>Rating: <%=pdqp.getRating()%><span class="pull-right">Price: <%=pdqp.getPrice()%></span></p>
                                    <p>Rank: <%=pdqp.getRank()%></p>
                                    <p>Category: <%=pdqp.getCategory()%></p>                                                
                                </div>
                            </div>
                        </div>                                    
                    </div>
                </div>
                <!--div class="caption-full thumbnail">
                    
                </div-->


                <!--div class="ratings">
                    <p class="pull-right">3 reviews</p>
                    <p>
                        
                           
                        <span class="glyphicon glyphicon-star"></span>
                       
                        
                        <span class="glyphicon glyphicon-star"></span>
                        <span class="glyphicon glyphicon-star"></span>
                        <span class="glyphicon glyphicon-star"></span>
                        <span class="glyphicon glyphicon-star-empty"></span>
                        4.0 stars
                    </p>
                </div-->


                <div class="well" style="height:300px;overflow:scroll">

                    <div class="text-right">
                        <a class="btn btn-success">Compare</a>
                    </div>


                    <div class="row text-center">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <h4>Here are Product having Similar Aspects</h4>
                        </div>
                    </div>

                    <hr>
                    <%Productdetail pdr = null;%>
                    <%if ((d.size() > 1)) {%>
                    <%for (int m = 0; m < d.size(); m++) {%>
                    <%if (m != 0) {%>
                    <%pdr = d.get(m);%>


                    <div class="row well recommendation">
                        <h4 class ="well rec_prodname_h4" id="rec_prodname_3"><%=pdr.getName()%></h4>
                        <div class="col-md-12 col-sm-12 col-xs-12">  
                            <div class="row well">                            
                                <div class="col-md-4 col-sm-6 col-xs-12 thumbnail" >
                                    <p class="nhidden">Product Name<span class="pull-right"></span></p>
                                    <img class="img-responsive" src="../../../img/<%=pdr.getProdid()%>.jpg" alt="image of <%=pdr.getProdid()%>" style="height:180px" id="recomm_prod_img_1">
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail">
                                    <p>Explanation Interface</p>
                                    <div id="<%=pdr.getProdid()%>" style="height:180px"></div>                                    
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail" >
                                    <p>Description</p>
                                    <div style="height:180px;overflow: auto">
                                        <div  style="background: grey;padding:2px">
                                            <div style="background: white;height:" id="desc_1">
                                                <p>Rating: <%=pdr.getRating()%><span class="pull-right">Price: <%=pdr.getPrice()%></span></p>
                                                <p>Rank: <%=pdr.getRank()%></p>
                                                <p>Category: <%=pdr.getCategory()%></p>                                                
                                            </div>
                                        </div>
                                    </div>                                    
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12 text-center">
                                    <p>
                                    <form action="products.jsp" onsubmit1="return retrievePaR(this)">
                                        <input type="hidden" name="product" id="prod_4" value="<%=pdr.getProdid()%>">
                                        <input type="submit" value="View" class="btn btn-primary" >
                                    </form>
                                    </p>
                                </div>
                            </div>
                            <span class="pull-left" style="color:white"></span>

                        </div>
                    </div>

                    <hr>
                    <%}%>
                    <%}%>
                    <%} else {%>                    
                    <h4 style="color:red">Sorry No Available Recommendations</h4>
                    <%}%>
                    <!--div class="row well recommendation">
                        <h4 class ="well rec_prodname_h4" id="rec_prodname_3">Product Name</h4>
                        <div class="col-md-12 col-sm-12 col-xs-12">                         
                            <div class="row well">                            
                                <div class="col-md-4 col-sm-6 col-xs-12 thumbnail" >
                                    <p class="nhidden">Product Name<span class="pull-right"></span></p>
                                    <img class="img-responsive" src="" alt="image of recommended product2" style="height:180px" id="recomm_prod_img_2">
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail">
                                    <p>Explanation Interface</p>
                                    <div id="placeholder_2" style="height:180px"></div>                                    
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail" >
                                    <p>Description</p>
                                    <div style="height:180px;overflow: auto">
                                        <div  style="background: grey;padding:2px"><div style="background: white;height:px" id="desc_2"></div><%%></div>
                                    </div>                                    
                                </div>
                            </div>
                            <span class="pull-right"></span>
    
                        </div>
                    </div>
    
                    <hr>
    
                    <div class="row well recommendation">
                        <h4 class ="well rec_prodname_h4" id="rec_prodname_3">Product Name</h4>
                        <div class="col-md-12 col-sm-12 col-xs-12">                       
                            <div class="row well">                            
                                <div class="col-md-4 col-sm-6 col-xs-12 thumbnail" >
                                    <p class="nhidden">Product Name<span class="pull-right"></span></p>
                                    <img class="img-responsive" src="" alt="image of recommended Product3" style="height:180px" id="recomm_prod_img_3">
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail">
                                    <p>Explanation Interface</p>
                                    <div id="placeholder_3" style="height:180px"></div>                                    
                                </div>
                                <div class="col-md-4 col-sm-6 col-xs-12 text-center thumbnail" >
                                    <p>Description</p>
                                    <div style="height:180px;overflow: auto">
                                        <div  style="background: grey;padding:2px"><div style="background: white;height:px" id="desc_3"></div><%%></div>
                                    </div>                                    
                                </div>
                            </div>
                            <span class="pull-right"></span>
                        </div>
                    </div-->

                </div>



            </div>

        </div>
        <!-- /.container -->
        <div class="container">

            <hr>

            <%@include file="../footer/footer.jsp" %>
