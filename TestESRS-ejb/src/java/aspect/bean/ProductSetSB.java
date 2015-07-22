/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.ejb.Stateless;

/**
 *
 * @author eneye380
 */
@Stateless
public class ProductSetSB implements ProductSetSBLocal, Serializable{

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private String queryProduct;
    private ArrayList<ProductSetSB> set;
    private Connection conn = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null, pp = null;
    private String db = "db1409777_esrs";
    private String url = "jdbc:mysql://localhost:3306/db1409777_esrs";
    private String username = "root";
    private String password = "";
    private String product1;
    private String product;
    private String product3;
    private String product2;

    public ProductSetSB() {
        System.out.println("Hello Aberdeen");
         set = new ArrayList<>();
        

    }

    //@Override
    public void retrieveSet(String productid) {
        try {

            try {
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                } catch (InstantiationException | IllegalAccessException ex) {
                    System.out.println("Error: unsuccessful Driver - " + ex);
                }
            } catch (ClassNotFoundException ex) {
                System.out.println("Error: unsuccessful Driver - " + ex);
            }
            System.out.println("Hello World");

            conn = DriverManager.getConnection(url, username, password);

            System.out.println("Connection: " + conn);

            //ps = conn.prepareStatement("SELECT * FROM queryproductandrecommendation WHERE queryProduct = ?");
            ps = conn.prepareStatement("SELECT * FROM productrecommendation WHERE queryProduct = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                ProductSetSB a = new ProductSetSB();
                a.setProduct(rs.getString(2));
                //this.setQueryProduct(rs.getString(1));
                //this.setProduct1(rs.getString(3));
                //this.setProduct2(rs.getString(4));
                //this.setProduct3(rs.getString(5));
                this.setSet(a);
                i++;

            }
            System.out.println("Count: " + i);
            if (conn != null) {
                try {
                    conn.close();
                    System.out.println("Connection closed ");
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                    System.out.println("ResultSet closed ");
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                    System.out.println("PreparedStatement closed ");
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        } finally {

        }

    }

    public void setQueryProduct(String qp) {
        this.queryProduct = qp;        
        System.out.println("Execute me once please:"+this.getQueryProduct());
        this.retrieveSet(this.getQueryProduct());
        

    }

    public String getQueryProduct() {
        return queryProduct;
    }

    public void setSet(ProductSetSB a) {

        set.add(a);

    }

    public ArrayList<ProductSetSB> getSet() {

        return set;
    }

    public void setProduct1(String p1) {
        this.product1 = p1;
    }

    public String getProduct1() {
        return product1;
    }

    public void setProduct2(String p2) {
        this.product2 = p2;
    }

    public String getProduct2() {
        return product2;
    }

    public void setProduct3(String p3) {
        this.product3 = p3;
    }

    public String getProduct3() {
        return product3;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getProduct() {
        return product;
    }

    public Connection getConn() {
        return conn;
    }
}
