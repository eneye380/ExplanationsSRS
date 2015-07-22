/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.model.Productaspectsentiment;
import aspect.model.ProductaspectsentimentPK;
import aspect.model.Productdetail;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.ejb.Stateless;

/**
 *
 * @author eneye380
 */
@Stateless
public class AspectScoreSB implements AspectScoreSBLocal {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private Connection conn = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null, pp = null;
    private String db = "db1409777_esrs";
    private String url = "jdbc:mysql://localhost:3306/db1409777_esrs";
    private String username = "root";
    private String password = "";
    private ArrayList<String> recommSet;
    private String prodid;
    private ArrayList<String> myProducts;
    private Map<String, Number> aspectValue;
    private Map<String, Map<String, Number>> aspectSet;
    private Map<String, Map<String, Map<String, Number>>> scoreSet;

    public AspectScoreSB() {
        recommSet = null;
        prodid = null;
        myProducts = new ArrayList<>();
        scoreSet = new HashMap<>();
    }

    public Map<String, Number> getAspectValue() {
        return aspectValue;
    }

    public void setAspectValue(Map<String, Number> aspectValue) {
        this.aspectValue = aspectValue;
    }

    public Map<String, Map<String, Number>> getAspectSet() {
        return aspectSet;
    }

    public void setAspectSet(Map<String, Map<String, Number>> aspectSet) {
        this.aspectSet = aspectSet;
    }

    public Map<String, Map<String, Map<String, Number>>> getScoreSet() {
        return scoreSet;
    }

    public void setScoreSet(Map<String, Map<String, Map<String, Number>>> scoreSet) {
        this.scoreSet = scoreSet;
    }

    public ArrayList<String> getRecommSet() {
        return recommSet;
    }

    public void setRecommSet(ArrayList<String> recommSet) {
        this.recommSet = recommSet;
    }

    public String getProdid() {
        return prodid;
    }

    public void setProdid(String prodid) {
        this.prodid = prodid;
    }

    public Map<String, Map<String, Map<String, Number>>> retrieveAspectScores() {

        BigDecimal score;
        int freq;
        BigDecimal gini;
        String aspect;

        if (prodid != null && recommSet != null) {
            myProducts.add(0, this.getProdid());
            if (recommSet.size() > 0) {
                for (int e = 0; e < recommSet.size(); e++) {
                    myProducts.add(e + 1, recommSet.get(e));
                }
            }
            for (int f = 0; f < myProducts.size(); f++) {
                ArrayList<Productaspectsentiment> p = this.processAspect(myProducts.get(f));
                aspectSet = new HashMap<>();
                for (int k = 0; k < p.size(); k++) {
                    aspectValue = new HashMap<>();
                    Productaspectsentiment pas = p.get(k);
                    aspect = pas.getProductaspectsentimentPK().getAspect();
                    score = pas.getScore();
                    freq = pas.getFreq();
                    gini = pas.getGini();
                    aspectValue.put("score", score);
                    aspectValue.put("freq", freq);
                    aspectValue.put("gini", gini);
                    aspectSet.put(aspect, aspectValue);
                }
                scoreSet.put(myProducts.get(f), aspectSet);
            }

        }
        System.out.println("MY SCORESET: "+scoreSet.toString());
        return scoreSet;
    }

    public ArrayList<Productaspectsentiment> processAspect(String productid) {
        System.out.println("getdetail_999");
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
            System.out.println(conn);
            ps = conn.prepareStatement("SELECT * FROM productaspectsentiment WHERE prodid = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            ArrayList<Productaspectsentiment> collec = new ArrayList<>();

            while (rs.next()) {
                ProductaspectsentimentPK p = new ProductaspectsentimentPK();
                Productaspectsentiment q = new Productaspectsentiment(p);
                q.getProductaspectsentimentPK().setProdid(rs.getString(1));
                q.getProductaspectsentimentPK().setAspect(rs.getString(2));
                q.setScore(rs.getBigDecimal(3));
                q.setFreq(rs.getInt(4));
                q.setGini(rs.getBigDecimal(5));

                collec.add(q);
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
            return collec;

        } catch (SQLException ex) {

            System.out.println("Error: " + ex);
            return null;

        } finally {

        }

    }

}
