package us.abook.business;


import java.util.HashSet;
import java.util.Set;

/**
 * Author generated by hbm2java
 */
public class Author  implements java.io.Serializable {

 
     private int id;
     private String name;
     private Set recordings = new HashSet(0);

    public Author() {
    }

    public Author(String name, Set recordings) {
       this.name = name;
       this.recordings = recordings;
    }
   
    public int getId() {
        return this.id;
    }
    
    protected void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set getRecordings() {
        return this.recordings;
    }
    
    public void setRecordings(Set recordings) {
        this.recordings = recordings;
    }

    /**
     * toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

      buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [");
      buffer.append("name").append("='").append(getName()).append("' ");			
      buffer.append("]");
      
      return buffer.toString();
     }



}


