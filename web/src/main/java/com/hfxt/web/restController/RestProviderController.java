package com.hfxt.web.restController;


import com.hfxt.domain.Pager;
import com.hfxt.domain.Provider;
import com.hfxt.domain.User;
import com.hfxt.service.IProviderService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/provider")
public class RestProviderController {

    @Autowired
    private IProviderService providerService;

    private Pager pager = new Pager();


    @RequestMapping(value = "/getAll",produces = "text/html;charset=utf-8")
    public ModelAndView getAllProvider(Pager pager, String proName){
        ModelAndView mv = new ModelAndView();
        if (pager==null){
            pager = this.pager;
        }
        if(proName!=null){
            proName = proName.trim();
        }
        List<Provider> providerList = providerService.getAllProviderByPage(proName, pager);
        mv.setViewName("/providerList.jsp");
        mv.addObject("NAME",proName);
        mv.addObject("PAGE",pager);
        mv.addObject("PROVIDERLIST",providerList);
        return mv;

    }

    @RequestMapping(value = "/del/{id}",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@PathVariable Integer id){
        String s = providerService.delProviderById(id);
        return s;
    }

    @RequestMapping(value = "/get/{id}",produces = "text/html;charset=utf-8")
    public ModelAndView getProviderById(@PathVariable("id") Integer id){
        ModelAndView mv = new ModelAndView();
        Provider provider = providerService.getProviderById(id);
        mv.setViewName("/providerView.jsp");
        mv.addObject("PROVIDER",provider);
        return mv;
    }

    @RequestMapping(value = "/update/{id}",produces = "text/html;charset=utf-8")
    public ModelAndView getUserToUpdate(@PathVariable("id") Integer id){
        ModelAndView mv = new ModelAndView();
        Provider provider = providerService.getProviderById(id);
        mv.setViewName("/providerUpdate.jsp");
        mv.addObject("PROVIDER",provider);
        return mv;
    }

    @RequestMapping(value = "/update",method = RequestMethod.POST)
    @ResponseBody
    public String updateProvider(HttpServletRequest req){

        String id = req.getParameter("id");
        String modifyBy = req.getParameter("modifyBy");
        String providerId = req.getParameter("providerId");
        String providerName = req.getParameter("providerName");
        String people = req.getParameter("people");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String fax = req.getParameter("fax");
        String describe = req.getParameter("describe");
        Provider provider = new Provider();
        provider.setId(Integer.parseInt(id));
        provider.setModifyBy(Integer.parseInt(modifyBy));
        provider.setProCode(providerId);
        provider.setProName(providerName);
        provider.setProContact(people);
        provider.setProPhone(phone);
        provider.setProAddress(address);
        provider.setProFax(fax);
        provider.setProDesc(describe);
        String s = providerService.updateProvider(provider);
        return s;
    }

    @RequestMapping("/test")
    @ResponseBody
    public String isExitsProCode(String providerId){
        if(providerId==null){
            return "error";
        }
        Provider provider = providerService.getProviderByProCode(providerId);
        if(provider!=null){
            return "exits";
        }else
            return "none";
    }

    @RequestMapping("/test1")
    @ResponseBody
    public String isExitsProName(String providerName){
        if(providerName==null){
            return "error";
        }
        Provider provider = providerService.getProviderByProName(providerName);
        if(provider!=null){
            return "exits";
        }else
            return "none";
    }


    @RequestMapping("/add")
    @ResponseBody
    public String addProdiver(HttpServletRequest req){
        Provider p = new Provider();
        User user = (User)SecurityUtils.getSubject().getPrincipal();
        p.setProCode(req.getParameter("providerId"));
        p.setProName(req.getParameter("providerName"));
        p.setProContact(req.getParameter("people"));
        p.setProPhone(req.getParameter("phone"));
        p.setProAddress(req.getParameter("address"));
        p.setProFax(req.getParameter("fax"));
        p.setProDesc(req.getParameter("describe"));
        p.setCreatedBy(user.getId());
        String s = providerService.saveProvider(p);
        return s;
    }



}
