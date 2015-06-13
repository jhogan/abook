package us.abook.business;
// vim: set et ts=4 sw=4 fdm=marker:

import java.util.*;

import org.hibernate.*;
import javax.persistence.*;
import org.hibernate.annotations.Index;

@Entity
public class Recording extends HibernateActiveRecord implements java.io.Serializable {
    private int id;
    private String title;
    private String derp;
    private double price;
    private String rating;
    private Set <Narrator> narrators;
    private Date released;
	private Set<Review> reviews;

	public Recording(HibernateConfiguration hc, Logger logger){ 
        super(hc, logger); 
    }
    public Recording(int id, HibernateConfiguration hc, Logger logger){ 
        super(id, hc, logger); 
    }

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    public int getId() { return this.id; }
	protected void setId(int v) { this.id = v;}

    public String getTitle() { return this.title; }
    public void setTitle(String title) { this.title = title; }

    public double getPrice() { return this.price; }
    public void setPrice(double price) { this.price = price; }

    public String getRating() { return this.rating; }
    public void setRating(String rating) { this.rating = rating; }

    @ManyToMany(cascade=CascadeType.ALL)
    @JoinTable(name="Recording_mm_Narrator", 
                    joinColumns={@JoinColumn(name="rid")}, 
                    inverseJoinColumns={@JoinColumn(name="nid")}
                )
     
    public Set<Narrator> getNarrators() { return this.narrators; }
    public void setNarrators(Set<Narrator> v) { this.narrators = v; }
    
    @OneToMany(cascade=CascadeType.ALL)
    @JoinColumn(name="recording_id", nullable=false)
    public Set<Review> getReviews() { return this.reviews; }
    public void setReviews(Set<Review> v) { this.reviews = v; }
    
    public Date setReleased() {
        return this.released;
    }
    
    public void Released(Date released) {
        this.released = released;
    }
}


