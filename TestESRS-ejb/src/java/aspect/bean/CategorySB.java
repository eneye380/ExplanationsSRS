/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

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
public class CategorySB implements CategorySBLocal {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private ArrayList<CategorySB> catSet;
    private String category;
    private Connection conn = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null, pp = null;
    private String db = "db1409777_esrs";
    private String url = "jdbc:mysql://localhost:3306/db1409777_esrs";
    private String username = "root";
    private String password = "";

    public CategorySB() {
        catSet = new ArrayList<>();
        category = "";
    }

    public void setCategory(String cat) {
        this.category = cat;
    }

    public String getCategory() {
        return this.category;
    }

    public void setCatSet(CategorySB c) {
        this.catSet.add(c);
    }

    public ArrayList<CategorySB> getCatSet() {

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

            ps = conn.prepareStatement("SELECT DISTINCT category FROM productcategory");

            rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                CategorySB a = new CategorySB();
                a.setCategory(rs.getString(1));
                this.setCatSet(a);
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
            return this.catSet;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
            return null;
        } finally {

        }
    }
}
