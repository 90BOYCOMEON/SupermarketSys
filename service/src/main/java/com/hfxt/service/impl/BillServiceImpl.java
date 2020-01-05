package com.hfxt.service.impl;

import com.alibaba.fastjson.JSON;
import com.hfxt.dao.IBillDao;
import com.hfxt.domain.Bill;
import com.hfxt.domain.Pager;
import com.hfxt.service.IBillService;
import com.hfxt.utils.RedisUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BillServiceImpl implements IBillService {

    @Autowired
    private IBillDao billDao;

    @Autowired
    private RedisUtils redisUtils;

    @Override
    public String delBillById(Integer id) {

        boolean exist = redisUtils.exist(id + "b");
        if(exist){
            redisUtils.delete(id+"b");
        }
        Integer row = billDao.delBillById(id);
        return row>0?"success":"error";
    }

    @Override
    public String saveBill(Bill bill) {
        Bill b = billDao.getBillByBillCode(bill.getBillCode());
        if(b!=null){
            return "billExits";
        }
        Map<String, Object> map = toMap(bill);
        return billDao.saveBill(map)>0?"success":"error";
    }

    @Override
    public String updateBill(Bill bill) {
        Map<String, Object> map = toMap(bill);
        Integer row = billDao.updateBill(map);
        redisUtils.delete(bill.getId()+"b");
        redisUtils.delete(bill.getBillCode()+"b");
        redisUtils.delete(bill.getProductName()+"b");
        Bill b = billDao.getBillById(bill.getId());
        redisUtils.delete(b.getBillCode()+ "b");
        redisUtils.delete(b.getProductName()+ "b");
        redisUtils.set(b.getId()+"b", JSON.toJSON(b).toString());
        redisUtils.set(b.getBillCode()+ "b",JSON.toJSON(b).toString());
        redisUtils.set(b.getProductName()+ "b",JSON.toJSON(b).toString());
        return row>0?"success":"error";
    }

    @Override
    public Bill getBillByBillCode(String billCode) {
        Object o = redisUtils.get(billCode+ "b");
        if(o!=null){
            return JSON.parseObject(o.toString(), Bill.class);
        }
        Bill bill = billDao.getBillByBillCode(billCode);
        if(bill==null){
            return null;
        }
        redisUtils.set(billCode+ "b",JSON.toJSON(bill).toString());
        return bill;
    }

    @Override
    public Bill getBillById(Integer id) {
        Object o = redisUtils.get(id + "b");
        if(o!=null){
            return JSON.parseObject(o.toString(), Bill.class);
        }
        Bill bill = billDao.getBillById(id);
        if(bill==null){
            return null;
        }
        redisUtils.set(id+"b",JSON.toJSON(bill).toString());
        return bill;
    }

    @Override
    public Bill getBillByName(String productName) {
        Object o = redisUtils.get(productName+ "b");
        if(o!=null){
            return JSON.parseObject(o.toString(), Bill.class);
        }
        Bill bill = billDao.getBillByName(productName);
        if(bill==null){
            return null;
        }
        redisUtils.set(productName+ "b",JSON.toJSON(bill).toString());
        return bill;
    }

    @Override
    public List<Bill> getAllBillByPage(Pager pager, Integer providerId, Integer isPayment, String productName) {
        List<Bill> billList = billDao.getAllBillByPage(pager, providerId, isPayment, productName);
        pager.setTotalCount(billDao.getCount(providerId, isPayment, productName));
        return billList;
    }

    @Override
    public Map<String, Object> toMap(Bill bill) {
        Map<String,Object> map = new HashMap<>();
        map.put("id",bill.getId());
        map.put("billCode",bill.getBillCode());
        map.put("productName",bill.getProductName());
        map.put("productDesc",bill.getProductDesc());
        map.put("productUnit",bill.getProductUnit());
        map.put("productCount",bill.getProductCount());
        map.put("totalPrice",bill.getTotalPrice());
        map.put("isPayment",bill.getIsPayment());
        map.put("createdBy",bill.getCreatedBy());
        map.put("creationDate",bill.getCreationDate());
        map.put("modifyBy",bill.getModifyBy());
        map.put("modifyDate",bill.getModifyDate());
        map.put("providerId",bill.getProviderId());
        map.put("status",bill.getStatus());
        return map;
    }
}
