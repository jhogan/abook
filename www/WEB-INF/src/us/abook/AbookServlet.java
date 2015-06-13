package us.abook;
// vim: set et ts=4 sw=4 fdm=marker:
import java.util.*;
import java.lang.reflect.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import us.abook.business.*;
import org.json.*;

public class AbookServlet extends HttpServlet{
    Logger _logger;
    public void init(ServletConfig conf) throws ServletException{
        super.init(conf);
    }
    public void doGet(HttpServletRequest req, 
        HttpServletResponse res) 
        throws ServletException, IOException{
        doPost(req, res);
    }
    public void doPost(HttpServletRequest req, 
			HttpServletResponse res) 
			throws ServletException, IOException{
        String fn = req.getParameter("fn");
        String log = req.getParameter("log");

        if (log != null && log.equals("1"))
            _logger = new Logger(res);
        else
            _logger = new Logger(null);

        try{
            JSONFunctions jf = new JSONFunctions(_logger);
            res.getWriter().print(jf.invoke(fn));
        }catch(Exception ex){ 
            ex.printStackTrace(res.getWriter());
        }


        HibernateConfiguration hc  = new HibernateConfiguration(_logger);

        String crud = "r";
        try{
            if (crud == "c"){
                res.getWriter().print("begin");
                Recording r = new Recording(hc, _logger);
                Narrator n = new Narrator(hc, _logger);
                Set <Recording> rset = new HashSet <Recording>();

                r.setTitle("Lame Coffee Pun");
                n.setName("Jesse 'Java' Hogan");
                rset.add(r);
                n.setRecordings(rset);
                n.save(true);
                res.getWriter().print("end");
            }else{ 
                if (crud == "r" || crud=="d" || crud=="u"){
                    Recording r = new Recording(2, hc, _logger);
                    if (crud == "u"){
                            r.setTitle("New Title");
                    }else if(crud == "d"){
                            r.delete();
                    }
                }
                hc.CloseSession();
                hc.CloseSessionFactory();
            }
        }
        catch(Exception ex){
            //res.getWriter().print(ex);
            ex.printStackTrace(res.getWriter());
        }
    }
    public void log(String msg){
        if (_logger != null)
            _logger.log(msg, 2);
    }
}
