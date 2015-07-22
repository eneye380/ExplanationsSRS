/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.model.Productdetail;
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
public class ProductDetailSB implements ProductDetailSBLocal, Serializable {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private Connection conn = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null, pp = null;
    private String db = "db1409777_esrs";
    private String url = "jdbc:mysql://localhost:3306/db1409777_esrs";
    private String username = "root";
    private String password = "";
    private ArrayList<Productdetail> collec;
    private ArrayList<String> recommSet;
    private String prodid;
    private int index = 0;

    public String getProdid() {
        return prodid;
    }

    public void setProdid(String prodid) {
        this.prodid = prodid;
    }

    public ArrayList<String> getRecommSet() {
        return recommSet;
    }

    public void setRecommSet(ArrayList<String> recommSet) {
        this.recommSet = recommSet;

    }

    public ArrayList<Productdetail> getCollec() {
        return this.collec;
    }

    public void setCollec(Productdetail collec) {
        this.collec.add(index, collec);
        index++;
    }

    public int getIndex() {
        return this.index;
    }

    public void setIndex(int i) {
        this.index = i;
    }

    public ProductDetailSB() {
        System.out.println("Hello + World");
        collec = new ArrayList<>();
        recommSet = null;
        prodid = null;
    }

    public ArrayList<Productdetail> retrieveDetail() {
        System.out.println("welcome");
        System.out.println("prodid: " + prodid);
        System.out.println("recommSet: " + recommSet);

        System.out.println("1");
        try {

            try {
                System.out.println("2");
                Class.forName("com.mysql.jdbc.Driver").newInstance();
            } catch (InstantiationException | IllegalAccessException ex) {
                System.out.println("Error: unsuccessful Driver - " + ex);
            }
        } catch (ClassNotFoundException ex) {
            System.out.println("Error: unsuccessful Driver - " + ex);
        }
        System.out.println("Hello World");

        try {
            conn = DriverManager.getConnection(url, username, password);
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        }
        System.out.println("3");
        System.out.println("Connection: " + conn);

            //ps = conn.prepareStatement("SELECT * FROM productdetail WHERE prodid = ?");
        // ps.setString(1, "" + productid + "");
        //rs = ps.executeQuery();
        //set = new ArrayList<>();
        if (prodid != null) {
            System.out.println("4");
            System.out.println("Am back, you hear");
            Productdetail p = null;
            try {
                System.out.println("11 - "+p);
                p = this.processsDetail(prodid);
                System.out.println("12 - "+p);
            } catch (SQLException ex) {
                System.out.println("1112Error: " + ex);
            }
            System.out.println("5");
            this.setCollec(p);
            if (recommSet != null) {
                System.out.println("6");
                if (recommSet.size() >= 1) {
                    System.out.println("7");
                    for (String s : recommSet) {
                        System.out.println("8");
                        Productdetail q = null;
                        try {
                            q = this.processsDetail(s);
                        } catch (SQLException ex) {
                            System.out.println("Error: " + ex);
                        }
                        this.setCollec(q);
                    }
                }

            }
        }
        if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }

        System.out.println("10");
        System.out.println("9");
        return this.getCollec();

    }

    public Productdetail processsDetail(String productid) throws SQLException {
        System.out.println("11");
        try {
            System.out.println("19");
            ps = conn.prepareStatement("SELECT * FROM productdetail WHERE prodid = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            Productdetail p = new Productdetail();
            while(rs.next()){
            
            p.setProdid(rs.getString(1));
            p.setName(rs.getString(2));
            p.setDate(rs.getString(3));
            p.setRank(rs.getString(4));
            p.setPrice(rs.getString(5));
            p.setCategory(rs.getString(6));
            p.setRating(rs.getString(7));
            p.setNreviews(rs.getString(8));
            p.setNcomments(rs.getString(9));
            p.setNquestions(rs.getString(10));
            p.setUrl(rs.getString(11));
            System.out.println("20");
            }
            //System.out.println("20");
            //conn.close();
            //ps.close();
            //rs.close();
            System.out.println("12");
            
            System.out.println("bye1");
            return p;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
            return null;
        }
    }

}
