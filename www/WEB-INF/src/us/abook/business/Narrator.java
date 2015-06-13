package us.abook.business;
// vim: set et ts=4 sw=4 fdm=marker:
import java.util.*;
import javax.persistence.*;
import org.hibernate.annotations.Index;
import org.hibernate.*;

@Entity
public class Narrator extends HibernateActiveRecord implements java.io.Serializable {
    private int id;
    private String name;
    private Set<Recording> recordings;

	public Narrator(){ 
    }
	public Narrator(HibernateConfiguration hc, Logger logger){ 
        super(hc, logger); 
    }
    public Narrator(int id, HibernateConfiguration hc, Logger logger){ 
        super(id, hc, logger); 
    }

    @Id 
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getId() { return this.id; }
	protected void setId(int v) { this.id = v;}
    
    public String getName() { return this.name; }
    public String setName(String v) { return this.name = v; }

    @ManyToMany(cascade=CascadeType.ALL)
    @JoinTable(name="Recording_mm_Narrator", 
                    joinColumns={@JoinColumn(name="nid")},
                    inverseJoinColumns={@JoinColumn(name="rid")}
                )
     
    public Set<Recording> getRecordings() { return this.recordings; }
    public void setRecordings(Set<Recording> v) { this.recordings = v; }
}
