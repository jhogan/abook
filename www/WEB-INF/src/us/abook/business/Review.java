package us.abook.business;
//vim: set et ts=4 sw=4 fdm=marker:

import java.util.*;
import javax.persistence.*;

import org.hibernate.annotations.Index;
import org.hibernate.*;

@Entity
public class Review extends HibernateActiveRecord {
	private int id;
	private String title;
	private String user; /* TODO: objectify */
	private Date date;
	private String text;
	private Recording recording;

	public Review(){ 
    }
	public Review(HibernateConfiguration hc, Logger logger){ 
        super(hc, logger); 
    }
    public Review(int id, HibernateConfiguration hc, Logger logger){ 
        super(id, hc, logger); 
    }

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public int getId() {
		return this.id;
	}

	protected void setId(int v) {
		this.id = v;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public void setUser_(String user) {
		this.user = user;
	}

	public String getUser_() {
		return user;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date getDate() {
		return date;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getText() {
		return text;
	}

	@ManyToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="recording_id", insertable=false, updatable=false, nullable=false)
	public void setRecording(Recording recording) {
		this.recording = recording;
	}

	public Recording getRecording() {
		return recording;
	}

}
