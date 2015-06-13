package us.abook.business;
// vim: set et ts=4 sw=4 fdm=marker:

import org.hibernate.*;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;
	

//import com.sun.org.apache.xpath.internal.operations.Bool;

import java.util.*;
public abstract class HibernateActiveRecord{
    private Session _session=null;
    private HibernateConfiguration _hc;
    private Logger _logger=null;
    public void log(String msg){
        if (_logger != null)
            _logger.log(msg, 2);
    }
	public HibernateActiveRecord(){

    }
	public HibernateActiveRecord(HibernateConfiguration hc, Logger logger){
        _hc=hc;
        _logger=logger;
    }
    public HibernateActiveRecord(Integer id, 
                HibernateConfiguration hc,
                Logger logger) {
        this(hc, logger);
        log("loading " + id);
    	this.getSession().load(this, id);
    }
    public Session getSession() {
    	if (_session == null){
            log("get hc session");
    		_session =_hc.getSession();
    	}
        log("ret session");
        return _session;
    }
    public void delete() {
        // FIXME: I wasn't able to get this to work
        log("deleting");
        this.getSession().delete(this);
    }
    public void _save( ) {
        this.getSession().save(this);
    }
    public void save(Boolean commit) {
    	Transaction tx;
    	tx = (commit) ? this.NewTx() : null;
    	
    	try{
            /* session is open if NewTx was called */
            if (tx == null)
                _hc.OpenSession();
    		this._save();
    		if (tx != null) tx.commit();
    	}
    	finally {
            _hc.CloseSession();
            _hc.CloseSessionFactory();
        }
    }
    public Transaction NewTx() {
    	return this.getSession().beginTransaction();
    }
}

