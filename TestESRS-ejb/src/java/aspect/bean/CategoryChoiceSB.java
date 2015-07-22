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
public class CategoryChoiceSB implements CategoryChoiceSBLocal, Serializable {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private String category;
    private String product;
    private ArrayList<CategoryChoiceSB> set;
    private Connection conn = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null, pp = null;
    private String db = "db1409777_esrs";
    private String url = "jdbc:mysql://localhost:3306/db1409777_esrs";
    private String username = "root";
    private String password = "";
    
    public CategoryChoiceSB(){
        set = new ArrayList<>();
    }
    
    public void retrieveSet(String category) {
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
            ps = conn.prepareStatement("SELECT * FROM productdetail WHERE category like ?");

            ps.setString(1, "%" + category + "%");
            System.out.println("CATEGORY: "+category);
            rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                CategoryChoiceSB a = new CategoryChoiceSB();
                a.setProduct(rs.getString(1));                
                this.setSet(a);
                i++;
                if(i == 12){
                    break;
                }

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

    

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public ArrayList<CategoryChoiceSB> getSet() {
        return set;
    }

    public void setSet(CategoryChoiceSB set) {
        
        this.set.add(set);
    }    

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
        this.retrieveSet(this.getCategory());
    }
    
    
}
