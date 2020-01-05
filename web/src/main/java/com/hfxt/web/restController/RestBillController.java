package com.hfxt.web.restController;

import com.alibaba.fastjson.JSONArray;
import com.hfxt.domain.Bill;
import com.hfxt.domain.Pager;
import com.hfxt.domain.Provider;
import com.hfxt.domain.User;
import com.hfxt.service.IBillService;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bill")
public class RestBillController {

    @Autowired
    private IBillService billService;

    private Pager pager = new Pager();

    @Autowired
    private IProviderService providerService;

    @RequestMapping(value = "/getAll", produces = "text/html;charset=utf-8")
    public ModelAndView getAllBill(Pager pager, Integer providerId, Integer isPayment, String productName) {
        ModelAndView mv = new ModelAndView();
        if (pager == null) {
            pager = this.pager;
        }
        if (productName != null) {
            productName = productName.trim();
        }
        Pager p = new Pager();
        p.setPageSize(99999);
        List<Provider> providerList = providerService.getAllProviderByPage(null, p);
        List<Bill> billList = billService.getAllBillByPage(pager, providerId, isPayment, productName);
        mv.setViewName("/billList.jsp");
        mv.addObject("PROLIST", providerList);
        mv.addObject("BILL", billList);
        mv.addObject("PAGE", pager);
        mv.addObject("PROID", providerId);
        mv.addObject("PRONAME", productName);
        mv.addObject("ISPAY", isPayment);
        return mv;
    }

    @RequestMapping(value = "/del/{id}", method = RequestMethod.POST)
    @ResponseBody
    public String delete(@PathVariable Integer id) {
        String s = billService.delBillById(id);
        return s;
    }

    @RequestMapping(value = "/get/{id}", produces = "text/html;charset=utf-8")
    public ModelAndView getBillById(@PathVariable("id") Integer id) {
        ModelAndView mv = new ModelAndView();
        Bill bill = billService.getBillById(id);
        Provider provider = providerService.getProviderById(bill.getProviderId());
        mv.setViewName("/billView.jsp");
        mv.addObject("BILL", bill);
        mv.addObject("PROVIDER", provider);
        return mv;
    }

    @RequestMapping(value = "/update/{id}", produces = "text/html;charset=utf-8")
    public ModelAndView getBillToUpdate(@PathVariable("id") Integer id) {
        ModelAndView mv = new ModelAndView();
        Bill bill = billService.getBillById(id);
        Pager p = new Pager();
        p.setPageSize(99999);
        List<Provider> providerList = providerService.getAllProviderByPage(null, p);
        mv.setViewName("/billUpdate.jsp");
        mv.addObject("BILL", bill);
        mv.addObject("PROLIST", providerList);
        return mv;
    }

    @RequestMapping(value = "/getPro",produces = "text/html;charset=utf-8" )
    @ResponseBody
    public String getPro(){
        Pager p = new Pager();
        p.setPageSize(99999);
        List<Provider> providerList = providerService.getAllProviderByPage(null, p);
        return JSONArray.toJSON(providerList).toString();
    }

    @RequestMapping("/test")
    @ResponseBody
    public String isExitsBillId(String providerId) {
        if (providerId == null) {
            return "error";
        }
        Bill bill = billService.getBillByBillCode(providerId);
        if (bill != null) {
            return "exits";
        } else
            return "none";
    }

    @RequestMapping("/test1")
    @ResponseBody
    public String isExitsBillName(String providerName) {
        if (providerName == null) {
            return "error";
        }
        Bill bill = billService.getBillByName(providerName);
        if (bill != null) {
            return "exits";
        } else
            return "none";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String updateUser(HttpServletRequest req) {

        String id = req.getParameter("id");
        String modifyBy = req.getParameter("modifyBy");
        String billCode = req.getParameter("providerId");
        String productName = req.getParameter("providerName");
        String productUnit = req.getParameter("people");
        String productCount = req.getParameter("phone");
        String price = req.getParameter("price");
        String providerId = req.getParameter("fax");
        String isPayment = req.getParameter("zhifu");

        Bill bill = new Bill();
        bill.setId(java.lang.Integer.parseInt(id));
        bill.setModifyBy(java.lang.Integer.parseInt(modifyBy));
        bill.setBillCode(billCode);
        bill.setProductName(productName);
        bill.setProductUnit(productUnit);
        bill.setProductCount(Float.parseFloat(productCount));
        bill.setTotalPrice(Float.parseFloat(price));
        bill.setProviderId(Integer.parseInt(providerId));
        bill.setIsPayment(Integer.parseInt(isPayment));
        String s = billService.updateBill(bill);
        return s;
    }

    @RequestMapping("/add")
    @ResponseBody
    public String addProdiver(HttpServletRequest req){
        Bill bill = new Bill();
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        bill.setCreatedBy(user.getId());
        bill.setBillCode(req.getParameter("billId"));
        bill.setProductName(req.getParameter("billName"));
        bill.setProductUnit(req.getParameter("billCom"));
        bill.setProductCount(Float.parseFloat(req.getParameter("billNum")));
        bill.setTotalPrice(Float.parseFloat(req.getParameter("money")));
        bill.setProviderId(Integer.parseInt(req.getParameter("supplier")));
        bill.setIsPayment(Integer.parseInt(req.getParameter("zhifu")));
        String s = billService.saveBill(bill);
        return s;
    }

}
