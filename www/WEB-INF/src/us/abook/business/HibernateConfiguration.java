package us.abook.business;
// vim: set et ts=4 sw=4 fdm=marker:

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;

public class HibernateConfiguration {
	private Configuration _config;
	private SessionFactory _sessionFactory;
	private Session _session;
    private Logger _logger;
	public HibernateConfiguration(Logger logger) {
        this._logger = logger;
        this.log("new hc singleton");
        this._config = new AnnotationConfiguration();
        this._config.configure();
        this._sessionFactory = this._config.buildSessionFactory();
	}
	public Configuration getConfig() {
		return _config;
	}
	public SessionFactory getSessionFactory() {
		return _sessionFactory;
	}
	public Session getSession() {
		if (_session == null){
            log("open session");
		    this.OpenSession();
		}
        log("ret session");
		return _session;
	}
	public void OpenSession() {
		if (_session == null)
            log("open session from factory");
		    _session =_sessionFactory.openSession();
		}
	public void CloseSession(){
		if (_session == null || !_session.isOpen()) return;
        log("closing session");

	}
	public void CloseSessionFactory(){
        if (_sessionFactory.isClosed()) return;
        log("closing session factory");
		_sessionFactory.close();
	}
    public void log(String msg) {
        _logger.log(msg, 2);
    }
}
